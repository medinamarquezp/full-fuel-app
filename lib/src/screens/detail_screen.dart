import 'package:flutter/material.dart';
import 'package:fullfuel_app/src/widgets/app_bar_widget.dart';
import 'package:fullfuel_app/src/widgets/app_bottom_navigation_bar_widget.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Map arguments = ModalRoute.of(context).settings.arguments as Map;
    final fuelstationID = arguments['fuelstationID'];
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBarWidget(),
        body: SafeArea(
          child: Stack(
            children: [
              Center(
                child: Text("FuelstationID: $fuelstationID"),
              )
            ],
          ),
        ),
        bottomNavigationBar: AppBottomNavigationBarWidget(index: 0));
  }
}
