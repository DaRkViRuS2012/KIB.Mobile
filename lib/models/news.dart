import 'package:kib/models/media.dart';

class News {
  int id;
  String enTitle;
  String arTitle;
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

  News({
    this.id,
    this.enTitle,
    this.arTitle,
    this.arBody,
    this.enBody,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.media,
  });

  factory News.fromJson(Map<String, dynamic> json) => new News(
        id: json["id"] == null ? null : json["id"],
        enTitle: json["en_title"] == null ? null : json["en_title"],
        arTitle: json["ar_title"] == null ? null : json["ar_title"],
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
        "en_title": enTitle == null ? null : enTitle,
        "ar_title": arTitle == null ? null : arTitle,
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
