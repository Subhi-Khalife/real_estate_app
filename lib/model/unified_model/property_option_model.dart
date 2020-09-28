
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

