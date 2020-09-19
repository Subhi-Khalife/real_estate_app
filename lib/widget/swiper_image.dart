import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:real_estate_app/widget/color_app.dart';

class SwiperImage extends StatelessWidget {
  bool withRaduis;
  int count;
  bool showSwiperPagination;
  bool autoplay;
  bool loop;
  List<String> images;
  SwiperImage(
      {this.withRaduis = false,
      this.count = 4,
      this.images,
      this.autoplay = true,
      this.loop = true,
      this.showSwiperPagination = true});
  SwiperController swiperController = new SwiperController();
  SwiperPagination swiperPagination = new SwiperPagination(
    alignment: Alignment.bottomLeft,
    builder: new DotSwiperPaginationBuilder(
        color: Colors.grey[300], activeColor: colorApp, size: 6, space: 5),
  );
  @override
  Widget build(BuildContext context) {
    return Swiper(
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: EdgeInsets.only(bottom: 10),
          child: ClipRRect(
            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular((withRaduis) ? 45 : 0)),
            child: Stack(
              children: <Widget>[
                Container(
                    width: MediaQuery.of(context).size.width,
                    height: 300,
                    color: Colors.white,
                    child: Image.network(
                      images[index],
                      fit: BoxFit.fill,
                    )),
                topShadow(),
                buttomShadow(),
              ],

            ),
          ),
        );
      },
      loop: loop,
      outer: false,
      physics: AlwaysScrollableScrollPhysics(),
      scrollDirection: Axis.horizontal,
      controller: swiperController,
      itemCount: images.length,
      autoplay: autoplay,
    );
  }

  Widget topShadow() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: new BorderRadius.only(
            bottomRight: Radius.circular(0),
          ),
          gradient: LinearGradient(
            colors: [Colors.transparent, Colors.black87],
            stops: [0.5, 1.0],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            tileMode: TileMode.repeated,
          )),
    );
  }

  Widget buttomShadow() {
    return Padding(
      padding: EdgeInsets.only(bottom: 0),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: new BorderRadius.only(
              bottomRight: Radius.circular(0),
            ),
            gradient: LinearGradient(
              colors: [Colors.transparent, Colors.black87],
              stops: [0.5, 1.0],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              tileMode: TileMode.repeated,
            )),
      ),
    );
  }
}
/*
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:treadeshop/Widget/ColorApp.dart';
import 'package:treadeshop/Widget/export.dart';
import 'package:treadeshop/Widget/shop_vouchers_card.dart';


  Widget build(BuildContext context) {
    return Swiper(
      pagination: (showSwiperPagination) ? swiperPagination : null,
      itemBuilder: (BuildContext context, int index) {
        return (count == 4)
            ? Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: ClipRRect(
                    borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular((withRaduis) ? 45 : 0)),
                    child: Stack(
                      children: <Widget>[
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: 300,
                          color: Colors.white,
                          child: Image.network(
                            'https://images.pexels.com/photos/443356/pexels-photo-443356.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940',
                            fit: BoxFit.fill,
                          ),
                        ),
                        topShadow(),
                        buttomShadow(),
                      ],
                    )),
              )
            : (count == 5)
                ? Container(
                    height: 175,
                    width: MediaQuery.of(context).size.width * 0.97,
                    child: (index % 2 == 0)
                        ? ShopVouchersCard()
                        : ShopVouchersCard(
                            pircent: "100",
                          ),
                  )
                : Container(
                    height: MediaQuery.of(context).size.height * 0.5,
                    width: MediaQuery.of(context).size.width * 0.95,
                    child: Center(child: MyProductCompany()));
      },
      loop: loop,
      outer: true,
      physics: AlwaysScrollableScrollPhysics(),
      scrollDirection: Axis.horizontal,
      controller: swiperController,
      itemCount: count,
      autoplay: autoplay,
    );
  }

  Widget topShadow() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: new BorderRadius.only(
            bottomRight: Radius.circular(0),
          ),
          gradient: LinearGradient(
            colors: [Colors.transparent, Colors.black87],
            stops: [0.5, 1.0],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            tileMode: TileMode.repeated,
          )),
    );
  }

  Widget buttomShadow() {
    return Padding(
      padding: EdgeInsets.only(bottom: 0),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: new BorderRadius.only(
              bottomRight: Radius.circular(0),
            ),
            gradient: LinearGradient(
              colors: [Colors.transparent, Colors.black87],
              stops: [0.5, 1.0],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              tileMode: TileMode.repeated,
            )),
      ),
    );
  }
}
*/
