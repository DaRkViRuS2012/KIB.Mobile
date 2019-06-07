
class City {
  int id;
  String enTitle;
  String arTitle;
  String cityId;

  City({
    this.id,
    this.enTitle,
    this.arTitle,
    this.cityId,
  });

  factory City.fromJson(Map<String, dynamic> json) => new City(
        id: json["id"] == null ? null : json["id"],
        enTitle: json["en_title"] == null ? null : json["en_title"],
        arTitle: json["ar_title"] == null ? null : json["ar_title"],
        cityId: json["city_id"] == null ? null : json["city_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "en_title": enTitle == null ? null : enTitle,
        "ar_title": arTitle == null ? null : arTitle,
        "city_id": cityId == null ? null : cityId,
        
      };
}
