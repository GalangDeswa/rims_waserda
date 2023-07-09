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
    return data.fold(0, (total, item) => total + (item.harga! * item.qty!));
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
    this.id,
    this.idLocal,
    this.idToko,
    this.idUser,
    this.idJenis,
    this.namaJenis,
    this.idKategori,
    this.idJenisStock,
    this.namaProduk,
    this.deskripsi,
    required this.qty,
    this.harga,
    this.hargaModal,
    this.image,
    this.status,
    this.updated,
    this.createdAt,
    this.updatedAt,
    this.diskonBarang,
    this.diskonKasir,
    this.idProduk,
  });

  int? id;
  String? idLocal;
  int? idProduk;
  int? idToko;
  int? idUser;
  String? idJenis;
  int? idJenisStock;
  String? namaJenis;
  int? idKategori;
  String? namaProduk;
  String? deskripsi;
  int qty;
  int? diskonBarang;
  int? diskonKasir;
  int? harga;
  int? hargaModal;
  String? image;
  String? status;
  String? updated;
  String? createdAt;
  String? updatedAt;

  factory DataKeranjangCache.fromJson(Map<String, dynamic> json) =>
      DataKeranjangCache(
        id: json["id"],
        idLocal: json["id_local"],
        idProduk: json["id_produk"],
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
        hargaModal: json["harga_modal"],
        diskonBarang: json["diskon_barang"],
        diskonKasir: json["diskon_kasir"],
        image: json["image"],
        status: json["status"],
        // updated: json["updated"]!,
        // createdAt: json["created_at"]!,
        // updatedAt: json["updated_at"]!,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "id_local": idLocal,
        "id_produk": idProduk,
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
        "harga_modal": hargaModal,
        "diskon_barang": diskonBarang,
        "diskon_kasir": diskonKasir,
        "image": image,
        "status": status,
        // "updated": updatedValues.reverse[updated],
        // "created_at": createdAtValues.reverse[createdAt],
        // "updated_at": updatedAtValues.reverse[updatedAt],
      };

  Map<String, dynamic> toMapForDb() {
    var map = <String, dynamic>{};
    map['id_produk'] = idProduk;
    map['id_user'] = idUser;
    map['id_toko'] = idToko;
    map['id_kategori'] = idKategori;
    map['id_jenis_stock'] = idJenisStock;
    map['nama_brg'] = namaProduk;
    map['qty'] = qty;
    map['harga_brg'] = harga;
    map['diskon_kasir'] = diskonKasir;
    map['diskon_brg'] = diskonBarang;
    map['harga_modal'] = hargaModal;
    // map['created_at'] = createdAt;
    //map['updated_at'] = updatedAt;

    return map;
  }

  Map<String, dynamic> penjualantoMapForDb() {
    var map = <String, dynamic>{};
    map['id_produk'] = idProduk;
    map['id_user'] = idUser;
    map['id_toko'] = idToko;
    map['id_kategori'] = idKategori;
    map['id_jenis_stock'] = idJenisStock;
    map['nama_brg'] = namaProduk;
    map['qty'] = qty;
    map['harga_brg'] = harga;
    map['diskon_kasir'] = diskonKasir;
    map['diskon_brg'] = diskonBarang;
    map['harga_modal'] = hargaModal;
    // map['created_at'] = createdAt;
    //map['updated_at'] = updatedAt;

    return map;
  }
}

class DataKeranjangCachev2 {
  DataKeranjangCachev2(
      {this.id,
      this.idToko,
      this.meja,
      this.idKategori,
      this.idJenisStock,
      this.idUser,
      this.namaBrg,
      this.hargaBrg,
      this.diskonBrg,
      this.qty});

  int? id;

  int? idToko;
  int? idUser;
  String? meja;
  int? idKategori;
  int? idJenisStock;
  String? namaBrg;
  int? hargaBrg;
  int? diskonBrg;
  int? qty;

  factory DataKeranjangCachev2.fromJson(Map<String, dynamic> json) =>
      DataKeranjangCachev2(
        id: json["id"],

        idToko: json["id_toko"],
        idUser: json["id_user"],
        meja: json["meja"],
        idKategori: json["id_kategori"],
        idJenisStock: json["id_jenis_stock"],
        namaBrg: json["nama_brg"],
        diskonBrg: json["diskon_brg"],
        hargaBrg: json["harga_brg"],
        qty: json["qty"],

        // updated: json["updated"]!,
        // createdAt: json["created_at"]!,
        // updatedAt: json["updated_at"]!,
      );

  // Map<String, dynamic> toJson() => {
  //       "id": id,
  //       "id_produk": idProduk,
  //       "id_toko": idToko,
  //       "id_user": idUser,
  //       "id_jenis": idJenis,
  //       "nama_jenis": namaJenis,
  //       "id_kategori": idKategori,
  //       "id_jenis_stock": idJenisStock,
  //       "nama_produk": namaProduk,
  //       "deskripsi": deskripsi,
  //       "qty": qty,
  //       "harga": harga,
  //       "diskon_barang": diskonBarang,
  //       "diskon_kasir": diskonKasir,
  //       "image": image,
  //       "status": status,
  //       // "updated": updatedValues.reverse[updated],
  //       // "created_at": createdAtValues.reverse[createdAt],
  //       // "updated_at": updatedAtValues.reverse[updatedAt],
  //     };

  Map<String, dynamic> toMapForDb() {
    var map = <String, dynamic>{};

    map['id_user'] = idUser;
    map['id_toko'] = idToko;
    map['id_kategori'] = idKategori;
    map['id_jenis_stock'] = idJenisStock;
    map['nama_brg'] = namaBrg;
    map['qty'] = qty;
    map['harga_brg'] = hargaBrg;
    map['diskon_brg'] = diskonBrg;

    // map['created_at'] = createdAt;
    //map['updated_at'] = updatedAt;

    return map;
  }
}

//TODO : crud penjualan local

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
