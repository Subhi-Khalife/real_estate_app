// To parse this JSON data, do
//
//     final getAllFavouritesModel = getAllFavouritesModelFromJson(jsonString);

import 'dart:convert';

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

class Property {
  Property({
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
    this.isFavorite,
    this.area,
    this.propertySpecs,
    this.user,
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
  dynamic isFavorite;
  Area area;
  List<PropertySpec> propertySpecs;
  User user;

  factory Property.fromJson(Map<String, dynamic> json) => Property(
    id: json["id"] == null ? null : json["id"],
    address: json["address"] == null ? null : json["address"],
    longitude: json["longitude"] == null ? null : json["longitude"].toDouble(),
    latitude: json["latitude"] == null ? null : json["latitude"].toDouble(),
    postalCode: json["postalCode"],
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
    isFavorite: json["is_favorite"],
    area: json["area"] == null ? null : Area.fromJson(json["area"]),
    propertySpecs: json["property_specs"] == null ? null : List<PropertySpec>.from(json["property_specs"].map((x) => PropertySpec.fromJson(x))),
    user: json["user"] == null ? null : User.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "address": address == null ? null : address,
    "longitude": longitude == null ? null : longitude,
    "latitude": latitude == null ? null : latitude,
    "postalCode": postalCode,
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
    "is_favorite": isFavorite,
    "area": area == null ? null : area.toJson(),
    "property_specs": propertySpecs == null ? null : List<dynamic>.from(propertySpecs.map((x) => x.toJson())),
    "user": user == null ? null : user.toJson(),
  };
}

class Area {
  Area({
    this.id,
    this.name,
    this.cityId,
    this.cityName,
    this.countryId,
    this.countryName,
  });

  int id;
  String name;
  int cityId;
  String cityName;
  int countryId;
  String countryName;

  factory Area.fromJson(Map<String, dynamic> json) => Area(
    id: json["id"] == null ? null : json["id"],
    name: json["name"] == null ? null : json["name"],
    cityId: json["city_id"] == null ? null : json["city_id"],
    cityName: json["city_name"] == null ? null : json["city_name"],
    countryId: json["country_id"] == null ? null : json["country_id"],
    countryName: json["country_name"] == null ? null : json["country_name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "name": name == null ? null : name,
    "city_id": cityId == null ? null : cityId,
    "city_name": cityName == null ? null : cityName,
    "country_id": countryId == null ? null : countryId,
    "country_name": countryName == null ? null : countryName,
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
