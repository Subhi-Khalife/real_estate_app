import 'dart:convert';

import 'package:real_estate_app/model/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceStore{

  static Future<UserModel> getUserObj() async{
      SharedPreferences sharedPreferences =await SharedPreferences.getInstance();
      print("runnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnn${sharedPreferences.get("userObj").runtimeType}");
     return userModelFromJson(sharedPreferences.get("userObj"));
  }

  static setUserObj(response)async{
    SharedPreferences sharedPreferences =await SharedPreferences.getInstance();
    sharedPreferences.setString("userObj",response);
  }

  static Future<String> getToken() async{
    SharedPreferences sharedPreferences =await SharedPreferences.getInstance();
    return sharedPreferences.get("token");
  }

  static setToken(token)async{
    SharedPreferences sharedPreferences =await SharedPreferences.getInstance();
    sharedPreferences.setString("token",token);
  }
}