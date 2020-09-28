// To parse this JSON data, do
//
//     final countryModel = countryModelFromJson(jsonString);

import 'dart:convert';

import 'unified_model/area_model.dart';

CountryModel countryModelFromJson(String str) => CountryModel.fromJson(json.decode(str));

String countryModelToJson(CountryModel data) => json.encode(data.toJson());

class CountryModel {
  CountryModel({
    this.status,
    this.data,
  });

  String status;
  List<Datum> data;

  factory CountryModel.fromJson(Map<String, dynamic> json) => CountryModel(
    status: json["status"] == null ? null : json["status"],
    data: json["data"] == null ? null : List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status == null ? null : status,
    "data": data == null ? null : List<dynamic>.from(data.map((x) => x.toJson())),
  };

  @override
  String toString() {
    return 'CountryModel{status: $status, data: $data}';
  }
}

class Datum {
  Datum({
    this.id,
    this.name,
    this.currency,
    this.currencyShortName,
    this.isoCode,
    this.countyCode,
    this.cities,
  });

  int id;
  String name;
  String currency;
  String currencyShortName;
  String isoCode;
  String countyCode;
  List<City> cities;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"] == null ? null : json["id"],
    name: json["name"] == null ? null : json["name"],
    currency: json["currency"] == null ? null : json["currency"],
    currencyShortName: json["currency_short_name"] == null ? null : json["currency_short_name"],
    isoCode: json["iso_code"] == null ? null : json["iso_code"],
    countyCode: json["county_code"] == null ? null : json["county_code"],
    cities: json["cities"] == null ? null : List<City>.from(json["cities"].map((x) => City.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "name": name == null ? null : name,
    "currency": currency == null ? null : currency,
    "currency_short_name": currencyShortName == null ? null : currencyShortName,
    "iso_code": isoCode == null ? null : isoCode,
    "county_code": countyCode == null ? null : countyCode,
    "cities": cities == null ? null : List<dynamic>.from(cities.map((x) => x.toJson())),
  };

  @override
  String toString() {
    return 'Datum{id: $id, name: $name, currency: $currency, currencyShortName: $currencyShortName, isoCode: $isoCode, countyCode: $countyCode, cities: $cities}';
  }
}

class City {
  City({
    this.id,
    this.name,
    this.countryId,
    this.areas,
  });

  int id;
  String name;
  int countryId;
  List<Area> areas;

  factory City.fromJson(Map<String, dynamic> json) => City(
    id: json["id"] == null ? null : json["id"],
    name: json["name"] == null ? null : json["name"],
    countryId: json["country_id"] == null ? null : json["country_id"],
    areas: json["areas"] == null ? null : List<Area>.from(json["areas"].map((x) => Area.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "name": name == null ? null : name,
    "country_id": countryId == null ? null : countryId,
    "areas": areas == null ? null : List<dynamic>.from(areas.map((x) => x.toJson())),
  };

  @override
  String toString() {
    return 'City{id: $id, name: $name, countryId: $countryId, areas: $areas}';
  }
}

