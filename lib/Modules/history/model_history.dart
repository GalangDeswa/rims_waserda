// To parse this JSON data, do
//
//     final history = historyFromJson(jsonString);

import 'dart:convert';

History historyFromJson(String str) => History.fromJson(json.decode(str));

String historyToJson(History data) => json.encode(data.toJson());

class History {
  History({
    required this.status,
    required this.message,
    required this.history,
  });

  bool status;
  String message;
  List<HistoryElement> history;

  factory History.fromJson(Map<String, dynamic> json) => History(
        status: json["status"],
        message: json["message"],
        history: List<HistoryElement>.from(
            json["history"].map((x) => HistoryElement.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "history": List<dynamic>.from(history.map((x) => x.toJson())),
      };
}

class HistoryElement {
  HistoryElement({
    required this.id,
    required this.kodeProduk,
    required this.qty,
    required this.tgl,
    required this.idKasir,
    required this.namaProduk,
    required this.harga,
    required this.idKategori,
    required this.barcode,
    required this.idJenis,
    required this.satuan,
    required this.stock,
    required this.nomorTransaksi,
    required this.total,
  });

  String id;
  String kodeProduk;
  String qty;
  String tgl;
  String idKasir;
  String namaProduk;
  String harga;
  String idKategori;
  String barcode;
  String idJenis;
  String satuan;
  String stock;
  String nomorTransaksi;
  String total;

  factory HistoryElement.fromJson(Map<String, dynamic> json) => HistoryElement(
        id: json["id"],
        kodeProduk: json["kode_produk"],
        qty: json["qty"],
        tgl: json["tgl"],
        idKasir: json["id_kasir"],
        namaProduk: json["nama_produk"],
        harga: json["harga"],
        idKategori: json["id_kategori"],
        barcode: json["barcode"],
        idJenis: json["id_jenis"],
        satuan: json["satuan"],
        stock: json["stock"],
        nomorTransaksi: json["nomor_transaksi"],
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "kode_produk": kodeProduk,
        "qty": qty,
        "tgl": tgl,
        "id_kasir": idKasir,
        "nama_produk": namaProduk,
        "harga": harga,
        "id_kategori": idKategori,
        "barcode": barcode,
        "id_jenis": idJenis,
        "satuan": satuan,
        "stock": stock,
        "nomor_transaksi": nomorTransaksi,
        "total": total,
      };
}
