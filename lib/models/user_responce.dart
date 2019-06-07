// To parse this JSON data, do
//
//     final serviceResponce = serviceResponceFromJson(jsonString);

import 'dart:convert';

import 'package:kib/models/user.dart';

UserResponse serviceResponceFromJson(String str) =>
    UserResponse.fromJson(json.decode(str));

String serviceResponceToJson(UserResponse data) => json.encode(data.toJson());

class UserResponse {
  bool status;
  User user;
  String message;
  String type;

  UserResponse({
    this.status,
    this.user,
    this.message,
    this.type,
  });

  factory UserResponse.fromJson(Map<String, dynamic> json) => new UserResponse(
        status: json["status"] == null ? null : json["status"],
        user: json["data"] == null ? null : User.fromJson(json["data"]),
        message: json["message"] == null ? null : json["message"],
        type: json["type"] == null ? null : json["type"],
      );

  Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "data": user == null ? null : user.toJson(),
        "message": message == null ? null : message,
        "type": type == null ? null : type,
      };
}
