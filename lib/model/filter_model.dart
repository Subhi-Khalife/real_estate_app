// To parse this JSON data, do
//
//     final filterModel = filterModelFromJson(jsonString);

import 'dart:convert';

import 'package:real_estate_app/model/get_all_type_model.dart';

FilterModel filterModelFromJson(String str) => FilterModel.fromJson(json.decode(str));

String filterModelToJson(FilterModel data) => json.encode(data.toJson());

class FilterModel {
  FilterModel({
    this.status,
    this.data,
  });

  String status;
  Data data;

  factory FilterModel.fromJson(Map<String, dynamic> json) => FilterModel(
    status: json["status"] == null ? null : json["status"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status == null ? null : status,
    "data": data == null ? null : data.toJson(),
  };
}

class Data {
  Data({
    this.properties,
    this.newFilter,
  });

  Properties properties;
  NewFilter newFilter;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    properties: json["properties"] == null ? null : Properties.fromJson(json["properties"]),
    newFilter: json["new_filter"] == null ? null : NewFilter.fromJson(json["new_filter"]),
  );

  Map<String, dynamic> toJson() => {
    "properties": properties == null ? null : properties.toJson(),
    "new_filter": newFilter == null ? null : newFilter.toJson(),
  };
}

class TypeElement {
  TypeElement({
    this.id,
    this.name,
    this.img,
    this.typeSpecs,
  });

  int id;
  String name;
  String img;
  List<TypeSpec> typeSpecs;

