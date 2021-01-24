import 'package:hive/hive.dart';
import 'package:fullfuel_app/src/entities/fuel_price_entity.dart';

part 'fuelstation_list_entity.g.dart';

@HiveType(typeId: 0)
class FuelstationListEntity {
  @HiveField(0)
  int fuelstationID;

  @HiveField(1)
  String name;

  @HiveField(2)
  double distance;

  @HiveField(3)
  double latitude;

  @HiveField(4)
  double longitude;

  @HiveField(5)
  bool isNowOpen;

  @HiveField(6)
  List<FuelPriceEntity> fuelPrices;

  @HiveField(7)
  String brandImage;

  FuelstationListEntity(
      {this.fuelstationID,
      this.name,
      this.distance,
      this.latitude,
      this.longitude,
      this.isNowOpen,
      this.fuelPrices,
      this.brandImage});

  factory FuelstationListEntity.fromJson(Map<String, dynamic> json) {
    final coordinates = json["coordinates"];
    return FuelstationListEntity(
        fuelstationID: json["fuelstationID"],
        name: json["name"],
        distance: json["distance"].toDouble(),
        latitude: coordinates["latitude"],
        longitude: coordinates["longitude"],
        isNowOpen: json["isNowOpen"],
        fuelPrices: FuelPriceEntity.fuelPriceListFromMap(json["fuelPrices"]),
        brandImage: json["brandImage"] != null ? json["brandImage"] : "");
  }
}
