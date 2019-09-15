import 'dart:convert';

User userFromJson(String str) {
  final jsonData = json.decode(str);
  return User.fromJson(jsonData);
}

String userToJson(User data) {
  final dyn = data.toJson();
  return json.encode(dyn);
}

class User {
  int id;
  String name;
  String username;
  String email;
  String mobile;
  String birthdate;
  String fcmtoken;
  String token;

  User(
      {this.id,
      this.name,
      this.username,
      this.email,
      this.mobile,
      this.birthdate,
      this.fcmtoken,
      this.token});

  factory User.fromJson(Map<String, dynamic> json) => new User(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        username: json["username"] == null ? null : json["username"],
        email: json["email"] == null ? null : json["email"],
        mobile: json["mobile"] == null ? null : json["mobile"],
        birthdate: json["birthdate"] == null ? null : json["birthdate"],
        fcmtoken: json["fcmtoken"] == null ? null : json["fcmtoken"],
        token: json["token"] == null ? null : json["token"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "username": username == null ? null : username,
        "email": email == null ? null : email,
        "mobile": mobile == null ? null : mobile,
        "birthdate": birthdate == null ? null : birthdate,
        "fcmtoken": fcmtoken == null ? null : fcmtoken,
        "token": token == null ? null : token,
      };
}
