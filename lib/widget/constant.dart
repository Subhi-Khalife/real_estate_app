import 'dart:io';

import 'package:real_estate_app/widget/shared_preference.dart';

class Constant {
  static double cardHeight,
      fontTitleSize,
      fontDescriptionSize,
      fontMoreInfoSize,
      verificaionTextSize;

  static int indexNavBar = 0;

  static String baseUrl = "http://ahmad.404developers.com";

  static Future<Map<String, String>> getHeader(String token) async {

    Map<String, String> header = {
      HttpHeaders.authorizationHeader: "Bearer $token",
      HttpHeaders.contentTypeHeader: "application/json",
      HttpHeaders.acceptHeader: "application/json"
    };
    return header;
  }
}
