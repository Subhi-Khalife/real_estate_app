import 'package:flutter/material.dart';
import 'package:real_estate_app/widget/color_app.dart';
import 'package:real_estate_app/widget/global_widget.dart';
class CardDesignerHome extends StatelessWidget {
  String imageUrl;
  String price ;
  CardDesignerHome({@required this.imageUrl, @required this.price });

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
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15.0),
              child: ImageCard(
               imageUrl: imageUrl,
               height: 50,width: 100,
              ),
            ),
          ),
          Positioned(
            bottom:10 ,
            right: 20,
            child: Align(
              alignment: Alignment.bottomRight,
              child: ContainerONCard(
                price: price,
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
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Text(price + " ل.س",textDirection: TextDirection.rtl,style: TextStyle(color: activeIconNavBar),),
            Text(" السعر : ",textDirection: TextDirection.rtl,),
          ],
        ),
      ),
      padding: EdgeInsets.only(left: 8.0,right: 8.0),
    );
  }
}
