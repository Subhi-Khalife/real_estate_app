import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


Widget appBar({@required Widget widget,bool centerTitle ,List<Widget> actions ,Widget leadingWidget}){
  return PreferredSize(
    preferredSize: Size.fromHeight(60),
    child: AppBar(
      backgroundColor: Colors.white,
      centerTitle: centerTitle ?? true,
      actions: actions,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(10.0),
            bottomLeft: Radius.circular(10.0)
        ),
      ),
      elevation: 4.0,
      iconTheme: IconThemeData(color: Colors.grey,),
      title:widget,
      leading: leadingWidget,
    ),
  );
}






