import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:rims_waserda/Modules/kasir/controller_kasir.dart';
import 'package:rims_waserda/Modules/pelanggan/data%20pelanggan/view_data_pelanggan_table.dart';
import 'package:rims_waserda/Modules/pelanggan/hutang/view_hutang_table.dart';

import '../../../Services/handler.dart';
import '../../../Templates/setting.dart';
import '../../../db_helper.dart';
import '../../Widgets/loading.dart';
import '../../Widgets/toast.dart';
import '../../dashboard/controller_dashboard.dart';
import '../hutang/controller_hutang.dart';
import 'model_data_pelanggan.dart';

class pelangganController extends GetxController {
  @override
  Future<void> onInit() async {
    // TODO: implement onInit
    super.onInit();
    await fetchDataPelangganlocal(id_toko);
    await fetchstatusPelangganlocal(id_toko);
  }

  List<Widget> table = [
    pelanggan_table(),
    hutang_table(),
  ];

  var selectedIndex = 0.obs;

  var formKeypelanggan = GlobalKey<FormState>().obs;
  var id_user = GetStorage().read('id_user');
  var token = GetStorage().read('token');
  var id_toko = GetStorage().read('id_toko');

  var search = TextEditingController().obs;
  var nama_pelanggan = TextEditingController().obs;
  var no_hp = TextEditingController().obs;

  var totalpage = 0.obs;
  var totaldata = 0.obs;
  var currentpage = 0.obs;
  var nextpage;
  var count = 0.obs;

  var nextdata;
  var previouspage;
  var perpage = 0.obs;

  var list_pelanggan = <DataPelanggan>[].obs;

  next() async {
    final respon = await http.post(Uri.parse(nextdata), body: {
      'token': token,
      'id_toko': id_toko,
    });
    final datav2 = json.decode(respon.body);
    var dataBeban = ModelPelanggan.fromJson(datav2);
    final data = json.decode(respon.body)['meta'];
    list_pelanggan.value = dataBeban.data;
    previouspage = data['pagination']['links']['previous'];
    nextdata = data['pagination']['links']['next'];
    currentpage.value = data['pagination']['current_page'];
    count.value = data['pagination']['count'];
    totaldata.value = data['pagination']['total'];
    perpage.value = data['pagination']['per_page'];
    print(nextdata);
    print(data);

    //return produk_list;
  }

  back() async {
    final respon = await http.post(Uri.parse(previouspage), body: {
      'token': token,
      'id_toko': id_toko,
    });
    final datav2 = json.decode(respon.body);
    var dataBeban = ModelPelanggan.fromJson(datav2);
    final data = json.decode(respon.body)['meta'];
    list_pelanggan.value = dataBeban.data;

    previouspage = data['pagination']['links']['previous'];
    nextdata = data['pagination']['links']['next'];
    count.value = data['pagination']['count'];
    totaldata.value = data['pagination']['total'];
    currentpage.value = data['pagination']['current_page'];
    perpage.value = data['pagination']['per_page'];
    print(previouspage);

    //return produk_list;
  }

  var list_pelanggan_local = <DataPelanggan>[].obs;
  var succ = true.obs;

  Map<String, dynamic> synclocal(data) {
    var map = <String, dynamic>{};

    map['sync'] = data;

    return map;
  }

  syncPelanggan(id_toko) async {
    print('-----------------SYNC PELANGGAN LOCAL TO HOST-------------------');

    //Get.dialog(showloading(), barrierDismissible: false);
    var checkconn = await check_conn.check();
    if (checkconn == true) {
      List<DataPelanggan> pelanggan = await fetchDataPelanggansync(id_toko);
      // list_pelanggan_local.refresh();
      print(
          'start up DB SYNC PELANGGAN--------------------------------------->');
      var query = pelanggan.where((x) => x.sync == 'N').toList();
      if (query.isEmpty) {
        print(query.toString() +
            '----------------------------------------------->');
        print(' all data sync -------------------------------->');
      } else {
        var p = await Future.forEach(query, (e) async {
          await REST.syncpelanggan(token, e.idLocal, e.idToko.toString(),
              e.namaPelanggan, e.noHp, e.aktif);
          print("PELANGGAN UP ----->   " +
              e.namaPelanggan.toString() +
              "------------------------------------------>");

          await DBHelper()
              .UPDATE(table: 'pelanggan_local', data: synclocal('Y'), id: e.id);
        });

        // Get.showSnackbar(
        //     toast().bottom_snackbar_success('Sukses', 'Produk  up DB'));
      }

      //Get.back(closeOverlays: true);

      // return [];
    } else {
      Get.back(closeOverlays: true);
      Get.showSnackbar(
          toast().bottom_snackbar_error('Error', 'Periksa Koneksi Internet'));
    }
  }

