import 'package:covid19_tracker/screens/Country.dart';
import 'package:covid19_tracker/screens/Global.dart';
import 'package:covid19_tracker/screens/navigationOption.dart';
import 'package:covid19_tracker/utlis/utlis.dart';
import 'package:flutter/material.dart';
enum Navigationstatus{
  Global,
  Country,
}
class Tracker extends StatefulWidget {
  const Tracker({Key key}) : super(key: key);

  @override
  _TrackerState createState() => _TrackerState();
}

class _TrackerState extends State<Tracker> {
  Navigationstatus navigationstatus=Navigationstatus.Global;
  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    return Scaffold (
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        elevation: 0,
        title: Text("Covid-19 Tracker"),
      centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Container(
              width: double.infinity,
            padding: EdgeInsets.all(32),
            decoration: BoxDecoration(
              color: kPrimaryColor,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(50),
                bottomRight: Radius.circular(50),
              ),
            ),
            child: AnimatedSwitcher(
              duration: Duration(milliseconds: 250,),
              child:navigationstatus==Navigationstatus.Global?Global()
                  :Country(),
            ),
          ),
          ),
          Container(
            height: size.height*0.1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              NavigationOption(
                title: "Global",
                selected: navigationstatus==Navigationstatus.Global,
                onSelected: (){
                  setState(() {
                    navigationstatus=Navigationstatus.Global;
                  });
                },
              ),
              NavigationOption(
                title: "Country",
                selected: navigationstatus==Navigationstatus.Country,
                onSelected: (){
                  setState(() {
                    navigationstatus=Navigationstatus.Country;
                  });
                },
              ),
            ],),
          ),
        ],
      ),
    );
  }
}
