import 'dart:convert';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:real_estate_app/model/user_model.dart';
import 'package:real_estate_app/widget/constant.dart';
import 'package:real_estate_app/widget/loading_dialog.dart';
import 'package:real_estate_app/widget/shared_preference.dart';
import 'package:real_estate_app/widget/show_message.dart';
import 'package:http/http.dart' as http;

class SignUpApi{
static Future<UserModel> signUpRequest(context,{
 @required String firstName,@required String lastName,
  String phoneNumber,@required String email,String birthDay,
  String cityName,@required String password
}) async{
  String url = Constant.baseUrl +"/auth/signUp";

  final param ={
    "password": password,
    "email": email,
    "first_name":firstName,
    "last_name":lastName,
    "phone":phoneNumber,
    "birthday":birthDay,
    "city":cityName
  };
  print("11111111111");
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {

    LoadingDialog loadingDialog = LoadingDialog(context);
    loadingDialog.show(context);
    try{
      print("22222222222");
      var response = await http.post(url, body: param).timeout(Duration(
        seconds: 30
      ));
      print("status code ${response.statusCode}");
      print("33333333333");
      if (response.statusCode == 230) {
        showMessage("SignUp success");
        print("response is ${response.body}");
        await SharedPreferenceStore.setUserObj(response.body);
        await SharedPreferenceStore.setToken(userModelFromJson(response.body).data.tokenApi); // extract token another way:     jsonDecode(response.body)["data"]["token_api"]
        await SharedPreferenceStore.setSaveLoginAndSignUp(true);
        loadingDialog.dismiss(context);
        return  userModelFromJson(response.body);
      }
      else if(response.statusCode == 330){
        showMessage("email already registered");
        loadingDialog.dismiss(context);
        return UserModel(status: "330");
      }
      else if (response.statusCode == 502) {
        showMessage("operation fail please contact us");
        loadingDialog.dismiss(context);
        return UserModel(status: "502");
      } else if (response.statusCode == 522) {
        showMessage("email format is invalid");
        loadingDialog.dismiss(context);
        return UserModel(status: "522");
      } else {
        print("error");
        loadingDialog.dismiss(context);
        return UserModel(status: "something wrong");
      }
    }catch(e){
      print("catch $e");
      loadingDialog.dismiss(context);
      return UserModel(status: "catch error");
    }

  } else {
    showMessage("please check internet connection");
    return UserModel(status: "no internet");
  }
}
}