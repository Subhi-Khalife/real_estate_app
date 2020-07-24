import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:real_estate_app/ui/house_detail.dart';
import 'package:real_estate_app/widget/card_category_just_in.dart';
import 'package:real_estate_app/widget/card_designer_home.dart';
import 'package:real_estate_app/widget/global_text.dart';

class HousesCategory extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HousesCategory();
  }
}

class _HousesCategory extends State<HousesCategory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              TitleListBuilder(
                  title: "Just in", seeAllText: "view All", onTapSeeAll: () {}),
              houseIntoJsutIn(),
              TitleListBuilder(
                  title: "Designer Homes",
                  seeAllText: "view All",
                  onTapSeeAll: () {}),
              designerHome(),
            ],
          ),
        ),
      ),
    );
  }

  Widget designerHome() {
    return Padding(
      padding: EdgeInsets.only(top: 20),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * .3,
        child: ListView.builder(
          shrinkWrap: true,
          physics: BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            return GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => HouesDetail()));
                },
                child: CardDesignerHome());
          },
          itemCount: 9,
          scrollDirection: Axis.horizontal,
        ),
      ),
    );
  }

  Widget houseIntoJsutIn() {
    return Padding(
      padding: EdgeInsets.only(top: 20),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * .45,
        child: ListView.builder(
          shrinkWrap: true,
          physics: BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            return GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => HouesDetail()));
                },
                child: CardJustIn());
          },
          itemCount: 9,
          scrollDirection: Axis.horizontal,
        ),
      ),
    );
  }
}
