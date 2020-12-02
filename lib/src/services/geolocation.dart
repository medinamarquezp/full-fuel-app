import 'package:geolocator/geolocator.dart';

class Geolocation {
  double latitude;
  double longitude;

  Geolocation(this.latitude, this.longitude);

  static Future<Geolocation> getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best,
        forceAndroidLocationManager: true);
    return Geolocation(position.latitude, position.longitude);
  }
}
