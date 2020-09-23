import 'dart:async';
import 'dart:convert';

import 'package:real_estate_app/model/get_all_favourites_model.dart';
import 'package:real_estate_app/widget/constant.dart';
import 'package:real_estate_app/widget/shared_preference.dart';
import 'package:http/http.dart' as http;

class FavouriteApi {
  static Future<int> addToFavourite(String propertyId) async {
    print("the id is :: $propertyId");
    String url = Constant.baseUrl + "/favorite/add";
    print("the id1 is :: $propertyId");
    String token = await SharedPreferenceStore.getToken();
    print("the id 2is :: $propertyId");
    Map<String, String> header = await Constant.getHeader(token);
    print(propertyId.runtimeType);
    print("the id is4 :: $propertyId");
    final param = {"property_id": propertyId};
    print(param);
    print("the token :: $token");
    print("the id is5 :: $propertyId");
    try {
      print("the id is66 :: $propertyId");
      var response =
          await http.post(url, headers: header, body: json.encode(param));
      print("the id is 66666:: $propertyId");
      print("the responce is  :: ${response.statusCode}");
      return 1;
    } catch (e) {
      print("Error Happened");
      return 0;
    }
  }

  static Future<GetAllFavouritesModel> getAllFavourites() async {
    String url = Constant.baseUrl + "/favorite/get";
    String token = await SharedPreferenceStore.getToken();
    Map<String, String> header = await Constant.getHeader(token);
    print("the token :: $token");
    try {
      var response =
          await http.get(url, headers: header).timeout(Duration(seconds: 30));
      print("the responce is  :: ${response.statusCode}");
      return getAllFavouritesModelFromJson(response.body);
    } on TimeoutException catch (e) {
      print("Error Time Out");
      return GetAllFavouritesModel(status: "no");
    } catch (e) {
      print("Error Happened");
      return GetAllFavouritesModel(status: "no");
    }
  }
}
