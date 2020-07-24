import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:real_estate_app/widget/constant.dart';
import 'package:real_estate_app/widget/loading_dialog.dart';
import 'package:real_estate_app/widget/show_message.dart';

class LoginModel {
  static Future login(
      String email, String password, BuildContext context) async {
    String url = Constant.baseUrl + "/auth/signIn";
    final params = {
      "password": password,
      "email": email,
    };
    LoadingDialog loadingDialog = LoadingDialog(context);
    loadingDialog.show(context);
    try {
      print("okk");
      var response = await http.post(url, body: params);
      print("okkkk");

      if (response.statusCode == 220) {
        showMessage("login success");
        loadingDialog.dismiss(context);
      } else if (response.statusCode == 401) {
        showMessage("invalid email or password");
        loadingDialog.dismiss(context);
      } else if (response.statusCode == 522) {
        showMessage("email format is invalid");
        loadingDialog.dismiss(context);
      } else {
        print("error");
      }
    } catch (e) {
      print("error");
      loadingDialog.dismiss(context);
    }
  }
}
