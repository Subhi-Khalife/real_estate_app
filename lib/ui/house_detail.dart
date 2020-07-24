import 'package:flutter/material.dart';
import 'package:flutter/src/rendering/sliver_persistent_header.dart';
import 'package:real_estate_app/widget/global_text.dart';

class HouesDetail extends StatefulWidget {
  @override
  _HouesDetail createState() => _HouesDetail();
}

class _HouesDetail extends State<HouesDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverPersistentHeader(
            pinned: true,
            floating: true,
            delegate: PagerHeader(mminExtent: 150, maxExtent: 250),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  priceAndDetail(),
                  space(context),
                  showImageAndTitle(
                      icon: Icons.star,
                      context: context,
                      description:
                          " hello hello hello hello  hello hello hello hello  hello hello hello hello  hello hello hello hello "),
                  showImageAndTitle(
                      icon: Icons.group,
                      context: context,
                      description: "hello hello hello hellohello hello ello "),
                  showImageAndTitle(
                      icon: Icons.account_box,
                      context: context,
                      description: "hello hello  hello "),
                  Row(
                    children: <Widget>[],
                  ),
                  showTwoButton(context),
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
}

Widget showTwoButton(BuildContext context) {
  return Padding(
    padding: EdgeInsets.only(top: 20),
    child: Row(
      children: <Widget>[
        //context, ,Colors.white
        Flexible(
            child: button(
                context: context,
                color: Colors.white,
                text: "Ask a Question",
                textColor: Colors.black)),
        Flexible(
            child: button(
                context: context,
                color: Colors.red,
                text: "Express interest",
                textColor: Colors.white))
      ],
    ),
  );
}

Widget button(
    {BuildContext context, String text, Color color, Color textColor}) {
  return GestureDetector(
    onTap: () {},
    child: Container(
      width: MediaQuery.of(context).size.width,
      height: 75,
      child: Card(
        color: color,
        child: Center(
            child: Text(
          text,
          style: TextStyle(color: textColor),
        )),
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
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
        Icon(icon, color: Colors.red),
        SizedBox(
          width: 10,
        ),
        PropertyCardDescription(
          description: description,
          colorDescription: Colors.black45,
        )
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

Widget priceAndDetail() {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      PropertyCardPrice(
        price: '\$4.999',
      ),
      Align(
        alignment: Alignment.centerRight,
        child: IconButton(icon: Icon(Icons.favorite), onPressed: () {}),
      ),
    ],
  );
}

class PagerHeader implements SliverPersistentHeaderDelegate {
  final double maxExtent;
  final double mminExtent;

  PagerHeader({@required this.maxExtent, this.mminExtent});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        Image.network(
          'https://images.pexels.com/photos/443356/pexels-photo-443356.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940',
          fit: BoxFit.cover,
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
