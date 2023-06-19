import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rims_waserda/Modules/produk/data%20produk/model_produk.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static const String databaseName = 'waserdav3.db';
  static const String tableName = 'produk';
  static const String id = 'id';
  static const String barcode = 'barcode';
  static const String idToko = 'id_toko';
  static const String idJenis = 'id_jenis';
  static const String idKategori = 'id_kategori';
  static const String idJenisStock = 'id_jenis_stock';
  static const String namaProduk = 'nama_produk';
  static const String deskripsi = 'deskripsi';
  static const String qty = 'qty';
  static const String harga = 'harga';
  static const String hargaModal = 'harga_modal';
  static const String diskonBarang = 'diskon_barang';
  static const String image = 'image';
  static const String status = 'status';

  static const String createdAt = 'created_at';
  static const String updatedAt = 'updated_at';
  static const String deletedAt = 'deleted_at';

  DatabaseHelper._privateConstructor();

  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;

  Future<Database> get database async => _database ??= await _initDatabase();

  Future<Database> _initDatabase() async {
    print(
        'create $databaseName db---------------------------------------------->');
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, databaseName);
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $tableName (
            $id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
            $barcode TEXT,
            $idToko INTEGER,
            $idJenis INTEGER,
            $idKategori INTEGER,
            $idJenisStock INTEGER,
            $namaProduk TEXT,
            $deskripsi TEXT,
            $harga INTEGER,
            $qty INTEGER,
            $hargaModal INTEGER,
            $diskonBarang INTEGER,
            $image TEXT,
            $status INTEGER,
            $createdAt TEXT,
            $updatedAt TEXT,
            $deletedAt TEXT)
          ''');
  }

  getProdukv2() async {
    var dbClient = await instance.database;
    var list = await dbClient.rawQuery('SELECT * FROM produk');
    List<DataProduk> produk =
        list.isNotEmpty ? list.map((e) => DataProduk.fromJson(e)).toList() : [];
    print(produk);
    return produk;
  }

  addProdukv2(DataProduk produk) async {
    var dbClient = await instance.database;
    var list = await dbClient.insert('produk', produk.toMapForDb());

    return list;
  }

  updateProdukv2(DataProduk produk) async {
    var dbClient = await instance.database;
    var list = await dbClient.update('produk', produk.toMapForDb(),
        where: 'id = ?', whereArgs: [produk.id]);

    return list;
  }
}

class Grocery {
  final int? id;
  final String name;

  Grocery({this.id, required this.name});

  factory Grocery.fromMap(Map<String, dynamic> json) => new Grocery(
        id: json['id'],
        name: json['name'],
      );

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
    };
  }
}
