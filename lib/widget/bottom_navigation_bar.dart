import 'package:flutter/material.dart';
import 'package:realestateapp/widget/color_app.dart';

class BottomNavBar extends StatefulWidget {
  final IconData iconExplore , iconFavorite ,iconAlert ,iconProfile;
  final String textExplore , textFavorite ,textAlert ,textProfile ;


  BottomNavBar(
      {@required this.iconExplore,
        @required this.iconFavorite,
        @required this.iconAlert,
        @required this.iconProfile,
        @required this.textExplore,
        @required this.textFavorite,
        @required this.textAlert,
        @required this.textProfile});
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {

  int index = 0 ;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(color:Colors.black12,spreadRadius: 0.0,blurRadius: 100.0),],
      ),
      child: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(widget.iconExplore,color: index == 0 ? activeIconNavBar : colorGrey,),
            title: Text(widget.textExplore,style: TextStyle(color:index == 0 ? activeIconNavBar : colorGrey,),),
          ),
          BottomNavigationBarItem(
            icon: Icon(widget.iconFavorite,color:index == 1 ? activeIconNavBar : colorGrey,),
            title: Text(widget.textFavorite,style: TextStyle(color:index == 1 ? activeIconNavBar : colorGrey,),),
          ),
          BottomNavigationBarItem(
            icon: Icon(widget.iconAlert,color:index == 2 ? activeIconNavBar : colorGrey,),
            title: Text(widget.textAlert,style: TextStyle(color:index == 2 ? activeIconNavBar : colorGrey,),),
          ),
          BottomNavigationBarItem(
            icon: Icon(widget.iconProfile,color:index == 3 ? activeIconNavBar : colorGrey,),
            title: Text(widget.textProfile,style: TextStyle(color:index == 3 ? activeIconNavBar : colorGrey,),),
          ),
        ],
        iconSize: 20,
        currentIndex: 0,
        fixedColor: colorGrey,
        onTap: (index){
          print("index $index");
          setState(() {
            this.index =index;
          });
        },
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}