  factory TypeElement.fromJson(Map<String, dynamic> json) => TypeElement(
    id: json["id"] == null ? null : json["id"],
    name: json["name"] == null ? null : json["name"],
    img: json["img"] == null ? null : json["img"],
    typeSpecs: json["type_specs"] == null ? null : List<TypeSpec>.from(json["type_specs"].map((x) => TypeSpec.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "name": name == null ? null : name,
    "img": img == null ? null : img,
    "type_specs": typeSpecs == null ? null : List<dynamic>.from(typeSpecs.map((x) => x.toJson())),
  };
}

class TypeSpec {
  TypeSpec({
    this.id,
    this.name,
    this.hasMultipleOption,
    this.typeId,
    this.typeOptions,
  });

  int id;
  String name;
  bool hasMultipleOption;
  int typeId;
  List<TypeOption> typeOptions;

  factory TypeSpec.fromJson(Map<String, dynamic> json) => TypeSpec(
    id: json["id"] == null ? null : json["id"],
    name: json["name"] == null ? null : json["name"],
    hasMultipleOption: json["has_multiple_option"] == null ? null : json["has_multiple_option"],
    typeId: json["type_id"] == null ? null : json["type_id"],
    typeOptions: json["type_options"] == null ? null : List<TypeOption>.from(json["type_options"].map((x) => TypeOption.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "name": name == null ? null : name,
    "has_multiple_option": hasMultipleOption == null ? null : hasMultipleOption,
    "type_id": typeId == null ? null : typeId,
    "type_options": typeOptions == null ? null : List<dynamic>.from(typeOptions.map((x) => x.toJson())),
  };
}

class TypeOption {
  TypeOption({
    this.id,
    this.name,
    this.typeSpecId,
  });

  int id;
  String name;
  int typeSpecId;

  factory TypeOption.fromJson(Map<String, dynamic> json) => TypeOption(
    id: json["id"] == null ? null : json["id"],
    name: json["name"] == null ? null : json["name"],
    typeSpecId: json["type_spec_id"] == null ? null : json["type_spec_id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "name": name == null ? null : name,
    "type_spec_id": typeSpecId == null ? null : typeSpecId,
  };
}

class Properties {
  Properties({
    this.currentPage,
    this.data,
    this.firstPageUrl,
    this.from,
    this.lastPage,
    this.lastPageUrl,
    this.nextPageUrl,
    this.path,
    this.perPage,
    this.prevPageUrl,
    this.to,
    this.total,
  });

  int currentPage;
  List<Datum> data;
  String firstPageUrl;
  int from;
  int lastPage;
  String lastPageUrl;
  dynamic nextPageUrl;
  String path;
  int perPage;
  dynamic prevPageUrl;
  int to;
  int total;

  factory Properties.fromJson(Map<String, dynamic> json) => Properties(
    currentPage: json["current_page"] == null ? null : json["current_page"],
    data: json["data"] == null ? null : List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    firstPageUrl: json["first_page_url"] == null ? null : json["first_page_url"],
    from: json["from"] == null ? null : json["from"],
    lastPage: json["last_page"] == null ? null : json["last_page"],
    lastPageUrl: json["last_page_url"] == null ? null : json["last_page_url"],
    nextPageUrl: json["next_page_url"],
    path: json["path"] == null ? null : json["path"],
    perPage: json["per_page"] == null ? null : json["per_page"],
    prevPageUrl: json["prev_page_url"],
    to: json["to"] == null ? null : json["to"],
    total: json["total"] == null ? null : json["total"],
  );

  Map<String, dynamic> toJson() => {
    "current_page": currentPage == null ? null : currentPage,
    "data": data == null ? null : List<dynamic>.from(data.map((x) => x.toJson())),
    "first_page_url": firstPageUrl == null ? null : firstPageUrl,
    "from": from == null ? null : from,
    "last_page": lastPage == null ? null : lastPage,
    "last_page_url": lastPageUrl == null ? null : lastPageUrl,
    "next_page_url": nextPageUrl,
    "path": path == null ? null : path,
    "per_page": perPage == null ? null : perPage,
    "prev_page_url": prevPageUrl,
    "to": to == null ? null : to,
    "total": total == null ? null : total,
  };
}

class Datum {
  Datum({
    this.id,
    this.address,
    this.longitude,
    this.latitude,
    this.postalCode,
    this.description,
    this.img,
    this.price,
    this.space,
    this.soldAt,
    this.useType,
    this.createdAt,
    this.areaId,
    this.userId,
    this.typeId,
    this.distance,
    this.images,
    this.user,
    this.type,
    this.area,
    this.propertySpecs,
  });

  int id;
  String address;
  double longitude;
  double latitude;
  dynamic postalCode;
  String description;
  String img;
  int price;
  int space;
  dynamic soldAt;
  String useType;
  DateTime createdAt;
  int areaId;
  int userId;
  int typeId;
  double distance;
  List<Image> images;
  User user;
  TypeElement type;
  Area area;
  List<PropertySpec> propertySpecs;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"] == null ? null : json["id"],
    address: json["address"] == null ? null : json["address"],
    longitude: json["longitude"] == null ? null : json["longitude"].toDouble(),
    latitude: json["latitude"] == null ? null : json["latitude"].toDouble(),
    postalCode: json["postal_code"],
    description: json["description"] == null ? null : json["description"],
    img: json["img"] == null ? null : json["img"],
    price: json["price"] == null ? null : json["price"],
    space: json["space"] == null ? null : json["space"],
    soldAt: json["sold_at"],
    useType: json["use_type"] == null ? null : json["use_type"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    areaId: json["area_id"] == null ? null : json["area_id"],
    userId: json["user_id"] == null ? null : json["user_id"],
    typeId: json["type_id"] == null ? null : json["type_id"],
    distance: json["distance"] == null ? null : json["distance"].toDouble(),
    images: json["images"] == null ? null : List<Image>.from(json["images"].map((x) => Image.fromJson(x))),
    user: json["user"] == null ? null : User.fromJson(json["user"]),
    type: json["type"] == null ? null : TypeElement.fromJson(json["type"]),
    area: json["area"] == null ? null : Area.fromJson(json["area"]),
    propertySpecs: json["property_specs"] == null ? null : List<PropertySpec>.from(json["property_specs"].map((x) => PropertySpec.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "address": address == null ? null : address,
    "longitude": longitude == null ? null : longitude,
    "latitude": latitude == null ? null : latitude,
    "postal_code": postalCode,
    "description": description == null ? null : description,
    "img": img == null ? null : img,
    "price": price == null ? null : price,
    "space": space == null ? null : space,
    "sold_at": soldAt,
    "use_type": useType == null ? null : useType,
    "created_at": createdAt == null ? null : createdAt.toIso8601String(),
    "area_id": areaId == null ? null : areaId,
    "user_id": userId == null ? null : userId,
    "type_id": typeId == null ? null : typeId,
    "distance": distance == null ? null : distance,
    "images": images == null ? null : List<dynamic>.from(images.map((x) => x.toJson())),
    "user": user == null ? null : user.toJson(),
    "type": type == null ? null : type.toJson(),
    "area": area == null ? null : area.toJson(),
    "property_specs": propertySpecs == null ? null : List<dynamic>.from(propertySpecs.map((x) => x.toJson())),
  };
}

class Area {
  Area({
    this.id,
    this.name,
    this.cityId,
    this.cityName,
  });

  int id;
  String name;
  int cityId;
  String cityName;

  factory Area.fromJson(Map<String, dynamic> json) => Area(
    id: json["id"] == null ? null : json["id"],
    name: json["name"] == null ? null : json["name"],
    cityId: json["city_id"] == null ? null : json["city_id"],
    cityName: json["city_name"] == null ? null : json["city_name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "name": name == null ? null : name,
    "city_id": cityId == null ? null : cityId,
    "city_name": cityName == null ? null : cityName,
  };
}

class Image {
  Image({
    this.id,
    this.url,
    this.propertyId,
  });

  int id;
  String url;
  int propertyId;

  factory Image.fromJson(Map<String, dynamic> json) => Image(
    id: json["id"] == null ? null : json["id"],
    url: json["url"] == null ? null : json["url"],
    propertyId: json["property_id"] == null ? null : json["property_id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "url": url == null ? null : url,
    "property_id": propertyId == null ? null : propertyId,
  };
}

class PropertySpec {
  PropertySpec({
    this.id,
    this.hasMultipleOption,
    this.propertyId,
    this.typeSpecId,
    this.name,
    this.propertyOptions,
  });

  int id;
  int hasMultipleOption;
  int propertyId;
  int typeSpecId;
  String name;
  List<PropertyOption> propertyOptions;

  factory PropertySpec.fromJson(Map<String, dynamic> json) => PropertySpec(
    id: json["id"] == null ? null : json["id"],
    hasMultipleOption: json["has_multiple_option"] == null ? null : json["has_multiple_option"],
    propertyId: json["property_id"] == null ? null : json["property_id"],
    typeSpecId: json["type_spec_id"] == null ? null : json["type_spec_id"],
    name: json["name"] == null ? null : json["name"],
    propertyOptions: json["property_options"] == null ? null : List<PropertyOption>.from(json["property_options"].map((x) => PropertyOption.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "has_multiple_option": hasMultipleOption == null ? null : hasMultipleOption,
    "property_id": propertyId == null ? null : propertyId,
    "type_spec_id": typeSpecId == null ? null : typeSpecId,
    "name": name == null ? null : name,
    "property_options": propertyOptions == null ? null : List<dynamic>.from(propertyOptions.map((x) => x.toJson())),
  };
}

class PropertyOption {
  PropertyOption({
    this.id,
    this.propertySpecId,
    this.typeOptionId,
    this.typeOption,
  });

  int id;
  int propertySpecId;
  int typeOptionId;
  TypeOption typeOption;

  factory PropertyOption.fromJson(Map<String, dynamic> json) => PropertyOption(
    id: json["id"] == null ? null : json["id"],
    propertySpecId: json["property_spec_id"] == null ? null : json["property_spec_id"],
    typeOptionId: json["type_option_id"] == null ? null : json["type_option_id"],
    typeOption: json["type_option"] == null ? null : TypeOption.fromJson(json["type_option"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "property_spec_id": propertySpecId == null ? null : propertySpecId,
    "type_option_id": typeOptionId == null ? null : typeOptionId,
    "type_option": typeOption == null ? null : typeOption.toJson(),
  };
}

class User {
  User({
    this.id,
    this.firstName,
    this.lastName,
    this.username,
    this.phone,
    this.email,
    this.emailVerifiedAt,
    this.profilePicture,
    this.suspendedAt,
    this.gender,
    this.userType,
    this.createdAt,
  });

  int id;
  String firstName;
  String lastName;
  String username;
  dynamic phone;
  String email;
  dynamic emailVerifiedAt;
  dynamic profilePicture;
  dynamic suspendedAt;
  dynamic gender;
  String userType;
  DateTime createdAt;

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"] == null ? null : json["id"],
    firstName: json["first_name"] == null ? null : json["first_name"],
    lastName: json["last_name"] == null ? null : json["last_name"],
    username: json["username"] == null ? null : json["username"],
    phone: json["phone"],
    email: json["email"] == null ? null : json["email"],
    emailVerifiedAt: json["email_verified_at"],
    profilePicture: json["profile_picture"],
    suspendedAt: json["suspended_at"],
    gender: json["gender"],
    userType: json["user_type"] == null ? null : json["user_type"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "first_name": firstName == null ? null : firstName,
    "last_name": lastName == null ? null : lastName,
    "username": username == null ? null : username,
    "phone": phone,
    "email": email == null ? null : email,
    "email_verified_at": emailVerifiedAt,
    "profile_picture": profilePicture,
    "suspended_at": suspendedAt,
    "gender": gender,
    "user_type": userType == null ? null : userType,
    "created_at": createdAt == null ? null : createdAt.toIso8601String(),
  };
}
