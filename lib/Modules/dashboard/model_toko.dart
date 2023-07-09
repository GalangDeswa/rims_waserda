// To parse this JSON data, do
//
//     final modelToko = modelTokoFromJson(jsonString);

import 'dart:convert';

ModelToko modelTokoFromJson(String str) => ModelToko.fromJson(json.decode(str));

String modelTokoToJson(ModelToko data) => json.encode(data.toJson());

class ModelToko {
  ModelToko({
    required this.success,
    required this.message,
    required this.data,
  });

  bool success;
  String message;
  List<Datum> data;

  factory ModelToko.fromJson(Map<String, dynamic> json) => ModelToko(
        success: json["success"],
        message: json["message"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    required this.toko,
    required this.konten,
    required this.pendapatan,
    required this.beban,
    required this.version,
  });

  Toko toko;
  List<Konten> konten;
  int pendapatan;
  int beban;
  List<Version> version;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        toko: Toko.fromJson(json["toko"]),
        konten:
            List<Konten>.from(json["konten"].map((x) => Konten.fromJson(x))),
        pendapatan: json["pendapatan"],
        beban: json["beban"],
        version:
            List<Version>.from(json["version"].map((x) => Version.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "toko": toko.toJson(),
        "konten": List<dynamic>.from(konten.map((x) => x.toJson())),
        "pendapatan": pendapatan,
        "beban": beban,
        "version": List<dynamic>.from(version.map((x) => x.toJson())),
      };
}

class Konten {
  Konten({
    required this.id,
    required this.judul,
    required this.deskripsi,
    required this.link,
    required this.photo,
  });

  int id;
  String judul;
  String deskripsi;
  String link;
  String photo;

  factory Konten.fromJson(Map<String, dynamic> json) => Konten(
        id: json["id"],
        judul: json["judul"],
        deskripsi: json["deskripsi"],
        link: json["link"],
        photo: json["photo"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "judul": judul,
        "deskripsi": deskripsi,
        "link": link,
        "photo": photo,
      };
}

class Toko {
  Toko({
    required this.id,
    required this.idUser,
    required this.jenisusaha,
    required this.namaToko,
    required this.alamat,
    this.nohp,
    required this.email,
    this.logo,
    required this.status,
    required this.tglAktif,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  int id;
  String idUser;
  String jenisusaha;
  String namaToko;
  String alamat;
  dynamic nohp;
  String email;
  dynamic logo;
  String status;
  DateTime tglAktif;
  DateTime? createdAt;
  dynamic updatedAt;
  dynamic deletedAt;

  factory Toko.fromJson(Map<String, dynamic> json) => Toko(
        id: json["id"],
        idUser: json["id_user"].toString(),
        jenisusaha: json["jenisusaha"],
        namaToko: json["nama_toko"],
        alamat: json["alamat"],
        nohp: json["nohp"],
        email: json["email"],
        logo: json["logo"],
        status: json["status"],
        tglAktif: DateTime.parse(json["tgl_aktif"]),
        //createdAt: DateTime.parse(json["created_at"]),
        //updatedAt: json["updated_at"],
        // deletedAt: json["deleted_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "id_user": idUser,
        "jenisusaha": jenisusaha,
        "nama_toko": namaToko,
        "alamat": alamat,
        "nohp": nohp,
        "email": email,
        "logo": logo,
        "status": status,
        "tgl_aktif": tglAktif.toIso8601String(),
        //  "created_at": createdAt.toIso8601String(),
        //"updated_at": updatedAt,
        //"deleted_at": deletedAt,
      };
}

class Version {
  Version({
    required this.id,
    required this.appVersion,
    required this.link,
    required this.comment,
  });

  int id;
  String appVersion;
  String link;
  String comment;

  factory Version.fromJson(Map<String, dynamic> json) => Version(
        id: json["id"],
        appVersion: json["app_version"],
        link: json["link"],
        comment: json["comment"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "app_version": appVersion,
        "link": link,
        "comment": comment,
      };
}
