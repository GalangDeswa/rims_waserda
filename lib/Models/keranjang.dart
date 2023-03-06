// To parse this JSON data, do
//
//     final keranjang = keranjangFromJson(jsonString);

import 'dart:convert';

Keranjang keranjangFromJson(String str) => Keranjang.fromJson(json.decode(str));

String keranjangToJson(Keranjang data) => json.encode(data.toJson());

class Keranjang {
  Keranjang({
    required this.status,
    required this.message,
    required this.keranjang,
  });

  bool status;
  String message;
  List<KeranjangElement> keranjang;

  factory Keranjang.fromJson(Map<String, dynamic> json) => Keranjang(
        status: json["status"],
        message: json["message"],
        keranjang: List<KeranjangElement>.from(
            json["keranjang"].map((x) => KeranjangElement.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "keranjang": List<dynamic>.from(keranjang.map((x) => x.toJson())),
      };
}

class KeranjangElement {
  KeranjangElement({
    required this.id,
    required this.kodeProduk,
    required this.qty,
    required this.tgl,
    required this.namaProduk,
    required this.harga,
    required this.idKategori,
    required this.barcode,
    required this.idJenis,
    required this.satuan,
    required this.stock,
  });

  String id;
  String kodeProduk;
  String qty;
  String tgl;
  String namaProduk;
  String harga;
  String idKategori;
  String barcode;
  String idJenis;
  String satuan;
  String stock;

  factory KeranjangElement.fromJson(Map<String, dynamic> json) =>
      KeranjangElement(
        id: json["id"],
        kodeProduk: json["kode_produk"],
        qty: json["qty"],
        tgl: json["tgl"],
        namaProduk: json["nama_produk"],
        harga: json["harga"],
        idKategori: json["id_kategori"],
        barcode: json["barcode"],
        idJenis: json["id_jenis"],
        satuan: json["satuan"],
        stock: json["stock"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "kode_produk": kodeProduk,
        "qty": qty,
        "tgl": tgl,
        "nama_produk": namaProduk,
        "harga": harga,
        "id_kategori": idKategori,
        "barcode": barcode,
        "id_jenis": idJenis,
        "satuan": satuan,
        "stock": stock,
      };
}
