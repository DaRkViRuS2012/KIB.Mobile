// To parse this JSON data, do
//
//     final AboutResponce = AboutResponceFromJson(jsonString);

import 'dart:convert';

import 'package:kib/models/about.dart';

AboutResponce aboutResponceFromJson(String str) =>
    AboutResponce.fromJson(json.decode(str));

String aboutResponceToJson(AboutResponce data) => json.encode(data.toJson());

class AboutResponce {
  bool status;
  About data;
  String message;
  String type;

  AboutResponce({
    this.status,
    this.data,
    this.message,
    this.type,
  });

  factory AboutResponce.fromJson(Map<String, dynamic> json) =>
      new AboutResponce(
        status: json["status"] == null ? null : json["status"],
        data: json["data"] == null ? null : About.fromJson(json["data"]),
        message: json["message"] == null ? null : json["message"],
        type: json["type"] == null ? null : json["type"],
      );

  Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "data": data == null ? null : data.toJson(),
        "message": message == null ? null : message,
        "type": type == null ? null : type,
      };
}
