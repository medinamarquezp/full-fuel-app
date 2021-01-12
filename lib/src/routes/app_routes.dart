import "package:flutter/material.dart";
import 'package:fullfuel_app/src/screens/splash_screen.dart';
import 'package:fullfuel_app/src/screens/network_error_screen.dart';
import 'package:fullfuel_app/src/screens/geolist_screen.dart';
import 'package:fullfuel_app/src/screens/favourites_screen.dart';
import 'package:fullfuel_app/src/screens/detail_screen.dart';
import 'package:fullfuel_app/src/screens/config_screen.dart';

Map<String, Widget Function(BuildContext)> getAppRoutes() {
  return {
    "/": (context) => SplashScreen(),
    "networkError": (context) => NetworkErrorScreen(),
    "geolist": (context) => GeolistScreen(),
    "favourites": (context) => FavouritesScreen(),
    "detail": (context) => DetailScreen(),
    "config": (context) => ConfigScreen(),
  };
}

String getNavigationRouteName(int index) {
  final routes = ["geolist", "favourites", "geolist", "config"];
  return routes[index];
}
