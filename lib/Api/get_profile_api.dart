
import 'dart:async';

import 'package:http/http.dart' as http;
import 'package:real_estate_app/model/get_profile.dart';
import 'package:real_estate_app/widget/constant.dart';
import 'package:real_estate_app/widget/shared_preference.dart';

class ProfileApi{
  static Future<GetProfile> getProfile() async {
    String url = Constant.baseUrl + "/user/profile";
    String token = await SharedPreferenceStore.getToken();
    Map<String, String> header = await Constant.getHeader(token);
    try {
      var response = await http.get(url, headers: header);
      print("status code ${response.statusCode}");
      if (response.statusCode == 220) {
        return getProfileFromJson(response.body);
      }
    } on TimeoutException catch (e) {
      return GetProfile(status: 'no');
    } catch (e) {
      return GetProfile(status: 'no');
    }
    return GetProfile(status: 'no');
  }
}