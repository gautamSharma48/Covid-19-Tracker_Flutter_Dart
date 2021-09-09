import 'package:covid19_tracker/screens/global_loading.dart';
import 'package:covid19_tracker/screens/globalstatistics.dart';
import 'package:covid19_tracker/services/covid_services.dart';
import 'package:flutter/material.dart';
import 'package:covid19_tracker/model/global_summary.dart';

CovidServices covidService = CovidServices();

class Global extends StatefulWidget {
  const Global({Key key}) : super(key: key);

  @override
  _GlobalState createState() => _GlobalState();
}

class _GlobalState extends State<Global> {
  Future<GlobalSummary> summary;

  @override
  void initState() {
    super.initState();
    summary = covidService.getGlobalSummary();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 4, vertical: 6),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

              Text(
                "Global Corona Virus Cases",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              GestureDetector(
                onTap: (){
                 setState(() {
                   summary = covidService.getGlobalSummary();

                 }); },
                child: Icon(
                  Icons.refresh,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        SingleChildScrollView(
          child: Column(children: [
            FutureBuilder(
                future: summary,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Text('Error'),
                    );
                  }
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      return GlobalLoading();
                    default:
                      return !snapshot.hasData
                          ? Center(
                              child: Text("Empty"),
                            )
                          : GlobalStatistics(summary: snapshot.data);
                  }
                }),
          ]),
        ),
      ],
    );
  }
}
