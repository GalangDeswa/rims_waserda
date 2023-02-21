// To parse this JSON data, do
//
//     final supliyer = supliyerFromJson(jsonString);

import 'dart:convert';

List<Supliyer> supliyerFromJson(String str) =>
    List<Supliyer>.from(json.decode(str).map((x) => Supliyer.fromJson(x)));

String supliyerToJson(List<Supliyer> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Supliyer {
  Supliyer({
    this.idSupliyer,
    this.namaSupliyer,
    this.noHpSupliyer,
    this.createdAt,
    this.updatedAt,
  });

  int? idSupliyer;
  String? namaSupliyer;
  String? noHpSupliyer;
  dynamic createdAt;
  dynamic updatedAt;

  factory Supliyer.fromJson(Map<String, dynamic> json) => Supliyer(
        idSupliyer: json["id_supliyer"],
        namaSupliyer: json["nama_supliyer"],
        noHpSupliyer: json["no_hp_supliyer"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id_supliyer": idSupliyer,
        "nama_supliyer": namaSupliyer,
        "no_hp_supliyer": noHpSupliyer,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}
