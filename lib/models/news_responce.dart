// To parse this JSON data, do
//
//     final NewsResponce = NewsResponceFromJson(jsonString);

import 'dart:convert';

import 'package:kib/models/news.dart';

NewsResponce NewsResponceFromJson(String str) =>
    NewsResponce.fromJson(json.decode(str));

String NewsResponceToJson(NewsResponce data) => json.encode(data.toJson());

class NewsResponce {
  bool status;
  List<News> data;
  String message;
  String type;

  NewsResponce({
    this.status,
    this.data,
    this.message,
    this.type,
  });

  factory NewsResponce.fromJson(Map<String, dynamic> json) => new NewsResponce(
        status: json["status"] == null ? null : json["status"],
        data: json["data"] == null
            ? null
            : new List<News>.from(json["data"].map((x) => News.fromJson(x))),
        message: json["message"] == null ? null : json["message"],
        type: json["type"] == null ? null : json["type"],
      );

  Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "data": data == null
            ? null
            : new List<News>.from(data.map((x) => x.toJson())),
        "message": message == null ? null : message,
        "type": type == null ? null : type,
      };
}
