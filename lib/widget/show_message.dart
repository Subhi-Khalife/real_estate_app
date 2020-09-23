import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:real_estate_app/widget/color_app.dart';

showMessage(String msg) {
  Fluttertoast.showToast(
      msg: msg,
      // gravity: ToastGravity.values[1],
      // timeInSecForIosWeb: 1,
      backgroundColor:colorApp,
      textColor: Colors.white,
      fontSize: 16.0);
}
