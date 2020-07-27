// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  UserModel({
    this.status,
    this.data,
  });

  String status;
  Data data;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    status: json["status"] == null ? null : json["status"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status == null ? null : status,
    "data": data == null ? null : data.toJson(),
  };

  @override
  String toString() {
    return 'UserModel{status: $status, data: $data}';
  }
}

class Data {
  Data({
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
    this.tokenApi,
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
  String tokenApi;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
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
    tokenApi: json["token_api"] == null ? null : json["token_api"],
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
    "token_api": tokenApi == null ? null : tokenApi,
  };

  @override
  String toString() {
    return 'Data{id: $id, firstName: $firstName, lastName: $lastName, username: $username, phone: $phone, email: $email, emailVerifiedAt: $emailVerifiedAt, profilePicture: $profilePicture, suspendedAt: $suspendedAt, gender: $gender, userType: $userType, createdAt: $createdAt, tokenApi: $tokenApi}';
  }
}
