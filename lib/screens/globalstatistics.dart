import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:covid19_tracker/utlis/utlis.dart';
import 'package:covid19_tracker/model/global_summary.dart';
import 'package:timeago/timeago.dart' as timeago;
class GlobalStatistics extends StatelessWidget {
  const GlobalStatistics({Key key, this.summary}) : super(key: key);
  static Size size;
  final GlobalSummary summary;
  

  Widget buildcard(String title,int totalcount,int todaycount,Color colorvalue){

    return Card(
      elevation:1,
      child:Container(
        height: size.height*0.13,
        padding: EdgeInsets.symmetric(
          horizontal: 16,vertical: 8),
      child: Column(
        children: [
          Text(title,
          style: TextStyle(
            color: Colors.grey,
            fontSize:14 ,
            fontWeight:FontWeight.bold ,
          ),),
          Expanded(child: Container()),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Total",
                    style:TextStyle(
                      color: colorvalue,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),),
                  Text(totalcount.toString().replaceAllMapped(reg,mathFunc),
                    style:TextStyle(
                      color: colorvalue,
                      fontWeight: FontWeight.bold,
                      fontSize: 23,
                    ),),
                ],

              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text("Today",
                    style:TextStyle(
                      color: colorvalue,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),),
                  Text(todaycount.toString().replaceAllMapped(reg,mathFunc),
                    style:TextStyle(
                      color: colorvalue,
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),),
                ],
              ),
            ],
          )
        ],
      ),
    )
    );
  }
  @override

  Widget build(BuildContext context) {
    String text="Affected Country - ";
     size=MediaQuery.of(context).size;
    return Column(
      children: [
        buildcard("ConFirmed",
        summary.totalConfirmed,
        summary.newConfirmed,
          kConfirmedColor,
        ),
        buildcard("Active Cases",
          summary.totalConfirmed-summary.totalDeaths,
          summary.newConfirmed-summary.newDeaths,
          kActiveColor,
        ),
        buildcard("Recovered",
          summary.totalRecovered,
          summary.newRecovered,
          kRecoveredColor,
        ),
        buildcard("Deaths",
          summary.totalDeaths,
          summary.newDeaths,
          kDeathColor,
        ),
        Padding(padding: EdgeInsets.symmetric(horizontal: 4,vertical: 6),
        child: Text(text+summary.affectedCountry.toString()
          ,
          style:
          TextStyle(color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 14,),
        ),
        ),
      ],
    );
  }

}
