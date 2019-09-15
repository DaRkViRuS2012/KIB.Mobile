import 'dart:convert';
import 'dart:ui';

import 'package:kib/models/media.dart';

About aboutFromJson(String str) {
  final jsonData = json.decode(str);
  return About.fromJson(jsonData);
}

String aboutToJson(About data) {
  final dyn = data.toJson();
  return json.encode(dyn);
}

class About {
  int id;
  String enDescription;
  String arDescription;
  String arBody;
  String enBody;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic deletedAt;
  List<Media> media;

  String image() {
    if (this.media != null) {
      return media[0].url;
    }
    return "";
  }

  String body(Locale locale) {
    if (locale.languageCode == 'en') {
      return enDescription;
    }
    return arDescription;
  }

  About({
    this.id,
    this.arDescription,
    this.enDescription,
    this.arBody,
    this.enBody,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.media,
  });

  factory About.fromJson(Map<String, dynamic> json) => new About(
        id: json["id"] == null ? null : json["id"],
        enDescription:
            json["en_description"] == null ? null : json["en_description"],
        arDescription:
            json["ar_description"] == null ? null : json["ar_description"],
        arBody: json["ar_body"] == null ? null : json["ar_body"],
        enBody: json["en_body"] == null ? null : json["en_body"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
        media: json["media"] == null
            ? null
            : new List<Media>.from(json["media"].map((x) => Media.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "en_description": enDescription == null ? null : enDescription,
        "ar_description": arDescription == null ? null : arDescription,
        "ar_body": arBody == null ? null : arBody,
        "en_body": enBody == null ? null : enBody,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
        "deleted_at": deletedAt,
        "media": media == null
            ? null
            : new List<dynamic>.from(media.map((x) => x.toJson())),
      };
}
