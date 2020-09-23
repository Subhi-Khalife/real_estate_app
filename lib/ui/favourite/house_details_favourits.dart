import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/rendering/sliver_persistent_header.dart';
import 'package:real_estate_app/Api/favourite.dart';
import 'package:real_estate_app/model/filter_model.dart';
import 'package:real_estate_app/model/get_all_favourites_model.dart';
import 'package:real_estate_app/widget/color_app.dart';
import 'package:real_estate_app/widget/global_text.dart';
import 'package:real_estate_app/widget/global_widget.dart';
import 'package:real_estate_app/widget/swiper_image.dart';

class HouesDetailFavourits extends StatefulWidget {
  Datumes properties;
  HouesDetailFavourits({this.properties});
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
                mminExtent: 150, maxExtent: 250, properties: widget.properties.property),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  priceAndDetail(widget.properties.property.price.toString(),
                      widget.properties.property, Colors.black54),
                  space(context),
                  showImageAndTitle(
                      icon: Icons.location_on,
                      context: context,
                      description: widget.properties.property.area.cityName +
                          "  -  " +
                          widget.properties.property.address),

                  showFullInfo(
                      context: context,
                      pro: widget.properties.property,
                      icon: Icons.info),
                  showImageAndTitle(
                    icon: Icons.tablet_mac,
                    context: context,
                    description: (widget.properties.property.user.phone == null)
                        ? "لا يوجد"
                        : widget.properties.property.user.phone,
                  ),
                  showImageAndTitle(
                    icon: Icons.mail,
                    context: context,
                    description: (widget.properties.property.user.email == null)
                        ? "لا يوجد"
                        : widget.properties.property.user.email,
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

  Widget priceAndDetail(String price, Property properties, Color textColor) {
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
                    color: (properties.isFavorite == true)
                        ? colorApp
                        : Colors.grey,
                  ),
                  onPressed: () async {
                    setState(() {
                      if (properties.isFavorite == true) {
                        properties.isFavorite = null;
                      } else {
                        properties.isFavorite = true;
                      }
                    });
                    await FavouriteApi.addToFavourite(
                        properties.id.toString());
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
              // return Row(
              //   children: [
              //     PropertyCardDescription(
              //       description: pro.propertySpecs[index].name,
              //       colorDescription: Colors.black45,
              //     ),
              //      ListView.builder(itemBuilder: (context,index){
              //        return  PropertyCardDescription(
              //          description: pro.propertySpecs[index].name,
              //          colorDescription: Colors.black45,
              //        );
              //      })
              //   ],
              // );
            },
          ),
        ),
        SizedBox(
          width: 10,
        ),
        Icon(icon, color: colorApp),

        // Expanded(
        //   child: PropertyCardDescription(
        //     description: description,
        //     colorDescription: Colors.black45,
        //   ),
        // )
      ],
    ),
  );
}
//
// Widget showTwoButton(BuildContext context) {
//   return Padding(
//     padding: EdgeInsets.only(top: 20),
//     child: Row(
//       children: <Widget>[
//         //context, ,Colors.white
//         Flexible(
//             child: button(
//                 context: context,
//                 color: Colors.white,
//                 text: "Ask a Question",
//                 textColor: colorApp)),
//         Flexible(
//             child: button(
//                 context: context,
//                 color: colorApp,
//                 text: "Express interest",
//                 textColor: Colors.white))
//       ],
//     ),
//   );
// }

// Widget button(
//     {BuildContext context, String text, Color color, Color textColor}) {
//   return GestureDetector(
//     onTap: () {},
//     child: Container(
//       width: MediaQuery.of(context).size.width,
//       height: 60,
//       child: Card(
//         color: color,
//         child: Center(
//             child: Text(
//               text,
//               style: TextStyle(color: textColor),
//             )),
//         elevation: 2,
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//       ),
//     ),
//   );
// }

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
  Property properties;

  PagerHeader({@required this.maxExtent, this.mminExtent, this.properties});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        ImageCard(
          imageUrl: properties.img,
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