  initPelangganToLocal(id_toko) async {
    List<DataPelanggan> pelanggan_local = await fetchDataPelanggan();
    //List<DataDetailPenjualan> beban_detail_local = await fetchJenisBeban();

    print('-------------------init pelanggan local---------------------');
    //Get.dialog(showloading(), barrierDismissible: false);
    await Future.forEach(pelanggan_local, (e) async {
      await DBHelper().INSERT(
          'pelanggan_local',
          DataPelanggan(
                  idLocal: e.idLocal,
                  id: e.id,
                  idToko: e.idToko,
                  namaPelanggan: e.namaPelanggan,
                  noHp: e.noHp,
                  sync: 'Y',
                  aktif: e.aktif)
              .toMapForDb());
    });

    // await Future.forEach(beban_kategori_local, (e) async {
    //   await DBHelper().INSERT(
    //       'beban_kategori_local',
    //       DataJenisBeban(id: e.id, idToko: e.idToko, kategori: e.kategori)
    //           .toMapForDb());
    // });

    // if (up != null) {
    //  print(up.toString());
    print('init success---------------------------------------------------->');
    await fetchDataPelangganlocal(id_toko);
    //await fetchJenisBebanlocal(id_toko);
    // Get.back(closeOverlays: true);
    //Get.showSnackbar(toast()
    //  .bottom_snackbar_success('Sukses', 'Produk berhasil ditambah'));
    // } else {
    //   // Get.back(closeOverlays: true);
    //   Get.showSnackbar(
    //       toast().bottom_snackbar_error('error', 'gagal tambah data local'));
    // }

    // if (add == 1) {
    //
    // } else {
    //   Get.back(closeOverlays: true);
    //   Get.showSnackbar(
    //       toast().bottom_snackbar_error('error', 'gagal tambah data local'));
    // }
  }

  fetchDataPelanggansync(id_toko) async {
    print('-------------------fetch pelanggan sync---------------------');
    //succ.value = false;
    List<Map<String, Object?>> query = await DBHelper().FETCH(
        'SELECT * FROM pelanggan_local WHERE id_toko = $id_toko ORDER BY ID DESC');
    List<DataPelanggan> pelanggan = query.isNotEmpty
        ? query.map((e) => DataPelanggan.fromJson(e)).toList()
        : [];
    list_pelanggan_local.value = pelanggan;
    // print('fect produk local --->' + produk.toList().toString());
    //succ.value = true;
    return pelanggan;
  }

  fetchDataPelangganlocal(id_toko) async {
    print('-------------------fetch pelanggan local---------------------');
    succ.value = false;
    List<Map<String, Object?>> query = await DBHelper().FETCH(
        'SELECT * FROM pelanggan_local WHERE id_toko = $id_toko AND aktif = "Y" ORDER BY ID DESC');
    List<DataPelanggan> pelanggan = query.isNotEmpty
        ? query.map((e) => DataPelanggan.fromJson(e)).toList()
        : [];
    list_pelanggan_local.value = pelanggan;
    // print('fect produk local --->' + produk.toList().toString());
    succ.value = true;
    return pelanggan;
  }

  var list_pelanggan_local_status = <DataPelanggan>[].obs;

