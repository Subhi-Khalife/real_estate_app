// To parse this JSON data, do
//
//     final getAllFavouritesModel = getAllFavouritesModelFromJson(jsonString);

import 'dart:convert';

import 'file:///D:/projects/real_estate_app/lib/model/unified_model/properity_model.dart';
import 'file:///D:/projects/real_estate_app/lib/model/unified_model/user_info_model.dart';

import 'unified_model/property_option_model.dart';

GetAllFavouritesModel getAllFavouritesModelFromJson(String str) => GetAllFavouritesModel.fromJson(json.decode(str));

String getAllFavouritesModelToJson(GetAllFavouritesModel data) => json.encode(data.toJson());

class GetAllFavouritesModel {
  GetAllFavouritesModel({
    this.status,
    this.data,
  });

  String status;
  List<Datumes> data;

  factory GetAllFavouritesModel.fromJson(Map<String, dynamic> json) => GetAllFavouritesModel(
    status: json["status"] == null ? null : json["status"],
    data: json["data"] == null ? null : List<Datumes>.from(json["data"].map((x) => Datumes.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status == null ? null : status,
    "data": data == null ? null : List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datumes {
  Datumes({
    this.id,
    this.userId,
    this.propertyId,
    this.property,
  });

  int id;
  int userId;
  int propertyId;
  Property property;

  factory Datumes.fromJson(Map<String, dynamic> json) => Datumes(
    id: json["id"] == null ? null : json["id"],
    userId: json["user_id"] == null ? null : json["user_id"],
    propertyId: json["property_id"] == null ? null : json["property_id"],
    property: json["property"] == null ? null : Property.fromJson(json["property"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "user_id": userId == null ? null : userId,
    "property_id": propertyId == null ? null : propertyId,
    "property": property == null ? null : property.toJson(),
  };
}
