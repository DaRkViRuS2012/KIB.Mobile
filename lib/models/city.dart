import 'dart:ui';

class City {
  int id;
  String enTitle;
  String arTitle;
  int cityId;

  City({
    this.id,
    this.enTitle,
    this.arTitle,
    this.cityId,
  });

  String title(Locale locale) {
    if (locale.languageCode == 'en') {
      return enTitle;
    }
    return arTitle;
  }

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
