import 'dart:async';

import 'package:real_estate_app/model/get_all_type_model.dart';
import 'package:real_estate_app/widget/constant.dart';
import 'package:real_estate_app/widget/shared_preference.dart';
import 'package:http/http.dart' as http;

class AddPropertyApi {
  static Future<GetAllTypeApi> getAllProperty() async {
    String url = Constant.baseUrl + "/type/allTypes";
    String token = await SharedPreferenceStore.getToken();
    Map<String, String> header = {"Authorization": "Bearer $token"};
    try {
      var response = await http.get(url, headers: header);
      print('GetAllTypeApi Api :${response.body}');
      print('GetAllTypeApi Api statusCode:${response.statusCode}');

      if (response.statusCode == 220) {
        print('GetTeacherVote Model Success');
        return getAllTypeApiFromJson(response.body);
      }
    } on TimeoutException catch (e) {
      print("hello 2");
      return GetAllTypeApi(status: 'no');
    } catch (e) {
      print("hello 3");
      return GetAllTypeApi(status: 'no');
      ;
    }
    print("hello 4");
    return GetAllTypeApi(status: 'no');
  }
}
