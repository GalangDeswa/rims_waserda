// // To parse this JSON data, do
// //
// //     final modelHutangv2 = modelHutangv2FromJson(jsonString);
//
// import 'dart:convert';
//
// ModelHutangv2 modelHutangv2FromJson(String str) =>
//     ModelHutangv2.fromJson(json.decode(str));
//
// String modelHutangv2ToJson(ModelHutangv2 data) => json.encode(data.toJson());
//
// class ModelHutangv2 {
//   bool success;
//   int statusCode;
//   String messages;
//   List<DataHutangv2> data;
//   Meta meta;
//
//   ModelHutangv2({
//     required this.success,
//     required this.statusCode,
//     required this.messages,
//     required this.data,
//     required this.meta,
//   });
//
//   factory ModelHutangv2.fromJson(Map<String, dynamic> json) => ModelHutangv2(
//         success: json["success"],
//         statusCode: json["status_code"],
//         messages: json["messages"],
//         data: List<DataHutangv2>.from(
//             json["data"].map((x) => DataHutangv2.fromJson(x))),
//         meta: Meta.fromJson(json["meta"]),
//       );
//
//   Map<String, dynamic> toJson() => {
//         "success": success,
//         "status_code": statusCode,
//         "messages": messages,
//         "data": List<dynamic>.from(data.map((x) => x.toJson())),
//         "meta": meta.toJson(),
//       };
// }
//
// class DataHutangv2 {
//   int id;
//   int idPelanggan;
//   String namaPelanggan;
//   int idToko;
//   int hutang;
//   DateTime tglHutang;
//   int status;
//   List<DetailHutang> detailHutang;
//   List<DetailItem> detailItem;
//   List<RiwayatHutang> riwayatHutang;
//
//   DataHutangv2({
//     required this.id,
//     required this.idPelanggan,
//     required this.namaPelanggan,
//     required this.idToko,
//     required this.hutang,
//     required this.tglHutang,
//     required this.status,
//     required this.detailHutang,
//     required this.detailItem,
//     required this.riwayatHutang,
//   });
//
//   factory DataHutangv2.fromJson(Map<String, dynamic> json) => DataHutangv2(
//         id: json["id"],
//         idPelanggan: json["id_pelanggan"],
//         namaPelanggan: json["nama_pelanggan"],
//         idToko: json["id_toko"],
//         hutang: json["hutang"],
//         tglHutang: DateTime.parse(json["tgl_hutang"]),
//         status: json["status"],
//         detailHutang: List<DetailHutang>.from(
//             json["detail_hutang"].map((x) => DetailHutang.fromJson(x))),
//         detailItem: List<DetailItem>.from(
//             json["detail_item"].map((x) => DetailItem.fromJson(x))),
//         riwayatHutang: List<RiwayatHutang>.from(
//             json["riwayat_hutang"].map((x) => RiwayatHutang.fromJson(x))),
//       );
//
//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "id_pelanggan": idPelanggan,
//         "nama_pelanggan": namaPelanggan,
//         "id_toko": idToko,
//         "hutang": hutang,
//         "tgl_hutang": tglHutang.toIso8601String(),
//         "status": status,
//         "detail_hutang":
//             List<dynamic>.from(detailHutang.map((x) => x.toJson())),
//         "detail_item": List<dynamic>.from(detailItem.map((x) => x.toJson())),
//         "riwayat_hutang":
//             List<dynamic>.from(riwayatHutang.map((x) => x.toJson())),
//       };
// }
//
// class DetailHutang {
//   int idPenjualan;
//   int idToko;
//   int totalItem;
//   DateTime tglPenjualan;
//   int metodeBayar;
//
//   DetailHutang({
//     required this.idPenjualan,
//     required this.idToko,
//     required this.totalItem,
//     required this.tglPenjualan,
//     required this.metodeBayar,
//   });
//
//   factory DetailHutang.fromJson(Map<String, dynamic> json) => DetailHutang(
//         idPenjualan: json["id_penjualan"],
//         idToko: json["id_toko"],
//         totalItem: json["total_item"],
//         tglPenjualan: DateTime.parse(json["tgl_penjualan"]),
//         metodeBayar: json["metode_bayar"],
//       );
//
//   Map<String, dynamic> toJson() => {
//         "id_penjualan": idPenjualan,
//         "id_toko": idToko,
//         "total_item": totalItem,
//         "tgl_penjualan": tglPenjualan.toIso8601String(),
//         "metode_bayar": metodeBayar,
//       };
// }
//
// class DetailItem {
//   int idPenjualan;
//   int idProduk;
//   int idKategori;
//   int idJenisStock;
//   String namaBrg;
//   int hargaBrg;
//   int qty;
//   int diskonBrg;
//   int total;
//
//   DetailItem({
//     required this.idPenjualan,
//     required this.idProduk,
//     required this.idKategori,
//     required this.idJenisStock,
//     required this.namaBrg,
//     required this.hargaBrg,
//     required this.qty,
//     required this.diskonBrg,
//     required this.total,
//   });
//
//   factory DetailItem.fromJson(Map<String, dynamic> json) => DetailItem(
//         idPenjualan: json["id_penjualan"],
//         idProduk: json["id_produk"],
//         idKategori: json["id_kategori"],
//         idJenisStock: json["id_jenis_stock"],
//         namaBrg: json["nama_brg"],
//         hargaBrg: json["harga_brg"],
//         qty: json["qty"],
//         diskonBrg: json["diskon_brg"],
//         total: json["total"],
//       );
//
//   Map<String, dynamic> toJson() => {
//         "id_penjualan": idPenjualan,
//         "id_produk": idProduk,
//         "id_kategori": idKategori,
//         "id_jenis_stock": idJenisStock,
//         "nama_brg": namaBrg,
//         "harga_brg": hargaBrg,
//         "qty": qty,
//         "diskon_brg": diskonBrg,
//         "total": total,
//       };
// }
//
// class RiwayatHutang {
//   int id;
//   int idHutang;
//   int idPelanggan;
//   int bayar;
//   int sisa;
//   DateTime tglHutang;
//   DateTime tglBayar;
//   DateTime? tglLunas;
//
//   RiwayatHutang({
//     required this.id,
//     required this.idHutang,
//     required this.idPelanggan,
//     required this.bayar,
//     required this.sisa,
//     required this.tglHutang,
//     required this.tglBayar,
//     this.tglLunas,
//   });
//
//   factory RiwayatHutang.fromJson(Map<String, dynamic> json) => RiwayatHutang(
//         id: json["id"],
//         idHutang: json["id_hutang"],
//         idPelanggan: json["id_pelanggan"],
//         bayar: json["bayar"],
//         sisa: json["sisa"],
//         tglHutang: DateTime.parse(json["tgl_hutang"]),
//         tglBayar: DateTime.parse(json["tgl_bayar"]),
//         tglLunas: json["tgl_lunas"] == null
//             ? null
//             : DateTime.parse(json["tgl_lunas"]),
//       );
//
//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "id_hutang": idHutang,
//         "id_pelanggan": idPelanggan,
//         "bayar": bayar,
//         "sisa": sisa,
//         "tgl_hutang": tglHutang.toIso8601String(),
//         "tgl_bayar": tglBayar.toIso8601String(),
//         "tgl_lunas": tglLunas?.toIso8601String(),
//       };
// }
//
// class Meta {
//   Catatan catatan;
//   Pagination pagination;
//
//   Meta({
//     required this.catatan,
//     required this.pagination,
//   });
//
//   factory Meta.fromJson(Map<String, dynamic> json) => Meta(
//         catatan: Catatan.fromJson(json["catatan"]),
//         pagination: Pagination.fromJson(json["pagination"]),
//       );
//
//   Map<String, dynamic> toJson() => {
//         "catatan": catatan.toJson(),
//         "pagination": pagination.toJson(),
//       };
// }
//
// class Catatan {
//   String status;
//
//   Catatan({
//     required this.status,
//   });
//
//   factory Catatan.fromJson(Map<String, dynamic> json) => Catatan(
//         status: json["status"],
//       );
//
//   Map<String, dynamic> toJson() => {
//         "status": status,
//       };
// }
//
// class Pagination {
//   int total;
//   int count;
//   int perPage;
//   int currentPage;
//   int totalPages;
//   List<dynamic> links;
//
//   Pagination({
//     required this.total,
//     required this.count,
//     required this.perPage,
//     required this.currentPage,
//     required this.totalPages,
//     required this.links,
//   });
//
//   factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
//         total: json["total"],
//         count: json["count"],
//         perPage: json["per_page"],
//         currentPage: json["current_page"],
//         totalPages: json["total_pages"],
//         links: List<dynamic>.from(json["links"].map((x) => x)),
//       );
//
//   Map<String, dynamic> toJson() => {
//         "total": total,
//         "count": count,
//         "per_page": perPage,
//         "current_page": currentPage,
//         "total_pages": totalPages,
//         "links": List<dynamic>.from(links.map((x) => x)),
//       };
// }
