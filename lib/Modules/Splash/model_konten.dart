// To parse this JSON data, do
//
//     final modelKonten = modelKontenFromJson(jsonString);

import 'dart:convert';

ModelKonten modelKontenFromJson(String str) =>
    ModelKonten.fromJson(json.decode(str));

String modelKontenToJson(ModelKonten data) => json.encode(data.toJson());

class ModelKonten {
  ModelKonten({
    required this.success,
    required this.statusCode,
    required this.messages,
    required this.data,
  });

  bool success;
  int statusCode;
  String messages;
  List<DataKonten> data;

  factory ModelKonten.fromJson(Map<String, dynamic> json) => ModelKonten(
        success: json["success"],
        statusCode: json["status_code"],
        messages: json["messages"],
        data: List<DataKonten>.from(
            json["data"].map((x) => DataKonten.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "status_code": statusCode,
        "messages": messages,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class DataKonten {
  DataKonten({
    required this.tipe,
    required this.judul,
    required this.deskripsi,
    this.link,
    required this.foto,
  });

  int tipe;
  String judul;
  String deskripsi;
  dynamic link;
  String foto;

  factory DataKonten.fromJson(Map<String, dynamic> json) => DataKonten(
        tipe: json["tipe"],
        judul: json["judul"],
        deskripsi: json["deskripsi"],
        link: json["link"],
        foto: json["foto"],
      );

  Map<String, dynamic> toJson() => {
        "tipe": tipe,
        "judul": judul,
        "deskripsi": deskripsi,
        "link": link,
        "foto": foto,
      };
}
