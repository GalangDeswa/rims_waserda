import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:rims_waserda/Modules/beban/data%20beban/view_beban_table.dart';

import '../../../Services/handler.dart';
import '../../Widgets/loading.dart';
import '../../Widgets/toast.dart';
import '../edit jenis beban/model_jenis_beban.dart';
import '../edit jenis beban/view_jenis_beban_table.dart';
import 'model_data_beban.dart';

class bebanController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchJenisBeban();
    fetchDataBeban();
  }

  var data = Get.arguments;

  var id_user = GetStorage().read('id_user');
  var token = GetStorage().read('token');
  var id_toko = GetStorage().read('id_toko');

  var nama = TextEditingController().obs;
  var search = TextEditingController().obs;
  var searchhariini = TextEditingController().obs;
  var kategori = TextEditingController().obs;
  var keterangan = TextEditingController().obs;
  var tanggal = TextEditingController().obs;
  var jumlah = TextEditingController().obs;

  var formKeyjenis = GlobalKey<FormState>().obs;

  List<Widget> table = [
    beban_table(),
    jenis_beban_table(),
  ];
  var formKeybeban = GlobalKey<FormState>().obs;
  RxInt selectedIndex = 0.obs;
  RxList jenisbebanlist = <DataJenisBeban>[].obs;
  RxList databebanlist = <DataBeban>[].obs;
  String? jenisbebanval;

  final dateformat = DateFormat('dd-MM-yyyy');

  stringdate() {
    var ff = dateformat.format(datedata[0]!);
    tanggal.value.text = ff;
  }

  List<DateTime?> datedata = [
    //DateTime.now(),
  ];

  deleteproduk(String id) async {
    Get.dialog(showloading(), barrierDismissible: false);
    var checkconn = await check_conn.check();
    if (checkconn == true) {
      var produk = await REST.bebanDataHapus(token, id, id_toko);
      if (produk != null) {
        print(produk);
        await fetchDataBeban();
        Get.back(closeOverlays: true);
        print('-----------batas----toasrp0-------------');
        Get.showSnackbar(toast()
            .bottom_snackbar_success('Berhasil', 'produk Berhasil dihapus'));
      } else {
        Get.back(closeOverlays: true);
        Get.showSnackbar(
            toast().bottom_snackbar_error('Error', 'gagal menghapus'));
      }
    } else {
      Get.back(closeOverlays: true);
      Get.showSnackbar(
          toast().bottom_snackbar_success('Error', 'periksa koneksi'));
    }
  }

  hapusBeban(String id) async {
    print('-------------------tambah beban---------------------');

    Get.dialog(showloading(), barrierDismissible: false);
    var checkconn = await check_conn.check();
    if (checkconn == true) {
      var beban = await REST.bebanDataHapus(token, id, id_toko);
      if (beban != null) {
        //print(beban);
        print('---------feacth data dari delete---------');

        fetchDataBeban();
        Get.back(closeOverlays: true, result: true);
        print('-----------batas----toasrp0-------------');
        Get.showSnackbar(toast()
            .bottom_snackbar_success('Berhasil', 'beban Berhasil di hapus'));
      } else {
        Get.back(closeOverlays: true);
        Get.showSnackbar(
            toast().bottom_snackbar_error('Error', ' beban Gagal di hapus'));
      }
    } else {
      Get.back(closeOverlays: true);
      Get.showSnackbar(
          toast().bottom_snackbar_error('Error', 'Periksa Koneksi Internet'));
    }
    return [];
  }

  clear() {
    nama.value.clear();
    kategori.value.clear();
    keterangan.value.clear();
    tanggal.value.clear();
    jumlah.value.clear();
  }

  fetchJenisBeban() async {
    print('-------------------fetchJenisbeban---------------------');

    var checkconn = await check_conn.check();
    if (checkconn == true) {
      var jenis = await REST.bebanKategori(token, id_toko);
      if (jenis != null) {
        print('-------------------datajenisbeban---------------');
        var dataJenis = ModelJenisBeban.fromJson(jenis);

        jenisbebanlist.value = dataJenis.data;
        jenisbebanlist.refresh();
        //update();
        print('--------------------list jenis---------------');
        print(jenisbebanlist);

        // Get.back(closeOverlays: true);

        return jenisbebanlist;
      } else {
        // Get.back(closeOverlays: true);
        Get.showSnackbar(
            toast().bottom_snackbar_error('Error', 'Gagal fecthjenisbeban'));
      }
    } else {
      //Get.back(closeOverlays: true);
      Get.showSnackbar(
          toast().bottom_snackbar_error('Error', 'Periksa koneksi'));
    }
    return [];
  }

  fetchDataBeban() async {
    print('-------------------fetch data beban---------------------');

    var checkconn = await check_conn.check();
    if (checkconn == true) {
      var beban = await REST.bebanData(token, id_toko, search.value.text);
      if (beban != null) {
        print('-------------------data beban---------------');
        var dataBeban = ModelBeban.fromJson(beban);

        databebanlist.value = dataBeban.data;
        databebanlist.refresh();
        //update();
        print('--------------------list data beban---------------');
        print(databebanlist);

        // Get.back(closeOverlays: true);

        return databebanlist;
      } else {
        // Get.back(closeOverlays: true);
        Get.showSnackbar(
            toast().bottom_snackbar_error('Error', 'Gagal fecthdatabeban'));
      }
    } else {
      //Get.back(closeOverlays: true);
      Get.showSnackbar(
          toast().bottom_snackbar_error('Error', 'Periksa koneksi'));
    }
    return [];
  }

  tambahBeban() async {
    print('-------------------tambah beban---------------------');

    Get.dialog(showloading(), barrierDismissible: false);
    var checkconn = await check_conn.check();
    if (checkconn == true) {
      var beban = await REST.bebanDataTambah(
          token,
          id_toko.toString(),
          jenisbebanval.toString(),
          id_user.toString(),
          nama.value.text,
          keterangan.value.text,
          tanggal.value.text,
          jumlah.value.text);
      if (beban != null) {
        print(beban);
        clear();
        var ui = await fetchDataBeban();
        if (ui != null) {
          Get.back(closeOverlays: true);
          Get.showSnackbar(toast()
              .bottom_snackbar_success('Berhasil', 'beban Berhasil di tambah'));
        } else {
          Get.showSnackbar(
              toast().bottom_snackbar_error('Error', ' beban Gagal di tambah'));
        }
      } else {
        Get.back(closeOverlays: true);
        Get.showSnackbar(
            toast().bottom_snackbar_error('Error', ' beban Gagal di tambah'));
      }
    } else {
      Get.back(closeOverlays: true);
      Get.showSnackbar(
          toast().bottom_snackbar_error('Error', 'Periksa Koneksi Internet'));
    }
    return [];
  }

  fetchDataBebanHariIni() async {
    print('-------------------fetch data beban---------------------');

    var checkconn = await check_conn.check();
    if (checkconn == true) {
      var beban =
          await REST.bebanDataHariIni(token, id_toko, search.value.text);
      if (beban != null) {
        print('-------------------data beban---------------');
        var dataBeban = ModelBeban.fromJson(beban);

        databebanlist.value = dataBeban.data;
        databebanlist.refresh();
        //update();
        print('--------------------list data beban---------------');
        print(databebanlist);

        // Get.back(closeOverlays: true);

        return databebanlist;
      } else {
        // Get.back(closeOverlays: true);
        Get.showSnackbar(
            toast().bottom_snackbar_error('Error', 'Gagal fecthdatabeban'));
      }
    } else {
      //Get.back(closeOverlays: true);
      Get.showSnackbar(
          toast().bottom_snackbar_error('Error', 'Periksa koneksi'));
    }
    return [];
  }

  tambahJenisBeban() async {
    print('-------------------tambah jenis beban---------------------');

    Get.dialog(showloading(), barrierDismissible: false);
    var checkconn = await check_conn.check();
    if (checkconn == true) {
      var jenis =
          await REST.bebanTambahJenis(token, id_toko, kategori.value.text);
      if (jenis != null) {
        print(jenis);
        await fetchJenisBeban();
        Get.back(closeOverlays: true, result: true);
        Get.showSnackbar(toast().bottom_snackbar_success(
            'Berhasil', 'jenis beban Berhasil diedit'));
      } else {
        Get.back(closeOverlays: true);
        Get.showSnackbar(
            toast().bottom_snackbar_error('Error', 'jenis beban Gagal diedit'));
      }
    } else {
      Get.back(closeOverlays: true);
      Get.showSnackbar(
          toast().bottom_snackbar_error('Error', 'Periksa Koneksi Internet'));
    }
    return [];
  }
}

