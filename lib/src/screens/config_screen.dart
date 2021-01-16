import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:toast/toast.dart';
import 'package:fullfuel_app/src/styles/fullfuel_colors.dart';
import 'package:fullfuel_app/src/widgets/safe_scaffold_widget.dart';
import 'package:fullfuel_app/src/widgets/form_field_container_widget.dart';
import 'package:fullfuel_app/src/widgets/button_loading_widget.dart';
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
  AnimationController animController;

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
    return SafeScaffoldWidget(
      pageTitle: "Configuración",
      page: _configPage(),
      pageIndex: 3,
    );
  }

  Column _configPage() {
    return Column(
      children: [
        _searchRadius(),
        _showOnlyOpenFuelStations(),
        ButtonLoadingWidget(
          label: "Guardar condiguración",
          fn: _saveConfig,
        ),
      ],
    );
  }

  FormFieldContainerWidget _searchRadius() {
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

    return FormFieldContainerWidget(label: label, widget: widget);
  }

  FormFieldContainerWidget _showOnlyOpenFuelStations() {
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

    return FormFieldContainerWidget(label: label, widget: widget);
  }
}
