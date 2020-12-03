import 'package:hive/hive.dart';

part 'fuel_price_entity.g.dart';

@HiveType(typeId: 1)
class FuelPriceEntity {
  @HiveField(0)
  String fuelType;

  @HiveField(1)
  double price;

  @HiveField(2)
  String evolution;

  FuelPriceEntity({this.fuelType, this.price, this.evolution});

  factory FuelPriceEntity.fromJson(Map<String, dynamic> json) {
    return FuelPriceEntity(
        fuelType: json["fuelType"],
        price: json["price"],
        evolution: json["evolution"]);
  }

  static List<FuelPriceEntity> fuelPriceListFromMap(List<dynamic> fuelPrices) {
    return fuelPrices
        .map((fuelPrice) => FuelPriceEntity.fromJson(fuelPrice))
        .toList();
  }

  static getFuelNameFromType(String fueltype) {
    switch (fueltype) {
      case "g95":
        return "GASOLINA 95";
      case "g98":
        return "GASOLINA 98";
      case "gasoil":
        return "GASOIL";
    }
  }
}
