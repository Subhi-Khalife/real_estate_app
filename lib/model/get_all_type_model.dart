// To parse this JSON data, do
//
//     final getAllTypeApi = getAllTypeApiFromJson(jsonString);

import 'dart:convert';

GetAllTypeApi getAllTypeApiFromJson(String str) => GetAllTypeApi.fromJson(json.decode(str));

String getAllTypeApiToJson(GetAllTypeApi data) => json.encode(data.toJson());

class GetAllTypeApi {
  GetAllTypeApi({
    this.status,
    this.data,
  });

  String status;
  List<Datum> data;

  factory GetAllTypeApi.fromJson(Map<String, dynamic> json) => GetAllTypeApi(
    status: json["status"] == null ? null : json["status"],
    data: json["data"] == null ? null : List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status == null ? null : status,
    "data": data == null ? null : List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  Datum({
    this.id,
    this.name,
    this.img,
    this.typeSpecs,
  });

  int id;
  String name;
  String img;
  List<TypeSpec> typeSpecs;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
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
    this.hasOption,
    this.hasMultipleOption,
    this.typeId,
    this.typeOptions,
  });

  int id;
  String name;
  bool hasOption;
  bool hasMultipleOption;
  int typeId;
  List<TypeOption> typeOptions;

  factory TypeSpec.fromJson(Map<String, dynamic> json) => TypeSpec(
    id: json["id"] == null ? null : json["id"],
    name: json["name"] == null ? null : json["name"],
    hasOption: json["has_option"] == null ? null : json["has_option"],
    hasMultipleOption: json["has_multiple_option"] == null ? null : json["has_multiple_option"],
    typeId: json["type_id"] == null ? null : json["type_id"],
    typeOptions: json["type_options"] == null ? null : List<TypeOption>.from(json["type_options"].map((x) => TypeOption.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "name": name == null ? null : name,
    "has_option": hasOption == null ? null : hasOption,
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
