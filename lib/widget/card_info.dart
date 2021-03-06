import 'package:flutter/material.dart';
import 'package:real_estate_app/widget/color_app.dart';
import 'package:real_estate_app/widget/global_text.dart';
import 'package:real_estate_app/widget/global_widget.dart';

class PropertyCardInformation extends StatelessWidget {
  String price, address, description, space;
  List<String> images = List<String>();
  String img;
  String type;
  PropertyCardInformation(
      {this.price,
      this.address,
      this.description,
      this.space,
      this.images,
      this.img,
      this.type});
  @override
  Widget build(BuildContext context) {
    print("the image is :: $img");
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        ClipRRect(
          borderRadius: BorderRadius.circular(15.0),
          child: ImageCard(
            imageUrl: "$img",
            height: MediaQuery.of(context).size.height * .25,
            width: MediaQuery.of(context).size.width * .9,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 6, left: 4, right: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              PropertyCardDescription(
                description: space + " متر مربع",
                colorDescription: Colors.black87,
              ),
              Spacer(),
              Directionality(
                textDirection: TextDirection.rtl,
                child: Padding(
                  padding:  EdgeInsets.only(right: 10.0),
                  child: PropertyCardPrice(
                    price: price + " ل.س",
                  ),
                ),
              )
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 6, left: 4, right: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Icon(
                Icons.location_on,
                color: activeIconNavBar,
                size: 14,
              ),
              SizedBox(
                width: 5,
              ),
              PropertyCardDescription(
                description: '$address',
                colorDescription: Colors.black38,
              )
            ],
          ),
        )
      ],
    );
  }
}
