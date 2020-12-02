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
    if (mounted && latitude == null && longitude == null) {
      setState(() {
        latitude = double.parse(currentLocation.latitude.toStringAsFixed(6));
        longitude = double.parse(currentLocation.longitude.toStringAsFixed(6));
      });
    }
  }
}
