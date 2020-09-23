import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:real_estate_app/model/user_model.dart';
import 'package:real_estate_app/ui/MainView.dart';
import 'package:real_estate_app/widget/constant.dart';
import 'package:real_estate_app/widget/loading_dialog.dart';
import 'package:real_estate_app/widget/shared_preference.dart';
import 'package:real_estate_app/widget/show_message.dart';

class LoginApi {
  static Future login(
      String email, String password, BuildContext context) async {
    String url = Constant.baseUrl + "/auth/signIn";
    final params = {
      "password": password,
      "email": email,
    };
    Map<String, String> header =await Constant.getHeader("");
    print("param $params");
    LoadingDialog loadingDialog = LoadingDialog(context);
    loadingDialog.show(context);
    try {
      print("okk");
      var response = await http.post(url, body: json.encode(params),headers: header).timeout(Duration(seconds: 30));

      print("the status Login :: ${response.body}");
      if (response.statusCode == 220) {
        print("220000000000000000000000000000000000000");
        showMessage("تم تسجيل الدخول بنجاح");
        await SharedPreferenceStore.setUserObj(response.body);
        await SharedPreferenceStore.setToken(userModelFromJson(response.body).data.tokenApi); // extract token another way:     jsonDecode(response.body)["data"]["token_api"]
        await SharedPreferenceStore.setSaveLoginAndSignUp(true);
        loadingDialog.dismiss(context);
        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>MainView()));
//        return userModelFromJson(response.body);
      } else if (response.statusCode == 401) {

        print("askjdsajkfd sjkda ndskjafkj sdahkj hadsjkfh jk");
        showMessage("خطأ في كلمة السر أو البريد الإلكتروني");
        loadingDialog.dismiss(context);
      } else if (response.statusCode == 522) {
        showMessage("تنسيق البريد الإلكتروني خاطئ");
        loadingDialog.dismiss(context);
      } else {
        print("error");
      }
    } catch (e) {
      print("error");
      loadingDialog.dismiss(context);
    }
  }

  static Future socialLogin({String socialToken, String provider}) async {
    print("inside Login Model");
    String url = Constant.baseUrl + '/clients/socialLogin';
    final params = {
      'provider': 'facebook',
      'social_token': '$socialToken',
    };
    try {
      var response = await http
          .post(url, body: params)
          .timeout(const Duration(seconds: 30));
      print("Login Model Status Code :: ${response.statusCode}");
      print("Login Model body :: ${response.body}");

      if (response.statusCode == 220) {
        showMessage("Login success");
//        return socailLoginApiFromJson(response.body);
      } else if (response.statusCode == 400) {
        showMessage("Email or Password wrong");
//        return SocailLoginApi(status: "no");
      }
    } on TimeoutException catch (e) {
      showMessage("Time out try again");
//      return SocailLoginApi(status: "no");
    } catch (e) {
      showMessage("Error happened try again");
//      return SocailLoginApi(status: "no");
    }
  }
}
