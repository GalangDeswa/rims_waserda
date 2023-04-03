// To parse this JSON data, do
//
//     final modelKeranjang = modelKeranjangFromJson(jsonString);

import 'dart:convert';

ModelKeranjang modelKeranjangFromJson(String str) =>
    ModelKeranjang.fromJson(json.decode(str));

String modelKeranjangToJson(ModelKeranjang data) => json.encode(data.toJson());

class ModelKeranjang {
  ModelKeranjang({
    required this.success,
    required this.statusCode,
    required this.messages,
    required this.data,
    required this.meta,
  });

  bool success;
  int statusCode;
  String messages;
  List<DataKeranjang> data;
  MetaKeranjang meta;

  factory ModelKeranjang.fromJson(Map<String, dynamic> json) => ModelKeranjang(
        success: json["success"],
        statusCode: json["status_code"],
        messages: json["messages"],
        data: List<DataKeranjang>.from(
            json["data"].map((x) => DataKeranjang.fromJson(x))),
        meta: MetaKeranjang.fromJson(json["meta"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "status_code": statusCode,
        "messages": messages,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "meta": meta.toJson(),
      };
}

class DataKeranjang {
  DataKeranjang({
    required this.id,
    required this.meja,
    required this.idToko,
    required this.idProduk,
    required this.detailProduk,
    required this.idKategori,
    required this.idUser,
    required this.namaUser,
    required this.namaBrg,
    required this.hargaBrg,
    required this.diskonBrg,
    required this.qty,
    required this.total,
    required this.status,
    required this.updated,
    required this.createdAt,
  });

  int id;
  String meja;
  String idToko;
  String idProduk;
  DetailProduk detailProduk;
  String idKategori;
  String idUser;
  String namaUser;
  String namaBrg;
  String hargaBrg;
  String diskonBrg;
  String qty;
  String total;
  String status;
  String updated;
  String createdAt;

  factory DataKeranjang.fromJson(Map<String, dynamic> json) => DataKeranjang(
        id: json["id"],
        meja: json["meja"].toString(),
        idToko: json["id_toko"].toString(),
        idProduk: json["id_produk"].toString(),
        detailProduk: DetailProduk.fromJson(json["detail_produk"]),
        idKategori: json["id_kategori"].toString(),
        idUser: json["id_user"].toString(),
        namaUser: json["nama_user"],
        namaBrg: json["nama_brg"],
        hargaBrg: json["harga_brg"],
        diskonBrg: json["diskon_brg"],
        qty: json["qty"],
        total: json["total"],
        status: json["status"].toString(),
        updated: json["updated"],
        createdAt: json["created_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "meja": meja,
        "id_toko": idToko,
        "id_produk": idProduk,
        "detail_produk": detailProduk.toJson(),
        "id_kategori": idKategori,
        "id_user": idUser,
        "nama_user": namaUser,
        "nama_brg": namaBrg,
        "harga_brg": hargaBrg,
        "diskon_brg": diskonBrg,
        "qty": qty,
        "total": total,
        "status": status,
        "updated": updated,
        "created_at": createdAt,
      };
}

class DetailProduk {
  DetailProduk({
    required this.idJenis,
    required this.deskripsi,
    required this.image,
  });

  String idJenis;
  String deskripsi;
  String image;

  factory DetailProduk.fromJson(Map<String, dynamic> json) => DetailProduk(
        idJenis: json["id_jenis"].toString(),
        deskripsi: json["deskripsi"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id_jenis": idJenis,
        "deskripsi": deskripsi,
        "image": image,
      };
}

class MetaKeranjang {
  MetaKeranjang({
    required this.subtotal,
    required this.total,
    required this.catatan,
  });

  String subtotal;
  String total;
  Catatan catatan;

  factory MetaKeranjang.fromJson(Map<String, dynamic> json) => MetaKeranjang(
        subtotal: json["subtotal"].toString(),
        total: json["total"].toString(),
        catatan: Catatan.fromJson(json["catatan"]),
      );

  Map<String, dynamic> toJson() => {
        "subtotal": subtotal,
        "total": total,
        "catatan": catatan.toJson(),
      };
}

class Catatan {
  Catatan({
    required this.kategori,
    required this.status,
  });

  String kategori;
  String status;

  factory Catatan.fromJson(Map<String, dynamic> json) => Catatan(
        kategori: json["kategori"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "kategori": kategori,
        "status": status,
      };
}
