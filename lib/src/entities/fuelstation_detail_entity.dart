class FuelstationDetailEntity {
  int fuelstationID;
  String name;
  String brandImage;
  String address;
  double distance;
  double latitude;
  double longitude;
  String timetable;
  bool isNowOpen;
  int bestDay;
  String bestMoment;
  List<PricesExtended> fuelPrices;
  List<PriceEvolution> monthlyPriceEvolution;

  FuelstationDetailEntity(
      {this.fuelstationID,
      this.name,
      this.brandImage,
      this.address,
      this.distance,
      this.latitude,
      this.longitude,
      this.timetable,
      this.isNowOpen,
      this.bestDay,
      this.bestMoment,
      this.fuelPrices,
      this.monthlyPriceEvolution});

  factory FuelstationDetailEntity.fromJson(Map<String, dynamic> json) {
    final brandImage = json["brandImage"] != null ? json["brandImage"] : "";
    final coordinates = json["coordinates"];
    return FuelstationDetailEntity(
      fuelstationID: json["fuelstationID"],
      name: json["name"],
      brandImage: brandImage,
      address: json["address"],
      distance: json["distance"],
      latitude: coordinates["latitude"],
      longitude: coordinates["longitude"],
      timetable: json["timetable"],
      isNowOpen: json["isNowOpen"],
      bestDay: json["bestDay"],
      bestMoment: json["bestMoment"],
      fuelPrices: PricesExtended.pricesExtendedListFromMap(json["fuelPrices"]),
      monthlyPriceEvolution: PriceEvolution.priceEvolutionListFromMap(
          json["monthlyPriceEvolution"]),
    );
  }
}

class PricesExtended {
  String fuelType;
  double price;
  String evolution;
  double min;
  double max;
  double avg;

  PricesExtended(
      {this.fuelType,
      this.price,
      this.evolution,
      this.min,
      this.max,
      this.avg});

  factory PricesExtended.fromJson(Map<String, dynamic> json) {
    return PricesExtended(
        fuelType: json["fuelType"],
        price: json["price"],
        evolution: json["evolution"],
        min: json["min"],
        max: json["max"],
        avg: json["avg"]);
  }

  static List<PricesExtended> pricesExtendedListFromMap(List<dynamic> prices) {
    return prices.map((price) => PricesExtended.fromJson(price)).toList();
  }
}

class PriceEvolution {
  int month;
  int day;
  String fuelType;
  double price;

  PriceEvolution({this.month, this.day, this.fuelType, this.price});

  factory PriceEvolution.fromJson(Map<String, dynamic> json) {
    return PriceEvolution(
        month: json["month"],
        day: json["day"],
        fuelType: json["fuelType"],
        price: json["price"]);
  }

  static List<PriceEvolution> priceEvolutionListFromMap(
      List<dynamic> pricesEvolution) {
    return pricesEvolution
        .map((priceEvolution) => PriceEvolution.fromJson(priceEvolution))
        .toList();
  }
}
