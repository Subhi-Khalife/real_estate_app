import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:real_estate_app/ui/onboarding.dart';
import 'package:real_estate_app/widget/color_app.dart';


class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 3),(){
      Navigator.push(context, CupertinoPageRoute(
        builder: (context) => Onboarding()
      ));
    });
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [colorApp,
          activeIconNavBar],
          begin: Alignment.bottomCenter,end: Alignment.topCenter,
          stops: [0.1,0.9],tileMode: TileMode.clamp
        ),
      ),
      child: Center(
        child: CupertinoActivityIndicator(
          animating: true,radius: 25,
        ),
      ),
    );
  }
}
