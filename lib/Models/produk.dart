// To parse this JSON data, do
//
//     final barang = barangFromJson(jsonString);

import 'dart:convert';

List<Barang> barangFromJson(String str) =>
    List<Barang>.from(json.decode(str).map((x) => Barang.fromJson(x)));

String barangToJson(List<Barang> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Barang {
  Barang({
    this.idBarang,
    this.kodeBarang,
    this.jenisBarang,
    this.namaBarang,
    this.idKategori,
    this.idSupliyer,
    this.harga,
    this.qty,
    this.createdAt,
    this.updatedAt,
  });

  int? idBarang;
  String? kodeBarang;
  String? jenisBarang;
  String? namaBarang;
  String? idKategori;
  String? idSupliyer;
  String? harga;
  String? qty;
  dynamic createdAt;
  dynamic updatedAt;

  factory Barang.fromJson(Map<String, dynamic> json) => Barang(
        idBarang: json["id_barang"],
        kodeBarang: json["kode_barang"],
        jenisBarang: json["jenis_barang"],
        namaBarang: json["nama_barang"],
        idKategori: json["id_kategori"],
        idSupliyer: json["id_supliyer"],
        harga: json["harga"],
        qty: json["qty"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id_barang": idBarang,
        "kode_barang": kodeBarang,
        "jenis_barang": jenisBarang,
        "nama_barang": namaBarang,
        "id_kategori": idKategori,
        "id_supliyer": idSupliyer,
        "harga": harga,
        "qty": qty,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