  fetchstatusPelangganlocal(id_toko) async {
    print('-------------------fetch pelanggan local---------------------');
    //succ.value = false;
    List<Map<String, Object?>> query = await DBHelper().FETCH(
        'SELECT pelanggan_local.*,penjualan_local.status FROM pelanggan_local LEFT JOIN penjualan_local ON pelanggan_local.id_Local = penjualan_local.id_pelanggan WHERE pelanggan_local.id_toko = $id_toko AND pelanggan_local.aktif = "Y" ORDER BY ID DESC');
    List<DataPelanggan> pelanggan = query.isNotEmpty
        ? query.map((e) => DataPelanggan.fromJson(e)).toList()
        : [];
    list_pelanggan_local_status.value = pelanggan;
    // print('fect produk local --->' + produk.toList().toString());
    //succ.value = true;
    return pelanggan;
  }

  searchpelangganlocal() async {
    List<Map<String, Object?>> query = await DBHelper().FETCH(
        'SELECT * FROM pelanggan_local WHERE id_toko = $id_toko AND aktif = "Y" AND nama_pelanggan LIKE "%${search.value.text}%" ORDER BY ID DESC');
    List<DataPelanggan> pelanggan = query.isNotEmpty
        ? query.map((e) => DataPelanggan.fromJson(e)).toList()
        : [];
    list_pelanggan_local.value = pelanggan;
    // print('fect produk local --->' + produk.toList().toString());

    return pelanggan;
  }

  statuspelanggan(id) {
    // var id_pelanggan = list_pelanggan_local.map((e) => e.id).toList();
    // var status =
    //     list_pelanggan_local_status.where((e) => e.id == id_pelanggan).toList();
    //
    // var ss = status.map((e) => e.status).toList();

    // var xxx = list_pelanggan_local_status
    //     .map((e) => e)
    //     .toList()
    //     .where((element) => element.id == id)
    //     .toList()
    //     .map((x) => x.status)
    //     .toList()
    //     .contains(3);

    var xxx = list_pelanggan_local_status
        .map((x) => x)
        .toList()
        .where((element) => element.id == id)
        .map((e) => e.status)
        .contains(3);

    print(xxx);

    if (xxx == true) {
      return Container(
          padding: EdgeInsets.all(6),
          decoration: BoxDecoration(
              color: color_template().select,
              borderRadius: BorderRadius.circular(10)),
          child: Text(
            "Hutang",
            style: font().reguler_white,
          ));
    } else {
      return Container(
          padding: EdgeInsets.all(6),
          decoration: BoxDecoration(
              color: Colors.green, borderRadius: BorderRadius.circular(10)),
          child: Text(
            "Selesai",
            style: font().reguler_white,
          ));
    }
  }

  statuspelangganhapus(id) {
    // var id_pelanggan = list_pelanggan_local.map((e) => e.id).toList();
    // var status =
    //     list_pelanggan_local_status.where((e) => e.id == id_pelanggan).toList();
    //
    // var ss = status.map((e) => e.status).toList();

    // var xxx = list_pelanggan_local_status
    //     .map((e) => e)
    //     .toList()
    //     .where((element) => element.id == id)
    //     .toList()
    //     .map((x) => x.status)
    //     .toList()
    //     .contains(3);

    var xxx = list_pelanggan_local_status
        .map((x) => x)
        .toList()
        .where((element) => element.id == id)
        .map((e) => e.status)
        .contains(3);

    print(xxx);

    if (xxx == true) {
      return true;
    } else {
      return false;
    }
  }

  //TODO : chek status hutang

