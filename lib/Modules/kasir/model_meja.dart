// To parse this JSON data, do
//
//     final ModelMeja = ModelMejaFromJson(jsonString);

import 'dart:convert';

ModelMeja ModelMejaFromJson(String str) => ModelMeja.fromJson(json.decode(str));

// String ModelMejaToJson(ModelMeja data) => json.encode(data.toJson());

class ModelMeja {
  ModelMeja({
    required this.success,
    required this.statusCode,
    required this.messages,
    required this.data,
  });

  bool success;
  int statusCode;
  String messages;
  List<DataMeja> data;

  double get subtotal {
    return data.fold(0, (total, item) => total + (item.harga! * item.qty!));
  }

  double get total {
    return subtotal + (subtotal * 0.1); // add 10% tax
  }

  factory ModelMeja.fromJson(Map<String, dynamic> json) => ModelMeja(
        success: json["success"],
        statusCode: json["status_code"],
        messages: json["messages"],
        data:
            List<DataMeja>.from(json["data"].map((x) => DataMeja.fromJson(x))),
      );

// Map<String, dynamic> toJson() => {
//       "success": success,
//       "status_code": statusCode,
//       "messages": messages,
//       "data": List<dynamic>.from(data.map((x) => x.toJson())),
//     };
}

class DataMeja {
  DataMeja(
      {this.id,
      this.meja,
      this.namaProduk,
      this.qty,
      this.harga,
      this.total,
      this.subtotal,
      this.diskonBrg,
      this.idMeja,
      this.idProduk,
      this.idProdukLocal,
      this.idJenisStock,
      this.idKategori,
      this.hargaModal,
      this.diskonKasir,
      this.ppn});

  int? id;
  String? namaProduk;
  String? meja;
  int? qty;
  int? harga;
  int? diskonBrg;
  int? total;
  int? subtotal;
  int? idMeja;
  int? idProduk;
  String? idProdukLocal;
  int? idJenisStock;
  int? idKategori;
  int? hargaModal;
  int? diskonKasir;
  int? ppn;

  factory DataMeja.fromJson(Map<String, dynamic> json) => DataMeja(
        id: json["id"],
        namaProduk: json["nama_produk"],
        meja: json["meja"].toString(),
        qty: json["qty"],
        harga: json["harga"],
        diskonBrg: json["diskonBrg"],
        total: json["total"],
        subtotal: json["subtotal"],
        idMeja: json["id_meja"],
        idProduk: json["id_produk"],
        idProdukLocal: json["id_produk_local"],
        idJenisStock: json["id_jenis_stock"],
        idKategori: json["id_kategori"],
        hargaModal: json["harga_modal"],
        diskonKasir: json["diskon_kasir"],
        ppn: json["ppn"],

        // updated: json["updated"]!,
        // createdAt: json["created_at"]!,
        // updatedAt: json["updated_at"]!,
      );

  // Map<String, dynamic> toJson() => {
  //       "id": id,
  //       "id_produk": idProduk,
  //       "id_toko": idToko,
  //       "id_user": idUser,
  //       "id_jenis": idJenis,
  //       "nama_jenis": namaJenis,
  //       "id_kategori": idKategori,
  //       "id_jenis_stock": idJenisStock,
  //       "nama_produk": namaProduk,
  //       "deskripsi": deskripsi,
  //       "qty": qty,
  //       "harga": harga,
  //       "diskon_barang": diskonBarang,
  //       "diskon_kasir": diskonKasir,
  //       "image": image,
  //       "status": status,
  //       // "updated": updatedValues.reverse[updated],
  //       // "created_at": createdAtValues.reverse[createdAt],
  //       // "updated_at": updatedAtValues.reverse[updatedAt],
  //     };

  Map<String, dynamic> toMapForDbMEJA() {
    var map = <String, dynamic>{};

    map['id'] = id;
    map['meja'] = meja;
    map['diskon_kasir'] = diskonKasir;
    map['subtotal'] = subtotal;
    map['total'] = total;
    map['ppn'] = ppn;

    return map;
  }

  Map<String, dynamic> toMapForDbMEJAUPDATE() {
    var map = <String, dynamic>{};

    map['meja'] = meja;
    map['diskon_kasir'] = diskonKasir;
    map['subtotal'] = subtotal;
    map['total'] = total;
    map['ppn'] = ppn;

    return map;
  }

  Map<String, dynamic> toMapForDbMEJADETAIL() {
    var map = <String, dynamic>{};

    map['id'] = id;
    map['id_meja'] = idMeja;
    map['id_produk_local'] = idProduk;
    map['nama_produk'] = namaProduk;
    map['qty'] = qty;
    map['diskonBrg'] = diskonBrg;
    map['harga'] = harga;
    map['id_produk_local'] = idProdukLocal;
    map['id_jenis_stock'] = idJenisStock;
    map['id_kategori'] = idKategori;
    map['harga_modal'] = hargaModal;

    return map;
  }

  Map<String, dynamic> toMapForDbMEJADETAILUPDATE() {
    var map = <String, dynamic>{};

    map['id_meja'] = idMeja;
    map['id_produk_local'] = idProduk;
    map['nama_produk'] = namaProduk;
    map['qty'] = qty;
    map['diskonBrg'] = diskonBrg;
    map['harga'] = harga;
    map['id_produk_local'] = idProdukLocal;
    map['id_jenis_stock'] = idJenisStock;
    map['id_kategori'] = idKategori;
    map['harga_modal'] = hargaModal;

    return map;
  }
}
