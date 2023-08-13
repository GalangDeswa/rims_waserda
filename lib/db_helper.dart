import 'dart:async';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rims_waserda/Modules/Widgets/toast.dart';
import 'package:rims_waserda/Modules/produk/data%20produk/model_produk.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  static Database? _db;

  Future<Database?> get db async {
    if (_db != null) {
      await GetStorage().write('db_local', 'exist');
      print(
          'DB is ready---------------------------------------------------------->');
      return _db;
    }
    print(
        'DB is not ready, init DB---------------------------------------------------------------->');
    await GetStorage().write('db_local', 'new');
    _db = await initDb();
    return _db;
  }

  initDb() async {
    print('init DB -------------------------------------------------------->');
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "waserda.db");
    bool dbExists = await File(path).exists();

    if (!dbExists) {
      // Copy from asset
      print('DB doesnt exits, copying DB----------------------------------->');
      ByteData data =
          await rootBundle.load(join("assets/database", "waserda.db"));
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      // Write and flush the bytes written
      //  await GetStorage().write('db_local', 'new');
      await File(path).writeAsBytes(bytes, flush: true);
    }
    print('DB exits, opening DB----------------------------------->');
    //  await GetStorage().write('db_local', 'exist');
    var theDb = await openDatabase(path, version: 1);
    return theDb;
  }

  getProduk() async {
    var dbClient = await db;
    var list =
        await dbClient!.rawQuery('SELECT * FROM view_produk ORDER BY ID DESC');
    List<DataProduk> produk =
        list.isNotEmpty ? list.map((e) => DataProduk.fromJson(e)).toList() : [];
    print(produk);
    return produk;
  }

  getProdukv2() async {
    var dbClient = await db;
    var list = await dbClient!.rawQuery('SELECT * FROM produk');
    List<DataProduk> produk =
        list.isNotEmpty ? list.map((e) => DataProduk.fromJson(e)).toList() : [];
    print(produk);
    return produk;
  }

  addProduk(DataProduk produk) async {
    var dbClient = await db;
    var list = await dbClient!.insert('produk', produk.toMapForDb());

    return list;
  }

  updateProduk(DataProduk produk) async {
    var dbClient = await db;
    var list = await dbClient!.update('produk', produk.toMapForDb(),
        where: 'id = ?', whereArgs: [produk.id]);

    return list;
  }

  deleteProduk(int id) async {
    var dbClient = await db;
    var list =
        await dbClient!.delete('produk', where: 'id = ?', whereArgs: [id]);
    return list;
  }

//-------------------------------------------------------------------------------------------

  FETCH(String query) async {
    try {
      var dbClient = await db;
      var queryDB = await dbClient!.rawQuery(query);
      return queryDB;
    } catch (e) {
      Get.back(closeOverlays: true);
      Get.showSnackbar(toast().bottom_snackbar_error('Error', e.toString()));
    }
  }

  INSERT(String table, dynamic data) async {
    try {
      var dbClient = await db;
      var query = await dbClient!.insert(table, data);
      return query;
    } catch (e) {
      Get.back(closeOverlays: true);
      Get.showSnackbar(toast().bottom_snackbar_error('Error', e.toString()));
    }
  }

  UPDATE(
      {required String table,
      required dynamic data,
      required dynamic id}) async {
    try {
      var dbClient = await db;
      var query = await dbClient!
          .update(table, data, where: 'id_local = ?', whereArgs: [id]);
      return query;
    } catch (e) {
      print('---------------------------errorr-----------');
      print(e);
      Get.back(closeOverlays: true);
      Get.showSnackbar(toast().bottom_snackbar_error('Error', e.toString()));
    }
  }

  DELETE(String table, int id) async {
    try {
      var dbClient = await db;
      var query =
          await dbClient!.delete(table, where: 'id_local = ?', whereArgs: [id]);
      return query;
    } catch (e) {
      Get.back(closeOverlays: true);
      Get.showSnackbar(toast().bottom_snackbar_error('Error', e.toString()));
    }
  }

  DELETEMEJA(String table, int id) async {
    try {
      var dbClient = await db;
      var query =
          await dbClient!.delete(table, where: 'id= ?', whereArgs: [id]);
      return query;
    } catch (e) {
      Get.back(closeOverlays: true);
      Get.showSnackbar(toast().bottom_snackbar_error('Error', e.toString()));
    }
  }

  DELETEALL(String table) async {
    try {
      var dbClient = await db;
      var query = await dbClient!.delete(table);
      return query;
    } catch (e) {
      Get.back(closeOverlays: true);
      Get.showSnackbar(toast().bottom_snackbar_error('Error', e.toString()));
    }
  }
}
