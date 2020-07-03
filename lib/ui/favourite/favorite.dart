import 'package:flutter/material.dart';
import 'package:projects/ui/house_detail.dart';
import 'package:projects/widget/card_info.dart';

class FavoriteView extends StatefulWidget {
  @override
  _FavoriteViewState createState() => _FavoriteViewState();
}

class _FavoriteViewState extends State<FavoriteView> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 50),
      child: Container(
          child: ListView.builder(
        itemBuilder: (context, index) {
          return InkWell(
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => HouesDetail()));
              },
              child: PropertyCardInformation());
        },
        itemCount: 5,
      )),
    );
  }
}
