/// Line chart example
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:fullfuel_app/src/styles/fullfuel_colors.dart';

class LinearChartWidget extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  LinearChartWidget(this.seriesList, {this.animate});

  factory LinearChartWidget.withSampleData() {
    return new LinearChartWidget(
      _createSampleData(),
      animate: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final primaryAxisList = getPrimaryAxisList(1.129, 1.139);
    return new charts.LineChart(
      seriesList,
      animate: animate,
      primaryMeasureAxis: new charts.NumericAxisSpec(
          tickProviderSpec:
              new charts.StaticNumericTickProviderSpec(primaryAxisList)),
      defaultRenderer: new charts.LineRendererConfig(includePoints: true),
    );
  }

  List<charts.TickSpec<num>> getPrimaryAxisList(double min, double max) {
    List<charts.TickSpec<num>> axisList = [];
    double value = min;
    do {
      axisList.add(charts.TickSpec(value));
      value = value + 0.002;
    } while (value <= max);
    return axisList;
  }

  /// Create one series with sample hard coded data.
  static List<charts.Series<FuelPriceNode, int>> _createSampleData() {
    final myFakeDesktopData = [
      new FuelPriceNode(1, 1.129),
      new FuelPriceNode(2, 1.125),
      new FuelPriceNode(3, 1.132),
      new FuelPriceNode(4, 1.127),
      new FuelPriceNode(5, 1.125),
      new FuelPriceNode(6, 1.139)
    ];

    var myFakeTabletData = [
      new FuelPriceNode(1, 1.091),
      new FuelPriceNode(2, 1.101),
      new FuelPriceNode(3, 1.087),
      new FuelPriceNode(4, 1.095),
    ];

    return [
      new charts.Series<FuelPriceNode, int>(
        id: 'Gasolina 95',
        colorFn: (_, __) => charts.ColorUtil.fromDartColor(FullfuelColors.g95),
        domainFn: (FuelPriceNode sales, _) => sales.day,
        measureFn: (FuelPriceNode sales, _) => sales.price,
        data: myFakeDesktopData,
      ),
      // new charts.Series<FuelPriceNode, int>(
      //   id: 'Gasoil',
      //   colorFn: (_, __) =>
      //       charts.ColorUtil.fromDartColor(FullfuelColors.gasoil),
      //   domainFn: (FuelPriceNode sales, _) => sales.day,
      //   measureFn: (FuelPriceNode sales, _) => sales.price,
      //   data: myFakeTabletData,
      // ),
    ];
  }
}

class FuelPriceNode {
  final int day;
  final double price;

  FuelPriceNode(this.day, this.price);
}
