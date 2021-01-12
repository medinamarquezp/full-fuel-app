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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: FullfuelColors.secondary_5,
        appBar: AppBarWidget(),
        body: Column(
          children: [
            _configTitle(),
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
}
