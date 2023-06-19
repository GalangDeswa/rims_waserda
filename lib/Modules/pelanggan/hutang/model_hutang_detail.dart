// To parse this JSON data, do
//
//     final modelHutangDetail = modelHutangDetailFromJson(jsonString);

import 'dart:convert';

ModelHutangDetail modelHutangDetailFromJson(String str) =>
    ModelHutangDetail.fromJson(json.decode(str));

String modelHutangDetailToJson(ModelHutangDetail data) =>
    json.encode(data.toJson());

class ModelHutangDetail {
  bool success;
  int statusCode;
  String messages;
  List<DataHutangDetail> data;

  //Meta meta;

  ModelHutangDetail({
    required this.success,
    required this.statusCode,
    required this.messages,
    required this.data,
    // required this.meta,
  });

  factory ModelHutangDetail.fromJson(Map<String, dynamic> json) =>
      ModelHutangDetail(
        success: json["success"],
        statusCode: json["status_code"],
        messages: json["messages"],
        data: List<DataHutangDetail>.from(
            json["data"].map((x) => DataHutangDetail.fromJson(x))),
        //   meta: Meta.fromJson(json["meta"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "status_code": statusCode,
        "messages": messages,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        // "meta": meta.toJson(),
      };
}

class DataHutangDetail {
  int? id;
  int? idHutang;
  int? idToko;
  int? idPelanggan;
  int? bayar;
  int? sisa;
  String? tglHutang;
  String? tglBayar;
  String? tglLunas;
  String? sync;
  String? aktif;

  DataHutangDetail({
    this.id,
    this.idHutang,
    this.idToko,
    this.idPelanggan,
    this.bayar,
    this.sisa,
    this.tglHutang,
    this.tglBayar,
    this.tglLunas,
    this.sync,
    this.aktif,
  });

  factory DataHutangDetail.fromJson(Map<String, dynamic> json) =>
      DataHutangDetail(
        id: json["id"],
        idHutang: json["id_hutang"],
        idToko: json["id_toko"],
        idPelanggan: json["id_pelanggan"],
        bayar: json["bayar"],
        sisa: json["sisa"],
        tglHutang: json["tgl_hutang"],
        tglBayar: json["tgl_bayar"],
        tglLunas: json["tgl_lunas"] ?? null,
        sync: json["sync"],
        aktif: json["aktif"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "id_hutang": idHutang,
        "id_toko": idToko,
        "id_pelanggan": idPelanggan,
        "bayar": bayar,
        "sisa": sisa,
        "tgl_hutang": tglHutang,
        "tgl_bayar": tglBayar,
        "tgl_lunas": tglLunas,
        "sync": sync,
        "aktif": aktif,
      };

  Map<String, dynamic> toMapForDb() {
    var map = <String, dynamic>{};
    map['id'] = id;
    map['id_toko'] = idToko;
    map['id_pelanggan'] = idPelanggan;
    map['id_hutang'] = idHutang;
    map['bayar'] = bayar;
    map['sisa'] = sisa;
    map['tgl_hutang'] = tglHutang;
    map['tgl_bayar'] = tglBayar;
    map['tgl_lunas'] = tglLunas ?? null;
    map['sync'] = sync;
    map['aktif'] = aktif;
    return map;
  }
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
