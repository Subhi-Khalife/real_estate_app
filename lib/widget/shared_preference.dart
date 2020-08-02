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
  static Future<bool> getCheckLogin()async{
    SharedPreferences sharedPreference = await SharedPreferences.getInstance();
    return sharedPreference.get("check");
  }
  static setSaveLoginAndSignUp(bool check)async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool("check",check);
  }
  static Future<String> getCheckShowOnBoarding()async{
    SharedPreferences sharedPreference = await SharedPreferences.getInstance();
    return sharedPreference.getString("isShow");
  }
  static setShowOnBoarding(String isShow)async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString("isShow",isShow);
  }
}