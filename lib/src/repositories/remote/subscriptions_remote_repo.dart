import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:fullfuel_app/src/repositories/remote/base_remote_repo.dart';

class SubscriptionsRemoteRepo extends BaseRemoteRepo {
  SubscriptionsRemoteRepo();

  Future<String> subscribe({int fuelstationID, String fuelType}) async {
    final url =
        "$apiURL/$apiVersion/subscriptions/add/$fuelstationID/$fuelType";
    final rs = await http.put(url, headers: headers());
    if (rs.statusCode == 200) {
      final rsDecoded = jsonDecode(rs.body);
      return rsDecoded["response"];
    } else {
      throw Exception(
          'Error on subscribing to $fuelType on fuel station $fuelstationID');
    }
  }

  Future<String> unsubscribe({int fuelstationID, String fuelType}) async {
    final url =
        "$apiURL/$apiVersion/subscriptions/remove/$fuelstationID/$fuelType";
    final rs = await http.put(url, headers: headers());
    if (rs.statusCode == 200) {
      final rsDecoded = jsonDecode(rs.body);
      return rsDecoded["response"];
    } else {
      throw Exception(
          'Error on unsubscribing to $fuelType on fuel station $fuelstationID');
    }
  }
}
