import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:fullfuel_app/src/styles/fullfuel_colors.dart';
import 'package:fullfuel_app/src/widgets/app_bar_widget.dart';
import 'package:fullfuel_app/src/widgets/app_bottom_navigation_bar_widget.dart';

class ConfigScreen extends StatefulWidget {
  ConfigScreen({Key key}) : super(key: key);

  @override
  _ConfigScreen createState() => _ConfigScreen();
}

class _ConfigScreen extends State<ConfigScreen> {
  final configBox = Hive.box('config');
  double _searchRadiusValue = 5;
  bool _showOnlyOpen = false;

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
        children: [Text(label.toUpperCase(), style: labelTextStyles), widget],
      ),
    );
  }

  Expanded _bottomButton() {
    final label = "Guardar condiguración";
    final labelTextStyles = TextStyle(fontSize: 16);
    return Expanded(
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          width: double.infinity,
          height: 60,
          margin: EdgeInsets.only(left: 20, right: 20, bottom: 40),
          child: RaisedButton(
            color: FullfuelColors.action,
            textColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4.0),
            ),
            onPressed: () => {},
            child: Text(label.toUpperCase(), style: labelTextStyles),
          ),
        ),
      ),
    );
  }
}
