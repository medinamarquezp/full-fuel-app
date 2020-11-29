import 'package:hive/hive.dart';

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
  List<FuelPrice> fuelPrices;

  FuelstationListEntity(
      {this.fuelstationID,
      this.name,
      this.distance,
      this.isNowOpen,
      this.fuelPrices});

  factory FuelstationListEntity.fromJson(Map<String, dynamic> json) {
    if (json == null) {
      throw FormatException("Null JSON provided to FuelstationListModel");
    }
    return FuelstationListEntity(
        fuelstationID: json["fuelstationID"],
        name: json["name"],
        distance: json["distance"],
        isNowOpen: json["isNowOpen"],
        fuelPrices: json["fuelPrices"] != null
            ? List<FuelPrice>.from(json["fuelPrices"])
            : null);
  }
}

class FuelPrice {
  String fuelType;
  double price;
  String evolution;

  FuelPrice(this.fuelType, this.price, this.evolution);
}
