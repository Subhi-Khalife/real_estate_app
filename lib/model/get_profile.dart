// To parse this JSON data, do
//
//     final getProfile = getProfileFromJson(jsonString);

import 'dart:convert';

import 'file:///D:/projects/real_estate_app/lib/model/unified_model/properity_model.dart';
import 'file:///D:/projects/real_estate_app/lib/model/unified_model/user_info_model.dart';

GetProfile getProfileFromJson(String str) => GetProfile.fromJson(json.decode(str));

String getProfileToJson(GetProfile data) => json.encode(data.toJson());

class GetProfile {
  GetProfile({
    this.status,
    this.data,
  });

  String status;
  Data data;

  factory GetProfile.fromJson(Map<String, dynamic> json) => GetProfile(
    status: json["status"] == null ? null : json["status"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status == null ? null : status,
    "data": data == null ? null : data.toJson(),
  };

  @override
  String toString() {
    return 'GetProfile{status: $status, data: $data}';
  }
}

class Data {
  Data({
    this.user,
    this.properties,
  });

  User user;
  List<Property> properties;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    user: json["user"] == null ? null : User.fromJson(json["user"]),
    properties: json["properties"] == null ? null : List<Property>.from(json["properties"].map((x) => Property.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "user": user == null ? null : user.toJson(),
    "properties": properties == null ? null : List<dynamic>.from(properties.map((x) => x.toJson())),
  };

  @override
  String toString() {
    return 'Data{user: $user, properties: $properties}';
  }
}
