import 'package:flutter/material.dart';
import 'package:real_estate_app/widget/color_app.dart';
import 'package:real_estate_app/widget/global_text.dart';
import 'package:real_estate_app/widget/global_widget.dart';

class PropertyCardInformation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ImageCard(
          imageUrl: "",
          height: MediaQuery.of(context).size.height*.25,
          width: MediaQuery.of(context).size.width*.9,
        ),

        Padding(
          padding: EdgeInsets.only(
              left: MediaQuery.of(context).size.width * 0.06,
              right: MediaQuery.of(context).size.width * 0.06,
              top: MediaQuery.of(context).size.width * 0.06,
              bottom: MediaQuery.of(context).size.width * 0.06),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                width:  MediaQuery.of(context).size.height*.4,
                child: Row(
                  children: <Widget>[
                    PropertyCardDescription(
                      description: "1,200 sq.ft",
                      colorDescription: Colors.black87,
                    ),
                    DotSpace(),
                    PropertyCardDescription(
                      description: "4 Beds",
                    ),
                    DotSpace(),
                    PropertyCardDescription(
                      description: "4 Bath",
                    ),
                  ],
                ),
              ),
              PropertyCardPrice(
                price: "\$4999",
              )
            ],
          ),
        ),
        
        Padding(
          padding: EdgeInsets.only(
              left: MediaQuery.of(context).size.width * 0.06,
              bottom: MediaQuery.of(context).size.width * 0.06),
          child: Row(
            children: <Widget>[
            Icon(Icons.location_on ,color: activeIconNavBar,size: 14,),
            SizedBox(width: 5,),
            PropertyCardDescription(
              description: '252 1st Avenue',
              colorDescription: Colors.black38,
            )
            ],
          ),
        )
      ],
    );
  }
}
