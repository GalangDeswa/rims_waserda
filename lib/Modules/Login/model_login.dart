// To parse this JSON data, do
//
//     final modelLogin = modelLoginFromJson(jsonString);

import 'dart:convert';

ModelLogin modelLoginFromJson(String str) =>
    ModelLogin.fromJson(json.decode(str));

String modelLoginToJson(ModelLogin data) => json.encode(data.toJson());

class ModelLogin {
  ModelLogin({
    required this.success,
    required this.message,
    required this.errors,
    required this.id,
    required this.idToko,
    required this.name,
    required this.email,
    this.hp,
    this.emailVerifiedAt,
    required this.createdAt,
    required this.updatedAt,
    required this.token,
    required this.tokenType,
  });

  bool success;
  String message;
  String errors;
  int id;
  String idToko;
  String name;
  String email;
  dynamic hp;
  dynamic emailVerifiedAt;
  DateTime createdAt;
  DateTime updatedAt;
  String token;
  String tokenType;

  factory ModelLogin.fromJson(Map<String, dynamic> json) => ModelLogin(
        success: json["success"],
        message: json["message"],
        errors: json["errors"],
        id: json["id"],
        idToko: json["id_toko"].toString(),
        name: json["name"],
        email: json["email"],
        hp: json["hp"],
        emailVerifiedAt: json["email_verified_at"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        token: json["token"],
        tokenType: json["token_type"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "errors": errors,
        "id": id,
        "id_toko": idToko,
        "name": name,
        "email": email,
        "hp": hp,
        "email_verified_at": emailVerifiedAt,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "token": token,
        "token_type": tokenType,
      };
}
