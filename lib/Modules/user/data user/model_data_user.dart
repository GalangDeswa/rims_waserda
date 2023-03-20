// To parse this JSON data, do
//
//     final modelUser = modelUserFromJson(jsonString);

import 'dart:convert';

ModelUser modelUserFromJson(String str) => ModelUser.fromJson(json.decode(str));

String modelUserToJson(ModelUser data) => json.encode(data.toJson());

class ModelUser {
  ModelUser({
    required this.success,
    required this.statusCode,
    required this.messages,
    required this.data,
    required this.meta,
  });

  bool success;
  int statusCode;
  String messages;
  List<Datum> data;
  Meta meta;

  factory ModelUser.fromJson(Map<String, dynamic> json) => ModelUser(
        success: json["success"],
        statusCode: json["status_code"],
        messages: json["messages"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
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

class Datum {
  Datum({
    required this.id,
    required this.idToko,
    required this.nama,
    required this.email,
    this.hp,
    required this.role,
    required this.status,
  });

  int id;
  String idToko;
  String nama;
  String email;
  dynamic hp;
  String role;
  String status;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        idToko: json["id_toko"],
        nama: json["nama"],
        email: json["email"],
        hp: json["hp"],
        role: json["role"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "id_toko": idToko,
        "nama": nama,
        "email": email,
        "hp": hp,
        "role": role,
        "status": status,
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
    required this.role,
    required this.status,
  });

  String role;
  String status;

  factory Catatan.fromJson(Map<String, dynamic> json) => Catatan(
        role: json["role"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "role": role,
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
