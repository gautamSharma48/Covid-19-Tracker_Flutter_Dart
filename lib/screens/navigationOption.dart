import 'package:covid19_tracker/utlis/utlis.dart';
import 'package:flutter/material.dart';
class NavigationOption extends StatelessWidget {
  final String title;
  final bool selected;
  final Function() onSelected;
  static Size size;
  const NavigationOption({Key key, this.title, this.selected, this.onSelected}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    size=MediaQuery.of(context).size;
    return GestureDetector(
      onTap: (){
        onSelected();
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Container(
              width: size.width*0.25,
              height: 50,
              margin: EdgeInsets.only(top: 10),
              decoration: BoxDecoration(
                color: selected?Colors.grey[400]:null,
                borderRadius: BorderRadius.all(Radius.circular(50)),
              ),
              child: Center(
                child: Text(title,
                style: TextStyle(
                  color: selected?kPrimaryColor:Colors.grey[400],
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
    ),
              ),
            ),
          ),
          selected?Column(
            children: [
              SizedBox(
                height: 12,
              ),
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: kPrimaryColor,
                  shape: BoxShape.circle,
                ),
              ),
            ],
          ) :Container(),
    ],
      )
    );
  }
}
