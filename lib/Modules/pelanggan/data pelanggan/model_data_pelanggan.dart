// To parse this JSON data, do
//
//     final modelPelanggan = modelPelangganFromJson(jsonString);

import 'dart:convert';

ModelPelanggan modelPelangganFromJson(String str) =>
    ModelPelanggan.fromJson(json.decode(str));

String modelPelangganToJson(ModelPelanggan data) => json.encode(data.toJson());

class ModelPelanggan {
  ModelPelanggan({
    required this.success,
    required this.statusCode,
    required this.messages,
    required this.data,
    // required this.meta,
  });

  bool success;
  int statusCode;
  String messages;
  List<DataPelanggan> data;
//  Meta meta;

  factory ModelPelanggan.fromJson(Map<String, dynamic> json) => ModelPelanggan(
        success: json["success"],
        statusCode: json["status_code"],
        messages: json["messages"],
        data: List<DataPelanggan>.from(
            json["data"].map((x) => DataPelanggan.fromJson(x))),
        // meta: Meta.fromJson(json["meta"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "status_code": statusCode,
        "messages": messages,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        // "meta": meta.toJson(),
      };
}

class DataPelanggan {
  DataPelanggan({
    this.id,
    this.idLocal,
    this.idToko,
    this.namaPelanggan,
    this.noHp,
    this.sync,
    this.aktif,
    this.status,
    // this.riwayatPembelian,
  });

  int? id;
  String? idLocal;
  int? idToko;
  String? namaPelanggan;
  String? noHp;
  String? sync;
  String? aktif;
  int? status;

  // List<RiwayatPembelian> riwayatPembelian;

  factory DataPelanggan.fromJson(Map<String, dynamic> json) => DataPelanggan(
        id: json["id"],
        idLocal: json["id_local"],
        idToko: json["id_toko"],
        namaPelanggan: json["nama_pelanggan"],
        noHp: json["no_hp"],
        sync: json["sync"],
        aktif: json["aktif"],
        status: json["status"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "id_local": idLocal,
        "id_toko": idToko,
        "nama_pelanggan": namaPelanggan,
        "no_hp": noHp,
        "sync": sync,
        "aktif": aktif,
        "status": status,
      };

  Map<String, dynamic> toMapForDb() {
    var map = <String, dynamic>{};
    map['id'] = id;
    map['id_local'] = idLocal;
    map['id_toko'] = idToko;
    map['nama_pelanggan'] = namaPelanggan;
    map['no_hp'] = noHp;
    map['sync'] = sync;
    map['aktif'] = aktif;
    // map['detail_item'] = List<dynamic>.from(detailItem!.map((x) => x.toJson()));
    return map;
  }
}

// class RiwayatPembelian {
//   RiwayatPembelian({
//     required this.meja,
//     required this.idUser,
//     required this.totalItem,
//     required this.diskonTotal,
//     this.subtotal,
//     required this.total,
//     required this.bayar,
//     required this.kembalian,
//     required this.tglPenjualan,
//     required this.metodeBayar,
//     required this.status,
//   });
//
//   int meja;
//   int idUser;
//   int totalItem;
//   int diskonTotal;
//   int? subtotal;
//   int total;
//   int bayar;
//   int kembalian;
//   DateTime tglPenjualan;
//   int metodeBayar;
//   int status;
//
//   factory RiwayatPembelian.fromJson(Map<String, dynamic> json) =>
//       RiwayatPembelian(
//         meja: json["meja"],
//         idUser: json["id_user"],
//         totalItem: json["total_item"],
//         diskonTotal: json["diskon_total"],
//         subtotal: json["subtotal"],
//         total: json["total"],
//         bayar: json["bayar"] ?? '',
//         kembalian: json["kembalian"],
//         tglPenjualan: DateTime.parse(json["tgl_penjualan"]),
//         metodeBayar: json["metode_bayar"],
//         status: json["status"],
//       );
//
//   Map<String, dynamic> toJson() => {
//         "meja": meja,
//         "id_user": idUser,
//         "total_item": totalItem,
//         "diskon_total": diskonTotal,
//         "subtotal": subtotal,
//         "total": total,
//         "bayar": bayar,
//         "kembalian": kembalian,
//         "tgl_penjualan": tglPenjualan.toIso8601String(),
//         "metode_bayar": metodeBayar,
//         "status": status,
//       };
// }

// class Meta {
//   Meta({
//     required this.catatan,
//     required this.pagination,
//   });
//
//   Catatan catatan;
//   Pagination pagination;
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
//   Catatan({
//     required this.status,
//   });
//
//   String status;
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
//   Pagination({
//     required this.total,
//     required this.count,
//     required this.perPage,
//     required this.currentPage,
//     required this.totalPages,
//     // required this.links,
//   });
//
//   int total;
//   int count;
//   int perPage;
//   int currentPage;
//   int totalPages;
//
//   //List<dynamic> links;
//
//   factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
//         total: json["total"],
//         count: json["count"],
//         perPage: json["per_page"],
//         currentPage: json["current_page"],
//         totalPages: json["total_pages"],
//         // links: List<dynamic>.from(json["links"].map((x) => x)),
//       );
//
//   Map<String, dynamic> toJson() => {
//         "total": total,
//         "count": count,
//         "per_page": perPage,
//         "current_page": currentPage,
//         "total_pages": totalPages,
//         //"links": List<dynamic>.from(links.map((x) => x)),
//       };
// }
