import 'dart:io';
import 'package:connectivity/connectivity.dart';
import 'package:async/async.dart';
import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:http/http.dart' as http;
import 'package:real_estate_app/widget/constant.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:real_estate_app/widget/shared_preference.dart';
import 'package:real_estate_app/widget/show_message.dart';

class UploadImageModel {
  static String path;

  static uploadImageCreateActivity(File file,
      {@required String imageType}) async {
    print("image type is $imageType");
    var url = Constant.baseUrl + "/file/uploadImage";
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      try {
        var dir = await path_provider.getTemporaryDirectory();
        var image = await FlutterImageCompress.compressAndGetFile(
          file.absolute.path,
          dir.absolute.path + "/temp.jpg",
          quality: 60,
          minWidth: 640,
          minHeight: 480,
        );
        file = image;
        var stream =
            new http.ByteStream(DelegatingStream.typed(file.openRead()));
        print("Hello from upload 3");

        String token = await SharedPreferenceStore.getToken();

        var length = await file.length();

        var uri = Uri.parse(url);

        Map<String, String> headers = await Constant.getHeader();

        var request = new http.MultipartRequest("POST", uri);

        var multipartFile = new http.MultipartFile(
          'image',
          stream,
          length,
          filename: basename(file.path),
        );

        print("Hello from upload $headers");

        request.fields['image_type'] = imageType;

        request.headers.addAll(headers);

        request.files.add(multipartFile);

        var response = await request.send().timeout(Duration(seconds: 300));

        print("404Developers ${response.statusCode}");

        print("the responce is $response");
        return response;
      } catch (e) {
        print('catchhhh $e');
        return 1;
      }
    } else if (connectivityResult == ConnectivityResult.none) {
      showMessage('لا يوجد اتصال بالانترنت');
      return 0;
    }
  }
}
//response.stream.transform(utf8.decoder).listen((value){
//
//});
