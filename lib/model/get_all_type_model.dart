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
  NewFilter data;

  factory GetAllTypeApi.fromJson(Map<String, dynamic> json) => GetAllTypeApi(
    status: json["status"] == null ? null : json["status"],
    data: json["data"] == null ? null : NewFilter.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status == null ? null : status,
    "data": data == null ? null : data.toJson(),
  };
}

class NewFilter {
  NewFilter({
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

  factory NewFilter.fromJson(Map<String, dynamic> json) => NewFilter(
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
