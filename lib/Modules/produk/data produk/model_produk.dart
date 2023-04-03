// To parse this JSON data, do
//
//     final modelProduk = modelProdukFromJson(jsonString);

import 'dart:convert';

ModelProduk modelProdukFromJson(String str) =>
    ModelProduk.fromJson(json.decode(str));

String modelProdukToJson(ModelProduk data) => json.encode(data.toJson());

class ModelProduk {
  ModelProduk({
    required this.success,
    required this.statusCode,
    required this.messages,
    required this.data,
    required this.meta,
  });

  bool success;
  int statusCode;
  String messages;
  List<DataProduk> data;
  Meta meta;

  factory ModelProduk.fromJson(Map<String, dynamic> json) => ModelProduk(
        success: json["success"],
        statusCode: json["status_code"],
        messages: json["messages"],
        data: List<DataProduk>.from(
            json["data"].map((x) => DataProduk.fromJson(x))),
        meta: Meta.fromJson(json["meta"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "status_code": statusCode,
        "messages": messages,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "meta": meta.toJson(),
      };
}

class DataProduk {
  DataProduk({
    required this.id,
    required this.idToko,
    required this.idUser,
    required this.idJenis,
    required this.namaJenis,
    required this.idKategori,
    required this.namaProduk,
    required this.deskripsi,
    required this.qty,
    required this.harga,
    required this.image,
    required this.status,
    required this.updated,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  String idToko;
  String idUser;
  String idJenis;
  String namaJenis;
  String idKategori;
  String namaProduk;
  String deskripsi;
  String qty;
  String harga;
  String image;
  String status;
  String updated;
  String createdAt;
  String updatedAt;

  factory DataProduk.fromJson(Map<String, dynamic> json) => DataProduk(
        id: json["id"],
        idToko: json["id_toko"].toString(),
        idUser: json["id_user"].toString(),
        idJenis: json["id_jenis"].toString(),
        namaJenis: json["nama_jenis"],
        idKategori: json["id_kategori"].toString(),
        namaProduk: json["nama_produk"],
        deskripsi: json["deskripsi"],
        qty: json["qty"],
        harga: json["harga"],
        image: json["image"],
        status: json["status"].toString(),
        updated: json["updated"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "id_toko": idToko,
        "id_user": idUser,
        "id_jenis": idJenis,
        "nama_jenis": namaJenis,
        "id_kategori": idKategori,
        "nama_produk": namaProduk,
        "deskripsi": deskripsi,
        "qty": qty,
        "harga": harga,
        "image": image,
        "status": status,
        "updated": updated,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}

class Meta {
  Meta({
    required this.catatan,
    required this.pagination,
  });

  Catatan catatan;
  Pagination pagination;

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        catatan: Catatan.fromJson(json["catatan"]),
        pagination: Pagination.fromJson(json["pagination"]),
      );

  Map<String, dynamic> toJson() => {
        "catatan": catatan.toJson(),
        "pagination": pagination.toJson(),
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

class Pagination {
  Pagination({
    required this.total,
    required this.count,
    required this.perPage,
    required this.currentPage,
    required this.totalPages,
    required this.links,
  });

  int total;
  int count;
  int perPage;
  int currentPage;
  int totalPages;
  List<dynamic> links;

  factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
        total: json["total"],
        count: json["count"],
        perPage: json["per_page"],
        currentPage: json["current_page"],
        totalPages: json["total_pages"],
        links: List<dynamic>.from(json["links"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "total": total,
        "count": count,
        "per_page": perPage,
        "current_page": currentPage,
        "total_pages": totalPages,
        "links": List<dynamic>.from(links.map((x) => x)),
      };
}
