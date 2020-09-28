
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
