// To parse this JSON data, do
//
//     final loginv2 = loginv2FromJson(jsonString);

import 'dart:convert';

Loginv2 loginv2FromJson(String str) => Loginv2.fromJson(json.decode(str));

String loginv2ToJson(Loginv2 data) => json.encode(data.toJson());

class Loginv2 {
  Loginv2({
    this.email,
    this.password,
  });

  String? email;
  String? password;

  factory Loginv2.fromJson(Map<String, dynamic> json) => Loginv2(
        email: json["email"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "password": password,
      };
}
