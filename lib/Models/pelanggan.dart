// To parse this JSON data, do
//
//     final pelanggan = pelangganFromJson(jsonString);

import 'dart:convert';

Pelanggan pelangganFromJson(String str) => Pelanggan.fromJson(json.decode(str));

String pelangganToJson(Pelanggan data) => json.encode(data.toJson());

class Pelanggan {
  Pelanggan({
    required this.status,
    required this.message,
    required this.pelanggan,
  });

  bool status;
  String message;
  PelangganClass pelanggan;

  factory Pelanggan.fromJson(Map<String, dynamic> json) => Pelanggan(
        status: json["status"],
        message: json["message"],
        pelanggan: PelangganClass.fromJson(json["pelanggan"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "pelanggan": pelanggan.toJson(),
      };
}

class PelangganClass {
  PelangganClass({
    required this.nomorIdentitas,
    required this.namaPelanggan,
    required this.alamatPelanggan,
    required this.noHp,
    required this.email,
  });

  String nomorIdentitas;
  String namaPelanggan;
  String alamatPelanggan;
  String noHp;
  String email;

  factory PelangganClass.fromJson(Map<String, dynamic> json) => PelangganClass(
        nomorIdentitas: json["nomor_identitas"],
        namaPelanggan: json["nama_pelanggan"],
        alamatPelanggan: json["alamat_pelanggan"],
        noHp: json["no_hp"],
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "nomor_identitas": nomorIdentitas,
        "nama_pelanggan": namaPelanggan,
        "alamat_pelanggan": alamatPelanggan,
        "no_hp": noHp,
        "email": email,
      };
}
