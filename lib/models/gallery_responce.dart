// To parse this JSON data, do
//
//     final GalleryResponce = GalleryResponceFromJson(jsonString);

import 'dart:convert';

import 'package:kib/models/gallery.dart';

GalleryResponce GalleryResponceFromJson(String str) =>
    GalleryResponce.fromJson(json.decode(str));

String GalleryResponceToJson(GalleryResponce data) =>
    json.encode(data.toJson());

class GalleryResponce {
  bool status;
  List<Gallery> data;
  String message;
  String type;

  GalleryResponce({
    this.status,
    this.data,
    this.message,
    this.type,
  });

  factory GalleryResponce.fromJson(Map<String, dynamic> json) =>
      new GalleryResponce(
        status: json["status"] == null ? null : json["status"],
        data: json["data"] == null
            ? null
            : new List<Gallery>.from(
                json["data"].map((x) => Gallery.fromJson(x))),
        message: json["message"] == null ? null : json["message"],
        type: json["type"] == null ? null : json["type"],
      );

  Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "data": data == null
            ? null
            : new List<Gallery>.from(data.map((x) => x.toJson())),
        "message": message == null ? null : message,
        "type": type == null ? null : type,
      };
}
