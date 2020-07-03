import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:projects/widget/color_app.dart';

class CustomTabBar extends StatefulWidget {
  @override
  _CustomTabBarState createState() => _CustomTabBarState();
}

class _CustomTabBarState extends State<CustomTabBar> with SingleTickerProviderStateMixin{
  TabController controller ;
  int index = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = TabController(
        vsync: this,
        initialIndex: 0,
        length: 2
    );
  }
  @override
  Widget build(BuildContext context) {
    return Card(
    elevation: 3.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      clipBehavior: Clip.hardEdge,
      shadowColor: colorGrey,
      margin: EdgeInsets.only(right: 10.0,left: 10.0),
      child: TabBar(
        tabs: <Widget>[
          Tab(
            child: Text("On Map",style: TextStyle(color: index == 0 ? activeIconNavBar :colorGrey ),),
          ),
          Tab(
            child: Text("Category",style: TextStyle(color: index == 1 ? activeIconNavBar :colorGrey ),),
          ),
        ],
        controller:controller,
        indicatorColor: activeIconNavBar,
        indicatorWeight: 3.0,
        labelStyle: TextStyle(fontSize: 18,fontWeight: FontWeight.w700),
        onTap: (position){
          setState(() {
            index =position ;
          });
        },
      ),
    );
  }

  Widget tabBarView(){
    return TabBarView(
      controller: controller,
      physics: BouncingScrollPhysics(),
      children: <Widget>[
        Container(
          height: 100,
          width: 100,
          color: Colors.red,
        ),
        Container(
          height: 100,
          width: 100,
          color: Colors.teal,
        ),
      ],
    );
  }
}
