import 'dart:convert';

import 'package:real_estate_app/model/filter_model.dart';
import 'package:real_estate_app/ui/add_properity/required_param.dart';
import 'package:real_estate_app/widget/constant.dart';
import 'package:real_estate_app/widget/shared_preference.dart';
import 'package:http/http.dart' as http;

class GetFilterApi {
  // filters
  static Future<FilterModel> getFilter({RequiredParam requiredParam, bool getAllHouse=false}) async {
    String show(RequiredParam requiredParam) {
      String search = "";
      if (requiredParam.minSpace.text.isNotEmpty)
        search += "min_space=${requiredParam.minSpace.text}";
      if (requiredParam.maxSpace.text.isNotEmpty) {
        if (search.length != 0) {
          search += "&";
        }
        search += "max_space=${requiredParam.maxSpace.text}";
      }
      if (requiredParam.useTypeValue.isNotEmpty) {
        if (search.length != 0) {
          search += "&";
        }
        search += "use_type=${requiredParam.useTypeValue}";
      }
      if (requiredParam.minPrice.text.isNotEmpty) {
        if (search.length != 0) {
          search += "&";
        }
        search += "max_space=${requiredParam.minPrice.text}";
      }
      if (requiredParam.maxPrice.text.isNotEmpty) {
        if (search.length != 0) {
          search += "&";
        }
        search += "max_space=${requiredParam.maxPrice.text}";
      }
      if (requiredParam.areaId.toString() != "0") {
        if (search.length != 0) {
          search += "&";
        }
        search += "area_id=${requiredParam.areaId}";
      }
      if (requiredParam.typeId[0].toString() != "-1") {
        if (search.length != 0) {
          search += "&";
        }
        search += "type_id=${requiredParam.typeId[0]}";
      }
      if (requiredParam.specValuesForFilter.length > 0) {
        print("ok");
        var x = List<dynamic>.from(
            requiredParam.specValuesForFilter.map((specObj) => specObj));
        if (search.length != 0) {
          search += "&";
        }
        search += "filte=${json.encode(x)}";
      }
      print("the search is :: $search");
      return search;
    }
    String f;
    if (getAllHouse == false)
      f = show(requiredParam);
    else {
      f = "";
    }

    String url = Constant.baseUrl + "/property/filter?$f";
    String token = await SharedPreferenceStore.getToken();
    Map<String, String> header = {"Authorization": "Bearer $token"};

    try {
      var response = await http.get(
        url,
        headers: header,
      );
      print(response.statusCode);
      print("body ${response.body}");
      if (response.statusCode == 220) {
        print("success");
        return filterModelFromJson(response.body);
      }
    } catch (e) {
      print("asdasdsad");
      return FilterModel(status: "no");
    }
  }
}
