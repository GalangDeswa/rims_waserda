import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rims_waserda/Modules/Widgets/loading.dart';
import 'package:rims_waserda/Modules/laporan/view_laporan_table_beban.dart';
import 'package:rims_waserda/Modules/laporan/view_laporan_table_penjualan.dart';
import 'package:rims_waserda/Modules/laporan/view_laporan_table_reversal.dart';
import 'package:rims_waserda/Modules/laporan/view_laporan_table_umum.dart';

import '../../Services/handler.dart';
import '../Widgets/toast.dart';
import '../beban/data beban/controller_beban.dart';
import '../history/Controller_history.dart';
import '../history/controller_detail_penjualan.dart';
import '../pelanggan/data pelanggan/controller_data_pelanggan.dart';
import '../pelanggan/hutang/controller_hutang.dart';
import '../produk/data produk/controller_data_produk.dart';

class laporanController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    // laporanumum();
    //createFileOfPdfUrl();
  }

  List<Widget> table = [
    laporan_table_umum(),
    laporan_table_penjualan(),
    laporan_table_beban(),
    laporan_table_reversal()
  ];

  var pickdate = TextEditingController().obs;

  var selectedIndex = 0.obs;

  var selectedTabs = false.obs;

  List<DateTime?> dates = [];
  final dateformat = DateFormat('dd-MM-yyyy');
  var date1;
  var date2;
  var isGranted = false.obs;
  var itemval;
  var id_user = GetStorage().read('id_user');
  var token = GetStorage().read('token');
  var id_toko = GetStorage().read('id_toko');

  var path_umum = ''.obs;
  File? pdffile_umum;

  var path_penjualan = ''.obs;
  File? pdffile_penjualan;

  var path_beban = ''.obs;
  File? pdffile_beban;

  var path_reversal = ''.obs;
  File? pdffile_reversal;

  var points = 0.0.obs;

  syncAll(id_toko) async {
    try {
      print("id toko---------------------------->");
      print(id_toko);

      print("sync produk jenis---------------------------->");
      await produkController().syncProdukJenis(id_toko);
      points.value = 0.1;

      print("sync produk---------------------------->");
      await produkController().syncProduk(id_toko);
      points.value = 0.2;
      print("sync beban jenis--------------------------->");
      await bebanController().syncBebanKategori(id_toko);
      points.value = 0.3;
      print("sync beban---------------------------->");
      await bebanController().syncBeban(id_toko);
      points.value = 0.4;
      print("sync pelanggan---------------------------->");
      await pelangganController().syncPelanggan(id_toko);
      points.value = 0.5;
      print("sync hutang---------------------------->");
      await hutangController().syncHutang(id_toko);
      points.value = 0.6;
      print("sync hutang detail---------------------------->");
      await hutangController().syncHutangDetail(id_toko);
      points.value = 0.7;
      print("sync penjualan---------------------------->");
      await historyController().syncPenjualan(id_toko);
      points.value = 0.8;
      print("sync penjualan detail---------------------------->");
      await detailpenjualanController().syncPenjualanDetail(id_toko);
      points.value = 0.9;
    } catch (e) {
      print(e);
      Get.showSnackbar(toast().bottom_snackbar_error('error', 'error sync'));
    }
  }

  laporanUmum() async {
    path_umum.value = '';
    print('-------------------fetch laporan umum---------------------');
    Get.dialog(showloading(), barrierDismissible: false);
    var checkconn = await check_conn.check();
    if (checkconn == true) {
      await syncAll(id_toko);
      var laporan = await REST.laporanUmum(token, id_toko, date1, date2);
      if (laporan != null) {
        String filename = 'Laporan umum tanggal ' + date1 + ' s-d ' + date2;

        Directory? tempDir = await getExternalStorageDirectory();
        String tempPath = tempDir!.path;
        pdffile_umum = File('$tempPath/$filename.pdf');
        print('$tempPath/$filename');
        await pdffile_umum!.writeAsBytes(laporan.bodyBytes);
        path_umum.value = pdffile_umum!.path;
        points.value = 1.0;
        Get.back(closeOverlays: true);
        return pdffile_umum;
      } else {
        Get.back(closeOverlays: true);
        Get.showSnackbar(
            toast().bottom_snackbar_error('Error', 'Gagal fecth laporan'));
      }
    } else {
      Get.back(closeOverlays: true);
      Get.showSnackbar(
          toast().bottom_snackbar_error('Error', 'Periksa koneksi'));
    }
    return [];
  }

  laporanPenjualan() async {
    path_penjualan.value = '';
    print('-------------------fetch laporan umum---------------------');
    Get.dialog(showloading(), barrierDismissible: false);
    var checkconn = await check_conn.check();
    if (checkconn == true) {
      await syncAll(id_toko);
      var laporan = await REST.laporanPenjualan(token, id_toko, date1, date2);
      if (laporan != null) {
        String filename =
            'Laporan penjualan tanggal ' + date1 + ' s-d ' + date2;

        Directory? tempDir = await getExternalStorageDirectory();
        String tempPath = tempDir!.path;
        pdffile_penjualan = File('$tempPath/$filename.pdf');
        print('$tempPath/$filename');
        await pdffile_penjualan!.writeAsBytes(laporan.bodyBytes);
        path_penjualan.value = pdffile_penjualan!.path;
        points.value = 1.0;
        Get.back(closeOverlays: true);
        return pdffile_penjualan;
      } else {
        Get.back(closeOverlays: true);
        Get.showSnackbar(
            toast().bottom_snackbar_error('Error', 'Gagal fecth laporan'));
      }
    } else {
      Get.back(closeOverlays: true);
      Get.showSnackbar(
          toast().bottom_snackbar_error('Error', 'Periksa koneksi'));
    }
    return [];
  }

  laporanBeban() async {
    path_beban.value = '';
    print('-------------------fetch laporan beban---------------------');
    Get.dialog(showloading(), barrierDismissible: false);
    var checkconn = await check_conn.check();
    if (checkconn == true) {
      await syncAll(id_toko);
      var laporan = await REST.laporanBeban(token, id_toko, date1, date2);
      if (laporan != null) {
        String filename = 'Laporan beban tanggal ' + date1 + ' s-d ' + date2;

        Directory? tempDir = await getExternalStorageDirectory();
        String tempPath = tempDir!.path;
        pdffile_beban = File('$tempPath/$filename.pdf');
        print('$tempPath/$filename');
        await pdffile_beban!.writeAsBytes(laporan.bodyBytes);
        path_beban.value = pdffile_beban!.path;
        points.value = 1.0;
        Get.back(closeOverlays: true);
        return pdffile_beban;
      } else {
        Get.back(closeOverlays: true);
        Get.showSnackbar(
            toast().bottom_snackbar_error('Error', 'Gagal fecth laporan'));
      }
    } else {
      Get.back(closeOverlays: true);
      Get.showSnackbar(
          toast().bottom_snackbar_error('Error', 'Periksa koneksi'));
    }
    return [];
  }

  laporanReversal() async {
    path_reversal.value = '';
    print('-------------------fetch laporan reversal---------------------');
    Get.dialog(showloading(), barrierDismissible: false);
    var checkconn = await check_conn.check();
    if (checkconn == true) {
      await syncAll(id_toko);
      var laporan = await REST.laporanReversal(token, id_toko, date1, date2);
      if (laporan != null) {
        String filename = 'Laporan reversal tanggal ' + date1 + ' s-d ' + date2;

        Directory? tempDir = await getExternalStorageDirectory();
        String tempPath = tempDir!.path;
        pdffile_reversal = File('$tempPath/$filename.pdf');
        print('$tempPath/$filename');
        await pdffile_reversal!.writeAsBytes(laporan.bodyBytes);
        path_reversal.value = pdffile_reversal!.path;
        points.value = 1.0;
        Get.back(closeOverlays: true);
        return pdffile_reversal;
      } else {
        Get.back(closeOverlays: true);
        Get.showSnackbar(
            toast().bottom_snackbar_error('Error', 'Gagal fecth laporan'));
      }
    } else {
      Get.back(closeOverlays: true);
      Get.showSnackbar(
          toast().bottom_snackbar_error('Error', 'Periksa koneksi'));
    }
    return [];
  }

  Future askPermission() async {
    return await [
      Permission.photos,
      Permission.videos,
      Permission.audio,
      //Permission.manageExternalStorage,
      //Permission.accessMediaLocation,
    ].request().then((permission) async {
      print(
          'permisison----------------------------------------------------------');
      print(permission);
      if (permission.containsValue(PermissionStatus.denied) ||
          permission.containsValue(PermissionStatus.permanentlyDenied)) {
        isGranted(false);
        await [
          Permission.photos,
          Permission.videos,
          Permission.audio,
          //Permission.manageExternalStorage,
          // Permission.accessMediaLocation,
          // Permission.locationAlways,
        ].request();
      } else {
        isGranted(true);
      }
    });
  }
}
