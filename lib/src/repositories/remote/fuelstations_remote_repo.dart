import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:fullfuel_app/src/entities/fuelstation_list_entity.dart';

class FuelstationsRemoteRepo {
  final _apiURL = DotEnv().env['API_URL'];
  final _authorization = DotEnv().env['API_AUTH_KEY'];
  double latitude;
  double longitude;

  FuelstationsRemoteRepo(this.latitude, this.longitude);

  Future<List<FuelstationListEntity>> fetchFuelstationsListGeo(
      {int radius = 1}) async {
    final url = "$_apiURL/fuelstations/list/geo/$latitude/$longitude/$radius";
    final rs = await http.get(url, headers: _headers());
    if (rs.statusCode == 200) {
      final rsDecoded = jsonDecode(rs.body);
      final responseList = rsDecoded["response"] as List;
      return _mapFuelStationList(responseList);
    } else {
      throw Exception('Failed to load fuelstations list');
    }
  }

  List<FuelstationListEntity> _mapFuelStationList(List<dynamic> responseList) {
    return responseList
        .map((fuelstationJson) =>
            FuelstationListEntity.fromJson(fuelstationJson))
        .toList();
  }

  Map<String, String> _headers() {
    return {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': _authorization,
    };
  }
}
