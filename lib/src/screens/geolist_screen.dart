import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:fullfuel_app/src/styles/fullfuel_colors.dart';
import 'package:fullfuel_app/src/widgets/app_bar_widget.dart';
import 'package:fullfuel_app/src/widgets/fuelstation_card_widget.dart';
import 'package:fullfuel_app/src/widgets/app_bottom_navigation_bar_widget.dart';
import 'package:fullfuel_app/src/entities/fuelstation_list_entity.dart';
import 'package:fullfuel_app/src/repositories/db/fuelstations_db_repo.dart';

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
          body: Column(
            children: [
              _distance(context),
              Expanded(
                child: GlowingOverscrollIndicator(
                  axisDirection: AxisDirection.down,
                  color: FullfuelColors.primary,
                  child: _fuelstationsList(),
                ),
              ),
            ],
          ),
          bottomNavigationBar: AppBottomNavigationBarWidget(index: 0)),
    );
  }

  ListView _fuelstationsList() {
    final configBox = Hive.box('config');
    final latitude = configBox.get('latitude');
    final longitude = configBox.get('longitude');
    final fuelstationsBox = Hive.box<FuelstationListEntity>('fuelstations');
    final dbRepo = FuelstationsDBRepo(fuelstationsBox);
    final fuelstationsList = dbRepo.getList().toList();
    return ListView.builder(
      itemCount: fuelstationsList.length,
      itemBuilder: (BuildContext context, int index) {
        return FuelstationCardWidget(
            fuelstationsList[index], latitude, longitude);
      },
    );
  }

  Row _distance(BuildContext context) {
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
          onPressed: () {
            Navigator.pushNamed(context, "config");
          },
        ),
      ],
    );
  }
}
