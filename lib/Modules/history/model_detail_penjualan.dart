// To parse this JSON data, do
//
//     final modelDetailPenjualan = modelDetailPenjualanFromJson(jsonString);

import 'dart:convert';

ModelDetailPenjualan modelDetailPenjualanFromJson(String str) =>
    ModelDetailPenjualan.fromJson(json.decode(str));

String modelDetailPenjualanToJson(ModelDetailPenjualan data) =>
    json.encode(data.toJson());

class ModelDetailPenjualan {
  ModelDetailPenjualan({
    required this.success,
    required this.statusCode,
    required this.messages,
    required this.data,
    // required this.meta,
  });

  bool success;
  int statusCode;
  String messages;
  List<DataDetailPenjualan> data;
  //Meta meta;

  factory ModelDetailPenjualan.fromJson(Map<String, dynamic> json) =>
      ModelDetailPenjualan(
        success: json["success"],
        statusCode: json["status_code"],
        messages: json["messages"],
        data: List<DataDetailPenjualan>.from(
            json["data"].map((x) => DataDetailPenjualan.fromJson(x))),
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

class DataDetailPenjualan {
  DataDetailPenjualan({
    this.id,
    this.meja,
    this.idToko,
    this.idUser,
    this.namaUser,
    this.totalItem,
    this.diskonTotal,
    this.subTotal,
    this.total,
    this.bayar,
    this.kembalian,
    this.tglPenjualan,
    this.metodeBayar,
    this.status,
    // this.detailItem,
  });

  int? id;
  int? meja;
  int? idToko;
  int? idUser;
  String? namaUser;
  int? totalItem;
  int? diskonTotal;
  int? subTotal;
  int? total;
  int? bayar;
  int? kembalian;
  String? tglPenjualan;
  int? metodeBayar;
  int? status;

  // List<DetailItem>? detailItem;

  factory DataDetailPenjualan.fromJson(Map<String, dynamic> json) =>
      DataDetailPenjualan(
        id: json["id"],
        meja: json["meja"],
        idToko: json["id_toko"],
        idUser: json["id_user"],
        namaUser: json["nama_user"],
        totalItem: json["total_item"],
        diskonTotal: json["diskon_total"],
        subTotal: json["sub_total"],
        total: json["total"],
        bayar: json["bayar"] ?? 0,
        kembalian: json["kembalian"],
        tglPenjualan: json["tgl_penjualan"],
        metodeBayar: json["metode_bayar"],
        status: json["status"],
        // detailItem: List<DetailItem>.from(
        //     json["detail_item"].map((x) => DetailItem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "meja": meja,
        "id_toko": idToko,
        "id_user": idUser,
        "nama_user": namaUser,
        "total_item": totalItem,
        "diskon_total": diskonTotal,
        "sub_total": subTotal,
        "total": total,
        "bayar": bayar,
        "kembalian": kembalian,
        "tgl_penjualan": tglPenjualan,
        "metode_bayar": metodeBayar,
        "status": status,
        // "detail_item": List<dynamic>.from(detailItem!.map((x) => x.toJson())),
      };
}

class DetailItem {
  DetailItem({
    this.idPenjualan,
    this.idProduk,
    this.idKategori,
    this.namaBrg,
    this.hargaBrg,
    this.qty,
    this.diskonBrg,
    this.total,
  });

  int? idPenjualan;
  int? idProduk;
  int? idKategori;
  String? namaBrg;
  int? hargaBrg;
  int? qty;
  int? diskonBrg;
  int? total;

  factory DetailItem.fromJson(Map<String, dynamic> json) => DetailItem(
        idPenjualan: json["id_penjualan"],
        idProduk: json["id_produk"],
        idKategori: json["id_kategori"],
        namaBrg: json["nama_brg"],
        hargaBrg: json["harga_brg"],
        qty: json["qty"],
        diskonBrg: json["diskon_brg"],
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "id_penjualan": idPenjualan,
        "id_produk": idProduk,
        "id_kategori": idKategori,
        "nama_brg": namaBrg,
        "harga_brg": hargaBrg,
        "qty": qty,
        "diskon_brg": diskonBrg,
        "total": total,
      };

  Map<String, dynamic> toMapForDb() {
    var map = <String, dynamic>{};
    map['id_penjualan'] = idPenjualan;
    map['id_produk'] = idProduk;
    map['id_kategori'] = idKategori;
    map['nama_brg'] = namaBrg;
    map['harga_brg'] = hargaBrg;
    map['qty'] = qty;
    map['diskon_brg'] = diskonBrg;

    map['total'] = total;

    return map;
  }
}

// class Meta {
//   Meta({
//     required this.catatan,
//   });
//
//   Catatan catatan;
//
//   factory Meta.fromJson(Map<String, dynamic> json) => Meta(
//         catatan: Catatan.fromJson(json["catatan"]),
//       );
//
//   Map<String, dynamic> toJson() => {
//         "catatan": catatan.toJson(),
//       };
// }
//
// class Catatan {
//   Catatan({
//     required this.status,
//     required this.metodeBayarDtl,
//   });
//
//   String status;
//   String metodeBayarDtl;
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