class editjenisbebanController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    kategori.value = TextEditingController(text: data.kategori);
  }

  var data = Get.arguments;
  var id_user = GetStorage().read('id_user');
  var token = GetStorage().read('token');
  var id_toko = GetStorage().read('id_toko');
  var search = TextEditingController().obs;
  var kategori = TextEditingController().obs;

  var formKeyjenis = GlobalKey<FormState>().obs;

  editJenisBeban() async {
    print('-------------------edit jenis beban---------------------');

    Get.dialog(showloading(), barrierDismissible: false);
    var checkconn = await check_conn.check();
    if (checkconn == true) {
      var jenis = await REST.bebanEditJenis(
          token, data.id.toString(), id_toko, kategori.value.text);
      if (jenis != null) {
        print(jenis);
        Get.back(closeOverlays: true, result: true);
        Get.showSnackbar(toast().bottom_snackbar_success(
            'Berhasil', 'jenis beban Berhasil diedit'));
      } else {
        Get.back(closeOverlays: true);
        Get.showSnackbar(
            toast().bottom_snackbar_error('Error', 'jenis beban Gagal diedit'));
      }
    } else {
      Get.back(closeOverlays: true);
      Get.showSnackbar(
          toast().bottom_snackbar_error('Error', 'Periksa Koneksi Internet'));
    }
    return [];
  }

  deleteJenisBeban(String id) async {
    print('-------------------delete jenis beban---------------------');

    Get.dialog(showloading(), barrierDismissible: false);
    var checkconn = await check_conn.check();
    if (checkconn == true) {
      var jenis = await REST.bebanHapusJenis(token, id, id_toko);
      if (jenis != null) {
        print(jenis);
        Get.back(closeOverlays: true, result: true);
        Get.showSnackbar(toast().bottom_snackbar_success(
            'Berhasil', 'jenis beban Berhasil dihapus'));
      } else {
        Get.back(closeOverlays: true);
        Get.showSnackbar(toast()
            .bottom_snackbar_error('Error', 'jenis beban Gagal dihapus'));
      }
    } else {
      Get.back(closeOverlays: true);
      Get.showSnackbar(
          toast().bottom_snackbar_error('Error', 'Periksa Koneksi Internet'));
    }
    return [];
  }
}

