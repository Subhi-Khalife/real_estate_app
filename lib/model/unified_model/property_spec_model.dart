
import 'file:///D:/projects/real_estate_app/lib/model/unified_model/property_option_model.dart';

import 'area_model.dart';
import '../user_model.dart';

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
  UserModel user;

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
    user: json["user"] == null ? null : UserModel.fromJson(json["user"]),
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