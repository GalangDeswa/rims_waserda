// To parse this JSON data, do
//
//     final produk = produkFromJson(jsonString);

import 'dart:convert';

Produk produkFromJson(String str) => Produk.fromJson(json.decode(str));

String produkToJson(Produk data) => json.encode(data.toJson());

class Produk {
  Produk({
    required this.status,
    required this.message,
    required this.produk,
  });

  bool status;
  String message;
  List<ProdukElement> produk;

  factory Produk.fromJson(Map<String, dynamic> json) => Produk(
    status: json["status"],
    message: json["message"],
    produk: List<ProdukElement>.from(json["produk"].map((x) => ProdukElement.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "produk": List<dynamic>.from(produk.map((x) => x.toJson())),
  };
}

class ProdukElement {
  ProdukElement({
    required this.id,
    required this.namaProduk,
    required this.harga,
    required this.idKategori,
    required this.kodeProduk,
    required this.barcode,
    required this.idJenis,
    required this.satuan,
    required this.stock,
    required this.kategori,
    required this.jenisProduk,
  });

  String id;
  String namaProduk;
  String harga;
  String idKategori;
  String kodeProduk;
  String barcode;
  String idJenis;
  String satuan;
  String stock;
  String kategori;
  String jenisProduk;

  factory ProdukElement.fromJson(Map<String, dynamic> json) => ProdukElement(
    id: json["id"],
    namaProduk: json["nama_produk"],
    harga: json["harga"],
    idKategori: json["id_kategori"],
    kodeProduk: json["kode_produk"],
    barcode: json["barcode"],
    idJenis: json["id_jenis"],
    satuan: json["satuan"],
    stock: json["stock"],
    kategori: json["kategori"],
    jenisProduk: json["jenis_produk"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "nama_produk": namaProduk,
    "harga": harga,
    "id_kategori": idKategori,
    "kode_produk": kodeProduk,
    "barcode": barcode,
    "id_jenis": idJenis,
    "satuan": satuan,
    "stock": stock,
    "kategori": kategori,
    "jenis_produk": jenisProduk,
  };
}
