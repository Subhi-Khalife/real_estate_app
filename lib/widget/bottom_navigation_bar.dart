import 'package:flutter/material.dart';
import 'package:real_estate_app/widget/color_app.dart';


class BottomNavBar extends StatefulWidget {
  final IconData iconExplore , iconFavorite ,iconAlert ,iconProfile;
  final String textExplore , textFavorite ,textAlert ,textProfile ;
  final Function onTap ;
  int index;

  BottomNavBar(
      {@required this.iconExplore,
        @required this.iconFavorite,
        @required this.iconAlert,
        @required this.iconProfile,
        @required this.textExplore,
        @required this.textFavorite,
        @required this.textAlert,
        @required this.textProfile,
        @required this.onTap,
        @required this.index,
      });
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(topLeft: Radius.circular(10.0) , topRight: Radius.circular(10.0)),
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black45,
              blurRadius: 10.0,
              spreadRadius: 5.0
            )
          ]
        ),
        child: BottomNavigationBar(
          elevation: 5,
          backgroundColor: Colors.white,
          items: [
            BottomNavigationBarItem(
              icon: Icon(widget.iconExplore,),
              title: Text(widget.textExplore,),
            ),
            BottomNavigationBarItem(
              icon: Icon(widget.iconFavorite),
              title: Text(widget.textFavorite,),
            ),
            BottomNavigationBarItem(
              icon: Icon(widget.iconAlert),
              title: Text(widget.textAlert,),
            ),
            BottomNavigationBarItem(
              icon: Icon(widget.iconProfile),
              title: Text(widget.textProfile, ),
            ),
          ],
          iconSize: 20,
          unselectedItemColor: colorGrey,
          selectedItemColor: activeIconNavBar,
          currentIndex: widget.index,
          selectedFontSize: 18,
          onTap:widget.onTap,
          type: BottomNavigationBarType.fixed,
        ),
      ),
    );
  }
}

