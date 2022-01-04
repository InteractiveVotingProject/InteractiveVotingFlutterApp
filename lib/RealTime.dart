import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class RealTime extends StatelessWidget {
  final List<charts.Series<dynamic, String>> seriesList;
  RealTime(this.seriesList);

  /// Creates a [BarChart] with sample data and no transition.
  factory RealTime.withSampleData() {
    return new RealTime(
      _createSampleData(),
    );
  }

  @override
  Widget build(BuildContext context) {
    // For horizontal bar charts, set the [vertical] flag to false.
    return new charts.BarChart(
      seriesList,
      vertical: false,
    );
  }

  /// Create one series with sample hard coded data.
  static List<charts.Series<OrdinalSales, String>> _createSampleData() {
    final data = [
      new OrdinalSales('1', 5),
      new OrdinalSales('2', 25),
      new OrdinalSales('3', 100),
      new OrdinalSales('4', 75),
    ];

    return [
      new charts.Series<OrdinalSales, String>(
        id: 'Sales',
        domainFn: (OrdinalSales sales, _) => sales.year,
        measureFn: (OrdinalSales sales, _) => sales.sales,
        data: data,
      )
    ];
  }
}

/// Sample ordinal data type.
class OrdinalSales {
  final String year;
  final int sales;
  OrdinalSales(this.year, this.sales);
}
