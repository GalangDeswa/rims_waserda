// To parse this JSON data, do
//
//     final modelPenjualan = modelPenjualanFromJson(jsonString);

import 'dart:convert';

ModelPenjualan modelPenjualanFromJson(String str) =>
    ModelPenjualan.fromJson(json.decode(str));

String modelPenjualanToJson(ModelPenjualan data) => json.encode(data.toJson());

class ModelPenjualan {
  ModelPenjualan({
    required this.success,
    required this.statusCode,
    required this.messages,
    required this.data,
    //  required this.meta,
  });

  bool success;
  int statusCode;
  String messages;
  List<DataPenjualan> data;

  //Meta meta;

  factory ModelPenjualan.fromJson(Map<String, dynamic> json) => ModelPenjualan(
        success: json["success"],
        statusCode: json["status_code"],
        messages: json["messages"],
        data: List<DataPenjualan>.from(
            json["data"].map((x) => DataPenjualan.fromJson(x))),
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

class DataPenjualan {
  DataPenjualan({
    this.id,
    this.idLocal,
    this.meja,
    this.idToko,
    this.idUser,
    this.namaPelanggan,
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
    this.sync,
    this.idPelanggan,
    required this.aktif,
    this.idHutang,
  });

  int? id;
  String? idLocal;
  String? meja;
  int? idToko;
  int? idUser;
  String? idPelanggan;
  String? namaPelanggan;
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
  String? sync;
  String aktif;
  String? idHutang;

  // List<DetailItem>? detailItem;

  factory DataPenjualan.fromJson(Map<String, dynamic> json) => DataPenjualan(
        id: json["id"],
        idLocal: json["id_local"],
        meja: json["meja"] ?? '0',
        idToko: json["id_toko"],
        idUser: json["id_user"],
        idPelanggan: json["id_pelanggan"] ?? '0',
        namaPelanggan: json["nama_pelanggan"] ?? '-',
        namaUser: json["nama_user"],
        totalItem: json["total_item"],
        diskonTotal: json["diskon_total"],
        subTotal: json["sub_total"],
        total: json["total"],
        bayar: json["bayar"] ?? 0.toString(),
        kembalian: json["kembalian"],
        tglPenjualan: json["tgl_penjualan"],
        metodeBayar: json["metode_bayar"],
        status: json["status"],
        sync: json["sync"],
        aktif: json["aktif"],
        idHutang: json["id_hutang"] ?? '0',
        // detailItem: List<DetailItem>.from(
        //     json["detail_item"].map((x) => DetailItem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "id_local": idLocal,
        "meja": meja,
        "id_toko": idToko,
        "id_user": idUser,
        "id_pelanggan": idPelanggan,
        "nama_pelanggan": namaPelanggan,
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
        "sync": sync,
        "aktif": aktif,
        "id_hutang": idHutang,
        //   "detail_item": List<dynamic>.from(detailItem!.map((x) => x.toJson())),
      };

  Map<String, dynamic> toMapForDb() {
    var map = <String, dynamic>{};
    map['id'] = id;
    map['id_local'] = idLocal;
    map['id_user'] = idUser;
    map['meja'] = meja;
    map['id_toko'] = idToko;
    map['id_pelanggan'] = idPelanggan ?? '0';
    map['nama_pelanggan'] = namaPelanggan ?? '-';
    map['nama_user'] = namaUser;
    map['total_item'] = totalItem;
    map['diskon_total'] = diskonTotal;
    map['sub_total'] = subTotal;
    map['total'] = total;
    map['bayar'] = bayar;
    map['kembalian'] = kembalian;
    map['tgl_penjualan'] = tglPenjualan;
    map['metode_bayar'] = metodeBayar;
    map['sync'] = sync;
    map['status'] = status;
    map['aktif'] = aktif;
    map['id_hutang'] = idHutang ?? '0';

    return map;
  }
}

class DetailItem {
  DetailItem({
    this.idPenjualan,
    this.idProduk,
    this.idKategori,
    this.namaBrg,
    this.hargaBrg,
    this.hargaModal,
    this.qty,
    this.diskonBrg,
    this.total,
  });

  int? idPenjualan;
  int? idProduk;
  int? idKategori;
  String? namaBrg;
  int? hargaBrg;
  int? hargaModal;
  int? qty;
  int? diskonBrg;
  int? total;

  factory DetailItem.fromJson(Map<String, dynamic> json) => DetailItem(
        idPenjualan: json["id_penjualan"],
        idProduk: json["id_produk"],
        idKategori: json["id_kategori"],
        namaBrg: json["nama_brg"],
        hargaBrg: json["harga_brg"],
        hargaModal: json["harga_modal"] ?? '0',
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
        "harga_modal": hargaModal,
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
    map['harga_modal'] = hargaModal;
    map['qty'] = qty;
    map['diskon_barang'] = diskonBrg;

    map['total'] = total;

    return map;
  }
}

// class Meta {
//   Meta({
//     this.catatan,
//     required this.pagination,
//   });
//
//   Catatan? catatan;
//   Pagination pagination;
//
//   factory Meta.fromJson(Map<String, dynamic> json) => Meta(
//         //catatan: Catatan.fromJson(json["catatan"]) ?? null,
//         pagination: Pagination.fromJson(json["pagination"]),
//       );
//
//   Map<String, dynamic> toJson() => {
//         "catatan": catatan?.toJson(),
//         "pagination": pagination.toJson(),
//       };
// }
//
// class Catatan {
//   Catatan({
//     this.status,
//     this.metodeBayarDtl,
//   });
//
//   String? status;
//   String? metodeBayarDtl;
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
//
// class Pagination {
//   Pagination({
//     required this.total,
//     required this.count,
//     required this.perPage,
//     required this.currentPage,
//     required this.totalPages,
//     //required this.links,
//   });
//
//   int total;
//   int count;
//   int perPage;
//   int currentPage;
//   int totalPages;
//
//   //List<dynamic> links;
//
//   factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
//         total: json["total"],
//         count: json["count"],
//         perPage: json["per_page"],
//         currentPage: json["current_page"],
//         totalPages: json["total_pages"],
//         //links: List<dynamic>.from(json["links"].map((x) => x)),
//       );
//
//   Map<String, dynamic> toJson() => {
//         "total": total,
//         "count": count,
//         "per_page": perPage,
//         "current_page": currentPage,
//         "total_pages": totalPages,
//         //"links": List<dynamic>.from(links.map((x) => x)),
//       };
// }
