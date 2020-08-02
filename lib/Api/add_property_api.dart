import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:real_estate_app/model/country_model.dart';
import 'package:real_estate_app/model/country_model.dart';
import 'package:real_estate_app/model/get_all_type_model.dart';
import 'package:real_estate_app/ui/add_properity/spec_values.dart';
import 'package:real_estate_app/widget/constant.dart';
import 'package:real_estate_app/widget/shared_preference.dart';
import 'package:http/http.dart' as http;
import 'package:real_estate_app/widget/show_message.dart';

class AddPropertyApi {
  static Future<GetAllTypeApi> getAllProperty() async {
    String url = Constant.baseUrl + "/type/allTypes";
    String token = await SharedPreferenceStore.getToken();
    print("the token is :: $token");
    Map<String, String> header = {"Authorization": "Bearer $token"};
    try {
      var response = await http.get(url, headers: header);
      print('GetAllTypeApi Api :${response.body}');
      print('GetAllTypeApi Api statusCode:${response.statusCode}');

      if (response.statusCode == 220) {
        print("the body:: ${response.body}");
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

  static Future<CountryModel> getAllCountries() async {
    String url = Constant.baseUrl + "/country/all";
    String token = await SharedPreferenceStore.getToken();
    Map<String, String> header = {"Authorization": "Bearer $token"};

    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      try {
        var response = await http.get(url, headers: header).timeout(Duration(seconds: 30));
        print('getAllCountries Api :${response.body}');
        print('getAllCountries Api statusCode:${response.statusCode}');

        if (response.statusCode == 220) {
          print('getAllCountries Model Success');
          return countryModelFromJson(response.body);
        }
      } on TimeoutException catch (e) {
        print("hello 2");
        return CountryModel(status: 'no');
      } catch (e) {
        print("hello 3");
        return CountryModel(status: 'no');
      }
      print("hello 4");
      return CountryModel(status: 'no');
    }
    else {
      showMessage("please check internet connection");
      return CountryModel(status: "no internet");
    }
  }

 static Future<int> addProperty({
  @required  int typeId ,
  @required String description,
  @required  int areaId ,
  @required  String address ,
  @required  int price ,
  @required  String img,
  @required  double space,
  @required  String useType,
  @required  List<String> images,
  @required  List<SpecValues> specs,
  double longitude, double latitude,
  double postalCode,
 })async {
   String url = Constant.baseUrl + "/property/create";
   String token = await SharedPreferenceStore.getToken();
   Map<String, String> header = {
     HttpHeaders.authorizationHeader: "Bearer $token",
     HttpHeaders.contentTypeHeader: "application/json"
   };
final param={
  "description":description,
  "type_id": typeId,
  "area_id": areaId,
  "address": address,
  "price": price,
  "img": img,
  "space" : space,
  "longtiude" :longitude,
  "latitude" : latitude,
  "postalCode" : postalCode,
  "use_type" : useType,
  "images" : List<dynamic>.from(images.map((image) => image)),
  "specs": List<dynamic>.from(specs.map((specObj) => specObj))
};

print ("Param is :::${json.encode(param)}");


   var connectivityResult = await (Connectivity().checkConnectivity());
   if (connectivityResult == ConnectivityResult.mobile ||
       connectivityResult == ConnectivityResult.wifi) {
     try {
       var response = await http.post(
           url,
           headers: header,
           body: json.encode(param))
           .timeout(Duration(seconds: 30));
       print('addProperty Api :${response.body}');
       print('addProperty Api statusCode:${response.statusCode}');

       if (response.statusCode == 230) {
         print('addProperty api Success');
         return response.statusCode;
       }else {
         return response.statusCode;
       }
     } on TimeoutException catch (e) {
       print("hello 2");
       return 7;
     } catch (e) {
       print("error $e");
       print("hello 3");
       return 8;
     }
   }
   else {
     showMessage("please check internet connection");
     return 9;
   }
  }
}