class editbebanController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    print('-------------edit beban conn-----------');
    fetchJenisBeban();
    nama.value = TextEditingController(text: data.nama);

    keterangan.value = TextEditingController(text: data.keterangan);
    tanggal.value = TextEditingController(text: data.tgl);
    jumlah.value = TextEditingController(text: data.jumlah);
    jenisbebanval.value = data.idKtrBeban.toString();
    print(jenisbebanval);
  }

  RxList databebanlist = <DataBeban>[].obs;
  var id_user = GetStorage().read('id_user');
  var token = GetStorage().read('token');
  var id_toko = GetStorage().read('id_toko');

  var jenisbebanlist = <DataJenisBeban>[].obs;

  var data = Get.arguments;
  late RxString jenisbebanval = data.idKtrBeban.toString().obs;

  var formKeybeban = GlobalKey<FormState>().obs;
  var nama = TextEditingController().obs;
  var search = TextEditingController().obs;
  var kategori = TextEditingController().obs;
  var keterangan = TextEditingController().obs;
  var tanggal = TextEditingController().obs;
  var jumlah = TextEditingController().obs;

  final dateformat = DateFormat('dd-MM-yyyy');

  stringdate() {
    var ff = dateformat.format(datedata[0]!);
    tanggal.value.text = ff;
  }

  fetchJenisBeban() async {
    print('-------------------fetchJenisbeban---------------------');

    var checkconn = await check_conn.check();
    if (checkconn == true) {
      var jenis = await REST.bebanKategori(token, id_toko);
      if (jenis != null) {
        print('-------------------datajenisbeban---------------');
        var dataJenis = ModelJenisBeban.fromJson(jenis);

        jenisbebanlist.value = dataJenis.data;
        jenisbebanlist.refresh();
        //update();
        print('--------------------list jenis beban---------------');
        print(jenisbebanlist);

        // Get.back(closeOverlays: true);

        return jenisbebanlist;
      } else {
        // Get.back(closeOverlays: true);
        Get.showSnackbar(
            toast().bottom_snackbar_error('Error', 'Gagal fecthjenisbeban'));
      }
    } else {
      //Get.back(closeOverlays: true);
      Get.showSnackbar(
          toast().bottom_snackbar_error('Error', 'Periksa koneksi'));
    }
    return [];
  }

  editBeban() async {
    print('-------------------tambah beban---------------------');

    Get.dialog(showloading(), barrierDismissible: false);
    var checkconn = await check_conn.check();
    if (checkconn == true) {
      var beban = await REST.bebanDataEdit(
          token,
          data.id,
          id_toko,
          jenisbebanval.value,
          nama.value.text,
          keterangan.value.text,
          tanggal.value.text,
          jumlah.value.text);
      if (beban != null) {
        print(beban);
        clear();
        //kalok edit gak terupdate ui, karna beda con untuk list di table?
        //solusi : bisa pakek get.find controller yg controller.list nya ada di view
        //bisa get.put juga
        // var con = Get.put(bebanController());
        // await con.fetchDataBeban();
        await Get.find<bebanController>().fetchDataBeban();

        // Get.back(
        //   closeOverlays: true,
        // );
        Get.back(closeOverlays: true);

        Get.showSnackbar(toast()
            .bottom_snackbar_success('Berhasil', 'beban Berhasil di edit'));
      } else {
        Get.back(closeOverlays: true);
        Get.showSnackbar(
            toast().bottom_snackbar_error('Error', ' beban Gagal di edit'));
      }
    } else {
      Get.back(closeOverlays: true);
      Get.showSnackbar(
          toast().bottom_snackbar_error('Error', 'Periksa Koneksi Internet'));
    }
    return [];
  }

  clear() {
    nama.value.clear();
    kategori.value.clear();
    keterangan.value.clear();
    tanggal.value.clear();
    jumlah.value.clear();
  }

  fetchDataBeban() async {
    print(
        '-------------------fetch data beban dari edit conn---------------------');

    var checkconn = await check_conn.check();
    if (checkconn == true) {
      var beban = await REST.bebanData(token, id_toko, search.value.text);
      if (beban != null) {
        print('-------------------data beban---------------');
        var dataBeban = ModelBeban.fromJson(beban);

        databebanlist.value = dataBeban.data;
        databebanlist.refresh();
        //update();
        print('--------------------list data beban---------------');
        print(databebanlist);

        // Get.back(closeOverlays: true);

        return databebanlist;
      } else {
        // Get.back(closeOverlays: true);
        Get.showSnackbar(
            toast().bottom_snackbar_error('Error', 'Gagal fecthdatabeban'));
      }
    } else {
      //Get.back(closeOverlays: true);
      Get.showSnackbar(
          toast().bottom_snackbar_error('Error', 'Periksa koneksi'));
    }
    return [];
  }

  List<DateTime?> datedata = [
    //DateTime.now(),
  ];
}
