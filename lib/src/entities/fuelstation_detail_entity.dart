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
      this.fuelPrices});

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
        fuelPrices:
            PricesExtended.pricesExtendedListFromMap(json["fuelPrices"]));
  }
}

class PricesExtended {
  String fuelType;
  double price;
  String evolution;
  double min;
  double max;
  double avg;
  MonthlyPriceEvolution monthlyPriceEvolution;

  PricesExtended(
      {this.fuelType,
      this.price,
      this.evolution,
      this.min,
      this.max,
      this.avg,
      this.monthlyPriceEvolution});

  factory PricesExtended.fromJson(Map<String, dynamic> json) {
    return PricesExtended(
        fuelType: json["fuelType"],
        price: json["price"],
        evolution: json["evolution"],
        min: json["min"],
        max: json["max"],
        avg: json["avg"],
        monthlyPriceEvolution:
            MonthlyPriceEvolution.fromJson(json["monthlyPriceEvolution"]));
  }

  static List<PricesExtended> pricesExtendedListFromMap(
      List<dynamic> fuelPrices) {
    return fuelPrices.map((fp) => PricesExtended.fromJson(fp)).toList();
  }
}

class MonthlyPriceEvolution {
  int month;
  int year;
  List<DayPrice> prices;

  MonthlyPriceEvolution({this.month, this.year, this.prices});

  factory MonthlyPriceEvolution.fromJson(Map<String, dynamic> json) {
    return MonthlyPriceEvolution(
        month: json["month"],
        year: json["year"],
        prices: DayPrice.dayPriceListFromMap(json["prices"]));
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
