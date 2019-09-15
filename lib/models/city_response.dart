// To parse this JSON data, do
//
//     final CityResponce = CityResponceFromJson(jsonString);

import 'dart:convert';

import 'package:kib/models/city.dart';

CityResponce cityResponceFromJson(String str) =>
    CityResponce.fromJson(json.decode(str));

String cityResponceToJson(CityResponce data) => json.encode(data.toJson());

class CityResponce {
  bool status;
  List<City> data;
  String message;
  String type;

  CityResponce({
    this.status,
    this.data,
    this.message,
    this.type,
  });

  factory CityResponce.fromJson(Map<String, dynamic> json) => new CityResponce(
        status: json["status"] == null ? null : json["status"],
        data: json["data"] == null
            ? null
            : new List<City>.from(json["data"].map((x) => City.fromJson(x))),
        message: json["message"] == null ? null : json["message"],
        type: json["type"] == null ? null : json["type"],
      );

  Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "data": data == null
            ? null
            : new List<City>.from(data.map((x) => x.toJson())),
        "message": message == null ? null : message,
        "type": type == null ? null : type,
      };
}
