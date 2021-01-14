import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:toast/toast.dart';
import 'package:progress_indicator_button/progress_button.dart';
import 'package:fullfuel_app/src/styles/fullfuel_colors.dart';
import 'package:fullfuel_app/src/widgets/app_bar_widget.dart';
import 'package:fullfuel_app/src/widgets/app_bottom_navigation_bar_widget.dart';
import 'package:fullfuel_app/src/entities/fuelstation_list_entity.dart';
import 'package:fullfuel_app/src/repositories/db/fuelstations_db_repo.dart';
import 'package:fullfuel_app/src/repositories/remote/fuelstations_remote_repo.dart';

class ConfigScreen extends StatefulWidget {
  ConfigScreen({Key key}) : super(key: key);

  @override
  _ConfigScreen createState() => _ConfigScreen();
}

class _ConfigScreen extends State<ConfigScreen> {
  final configBox = Hive.box('config');
  double _searchRadiusValue;
  bool _showOnlyOpen;

  @override
  void initState() {
    super.initState();
    _showOnlyOpen = configBox.get("showOnlyOpen", defaultValue: false);
    _searchRadiusValue = configBox.get("searchRadiusValue", defaultValue: 5.0);
  }

  Future<void> _saveConfig(AnimationController controller) async {
    controller.forward();
    await configBox.put("searchRadiusValue", _searchRadiusValue);
    await configBox.put("showOnlyOpen", _showOnlyOpen);
    List<FuelstationListEntity> fuelstations = await _getRemoteFuelstations();
    await _cacheFuelstations(fuelstations);
    controller.reset();
    Toast.show("Cambios realizados correctamente", context,
        duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
  }

  Future<List<FuelstationListEntity>> _getRemoteFuelstations() async {
    FuelstationsRemoteRepo remote = FuelstationsRemoteRepo(
        configBox.get("latitude"), configBox.get("longitude"));
    final fuelstations = await remote.fetchFuelstationsListGeo(
        radius: _searchRadiusValue.toInt(), showOnlyOpen: _showOnlyOpen);
    return fuelstations;
  }

  Future<void> _cacheFuelstations(
      List<FuelstationListEntity> fuelstations) async {
    final fuelstationsBox = Hive.box<FuelstationListEntity>('fuelstations');
    final dbRepo = FuelstationsDBRepo(fuelstationsBox);
    await dbRepo.clearOnInit();
    await dbRepo.saveList(fuelstations);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: FullfuelColors.secondary_5,
        appBar: AppBarWidget(),
        body: Column(
          children: [
            _configTitle(),
            _searchRadius(),
            _showOnlyOpenFuelStations(),
            _bottomButton()
          ],
        ),
        bottomNavigationBar: AppBottomNavigationBarWidget(index: 3),
      ),
    );
  }

  Container _configTitle() {
    final content = "Configuración";
    final styles = TextStyle(color: FullfuelColors.primary, fontSize: 16);
    return Container(
      margin: EdgeInsets.only(top: 30, left: 20),
      width: double.infinity,
      child:
          Text(content.toUpperCase(), style: styles, textAlign: TextAlign.left),
    );
  }

  Container _searchRadius() {
    final label = "Radio de búsqueda (${_searchRadiusValue.toInt()} KM)";
    final widget = Slider(
      inactiveColor: FullfuelColors.secondary_30,
      activeColor: FullfuelColors.primary,
      value: _searchRadiusValue,
      min: 5,
      max: 30,
      divisions: 5,
      label: _searchRadiusValue.round().toString(),
      onChanged: (double value) {
        setState(() {
          _searchRadiusValue = value;
        });
      },
    );

    return _formAreaContainer(label, widget);
  }

  Container _showOnlyOpenFuelStations() {
    final label = "Mostrar solo";
    final widget = Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Gasolineras abiertas",
            style: TextStyle(color: FullfuelColors.primary, fontSize: 16),
          ),
          Switch(
            value: _showOnlyOpen,
            onChanged: (value) {
              setState(() {
                _showOnlyOpen = value;
              });
            },
            activeTrackColor: FullfuelColors.secondary_30,
            activeColor: FullfuelColors.primary,
          ),
        ],
      ),
    );

    return _formAreaContainer(label, widget);
  }

  Container _formAreaContainer(String label, Widget widget) {
    final labelTextStyles =
        TextStyle(color: FullfuelColors.secondary, fontSize: 13);
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(18),
      margin: EdgeInsets.only(top: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(color: FullfuelColors.secondary_30, width: 1),
          bottom: BorderSide(color: FullfuelColors.secondary_30, width: 1),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label.toUpperCase(), style: labelTextStyles),
          widget,
        ],
      ),
    );
  }

  Expanded _bottomButton() {
    final label = "Guardar condiguración";
    final labelTextStyles = TextStyle(fontSize: 16, color: Colors.white);
    return Expanded(
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          width: double.infinity,
          height: 60,
          margin: EdgeInsets.only(left: 20, right: 20, bottom: 40),
          child: ProgressButton(
            color: FullfuelColors.action,
            borderRadius: BorderRadius.all(Radius.circular(4)),
            child: Text(
              label.toUpperCase(),
              style: labelTextStyles,
            ),
            onPressed: (AnimationController controller) async {
              await _saveConfig(controller);
            },
          ),
        ),
      ),
    );
  }
}
