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
  bool isNowOpen;

  @HiveField(4)
  List<FuelPriceEntity> fuelPrices;

  @HiveField(5)
  String brandImage;

  FuelstationListEntity(
      {this.fuelstationID,
      this.name,
      this.distance,
      this.isNowOpen,
      this.fuelPrices,
      this.brandImage});

  factory FuelstationListEntity.fromJson(Map<String, dynamic> json) {
    return FuelstationListEntity(
        fuelstationID: json["fuelstationID"],
        name: json["name"],
        distance: json["distance"],
        isNowOpen: json["isNowOpen"],
        fuelPrices: FuelPriceEntity.fuelPriceListFromMap(json["fuelPrices"]),
        brandImage: json["brandImage"] != null ? json["brandImage"] : "");
  }
}
