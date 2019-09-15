// To parse this JSON data, do
//
//     final serviceResponce = serviceResponceFromJson(jsonString);

import 'dart:convert';

import 'package:kib/models/service.dart';

ServiceResponce serviceResponceFromJson(String str) =>
    ServiceResponce.fromJson(json.decode(str));

String serviceResponceToJson(ServiceResponce data) =>
    json.encode(data.toJson());

class ServiceResponce {
  bool status;
  List<Service> data;
  String message;
  String type;

  ServiceResponce({
    this.status,
    this.data,
    this.message,
    this.type,
  });

  factory ServiceResponce.fromJson(Map<String, dynamic> json) =>
      new ServiceResponce(
        status: json["status"] == null ? null : json["status"],
        data: json["data"] == null
            ? null
            : new List<Service>.from(
                json["data"].map((x) => Service.fromJson(x))),
        message: json["message"] == null ? null : json["message"],
        type: json["type"] == null ? null : json["type"],
      );

  Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "data": data == null
            ? null
            : new List<Service>.from(data.map((x) => x.toJson())),
        "message": message == null ? null : message,
        "type": type == null ? null : type,
      };
}
