// To parse this JSON data, do
//
//     final specValues = specValuesFromJson(jsonString);

import 'dart:convert';

SpecValuesForFilter specValuesFromJson(String str) => SpecValuesForFilter.fromJson(json.decode(str));

String specValuesToJson(SpecValuesForFilter data) => json.encode(data.toJson());

class SpecValuesForFilter {
  SpecValuesForFilter({
    this.id,
    this.option,
  });

  int id;
  List<int> option;

  factory SpecValuesForFilter.fromJson(Map<String, dynamic> json) => SpecValuesForFilter(
    id: json["type_spec_id"] == null ? null : json["type_spec_id"],
    option: json["type_option_id"] == null ? null : List<int>.from(json["type_option_id"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "type_spec_id": id == null ? null : id,
    "type_option_id": option == null ? null : List<dynamic>.from(option.map((x) => x)),
  };

  @override
  String toString() {
    return 'SpecValues{type_spec_id: $id, type_option_id: $option}';
  }
}