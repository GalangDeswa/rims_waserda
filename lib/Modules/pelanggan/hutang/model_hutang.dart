// To parse this JSON data, do
//
//     final modelHutang = modelHutangFromJson(jsonString);

import 'dart:convert';

ModelHutang modelHutangFromJson(String str) =>
    ModelHutang.fromJson(json.decode(str));

String modelHutangToJson(ModelHutang data) => json.encode(data.toJson());

class ModelHutang {
  bool success;
  int statusCode;
  String messages;
  List<DataHutang> data;

  //Meta meta;

  ModelHutang({
    required this.success,
    required this.statusCode,
    required this.messages,
    required this.data,
    //required this.meta,
  });

  factory ModelHutang.fromJson(Map<String, dynamic> json) => ModelHutang(
        success: json["success"],
        statusCode: json["status_code"],
        messages: json["messages"],
        data: List<DataHutang>.from(
            json["data"].map((x) => DataHutang.fromJson(x))),
        //  meta: Meta.fromJson(json["meta"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "status_code": statusCode,
        "messages": messages,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        // "meta": meta.toJson(),
      };
}

class DataHutang {
  int? id;
  String? idLocal;
  String? idPelanggan;
  String? namaPelanggan;
  int? idToko;
  int? hutang;
  String? tglHutang;
  int? status;
  String? sync;
  String? aktif;

  DataHutang(
      {this.id,
      this.idLocal,
      this.idPelanggan,
      this.namaPelanggan,
      this.idToko,
      this.hutang,
      this.tglHutang,
      this.status,
      this.sync,
      this.aktif});

  factory DataHutang.fromJson(Map<String, dynamic> json) => DataHutang(
        id: json["id"],
        idLocal: json["id_local"],
        idPelanggan: json["id_pelanggan"],
        namaPelanggan: json["nama_pelanggan"],
        idToko: json["id_toko"],
        hutang: json["hutang"],
        tglHutang: json["tgl_hutang"],
        status: json["status"],
        sync: json["sync"],
        aktif: json["aktif"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "id_local": idLocal,
        "id_pelanggan": idPelanggan,
        "nama_pelanggan": namaPelanggan,
        "id_toko": idToko,
        "hutang": hutang,
        "tgl_hutang": tglHutang,
        "status": status,
        "sync": sync,
        "aktif": aktif,
      };

  Map<String, dynamic> toMapForDb() {
    var map = <String, dynamic>{};
    map['id'] = id;
    map['id_local'] = idLocal;
    map['id_toko'] = idToko;
    map['id_pelanggan'] = idPelanggan;
    // map['nama_pelanggan'] = namaPelanggan;
    map['hutang'] = hutang;
    map['tgl_hutang'] = tglHutang;
    map['sync'] = sync;
    map['status'] = status;
    map['aktif'] = aktif;
    return map;
  }
}

class DetailHutang {
  int idPenjualan;
  int idToko;
  int totalItem;
  DateTime tglPenjualan;
  int metodeBayar;

  DetailHutang({
    required this.idPenjualan,
    required this.idToko,
    required this.totalItem,
    required this.tglPenjualan,
    required this.metodeBayar,
  });

  factory DetailHutang.fromJson(Map<String, dynamic> json) => DetailHutang(
        idPenjualan: json["id_penjualan"],
        idToko: json["id_toko"],
        totalItem: json["total_item"],
        tglPenjualan: DateTime.parse(json["tgl_penjualan"]),
        metodeBayar: json["metode_bayar"],
      );

  Map<String, dynamic> toJson() => {
        "id_penjualan": idPenjualan,
        "id_toko": idToko,
        "total_item": totalItem,
        "tgl_penjualan": tglPenjualan.toIso8601String(),
        "metode_bayar": metodeBayar,
      };
}

class DetailItem {
  int idPenjualan;
  int idProduk;
  int idKategori;
  int idJenisStock;
  String namaBrg;
  int hargaBrg;
  int qty;
  int diskonBrg;
  int total;

  DetailItem({
    required this.idPenjualan,
    required this.idProduk,
    required this.idKategori,
    required this.idJenisStock,
    required this.namaBrg,
    required this.hargaBrg,
    required this.qty,
    required this.diskonBrg,
    required this.total,
  });

  factory DetailItem.fromJson(Map<String, dynamic> json) => DetailItem(
        idPenjualan: json["id_penjualan"],
        idProduk: json["id_produk"],
        idKategori: json["id_kategori"],
        idJenisStock: json["id_jenis_stock"],
        namaBrg: json["nama_brg"],
        hargaBrg: json["harga_brg"],
        qty: json["qty"],
        diskonBrg: json["diskon_brg"],
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "id_penjualan": idPenjualan,
        "id_produk": idProduk,
        "id_kategori": idKategori,
        "id_jenis_stock": idJenisStock,
        "nama_brg": namaBrg,
        "harga_brg": hargaBrg,
        "qty": qty,
        "diskon_brg": diskonBrg,
        "total": total,
      };
}

// class Meta {
//   Catatan catatan;
//   Pagination pagination;
//
//   Meta({
//     required this.catatan,
//     required this.pagination,
//   });
//
//   factory Meta.fromJson(Map<String, dynamic> json) => Meta(
//         catatan: Catatan.fromJson(json["catatan"]),
//         pagination: Pagination.fromJson(json["pagination"]),
//       );
//
//   Map<String, dynamic> toJson() => {
//         "catatan": catatan.toJson(),
//         "pagination": pagination.toJson(),
//       };
// }
//
// class Catatan {
//   String status;
//
//   Catatan({
//     required this.status,
//   });
//
//   factory Catatan.fromJson(Map<String, dynamic> json) => Catatan(
//         status: json["status"],
//       );
//
//   Map<String, dynamic> toJson() => {
//         "status": status,
//       };
// }
//
// class Pagination {
//   int total;
//   int count;
//   int perPage;
//   int currentPage;
//   int totalPages;
//   List<dynamic> links;
//
//   Pagination({
//     required this.total,
//     required this.count,
//     required this.perPage,
//     required this.currentPage,
//     required this.totalPages,
//     required this.links,
//   });
//
//   factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
//         total: json["total"],
//         count: json["count"],
//         perPage: json["per_page"],
//         currentPage: json["current_page"],
//         totalPages: json["total_pages"],
//         links: List<dynamic>.from(json["links"].map((x) => x)),
//       );
//
//   Map<String, dynamic> toJson() => {
//         "total": total,
//         "count": count,
//         "per_page": perPage,
//         "current_page": currentPage,
//         "total_pages": totalPages,
//         "links": List<dynamic>.from(links.map((x) => x)),
//       };
// }
