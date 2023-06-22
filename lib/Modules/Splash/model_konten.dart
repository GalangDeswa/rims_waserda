// To parse this JSON data, do
//
//     final modelKonten = modelKontenFromJson(jsonString);

import 'dart:convert';

ModelKonten modelKontenFromJson(String str) =>
    ModelKonten.fromJson(json.decode(str));

String modelKontenToJson(ModelKonten data) => json.encode(data.toJson());

class ModelKonten {
  bool success;
  int statusCode;
  String messages;
  List<DataKonten> data;

  ModelKonten({
    required this.success,
    required this.statusCode,
    required this.messages,
    required this.data,
  });

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
  int? tipe;
  String? judul;
  String? deskripsi;
  String? link;
  String? foto;
  int? id;

  DataKonten({
    this.id,
    this.tipe,
    this.judul,
    this.deskripsi,
    this.link,
    this.foto,
  });

  factory DataKonten.fromJson(Map<String, dynamic> json) => DataKonten(
        id: json["id"],
        tipe: json["tipe"],
        judul: json["judul"],
        deskripsi: json["deskripsi"],
        link: json["link"],
        foto: json["foto"],
      );

  Map<String, dynamic> toJson() => {
        "tipe": tipe,
        "id": id,
        "judul": judul,
        "deskripsi": deskripsi,
        "link": link,
        "foto": foto,
      };

  Map<String, dynamic> toMapForDb() {
    var map = <String, dynamic>{};
    map['id'] = id;
    map['tipe'] = tipe;
    map['judul'] = judul;
    map['deskripsi'] = deskripsi;
    map['link'] = link;
    map['foto'] = foto;

    // map['created_at'] = createdAt;
    //map['updated_at'] = updatedAt;

    return map;
  }
}
