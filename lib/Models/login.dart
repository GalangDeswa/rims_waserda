// To parse this JSON data, do
//
//     final login = loginFromJson(jsonString);

import 'dart:convert';

Login loginFromJson(String str) => Login.fromJson(json.decode(str));

String loginToJson(Login data) => json.encode(data.toJson());

class Login {
  Login({
    this.accessToken,
    this.data,
  });

  String? accessToken;
  Data? data;

  factory Login.fromJson(Map<String, dynamic> json) => Login(
        accessToken: json["accessToken"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "accessToken": accessToken,
        "data": data!.toJson(),
      };
}

class Data {
  Data({
    this.id,
    this.nama,
    this.email,
    this.isActive,
    this.storeId,
  });

  String? id;
  String? nama;
  String? email;
  bool? isActive;
  List<StoreId>? storeId;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["_id"],
        nama: json["nama"],
        email: json["email"],
        isActive: json["is_active"],
        storeId: List<StoreId>.from(
            json["store_id"].map((x) => StoreId.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "nama": nama,
        "email": email,
        "is_active": isActive,
        "store_id": List<dynamic>.from(storeId!.map((x) => x.toJson())),
      };
}

class StoreId {
  StoreId({
    this.id,
    this.nama,
    this.email,
    this.phone,
    this.logoStore,
    this.alamat,
    this.kec,
    this.kab,
    this.receiptHeader,
    this.receiptFooter,
    this.createdAt,
    this.updatedAt,
  });

  String? id;
  String? nama;
  String? email;
  String? phone;
  String? logoStore;
  String? alamat;
  String? kec;
  String? kab;
  String? receiptHeader;
  String? receiptFooter;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory StoreId.fromJson(Map<String, dynamic> json) => StoreId(
        id: json["_id"],
        nama: json["nama"],
        email: json["email"],
        phone: json["phone"],
        logoStore: json["logo_store"],
        alamat: json["alamat"],
        kec: json["kec"],
        kab: json["kab"],
        receiptHeader: json["receipt_header"],
        receiptFooter: json["receipt_footer"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "nama": nama,
        "email": email,
        "phone": phone,
        "logo_store": logoStore,
        "alamat": alamat,
        "kec": kec,
        "kab": kab,
        "receipt_header": receiptHeader,
        "receipt_footer": receiptFooter,
        "createdAt": createdAt!.toIso8601String(),
        "updatedAt": updatedAt!.toIso8601String(),
      };
}
