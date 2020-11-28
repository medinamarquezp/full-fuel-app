import 'package:flutter/material.dart';
import 'package:fullfuel_app/src/screens/geolist_screen.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Fullfuel',
        debugShowCheckedModeBanner: false,
        home: GeolistScreen());
  }
}
