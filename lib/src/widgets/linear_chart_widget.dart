/// Line chart example
import 'package:charts_flutter/flutter.dart' as charts;
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:fullfuel_app/src/styles/fullfuel_colors.dart';
import 'package:fullfuel_app/src/entities/fuelstation_detail_entity.dart';

class LinearChartWidget extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;
  static double minPrice;
  static double maxPrice;

  LinearChartWidget(this.seriesList, {this.animate});

  factory LinearChartWidget.create(List<PricesExtended> fuelPrices) {
    final chartSeries = _processData(fuelPrices);
    return new LinearChartWidget(
      chartSeries,
      animate: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final primaryAxisList = getPrimaryAxisList(minPrice, maxPrice);
    return new charts.NumericComboChart(
      seriesList,
      animate: animate,
      primaryMeasureAxis: new charts.NumericAxisSpec(
          tickProviderSpec:
              new charts.StaticNumericTickProviderSpec(primaryAxisList)),
      defaultRenderer: new charts.LineRendererConfig(includePoints: true),
      behaviors: [
        new charts.SeriesLegend(position: charts.BehaviorPosition.bottom),
      ],
    );
  }

  List<charts.TickSpec<num>> getPrimaryAxisList(double min, double max) {
    List<charts.TickSpec<num>> axisList = [];
    double increment = 0.020;
    double value = min;
    double maxAxis = max + increment;
    do {
      axisList.add(charts.TickSpec(value));
      value = value + increment;
    } while (value <= maxAxis);
    return axisList;
  }

  static List<charts.Series<DayPrice, int>> _processData(
      List<PricesExtended> fuelPrices) {
    List<double> minPrices = [];
    List<double> maxPrices = [];
    List<DayPrice> g95 = [];
    List<DayPrice> g98 = [];
    List<DayPrice> gasoil = [];

    for (final fuelPrice in fuelPrices) {
      final fuelType = fuelPrice.fuelType;
      final List<DayPrice> fuelPricesByDay =
          fuelPrice.monthlyPriceEvolution.prices;
      minPrices.add(fuelPrice.min);
      maxPrices.add(fuelPrice.max);
      for (final dayPrice in fuelPricesByDay) {
        if (fuelType == "g95") g95.add(dayPrice);
        if (fuelType == "g98") g98.add(dayPrice);
        if (fuelType == "gasoil") gasoil.add(dayPrice);
      }
    }

    minPrice = minPrices.reduce(min);
    maxPrice = maxPrices.reduce(max);
    return _generateChartSeries(g95, g98, gasoil);
  }

  static List<charts.Series<DayPrice, int>> _generateChartSeries(
      List<DayPrice> g95, List<DayPrice> g98, List<DayPrice> gasoil) {
    List<charts.Series<DayPrice, int>> chartSeries = [];
    if (g95.isNotEmpty) {
      final g95ChartSerie = charts.Series<DayPrice, int>(
        id: 'Gasolina 95',
        colorFn: (_, __) => charts.ColorUtil.fromDartColor(FullfuelColors.g95),
        domainFn: (DayPrice dayPrices, _) => dayPrices.day,
        measureFn: (DayPrice dayPrices, _) => dayPrices.price,
        data: g95,
      );
      chartSeries.add(g95ChartSerie);
    }

    if (g98.isNotEmpty) {
      final g98ChartSerie = charts.Series<DayPrice, int>(
        id: 'Gasolina 98',
        colorFn: (_, __) => charts.ColorUtil.fromDartColor(FullfuelColors.g98),
        domainFn: (DayPrice dayPrices, _) => dayPrices.day,
        measureFn: (DayPrice dayPrices, _) => dayPrices.price,
        data: g98,
      );
      chartSeries.add(g98ChartSerie);
    }

    if (gasoil.isNotEmpty) {
      final gasoilChartSerie = charts.Series<DayPrice, int>(
        id: 'Gasoil',
        colorFn: (_, __) =>
            charts.ColorUtil.fromDartColor(FullfuelColors.gasoil),
        domainFn: (DayPrice dayPrices, _) => dayPrices.day,
        measureFn: (DayPrice dayPrices, _) => dayPrices.price,
        data: gasoil,
      );
      chartSeries.add(gasoilChartSerie);
    }
    return chartSeries;
  }
}
