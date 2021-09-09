import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class GlobalLoading extends StatelessWidget {
  const GlobalLoading({Key key}) : super(key: key);
  static Size size;

  Widget loadingCard() {
    return Card(
      elevation: 1,
      child: Container(
        height: size.height*0.15,
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Shimmer.fromColors(
          baseColor: Colors.grey[300],
          highlightColor: Colors.grey[100],
          child: Column(
            children: [
              Container(
                width: 100,
                height: 20,
                color: Colors.white,
              ),
              Expanded(child: Container()),
              Container(
                width: double.infinity,
                height: 15,
                color: Colors.white,
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                width: double.infinity,
                height: 30,
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    size=MediaQuery.of(context).size;
    return Column(
      children: [
        loadingCard(),
        loadingCard(),
        loadingCard(),
        loadingCard(),
      ],
    );
  }
}
