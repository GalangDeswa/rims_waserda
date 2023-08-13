// To parse this JSON data, do
//
//     final modelJenis = modelJenisFromJson(jsonString);

import 'dart:convert';

ModelJenis modelJenisFromJson(String str) =>
    ModelJenis.fromJson(json.decode(str));

String modelJenisToJson(ModelJenis data) => json.encode(data.toJson());

class ModelJenis {
  ModelJenis({
    required this.success,
    required this.statusCode,
    required this.messages,
    required this.data,
    //required this.meta,
  });

  bool success;
  int statusCode;
  String messages;
  List<DataJenis> data;
  //Meta meta;

  factory ModelJenis.fromJson(Map<String, dynamic> json) => ModelJenis(
        success: json["success"],
        statusCode: json["status_code"],
        messages: json["messages"],
        data: List<DataJenis>.from(
            json["data"].map((x) => DataJenis.fromJson(x))),
        //  meta: Meta.fromJson(json["meta"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "status_code": statusCode,
        "messages": messages,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        //"meta": meta.toJson(),
      };
}

class DataJenis {
  DataJenis({
    this.id,
    this.idLocal,
    this.idToko,
    this.namaJenis,
    this.sync,
    required this.aktif,
  });

  int? id;
  String? idLocal;
  String? idToko;
  String? namaJenis;
  String? sync;
  String aktif;

  // @override
  // bool operator ==(Object other) =>
  //     other is DataJenis && other.namaJenis == namaJenis;
  //
  // @override
  // int get hashCode => namaJenis.hashCode;

  factory DataJenis.fromJson(Map<String, dynamic> json) => DataJenis(
        id: json["id"],
        idLocal: json["id_local"],
        idToko: json["id_toko"].toString(),
        namaJenis: json["nama_jenis"],
        sync: json["sync"],
        aktif: json["aktif"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "id_local": idLocal,
        "id_toko": idToko,
        "nama_jenis": namaJenis,
        "sync": sync,
        "aktif": aktif,
      };

  Map<String, dynamic> toMapForDb() {
    var map = <String, dynamic>{};
    map['id'] = id;
    map['id_local'] = idLocal;
    map['id_toko'] = idToko;
    map['nama_jenis'] = namaJenis;
    map['sync'] = sync;
    map['aktif'] = aktif;
    return map;
  }

  Map<String, dynamic> updateInit() {
    var map = <String, dynamic>{};

    map['id_local'] = idLocal;
    map['id_toko'] = idToko;
    map['nama_jenis'] = namaJenis;
    map['sync'] = sync;
    map['aktif'] = aktif;
    return map;
  }
}

// class Meta {
//   Meta({
//     required this.catatan,
//     // required this.pagination,
//   });
//
//   String catatan;
//   //Pagination pagination;
//
//   factory Meta.fromJson(Map<String, dynamic> json) => Meta(
//         catatan: json["catatan"],
//         // pagination: Pagination.fromJson(json["pagination"]),
//       );
//
//   Map<String, dynamic> toJson() => {
//         "catatan": catatan,
//         // "pagination": pagination.toJson(),
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
