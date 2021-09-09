import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
class CountryLoading extends StatelessWidget {
  const CountryLoading({Key key, this.inputTextLoading}) : super(key: key);
final bool inputTextLoading;
static Size size;
  @override
  Widget build(BuildContext context) {
    size=MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: [
          inputTextLoading?loadingInputcard()
              :Container(),
          loadingCard(),
          loadingCard(),
          loadingChartCard(),
        ],
      ),
    );
  }


  Widget loadingCard(){
    return Card(
      elevation: 1,
        child: Container(
          height: size.height*0.1,
          padding: EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
          child: Shimmer.fromColors(
            baseColor: Colors.grey[300],
            highlightColor: Colors.grey[100],
            child: Column(
              children: [
                Container(
                  width: size.width*0.12,
                  height: size.height*0.02,
                  color:Colors.white,
                ),
                Expanded(child:
                Container(
                )),
                Container(
                  width: double.infinity,
                  height: size.height*0.02,
                  color:Colors.white,
                ),
                SizedBox(height: 5,),
                Container(
                  width:double.infinity,
                  height: size.height*0.02,
                  color:Colors.white,
                ),
              ],
            ),
          ),
        ),
    );
  }

  Widget loadingInputcard(){
    return Card(
      elevation: 1,
      child: Container(
        height: size.height*0.10,
        padding: EdgeInsets.all(24),
        child: Shimmer.fromColors(
            child: Container(
              width: double.infinity,
              height: 57,
              color: Colors.white,
            ),
            baseColor: Colors.grey[300],
            highlightColor: Colors.grey[100]),
      ),
    );
  }
  Widget loadingChartCard(){
    return Card(
      elevation:1 ,
      child: Container(
        height: 100,
        padding: EdgeInsets.symmetric(
          horizontal: 16,vertical: 8
        ),
        child: Shimmer.fromColors(
            child: Column(
              children: [
                Expanded(child: Container(
                  color: Colors.white,
                ))
              ],
            ),
            baseColor:Colors.grey[300],
            highlightColor:Colors.grey[100]),
      ),
    );
  }
}
