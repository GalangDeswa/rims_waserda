// To parse this JSON data, do
//
//     final modelBeban = modelBebanFromJson(jsonString);

import 'dart:convert';

ModelBeban modelBebanFromJson(String str) =>
    ModelBeban.fromJson(json.decode(str));

String modelBebanToJson(ModelBeban data) => json.encode(data.toJson());

class ModelBeban {
  ModelBeban({
    required this.success,
    required this.statusCode,
    required this.messages,
    required this.data,
    // required this.meta,
  });

  bool success;
  int statusCode;
  String messages;
  List<DataBeban> data;

  // Meta meta;

  factory ModelBeban.fromJson(Map<String, dynamic> json) => ModelBeban(
        success: json["success"],
        statusCode: json["status_code"],
        messages: json["messages"],
        data: List<DataBeban>.from(
            json["data"].map((x) => DataBeban.fromJson(x))),
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

class DataBeban {
  DataBeban({
    this.id,
    this.idLocal,
    this.idToko,
    this.idUser,
    this.nama,
    this.keterangan,
    this.tgl,
    this.jumlah,
    this.idKtrBeban,
    this.namaKtrBeban,
    this.sync,
    required this.aktif,
  });

  int? id;
  String? idLocal;
  int? idToko;
  int? idUser;
  String? nama;
  String? keterangan;
  String? tgl;
  int? jumlah;
  String? idKtrBeban;
  String? namaKtrBeban;
  String? sync;
  String aktif;

  factory DataBeban.fromJson(Map<String, dynamic> json) => DataBeban(
        id: json["id"],
        idLocal: json["id_local"],
        idToko: json["id_toko"],
        idUser: json["id_user"],
        nama: json["nama"],
        keterangan: json["keterangan"],
        tgl: json["tgl"],
        jumlah: json["jumlah"],
        idKtrBeban: json["id_ktr_beban"],
        namaKtrBeban: json["nama_ktr_beban"],
        sync: json["sync"],
        aktif: json["aktif"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "id_local": idLocal,
        "id_toko": idToko,
        "id_user": idUser,
        "nama": nama,
        "keterangan": keterangan,
        "tgl": tgl,
        "jumlah": jumlah,
        "id_ktr_beban": idKtrBeban,
        "nama_ktr_beban": namaKtrBeban,
        "sync": sync,
        "aktif": aktif,
      };

  Map<String, dynamic> toMapForDb() {
    var map = <String, dynamic>{};
    map['id'] = id;
    map['id_local'] = idLocal;
    map['id_toko'] = idToko;
    map['id_user'] = idUser;
    map['nama'] = nama;
    map['keterangan'] = keterangan;
    map['tgl'] = tgl;
    map['jumlah'] = jumlah;
    map['id_ktr_beban'] = idKtrBeban;
    map['nama_ktr_beban'] = namaKtrBeban;
    map['sync'] = sync;
    map['aktif'] = aktif;
    return map;
  }
}

// class Meta {
//   Meta({
//     required this.catatan,
//     required this.pagination,
//   });
//
//   String catatan;
//   Pagination pagination;
//
//   factory Meta.fromJson(Map<String, dynamic> json) => Meta(
//         catatan: json["catatan"],
//         pagination: Pagination.fromJson(json["pagination"]),
//       );
//
//   Map<String, dynamic> toJson() => {
//         "catatan": catatan,
//         "pagination": pagination.toJson(),
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
//   // List<dynamic> links;
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
//         // "links": List<dynamic>.from(links.map((x) => x)),
//       };
// }
