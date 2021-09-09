import 'package:charts_flutter/flutter.dart'as charts;
import 'package:covid19_tracker/model/time_series_cases.dart';
import 'package:flutter/material.dart';


class Chart extends StatelessWidget {
  final List<charts.Series<TimeSeriesCases,DateTime>> seriesList;
final bool animate;
  Chart(this.seriesList, {this.animate});
  @override
  Widget build(BuildContext context) {
    return charts.TimeSeriesChart(
      seriesList,
      animate: animate,
      domainAxis: charts.EndPointsTimeAxisSpec(),
    );

  }}
