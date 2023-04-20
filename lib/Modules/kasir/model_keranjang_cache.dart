// To parse this JSON data, do
//
//     final modelKeranjangCache = modelKeranjangCacheFromJson(jsonString);

import 'dart:convert';

ModelKeranjangCache modelKeranjangCacheFromJson(String str) =>
    ModelKeranjangCache.fromJson(json.decode(str));

String modelKeranjangCacheToJson(ModelKeranjangCache data) =>
    json.encode(data.toJson());

class ModelKeranjangCache {
  ModelKeranjangCache({
    required this.success,
    required this.statusCode,
    required this.messages,
    required this.data,
    required this.meta,
  });

  bool success;
  int statusCode;
  String messages;
  List<DataKeranjangCache> data;
  Meta meta;

  double get subtotal {
    return data.fold(
        0, (total, item) => total + (double.parse(item.harga) * item.qty));
  }

  double get total {
    return subtotal + (subtotal * 0.1); // add 10% tax
  }

  factory ModelKeranjangCache.fromJson(Map<String, dynamic> json) =>
      ModelKeranjangCache(
        success: json["success"],
        statusCode: json["status_code"],
        messages: json["messages"],
        data: List<DataKeranjangCache>.from(
            json["data"].map((x) => DataKeranjangCache.fromJson(x))),
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

class DataKeranjangCache {
  DataKeranjangCache({
    required this.id,
    required this.idToko,
    required this.idUser,
    required this.idJenis,
    required this.namaJenis,
    required this.idKategori,
    required this.idJenisStock,
    required this.namaProduk,
    required this.deskripsi,
    required this.qty,
    required this.harga,
    required this.image,
    required this.status,
    required this.updated,
    required this.createdAt,
    required this.updatedAt,
    this.diskonBarang,
  });

  int id;
  String idToko;
  String idUser;
  String idJenis;
  int? idJenisStock;
  String namaJenis;
  String idKategori;
  String namaProduk;
  String deskripsi;
  int qty;
  int? diskonBarang;
  String harga;
  String image;
  String status;
  String updated;
  String createdAt;
  String updatedAt;

  DataKeranjangCache copyWith({
    int? id,
    String? idToko,
    String? idUser,
    String? idJenis,
    String? namaJenis,
    String? idKategori,
    String? namaProduk,
    String? deskripsi,
    int? qty,
    String? harga,
    String? image,
    String? status,
    String? updated,
    String? createdAt,
    String? updatedAt,
  }) =>
      DataKeranjangCache(
        id: id ?? this.id,
        idToko: idToko ?? this.idToko,
        idUser: idUser ?? this.idUser,
        idJenis: idJenis ?? this.idJenis,
        namaJenis: namaJenis ?? this.namaJenis,
        idKategori: idKategori ?? this.idKategori,
        idJenisStock: idJenisStock ?? this.idJenisStock,
        namaProduk: namaProduk ?? this.namaProduk,
        deskripsi: deskripsi ?? this.deskripsi,
        qty: qty ?? this.qty,
        harga: harga ?? this.harga,
        image: image ?? this.image,
        status: status ?? this.status,
        updated: updated ?? this.updated,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory DataKeranjangCache.fromJson(Map<String, dynamic> json) =>
      DataKeranjangCache(
        id: json["id"],
        idToko: json["id_toko"],
        idUser: json["id_user"],
        idJenis: json["id_jenis"],
        namaJenis: json["nama_jenis"],
        idKategori: json["id_kategori"],
        idJenisStock: json["id_jenis_stock"],
        namaProduk: json["nama_produk"],
        deskripsi: json["deskripsi"],
        qty: json["qty"],
        harga: json["harga"],
        diskonBarang: json["diskon_barang"],
        image: json["image"],
        status: json["status"],
        updated: json["updated"]!,
        createdAt: json["created_at"]!,
        updatedAt: json["updated_at"]!,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "id_toko": idToko,
        "id_user": idUser,
        "id_jenis": idJenis,
        "nama_jenis": namaJenis,
        "id_kategori": idKategori,
        "id_jenis_stock": idJenisStock,
        "nama_produk": namaProduk,
        "deskripsi": deskripsi,
        "qty": qty,
        "harga": harga,
        "diskon_barang": diskonBarang,
        "image": image,
        "status": status,
        "updated": updatedValues.reverse[updated],
        "created_at": createdAtValues.reverse[createdAt],
        "updated_at": updatedAtValues.reverse[updatedAt],
      };
}

enum CreatedAt { THE_08042023, THE_13042023 }

final createdAtValues = EnumValues({
  "08-04-2023": CreatedAt.THE_08042023,
  "13-04-2023": CreatedAt.THE_13042023
});

enum Updated { THE_3_DAYS_AGO, THE_1_DAY_AGO }

final updatedValues = EnumValues(
    {"1 day ago": Updated.THE_1_DAY_AGO, "3 days ago": Updated.THE_3_DAYS_AGO});

enum UpdatedAt { THE_11042023, THE_13042023 }

final updatedAtValues = EnumValues({
  "11-04-2023": UpdatedAt.THE_11042023,
  "13-04-2023": UpdatedAt.THE_13042023
});

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
  Links links;

  factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
        total: json["total"],
        count: json["count"],
        perPage: json["per_page"],
        currentPage: json["current_page"],
        totalPages: json["total_pages"],
        links: Links.fromJson(json["links"]),
      );

  Map<String, dynamic> toJson() => {
        "total": total,
        "count": count,
        "per_page": perPage,
        "current_page": currentPage,
        "total_pages": totalPages,
        "links": links.toJson(),
      };
}

class Links {
  Links({
    required this.next,
  });

  String next;

  factory Links.fromJson(Map<String, dynamic> json) => Links(
        next: json["next"],
      );

  Map<String, dynamic> toJson() => {
        "next": next,
      };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
