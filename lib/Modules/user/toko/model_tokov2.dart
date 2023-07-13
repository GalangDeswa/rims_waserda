// To parse this JSON data, do
//
//     final modeltokov2 = modeltokov2FromJson(jsonString);

import 'dart:convert';

Modeltokov2 modeltokov2FromJson(String str) =>
    Modeltokov2.fromJson(json.decode(str));

String modeltokov2ToJson(Modeltokov2 data) => json.encode(data.toJson());

class Modeltokov2 {
  String messages;
  int status;
  List<DataTokov2> data;

  Modeltokov2({
    required this.messages,
    required this.status,
    required this.data,
  });

  factory Modeltokov2.fromJson(Map<String, dynamic> json) => Modeltokov2(
        messages: json["messages"],
        status: json["status"],
        data: List<DataTokov2>.from(
            json["data"].map((x) => DataTokov2.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "messages": messages,
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class DataTokov2 {
  int? id;
  String? idLocal;
  int? idUser;
  String? jenisusaha;
  String? namaToko;
  String? alamat;
  String? nohp;
  String? email;
  String? logo;
  String? status;
  DateTime? tglAktif;
  DateTime? createdAt;
  dynamic updatedAt;
  dynamic deletedAt;
  String? sync;

  DataTokov2({
    this.id,
    this.idLocal,
    this.idUser,
    this.jenisusaha,
    this.namaToko,
    this.alamat,
    this.nohp,
    this.email,
    this.logo,
    this.status,
    this.tglAktif,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.sync,
  });

  factory DataTokov2.fromJson(Map<String, dynamic> json) => DataTokov2(
        id: json["id"],
        sync: json["sync"],
        idLocal: json["id_local"],
        idUser: json["id_user"],
        jenisusaha: json["jenisusaha"],
        namaToko: json["nama_toko"],
        alamat: json["alamat"],
        nohp: json["nohp"],
        email: json["email"],
        logo: json["logo"],
        status: json["status"],
        tglAktif: DateTime.parse(json["tgl_aktif"]),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"],
        deletedAt: json["deleted_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "sync": sync,
        "id_local": idLocal,
        "id_user": idUser,
        "jenisusaha": jenisusaha,
        "nama_toko": namaToko,
        "alamat": alamat,
        "nohp": nohp,
        "email": email,
        "logo": logo,
        "status": status,
        "tgl_aktif": tglAktif!.toIso8601String(),
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt,
        "deleted_at": deletedAt,
      };

  Map<String, dynamic> toMapForDb() {
    var map = <String, dynamic>{};
    map['id'] = id;
    map['id_local'] = idLocal;
    map['jenisusaha'] = jenisusaha;
    map['nama_toko'] = namaToko;
    map['alamat'] = alamat;
    map['nohp'] = nohp;
    map['email'] = email;
    map['logo'] = logo;
    map['status'] = status;
    map['tgl_aktif'] = tglAktif;
    map['sync'] = sync;

    return map;
  }
}
