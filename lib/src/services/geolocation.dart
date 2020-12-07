import 'package:geolocator/geolocator.dart';

class Geolocation {
  double latitude;
  double longitude;

  Geolocation(this.latitude, this.longitude);

  static Future<Geolocation> getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    final latitude = double.parse(position.latitude.toStringAsFixed(6));
    final longitude = double.parse(position.longitude.toStringAsFixed(6));
    return Geolocation(latitude, longitude);
  }

  static String getDistance(double fromLatitude, double fromLongitude,
      double toLatitude, double toLongitude) {
    final distance = Geolocator.distanceBetween(
        fromLatitude, fromLongitude, toLatitude, toLongitude);
    return (distance < 1000.00)
        ? "A ${getDistanceInMeters(distance)} M"
        : "A ${mToKm(distance)} KM";
  }

  static int getDistanceInMeters(double distance) {
    return (distance != null) ? distance.round() : 0;
  }

  static String mToKm(double distance) {
    return (distance != null) ? (distance / 1000).toStringAsFixed(2) : "";
  }
}
