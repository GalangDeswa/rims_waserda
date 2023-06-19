// To parse this JSON data, do
//
//     final modelDetailPenjualanV2 = modelDetailPenjualanV2FromJson(jsonString);

import 'dart:convert';

ModelDetailPenjualanV2 modelDetailPenjualanV2FromJson(String str) =>
    ModelDetailPenjualanV2.fromJson(json.decode(str));

String modelDetailPenjualanV2ToJson(ModelDetailPenjualanV2 data) =>
    json.encode(data.toJson());

class ModelDetailPenjualanV2 {
  bool? success;
  int? statusCode;
  String? messages;
  List<DataPenjualanDetailV2>? data;
  // Meta? meta;

  ModelDetailPenjualanV2({
    this.success,
    this.statusCode,
    this.messages,
    this.data,
    //  this.meta,
  });

  factory ModelDetailPenjualanV2.fromJson(Map<String, dynamic> json) =>
      ModelDetailPenjualanV2(
        success: json["success"],
        statusCode: json["status_code"],
        messages: json["messages"],
        data: json["data"] == null
            ? []
            : List<DataPenjualanDetailV2>.from(
                json["data"]!.map((x) => DataPenjualanDetailV2.fromJson(x))),
        // meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "status_code": statusCode,
        "messages": messages,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        // "meta": meta?.toJson(),
      };
}

class DataPenjualanDetailV2 {
  int? id;
  int? idPenjualan;
  int? idProduk;
  int? idKategori;
  int? idJenisStock;
  String? namaBrg;
  int? hargaBrg;
  int? hargaModal;
  int? qty;
  int? diskonBrg;
  int? diskonKasir;
  int? total;
  String? sync;
  String? tgl;
  String aktif;
  int? idUser;

  DataPenjualanDetailV2({
    this.idPenjualan,
    this.id,
    this.idProduk,
    this.idKategori,
    this.idJenisStock,
    this.namaBrg,
    this.hargaBrg,
    this.hargaModal,
    this.qty,
    this.diskonBrg,
    this.diskonKasir,
    this.total,
    this.sync,
    this.tgl,
    this.idUser,
    required this.aktif,
  });

  factory DataPenjualanDetailV2.fromJson(Map<String, dynamic> json) =>
      DataPenjualanDetailV2(
        id: json["id"],
        idPenjualan: json["id_penjualan"],
        idProduk: json["id_produk"],
        idKategori: json["id_kategori"],
        idJenisStock: json["id_jenis_stock"],
        namaBrg: json["nama_brg"],
        hargaBrg: json["harga_brg"],
        hargaModal: json["harga_modal"],
        qty: json["qty"],
        diskonBrg: json["diskon_brg"],
        diskonKasir: json["diskon_kasir"],
        total: json["total"],
        sync: json["sync"],
        tgl: json["tgl"],
        aktif: json["aktif"],
        idUser: json["id_user"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "id_penjualan": idPenjualan,
        "id_produk": idProduk,
        "id_kategori": idKategori,
        "id_jenis_stock": idJenisStock,
        "nama_brg": namaBrg,
        "harga_brg": hargaBrg,
        "harga_modal": hargaModal,
        "qty": qty,
        "diskon_brg": diskonBrg,
        "diskon_kasir": diskonKasir,
        "total": total,
        "sync": sync,
        "tgl": tgl,
        "aktif": aktif,
        "id_user": idUser,
      };

  Map<String, dynamic> toMapForDb() {
    var map = <String, dynamic>{};
    map['id'] = id;
    map['id_penjualan'] = idPenjualan;
    map['id_produk'] = idProduk;
    map['id_kategori'] = idKategori;
    map['id_jenis_stock'] = idJenisStock;
    map['nama_brg'] = namaBrg;
    map['harga_brg'] = hargaBrg;
    map['harga_modal'] = hargaModal;
    map['diskon_brg'] = diskonBrg;
    map['diskon_kasir'] = diskonKasir;
    map['qty'] = qty;
    map['total'] = total;
    map['sync'] = sync;
    map['tgl'] = tgl;
    map['aktif'] = aktif;
    map['id_user'] = idUser;
    return map;
  }
}

// class Meta {
//   Catatan? catatan;
//
//   Meta({
//     this.catatan,
//   });
//
//   factory Meta.fromJson(Map<String, dynamic> json) => Meta(
//         catatan:
//             json["catatan"] == null ? null : Catatan.fromJson(json["catatan"]),
//       );
//
//   Map<String, dynamic> toJson() => {
//         "catatan": catatan?.toJson(),
//       };
// }
//
// class Catatan {
//   String? status;
//   String? metodeBayarDtl;
//
//   Catatan({
//     this.status,
//     this.metodeBayarDtl,
//   });
//
//   factory Catatan.fromJson(Map<String, dynamic> json) => Catatan(
//         status: json["status"],
//         metodeBayarDtl: json["metode_bayar_dtl"],
//       );
//
//   Map<String, dynamic> toJson() => {
//         "status": status,
//         "metode_bayar_dtl": metodeBayarDtl,
//       };
// }
