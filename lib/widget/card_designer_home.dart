import 'package:flutter/material.dart';
import 'package:projects/widget/color_app.dart';
import 'package:projects/widget/global_widget.dart';
class CardDesignerHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height *.3,
      width: MediaQuery.of(context).size.width*0.9,
      child: Stack(
        children: <Widget>[
          Positioned.fill(
            left: 10,
            right: 10,
            child: ImageCard(
             imageUrl: "",
             height: 50,width: 100,
            ),
          ),
          Positioned(
            bottom:10 ,
            right: 20,
            child: Align(
              alignment: Alignment.bottomRight,
              child: ContainerONCard(
                price: '\$ 1,999/sq.ft',
              ),
            ),
          )
        ],
      ),
    );
  }
}

class ContainerONCard extends StatelessWidget {
  final String price;

  ContainerONCard({@required this.price});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(13.0),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 60,
            spreadRadius: 0.0
          )
        ]
      ),
      child: Center(
        child: Row(
          children: <Widget>[
            Text("Starts at  "),
            Text(price,style: TextStyle(color: activeIconNavBar),),
          ],
        ),
      ),
      padding: EdgeInsets.only(left: 8.0,right: 8.0),
    );
  }
}
