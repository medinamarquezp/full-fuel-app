import 'package:flutter/material.dart';
import 'package:fullfuel_app/src/styles/fullfuel_colors.dart';
import 'package:fullfuel_app/src/widgets/app_bar_widget.dart';
import 'package:fullfuel_app/src/widgets/fuelstation_card_widget.dart';
import 'package:fullfuel_app/src/widgets/app_bottom_navigation_bar_widget.dart';

class GeolistScreen extends StatefulWidget {
  GeolistScreen({Key key}) : super(key: key);

  @override
  _GeolistScreenState createState() => _GeolistScreenState();
}

class _GeolistScreenState extends State<GeolistScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: FullfuelColors.secondary_5,
        appBar: AppBarWidget(),
        body: ListView(
          children: [
            _distance(),
            FuelstationCardWidget(),
            FuelstationCardWidget(),
          ],
        ),
        bottomNavigationBar: AppBottomNavigationBarWidget(),
      ),
    );
  }

  Row _distance() {
    final label = "15 km.";
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ActionChip(
          backgroundColor: FullfuelColors.secondary_20,
          labelStyle: TextStyle(color: FullfuelColors.secondary, fontSize: 16),
          padding: EdgeInsets.all(10),
          avatar: Icon(Icons.room, color: FullfuelColors.secondary, size: 20),
          label: Text(label),
          onPressed: () {},
        ),
      ],
    );
  }
}
