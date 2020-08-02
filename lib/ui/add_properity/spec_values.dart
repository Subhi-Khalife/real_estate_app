// To parse this JSON data, do
//
//     final specValues = specValuesFromJson(jsonString);

import 'dart:convert';

SpecValues specValuesFromJson(String str) => SpecValues.fromJson(json.decode(str));

String specValuesToJson(SpecValues data) => json.encode(data.toJson());

class SpecValues {
  SpecValues({
    this.id,
    this.value,
    this.option,
  });

  int id;
  String value;
  List<int> option;

  factory SpecValues.fromJson(Map<String, dynamic> json) => SpecValues(
    id: json["id"] == null ? null : json["id"],
    value: json["value"] == null ? null : json["value"],
    option: json["option"] == null ? null : List<int>.from(json["option"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "value": value == null ? null : value,
    "option": option == null ? null : List<dynamic>.from(option.map((x) => x)),
  };

  @override
  String toString() {
    return 'SpecValues{id: $id, value: $value, option: $option}';
  }
}