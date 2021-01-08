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
  int month;
  List<DayPrice> g95;
  List<DayPrice> g98;
  List<DayPrice> gasoil;

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
      this.month,
      this.g95,
      this.g98,
      this.gasoil});

  factory FuelstationDetailEntity.fromJson(Map<String, dynamic> json) {
    final brandImage = json["brandImage"] != null ? json["brandImage"] : "";
    final coordinates = json["coordinates"];
    final List<dynamic> g95 = json["monthlyPriceEvolution"]["g95"];
    final List<dynamic> g98 = json["monthlyPriceEvolution"]["g98"];
    final List<dynamic> gasoil = json["monthlyPriceEvolution"]["gasoil"];
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
      month: json["monthlyPriceEvolution"]["month"],
      g95: (g95.isNotEmpty) ? DayPrice.dayPriceListFromMap(g95) : [],
      g98: (g98.isNotEmpty) ? DayPrice.dayPriceListFromMap(g98) : [],
      gasoil: (gasoil.isNotEmpty) ? DayPrice.dayPriceListFromMap(gasoil) : [],
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

class DayPrice {
  int day;
  double price;

  DayPrice({this.day, this.price});

  factory DayPrice.fromJson(Map<String, dynamic> json) {
    return DayPrice(day: json["day"], price: double.parse(json["price"]));
  }

  static List<DayPrice> dayPriceListFromMap(List<dynamic> dayprices) {
    return dayprices.map((dayPrice) => DayPrice.fromJson(dayPrice)).toList();
  }
}
