import 'package:covid19_tracker/model/country_summary.dart';
import 'package:covid19_tracker/model/time_series_cases.dart';
import 'package:covid19_tracker/screens/chart.dart';
import 'package:covid19_tracker/utlis/utlis.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class CountryStastics extends StatelessWidget {
  const CountryStastics({Key key, this.summaryList}) : super(key: key);
  final List<CountrySummary> summaryList;
  static Size size;

  Widget buildcard(
      String leftTitle,
      int leftvalue,
      Color leftcolor,
      String rightTitle,
      int rightValue,
      Color rightcolor){
    return Card(
      elevation: 1,
      child: Container(
        height: size.height*0.15,
        padding: EdgeInsets.symmetric(
          horizontal: 16,vertical: 8
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,

          children: [
            Column(
              children: [
                Text(
                  leftTitle,
                  style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                Expanded(child: Container(),),

                Text(
                  "Total",
                  style: TextStyle(
                    color: leftcolor,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                Text(
                  leftvalue.toString(),
                  style: TextStyle(
                    color: leftcolor,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),

                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  rightTitle,
                  style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),

                Expanded(
                  child: Container(),
                ),

                Text(
                  "Total",
                  style: TextStyle(
                    color: rightcolor,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),

                Text(
                  rightValue.toString().replaceAllMapped(reg, mathFunc),
                  style: TextStyle(
                    color: rightcolor,
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),

              ],
            )

          ],
        ),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    size=MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildcard("Confirmed",
          summaryList[summaryList.length - 1].confirmed,
          kConfirmedColor,
          "Active",
          summaryList[summaryList.length - 1].active,
              kActiveColor,
      ),
          buildcard("Recovered",
            summaryList[summaryList.length - 1].recovered,
            kRecoveredColor,
            "Death",
            summaryList[summaryList.length - 1].death,
            kDeathColor,
          ),
          buildCardChart(summaryList),




        ],
      ),
    );
  }
  Widget buildCardChart(List<CountrySummary> summaryList){
    return Card(
      elevation: 1,
      child: Container(
        height: 190,
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Chart(
          _createData(summaryList),
          animate: false,
        ),
      ),
    );
  }
  static List<charts.Series<TimeSeriesCases, DateTime>>
  _createData(List<CountrySummary> summaryList)
  {
    List<TimeSeriesCases> confirmData=[];
    List<TimeSeriesCases> activeData=[];
    List<TimeSeriesCases> recoveredData=[];
    List<TimeSeriesCases> deathData=[];

    for(var item in summaryList){
      confirmData.add(TimeSeriesCases(item.dateTime, item.confirmed));
      activeData.add(TimeSeriesCases(item.dateTime,item.active));
      recoveredData.add(TimeSeriesCases(item.dateTime, item.recovered));
      deathData.add(TimeSeriesCases(item.dateTime,item.death));
    }

    return [
      new charts.Series<TimeSeriesCases, DateTime>(
        id: 'Confirmed',
        colorFn: (_, __) => charts.ColorUtil.fromDartColor(kConfirmedColor),
        domainFn: (TimeSeriesCases cases, _) => cases.time,
        measureFn: (TimeSeriesCases cases, _) => cases.cases,
        data: confirmData,
      ),
      new charts.Series<TimeSeriesCases, DateTime>(
        id: 'Active',
        colorFn: (_, __) => charts.ColorUtil.fromDartColor(kActiveColor),
        domainFn: (TimeSeriesCases cases, _) => cases.time,
        measureFn: (TimeSeriesCases cases, _) => cases.cases,
        data: activeData,
      ),
      new charts.Series<TimeSeriesCases, DateTime>(
        id: 'Recovered',
        colorFn: (_, __) => charts.ColorUtil.fromDartColor(kRecoveredColor),
        domainFn: (TimeSeriesCases cases, _) => cases.time,
        measureFn: (TimeSeriesCases cases, _) => cases.cases,
        data: recoveredData,
      ),
      new charts.Series<TimeSeriesCases, DateTime>(
        id: 'Death',
        colorFn: (_, __) => charts.ColorUtil.fromDartColor(kDeathColor),
        domainFn: (TimeSeriesCases cases, _) => cases.time,
        measureFn: (TimeSeriesCases cases, _) => cases.cases,
        data: deathData,
      ),
    ];
 }
  }
