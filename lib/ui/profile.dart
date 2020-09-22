import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:real_estate_app/Provider/google_map_provider.dart';
import 'package:real_estate_app/Provider/provier_property.dart';
import 'package:real_estate_app/bloc/explore_bloc/explore_dart_bloc.dart';
import 'package:real_estate_app/ui/add_properity/add_property_spec_and_image.dart';
import 'package:real_estate_app/ui/house_detail.dart';
import 'package:real_estate_app/widget/card_info.dart';
import 'package:real_estate_app/widget/color_app.dart';

class ProfileView extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<ProfileView> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: body(),
    );
  }

  Widget appBar() {
    return AppBar(
      backgroundColor: Colors.grey.shade100,
      elevation: 0,
      centerTitle: false,
      actions: <Widget>[
        Transform.translate(
          offset: Offset(0,15),
          child: Text("الملف الشخصي",style: TextStyle(
              fontSize: 20,color: Colors.black54
          ),),
        ),
        SizedBox(width: 25,),
      ],
    );
  }
  Widget body(){
    return ListView(
      padding: EdgeInsets.only(top: 20,bottom: 20,right: 15,left: 15),
      children: [
        profileImage(),
        space(height: 30),
        rowInfo(
          text: "safdas",
          title: "sadasda :"
        ),
        space(),
        Divider(),
        space(),
        rowInfo(
            text: "safdas",
            title: "sadasda :"
        ),
        space(),
        Divider(),
        space(),
        rowInfo(
            text: "safdas",
            title: "sadasda :"
        ),
        space(),
        Divider(),
        space(),
      ],
    );
  }

  Widget space({double height , double width}){
    return SizedBox(height: height ?? 10, width: width ?? 0,);
  }

  Widget rowInfo({@required String title ,@required String text}){
    return Row(
      mainAxisAlignment:MainAxisAlignment.end,
      children: [
        Text(text,textDirection: TextDirection.rtl,style: TextStyle(color: Colors.black,fontSize: 18),),
        SizedBox(width: 20,),
        Text(title,textDirection: TextDirection.rtl,style: TextStyle(color: Colors.black,fontSize: 18),),
        SizedBox(width: 10,),
      ],
    );
  }
  Widget profileImage(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Material(
          elevation: 5.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(90)
          ),
          shadowColor: activeIconNavBar.withOpacity(0.3),
          child: Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white
            ),
          ),
        ),
      ],
    );
  }
}
