import 'package:flutter/material.dart';
import 'package:fullfuel_app/src/services/geolocation.dart';

mixin LocationMixin<T extends StatefulWidget> on State<T> {
  double latitude;
  double longitude;

  @override
  void initState() {
    super.initState();
    getCurrentLocation();
  }

  void getCurrentLocation() async {
    Geolocation currentLocation = await Geolocation.getCurrentLocation();
    this.latitude = currentLocation.latitude;
    this.longitude = currentLocation.longitude;
  }
}