  fetchDataPelanggan() async {
    print('-------------------fetch data beban---------------------');

    var checkconn = await check_conn.check();
    if (checkconn == true) {
      var pelanggan = await REST.pelangganData(token, id_toko);
      if (pelanggan != null) {
        print('-------------------data beban---------------');
        var dataPelanggan = ModelPelanggan.fromJson(pelanggan);

        list_pelanggan.value = dataPelanggan.data;

        print('--------------------list data beban---------------');
        print(list_pelanggan);

        // Get.back(closeOverlays: true);

        return list_pelanggan;
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

  clear() {
    nama_pelanggan.value.clear();
    no_hp.value.clear();
  }

  String stringGenerator(int len) {
    var random = Random.secure();
    var values = List<int>.generate(len, (i) => random.nextInt(255));

    var uniqueId = base64UrlEncode(values);
    print(uniqueId);
    return uniqueId;
  }

  tambahPelangganlocal() async {
    print('-------------------tambah pelanggan local---------------------');

    Get.dialog(const showloading(), barrierDismissible: false);

    var query = await DBHelper().INSERT(
        'pelanggan_local',
        DataPelanggan(
                idLocal: stringGenerator(10),
                idToko: int.parse(id_toko),
                namaPelanggan: nama_pelanggan.value.text,
                noHp: no_hp.value.text,
                sync: 'N',
                aktif: 'Y')
            .toMapForDb());

    if (query != null) {
      print(query);
      await fetchDataPelangganlocal(id_toko);
      await Get.find<kasirController>().fetchDataPelangganlocal(id_toko);
      await Get.find<hutangController>().fetchDataHutanglocal(id_toko);
      await Get.find<dashboardController>().loadpelanggantotal();
      nama_pelanggan.value.clear();
      no_hp.value.clear();
      Get.back(closeOverlays: true);
      Get.showSnackbar(toast()
          .bottom_snackbar_success('Sukses', 'Pelanggan berhasil ditambah'));
    } else {
      Get.back(closeOverlays: true);
      Get.showSnackbar(
          toast().bottom_snackbar_error('error', 'gagal tambah data local'));
    }

    // if (add == 1) {
    //
    // } else {
    //   Get.back(closeOverlays: true);
    //   Get.showSnackbar(
    //       toast().bottom_snackbar_error('error', 'gagal tambah data local'));
    // }
  }

  tambahPelanggan() async {
    print('-------------------tambah pelanggan---------------------');

    Get.dialog(showloading(), barrierDismissible: false);
    var checkconn = await check_conn.check();
    if (checkconn == true) {
      var pelanggan = await REST.pelangganTambah(
          token, id_toko, nama_pelanggan.value.text, no_hp.value.text);
      if (pelanggan != null) {
        print(pelanggan);
        var ui = await fetchDataPelanggan();
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

  hapuspelangganlocal(String id_local) async {
    print('delete pelanggan local---------------------------------------->');
    Get.dialog(const showloading(), barrierDismissible: false);
    var select = list_pelanggan_local.where((x) => x.idLocal == id_local).first;
    var delete = await DBHelper().UPDATE(
      id: select.idLocal,
      table: 'pelanggan_local',
      data: DataPelanggan(
              id: select.id,
              idLocal: select.idLocal,
              idToko: select.idToko,
              namaPelanggan: select.namaPelanggan,
              noHp: select.noHp,
              sync: 'N',
              aktif: 'N')
          .toMapForDb(),
    );

    // var query = await DBHelper().DELETE('produk_local', id);
    if (delete == 1) {
      await fetchDataPelangganlocal(id_toko);
      await Get.find<kasirController>().fetchDataPelangganlocal(id_toko);
      await Get.find<hutangController>().fetchDataHutanglocal(id_toko);
      await Get.find<dashboardController>().loadpelanggantotal();
      Get.back(closeOverlays: true);
      Get.showSnackbar(
          toast().bottom_snackbar_success('Sukses', 'Produk berhasil dihapus'));
      print('deleted ' + id_local.toString());
    } else {
      Get.back(closeOverlays: true);
      Get.showSnackbar(
          toast().bottom_snackbar_error('Error', 'gagal menghapus produk'));
    }
  }

  hapusPelanggan(String id) async {
    print('-------------------tambah beban---------------------');

    Get.dialog(showloading(), barrierDismissible: false);
    var checkconn = await check_conn.check();
    if (checkconn == true) {
      var hapus = await REST.pelangganHapus(token, id_toko, id);
      if (hapus != null) {
        //print(beban);
        print('---------feacth data dari delete---------');

        await fetchDataPelanggan();
        Get.back(closeOverlays: true, result: true);
        print('-----------batas----toasrp0-------------');
        Get.showSnackbar(toast().bottom_snackbar_success(
            'Berhasil', 'Pelanggan Berhasil di hapus'));
      } else {
        Get.back(closeOverlays: true);
        Get.showSnackbar(
            toast().bottom_snackbar_error('Error', 'Pelanggan Gagal di hapus'));
      }
    } else {
      Get.back(closeOverlays: true);
      Get.showSnackbar(
          toast().bottom_snackbar_error('Error', 'Periksa Koneksi Internet'));
    }
    return [];
  }
}
