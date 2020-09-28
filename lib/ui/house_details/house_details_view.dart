import 'package:flutter/material.dart';
import 'package:flutter/src/rendering/sliver_persistent_header.dart';
import 'package:real_estate_app/Api/favourite.dart';
import 'file:///D:/projects/real_estate_app/lib/model/unified_model/properity_model.dart';
import 'package:real_estate_app/ui/house_details/house_details_param.dart';
import 'package:real_estate_app/widget/color_app.dart';
import 'package:real_estate_app/widget/global_text.dart';
import 'package:real_estate_app/widget/global_widget.dart';

class HouesDetailFavourits extends StatefulWidget {
  HouseDetails houseDetails;
  HouesDetailFavourits({this.houseDetails});
  @override
  _HouesDetailFavourits createState() => _HouesDetailFavourits();
}

class _HouesDetailFavourits extends State<HouesDetailFavourits> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverPersistentHeader(
            pinned: true,
            floating: true,
            delegate: PagerHeader(
                mminExtent: 150, maxExtent: 250, houseDetails: widget.houseDetails),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  priceAndDetail(widget.houseDetails.price.toString(),
                      widget.houseDetails, Colors.black54),
                  space(context),
                  showImageAndTitle(
                      icon: Icons.location_on,
                      context: context,
                      description: widget.houseDetails.areaCityName +
                          "  -  " +
                          widget.houseDetails.areaCityAddress),

                  showFullInfo(
                      context: context,
                      pro: widget.houseDetails.property,
                      icon: Icons.info),
                  showImageAndTitle(
                    icon: Icons.tablet_mac,
                    context: context,
                    description: (widget.houseDetails.phone == null)
                        ? "لا يوجد"
                        : widget.houseDetails.phone,
                  ),
                  showImageAndTitle(
                    icon: Icons.mail,
                    context: context,
                    description: (widget.houseDetails.email == null)
                        ? "لا يوجد"
                        : widget.houseDetails.email,
                  ),
                  Row(
                    children: <Widget>[],
                  ),
                  // showTwoButton(context),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.2,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget priceAndDetail(String price, HouseDetails properties, Color textColor) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 5),
          child: Row(
            children: [
              PropertyCardPrice(
                price: '\$ $price',
              ),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Text(
                "وصف المنزل\n" + "${properties.description}",
                style: TextStyle(color: textColor),
                textDirection: TextDirection.rtl,
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                  icon: Icon(
                    Icons.favorite,
                    color: (properties.property.isFavorite == true)
                        ? colorApp
                        : Colors.grey,
                  ),
                  onPressed: () async {
                    setState(() {
                      if (properties.property.isFavorite == true) {
                        properties.property.isFavorite = null;
                      } else {
                        properties.property.isFavorite = true;
                      }
                    });
                    await FavouriteApi.addToFavourite(
                        properties.properityId.toString());
                  }),
            ),
          ],
        )
      ],
    );
  }
}

Widget showFullInfo({BuildContext context, Property pro, IconData icon}) {
  return Padding(
    padding: EdgeInsets.only(top: 20, left: 5),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: ListView.builder(
            shrinkWrap: true,
            physics: BouncingScrollPhysics(),
            itemCount: pro.propertySpecs.length,
            itemBuilder: (context, index) {
              String name = "${pro.propertySpecs[index].name}";
              name += ":";
              for (int i = 0;
              i < pro.propertySpecs[index].propertyOptions.length;
              i++) {
                name += " " +
                    pro.propertySpecs[index].propertyOptions[i].typeOption
                        .name +
                    " ";
              }
              return PropertyCardDescription(
                description: name,
                colorDescription: Colors.black45,
              );

            },
          ),
        ),
        SizedBox(
          width: 10,
        ),
        Icon(icon, color: colorApp),

      ],
    ),
  );
}
Widget showImageAndTitle(
    {BuildContext context, String description, IconData icon}) {
  return Padding(
    padding: EdgeInsets.only(top: 20, left: 5),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: PropertyCardDescription(
            description: description,
            colorDescription: Colors.black45,
          ),
        ),
        SizedBox(
          width: 10,
        ),
        Icon(icon, color: colorApp),
      ],
    ),
  );
}

Widget space(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.only(top: 15),
    child: Container(
      width: MediaQuery.of(context).size.width,
      height: 1,
      color: Colors.black38,
    ),
  );
}

class PagerHeader implements SliverPersistentHeaderDelegate {
  final double maxExtent;
  final double mminExtent;
  HouseDetails houseDetails;

  PagerHeader({@required this.maxExtent, this.mminExtent, this.houseDetails});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        ImageCard(
          imageUrl: houseDetails.image,
        ),
        Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.transparent, Colors.black45],
                stops: [0.5, 1.0],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                tileMode: TileMode.repeated,
              )),
        ),
      ],
    );
  }

  @override
  // TODO: implement minExtent
  double get minExtent => mminExtent;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    // TODO: implement shouldRebuild
    return true;
  }

  @override
  // TODO: implement snapConfiguration
  FloatingHeaderSnapConfiguration get snapConfiguration => null;

  @override
  // TODO: implement stretchConfiguration
  OverScrollHeaderStretchConfiguration get stretchConfiguration => null;
}
