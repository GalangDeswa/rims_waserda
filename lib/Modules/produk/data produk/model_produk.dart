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
    this.barcode,
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
    required this.diskonBarang,
    required this.image,
    required this.status,
    required this.updated,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  String? barcode;
  int idToko;
  int idUser;
  int idJenis;
  String namaJenis;
  int idKategori;
  int idJenisStock;
  String namaProduk;
  String deskripsi;
  String qty;
  String harga;
  int diskonBarang;
  String image;
  int status;
  Updated? updated;
  CreatedAt? createdAt;
  UpdatedAt? updatedAt;

  factory DataProduk.fromJson(Map<String, dynamic> json) => DataProduk(
        id: json["id"],
        barcode: json["barcode"],
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
        updated: updatedValues.map[json["updated"]],
        createdAt: createdAtValues.map[json["created_at"]],
        updatedAt: updatedAtValues.map[json["updated_at"]],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "barcode": barcode,
        "id_toko": idToko,
        "id_user": idUser,
        "id_jenis": idJenis,
        "nama_jenis": namaJenisValues.reverse[namaJenis],
        "id_kategori": idKategori,
        "id_jenis_stock": idJenisStock,
        "nama_produk": namaProduk,
        "deskripsi": deskripsiValues.reverse[deskripsi],
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

enum CreatedAt { THE_13042023, THE_08042023 }

final createdAtValues = EnumValues({
  "08-04-2023": CreatedAt.THE_08042023,
  "13-04-2023": CreatedAt.THE_13042023
});

enum Deskripsi { EMPTY, SPESIAL }

final deskripsiValues =
    EnumValues({"-": Deskripsi.EMPTY, "spesial": Deskripsi.SPESIAL});

enum NamaJenis { MAKANAN, MINUMAN, SNACK }

final namaJenisValues = EnumValues({
  "Makanan": NamaJenis.MAKANAN,
  "Minuman": NamaJenis.MINUMAN,
  "Snack": NamaJenis.SNACK
});

enum Updated { THE_4_DAYS_AGO, THE_5_DAYS_AGO }

final updatedValues = EnumValues({
  "4 days ago": Updated.THE_4_DAYS_AGO,
  "5 days ago": Updated.THE_5_DAYS_AGO
});

enum UpdatedAt { THE_13042023, THE_11042023 }

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
    //  this.links,
  });

  int total;
  int count;
  int perPage;
  int currentPage;
  int totalPages;
  //List<Links>? links;

  factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
        total: json["total"],
        count: json["count"],
        perPage: json["per_page"],
        currentPage: json["current_page"],
        totalPages: json["total_pages"],
        //  links: List<Links>.from(json["links"].map((x) => Links.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "total": total,
        "count": count,
        "per_page": perPage,
        "current_page": currentPage,
        "total_pages": totalPages,
        //"links": List<dynamic>.from(links!.map((x) => x)),
      };
}

class Links {
  Links({
    this.previous,
    this.next,
  });

  String? previous;
  String? next;

  factory Links.fromJson(Map<String, dynamic> json) => Links(
        previous: json["previous"],
        next: json["next"],
      );

  Map<String, dynamic> toJson() => {
        "previous": previous,
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
