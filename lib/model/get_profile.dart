// To parse this JSON data, do
//
//     final getProfile = getProfileFromJson(jsonString);

import 'dart:convert';

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
    this.area,
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
  Area area;

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
    area: json["area"] == null ? null : Area.fromJson(json["area"]),
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
    "area": area == null ? null : area.toJson(),
  };

  @override
  String toString() {
    return 'Property{id: $id, address: $address, longitude: $longitude, latitude: $latitude, postalCode: $postalCode, description: $description, img: $img, price: $price, space: $space, soldAt: $soldAt, useType: $useType, createdAt: $createdAt, areaId: $areaId, userId: $userId, typeId: $typeId, area: $area}';
  }
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

  @override
  String toString() {
    return 'Area{id: $id, name: $name, cityId: $cityId, cityName: $cityName, countryId: $countryId, countryName: $countryName}';
  }
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
  String phone;
  String email;
  String emailVerifiedAt;
  String profilePicture;
  String suspendedAt;
  String gender;
  String userType;
  DateTime createdAt;

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"] == null ? null : json["id"],
    firstName: json["first_name"] == null ? null : json["first_name"],
    lastName: json["last_name"] == null ? null : json["last_name"],
    username: json["username"] == null ? null : json["username"],
    phone: json["phone"] == null ? null : json["phone"],
    email: json["email"] == null ? null : json["email"],
    emailVerifiedAt: json["email_verified_at"] == null ? null : json["email_verified_at"],
    profilePicture: json["profile_picture"] == null ? null : json["profile_picture"],
    suspendedAt: json["suspended_at"] == null ? null : json["suspended_at"],
    gender: json["gender"] == null ? null : json["gender"],
    userType: json["user_type"] == null ? null : json["user_type"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "first_name": firstName == null ? null : firstName,
    "last_name": lastName == null ? null : lastName,
    "username": username == null ? null : username,
    "phone": phone == null ? null : phone,
    "email": email == null ? null : email,
    "email_verified_at": emailVerifiedAt == null ? null : emailVerifiedAt,
    "profile_picture": profilePicture == null ? null : profilePicture,
    "suspended_at": suspendedAt == null ? null : suspendedAt,
    "gender": gender == null ? null : gender,
    "user_type": userType == null ? null : userType,
    "created_at": createdAt == null ? null : createdAt.toIso8601String(),
  };

  @override
  String toString() {
    return 'User{id: $id, firstName: $firstName, lastName: $lastName, username: $username, phone: $phone, email: $email, emailVerifiedAt: $emailVerifiedAt, profilePicture: $profilePicture, suspendedAt: $suspendedAt, gender: $gender, userType: $userType, createdAt: $createdAt}';
  }
}
