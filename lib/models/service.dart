import 'dart:ui';

import 'package:kib/models/media.dart';

class Service {
  int id;
  String enTitle;
  String arTitle;
  String enSubtitle;
  String arSubtitle;
  String arDescription;
  String enDescription;
  int parentId;
  int active;
  int companyId;
  String type;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic deletedAt;
  List<Media> media;
  List<Media> productMedia;
  List<Service> sons;
  dynamic company;
  List<dynamic> options;
  Media quotation;

  String image(String baseURL) {
    if (type == "service") {
      if (this.media != null) {
        for (Media m in media) {
          if (m.mediaType == "image") {
            return m.url;
          }
        }
      }
    }
    if (type == "product") {
      if (this.productMedia != null) {
        for (Media m in productMedia) {
          if (m.mediaType == "image") {
            return m.url;
          }
        }
      }
    }
    return "";
  }

  String title(Locale locale) {
    if (locale.languageCode == 'en') {
      return enTitle;
    }
    return arTitle;
  }

  String quotationURL(String baseURL) {
    if (this.quotation != null) {
      return quotation.url;
    }
    return "";
  }

  Service({
    this.id,
    this.enTitle,
    this.arTitle,
    this.enSubtitle,
    this.arSubtitle,
    this.arDescription,
    this.enDescription,
    this.parentId,
    this.active,
    this.companyId,
    this.type,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.media,
    this.productMedia,
    this.sons,
    this.company,
    this.options,
    this.quotation,
  });

  factory Service.fromJson(Map<String, dynamic> json) => new Service(
        id: json["id"] == null ? null : json["id"],
        enTitle: json["en_title"] == null ? null : json["en_title"],
        arTitle: json["ar_title"] == null ? null : json["ar_title"],
        enSubtitle: json["en_subtitle"] == null ? null : json["en_subtitle"],
        arSubtitle: json["ar_subtitle"] == null ? null : json["ar_subtitle"],
        arDescription:
            json["ar_description"] == null ? null : json["ar_description"],
        enDescription:
            json["en_description"] == null ? null : json["en_description"],
        parentId: json["parent_id"] == null ? null : json["parent_id"],
        active: json["active"] == null ? null : json["active"],
        companyId: json["company_id"] == null ? null : json["company_id"],
        type: json["type"] == null ? null : json["type"],
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
        productMedia: json["product_media"] == null
            ? null
            : new List<Media>.from(
                json["product_media"].map((x) => Media.fromJson(x))),
        sons: json["sons"] == null
            ? null
            : new List<Service>.from(
                json["sons"].map((x) => Service.fromJson(x))),
        company: json["company"],
        options: json["options"] == null
            ? null
            : new List<dynamic>.from(json["options"].map((x) => x)),
        quotation: json["quotation"] == null
            ? null
            : Media.fromJson(json["quotation"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "en_title": enTitle == null ? null : enTitle,
        "ar_title": arTitle == null ? null : arTitle,
        "en_subtitle": enSubtitle == null ? null : enSubtitle,
        "ar_subtitle": arSubtitle == null ? null : arSubtitle,
        "ar_description": arDescription == null ? null : arDescription,
        "en_description": enDescription == null ? null : enDescription,
        "parent_id": parentId == null ? null : parentId,
        "active": active == null ? null : active,
        "company_id": companyId == null ? null : companyId,
        "type": type == null ? null : type,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
        "deleted_at": deletedAt,
        "media": media == null
            ? null
            : new List<Media>.from(media.map((x) => x.toJson())),
        "product_media": media == null
            ? null
            : new List<Media>.from(productMedia.map((x) => x.toJson())),
        "sons": sons == null
            ? null
            : new List<Service>.from(sons.map((x) => x.toJson())),
        "company": company,
        "options": options == null
            ? null
            : new List<dynamic>.from(options.map((x) => x)),
        "quotation": quotation == null ? null : quotation.toJson(),
      };
}
