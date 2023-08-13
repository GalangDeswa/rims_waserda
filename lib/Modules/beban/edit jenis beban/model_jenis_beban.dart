// To parse this JSON data, do
//
//     final modelJenisBeban = modelJenisBebanFromJson(jsonString);

import 'dart:convert';

ModelJenisBeban modelJenisBebanFromJson(String str) =>
    ModelJenisBeban.fromJson(json.decode(str));

String modelJenisBebanToJson(ModelJenisBeban data) =>
    json.encode(data.toJson());

class ModelJenisBeban {
  ModelJenisBeban({
    required this.success,
    required this.statusCode,
    required this.messages,
    required this.data,
    // required this.meta,
  });

  bool success;
  int statusCode;
  String messages;
  List<DataJenisBeban> data;

  // Meta meta;

  factory ModelJenisBeban.fromJson(Map<String, dynamic> json) =>
      ModelJenisBeban(
        success: json["success"],
        statusCode: json["status_code"],
        messages: json["messages"],
        data: List<DataJenisBeban>.from(
            json["data"].map((x) => DataJenisBeban.fromJson(x))),
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

class DataJenisBeban {
  DataJenisBeban(
      {this.id,
      this.idToko,
      this.kategori,
      this.sync,
      this.idLocal,
      required this.aktif});

  int? id;
  String? idLocal;
  int? idToko;
  String? kategori;
  String? sync;
  String aktif;

  factory DataJenisBeban.fromJson(Map<String, dynamic> json) => DataJenisBeban(
        id: json["id"],
        idLocal: json["id_local"],
        idToko: json["id_toko"],
        kategori: json["kategori"],
        sync: json["sync"],
        aktif: json["aktif"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "id_local": idLocal,
        "id_toko": idToko,
        "kategori": kategori,
        "aktif": aktif,
        "sync": sync,
      };

  Map<String, dynamic> toMapForDb() {
    var map = <String, dynamic>{};
    map['id'] = id;
    map['id_local'] = idLocal;
    map['id_toko'] = idToko;
    map['kategori'] = kategori;
    map['sync'] = sync;
    map['aktif'] = aktif;
    return map;
  }

  Map<String, dynamic> updateInit() {
    var map = <String, dynamic>{};
    map['id_local'] = idLocal;
    map['id_toko'] = idToko;
    map['kategori'] = kategori;
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
