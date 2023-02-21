// To parse this JSON data, do
//
//     final kategeori = kategeoriFromJson(jsonString);

import 'dart:convert';

List<Kategeori> kategeoriFromJson(String str) =>
    List<Kategeori>.from(json.decode(str).map((x) => Kategeori.fromJson(x)));

String kategeoriToJson(List<Kategeori> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Kategeori {
  Kategeori({
    this.idKategori,
    this.kategori,
    this.createdAt,
    this.updatedAt,
  });

  int? idKategori;
  String? kategori;
  dynamic createdAt;
  dynamic updatedAt;

  factory Kategeori.fromJson(Map<String, dynamic> json) => Kategeori(
        idKategori: json["id_kategori"],
        kategori: json["kategori"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id_kategori": idKategori,
        "kategori": kategori,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}
