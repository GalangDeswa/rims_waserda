import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:rims_waserda/Modules/beban/data%20beban/view_beban_table.dart';
import 'package:rims_waserda/Modules/dashboard/controller_dashboard.dart';

import '../../../Services/handler.dart';
import '../../../db_helper.dart';
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
    print('----------------------bebancon init--------------------');
    fetchJenisBebanlocal(id_toko);
    fetchBebanlocalhariini(id_toko);
    fetchBebanlocal(id_toko);
  }

  var format = NumberFormat.simpleCurrency(locale: 'id', decimalDigits: 0);

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
  var jumlahbeban = 0.0.obs;

  var formKeyjenisbeban = GlobalKey<FormState>().obs;
  var sort = false.obs;
  var ColIndex = 0.obs;

  clear() {
    nama.value.clear();
    kategori.value.clear();
    keterangan.value.clear();
    tanggal.value.clear();
    datedata.clear();
    jumlah.value.clear();
    jumlahbeban.value = 0;
    jenisbebanval = null;
  }

  next() async {
    final respon = await http.post(Uri.parse(nextdata), body: {
      'token': token,
      'id_toko': id_toko,
      'search': search.value.text,
    });
    final datav2 = json.decode(respon.body);
    var dataBeban = ModelBeban.fromJson(datav2);
    final data = json.decode(respon.body)['meta'];
    databebanlist.value = dataBeban.data;
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
      'search': search.value.text,
    });
    final datav2 = json.decode(respon.body);
    var dataBeban = ModelBeban.fromJson(datav2);
    final data = json.decode(respon.body)['meta'];
    databebanlist.value = dataBeban.data;

    previouspage = data['pagination']['links']['previous'];
    nextdata = data['pagination']['links']['next'];
    count.value = data['pagination']['count'];
    totaldata.value = data['pagination']['total'];
    currentpage.value = data['pagination']['current_page'];
    perpage.value = data['pagination']['per_page'];
    print(previouspage);

    //return produk_list;
  }

  var totalpage = 0.obs;
  var totaldata = 0.obs;
  var currentpage = 0.obs;
  var nextpage;
  var count = 0.obs;

  var nextdata;
  var previouspage;
  var perpage = 0.obs;

  var totalpagejenis = 0.obs;
  var totaldatajenis = 0.obs;
  var currentpagejenis = 0.obs;
  var nextpagejeis;
  var countjenis = 0.obs;

  var nextdatajenis;
  var previouspagejenis;
  var perpagejenis = 0.obs;

  nextjenis() async {
    final respon = await http.post(Uri.parse(nextdatajenis), body: {
      'token': token,
      'id_toko': id_toko,
      'search': search.value.text,
    });
    final datav2 = json.decode(respon.body);
    var dataJenis = ModelJenisBeban.fromJson(datav2);
    final data = json.decode(respon.body)['meta'];
    jenisbebanlist.value = dataJenis.data;
    previouspagejenis = data['pagination']['links']['previous'];
    nextdatajenis = data['pagination']['links']['next'];
    currentpagejenis.value = data['pagination']['current_page'];
    countjenis.value = data['pagination']['count'];
    totaldatajenis.value = data['pagination']['total'];
    perpagejenis.value = data['pagination']['per_page'];
    print(nextdatajenis);
    print(data);

    //return produk_list;
  }

  backjenis() async {
    final respon = await http.post(Uri.parse(previouspagejenis), body: {
      'token': token,
      'id_toko': id_toko,
      'search': search.value.text,
    });
    final datav2 = json.decode(respon.body);
    var dataJenis = ModelJenisBeban.fromJson(datav2);
    final data = json.decode(respon.body)['meta'];
    jenisbebanlist.value = dataJenis.data;

    previouspagejenis = data['pagination']['links']['previous'];
    nextdatajenis = data['pagination']['links']['next'];
    countjenis.value = data['pagination']['count'];
    totaldatajenis.value = data['pagination']['total'];
    currentpagejenis.value = data['pagination']['current_page'];
    perpagejenis.value = data['pagination']['per_page'];
    print(previouspagejenis);

    //return produk_list;
  }

  List<Widget> table = [
    beban_table(),
    jenis_beban_table(),
  ];
  var formKeybeban = GlobalKey<FormState>().obs;
  RxInt selectedIndex = 0.obs;
  var jenisbebanlist = <DataJenisBeban>[].obs;
  var databebanlist = <DataBeban>[].obs;

  String? jenisbebanval;

  DateFormat dateFormat = DateFormat("dd-MM-yyyy");

  final nominal = NumberFormat("#,##0");

  final numformat = NumberFormat.currency(locale: 'id', decimalDigits: 0);

  stringdate() {
    var ff = dateFormat.format(datedata.first!);
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

  deletebebanlocal(String id_local) async {
    print('delete beban local---------------------------------------->');
    Get.dialog(const showloading(), barrierDismissible: false);
    var select = databebanlistlocal.where((x) => x.idLocal == id_local).first;
    var delete = await DBHelper().UPDATE(
      id: select.idLocal,
      table: 'beban_local',
      data: DataBeban(
              aktif: 'N',
              sync: 'N',
              id: select.id,
              idLocal: select.idLocal,
              idToko: select.idToko,
              jumlah: select.jumlah,
              tgl: select.tgl,
              keterangan: select.keterangan,
              nama: select.nama,
              idKtrBeban: select.idKtrBeban,
              idUser: select.idUser,
              namaKtrBeban: select.namaKtrBeban)
          .toMapForDb(),
    );

    // var query = await DBHelper().DELETE('produk_local', id);
    if (delete == 1) {
      await fetchBebanlocal(id_toko);
      await Get.find<dashboardController>().loadbebanhariini();
      await Get.find<dashboardController>().loadpendapatanhariini();
      await Get.find<dashboardController>().loadpendapatantotal();
      Get.back(closeOverlays: true);
      Get.showSnackbar(
          toast().bottom_snackbar_success('Sukses', 'Beban berhasil dihapus'));
      print('deleted ' + id_local.toString());
    } else {
      Get.back(closeOverlays: true);
      Get.showSnackbar(toast()
          .bottom_snackbar_error('Error', 'gagal menghapus kategori beban'));
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

  deletejenisbebanlocal(String id_local) async {
    print('delete jenis beban local---------------------------------------->');
    Get.dialog(showloading(), barrierDismissible: false);
    var select = jenisbebanlistlocal.where((x) => x.idLocal == id_local).first;
    var delete = await DBHelper().UPDATE(
      id: select.idLocal,
      table: 'beban_kategori_local',
      data: DataJenisBeban(
              aktif: 'N',
              sync: 'N',
              idToko: select.idToko,
              id: select.id,
              idLocal: select.idLocal,
              kategori: select.kategori)
          .toMapForDb(),
    );

    // var query = await DBHelper().DELETE('produk_local', id);
    if (delete == 1) {
      await fetchJenisBebanlocal(id_toko);
      Get.back(closeOverlays: true);
      Get.showSnackbar(toast().bottom_snackbar_success(
          'Sukses', 'Kategori beban berhasil dihapus'));
      print('deleted ' + id_local.toString());
    } else {
      Get.back(closeOverlays: true);
      Get.showSnackbar(toast()
          .bottom_snackbar_error('Error', 'gagal menghapus kategori beban'));
    }
  }

  deleteJenisBeban(String id) async {
    print('-------------------delete jenis beban---------------------');

    Get.dialog(showloading(), barrierDismissible: false);
    var checkconn = await check_conn.check();
    if (checkconn == true) {
      var jenis = await REST.bebanHapusJenis(token, id, id_toko);
      if (jenis != null) {
        print(jenis);
        await fetchJenisBeban();
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

  Map<String, dynamic> synclocal(data) {
    var map = <String, dynamic>{};

    map['sync'] = data;

    return map;
  }

  searchbebanlocal() async {
    List<Map<String, Object?>> query = await DBHelper().FETCH(
        'SELECT * FROM beban_local WHERE id_toko = $id_toko AND aktif = "Y" AND nama LIKE "%${search.value.text}%" ORDER BY ID DESC');
    List<DataBeban> jenis = query.isNotEmpty
        ? query.map((e) => DataBeban.fromJson(e)).toList()
        : [];
    databebanlistlocal.value = jenis;

    return jenis;
  }

  syncBeban(id_toko) async {
    print('-----------------SYNC BEBAN LOCAL TO HOST-------------------');

    //Get.dialog(showloading(), barrierDismissible: false);
    var checkconn = await check_conn.check();
    if (checkconn == true) {
      List<DataBeban> beban = await fetchBebansync(id_toko);
      // databebanlistlocal.refresh();
      print('start up DB SYNC BEBAN--------------------------------------->');
      var query = beban.where((x) => x.sync == 'N').toList();
      if (query.isEmpty) {
        print(query.toString() +
            '----------------------------------------------->');
        print(' all data sync -------------------------------->');
      } else {
        await Future.forEach(query, (e) async {
          var x = await REST.syncbeban(
            token: token,
            id: e.idLocal,
            idtoko: e.idToko.toString(),
            idkatbeban: e.idKtrBeban.toString(),
            iduser: e.idUser.toString(),
            nama: e.nama,
            keterangan: e.keterangan,
            tgl: e.tgl,
            jumlah: e.jumlah.toString(),
            aktif: e.aktif,
          );
          print('print x--------------------->');
          print(x);
          print("BEBAN UP --------->   " +
              e.nama! +
              "------------------------------------------>");

          if (x == false) {
            print('gagal sync beban x= gagal------------------------>');
            return;
          } else {
            print('beban local sync = y------------------------>');
            await DBHelper().UPDATE(
                table: 'beban_local', data: synclocal('Y'), id: e.idLocal);
          }
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

  syncBebanKategori(id_toko) async {
    print(
        '-----------------SYNC BEBAN KATEGORI LOCAL TO HOST-------------------');

    //Get.dialog(showloading(), barrierDismissible: false);
    var checkconn = await check_conn.check();
    if (checkconn == true) {
      List<DataJenisBeban> bebankategori = await fetchJenisBebansync(id_toko);
      // jenisbebanlistlocal.refresh();
      print(
          'start up DB SYNC BEBAN KATEGORI LOCAL--------------------------------------->');
      var query = bebankategori.where((x) => x.sync == 'N').toList();
      if (query.isEmpty) {
        print(query.toString() +
            '----------------------------------------------->');
        print(' all data sync -------------------------------->');
      } else {
        await Future.forEach(query, (e) async {
          var sync = await REST.syncbebanJenis(
              token, e.idLocal, e.idToko.toString(), e.kategori, e.aktif);
          print("BEBAN KATEGORI UP ------>    " +
              e.kategori! +
              "------------------------------------------>");
          if (sync != null) {
            await DBHelper().UPDATE(
                table: 'beban_kategori_local',
                data: synclocal('Y'),
                id: e.idLocal);
          }
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

  var succ = true.obs;

  initBebanToLocal(id_toko) async {
    //login -> sync -> init

    List<DataBeban> beban_local = await fetchDataBeban();
    List<DataJenisBeban> beban_kategori_local = await fetchJenisBeban();
    List<DataBeban> check_beban_local = await fetchBebansync(id_toko);
    List<DataJenisBeban> check_jenis_beban_local =
        await fetchJenisBebansync(id_toko);

    print('-------------------init beban local---------------------');
    //Get.dialog(showloading(), barrierDismissible: false);
    await Future.forEach(beban_local, (e) async {
      var x = check_beban_local
          .where((element) => element.idLocal == e.idLocal)
          .firstOrNull;
      if (x == null) {
        print('insert------------------------------>' + ' ' + e.nama!);
        await DBHelper().INSERT(
            'beban_local',
            DataBeban(
                    id: e.id,
                    idLocal: e.idLocal,
                    idToko: e.idToko,
                    idUser: e.idUser,
                    nama: e.nama,
                    keterangan: e.keterangan,
                    tgl: e.tgl,
                    jumlah: e.jumlah,
                    idKtrBeban: e.idKtrBeban,
                    namaKtrBeban: e.namaKtrBeban,
                    sync: 'Y',
                    aktif: e.aktif)
                .toMapForDb());
      } else {
        print('update--------------------------------------------->' + e.nama!);
        await DBHelper().UPDATE(
            table: 'beban_local',
            data: DataBeban(
                    idLocal: e.idLocal,
                    idToko: e.idToko,
                    idUser: e.idUser,
                    nama: e.nama,
                    keterangan: e.keterangan,
                    tgl: e.tgl,
                    jumlah: e.jumlah,
                    idKtrBeban: e.idKtrBeban,
                    namaKtrBeban: e.namaKtrBeban,
                    sync: 'Y',
                    aktif: e.aktif)
                .updateInit(),
            id: e.idLocal);
      }
    });

    await Future.forEach(beban_kategori_local, (e) async {
      var x = check_jenis_beban_local
          .where((element) => element.idLocal == e.idLocal)
          .firstOrNull;
      if (x == null) {
        print('insert ---------------------------------> ' + ' ' + e.kategori!);
        await DBHelper().INSERT(
            'beban_kategori_local',
            DataJenisBeban(
                    id: e.id,
                    aktif: e.aktif,
                    idLocal: e.idLocal,
                    idToko: e.idToko,
                    kategori: e.kategori,
                    sync: 'Y')
                .toMapForDb());
      } else {
        print('update ---------------------------------> ' + ' ' + e.kategori!);
        await DBHelper().UPDATE(
            table: 'beban_kategori_local',
            data: DataJenisBeban(
                    aktif: e.aktif,
                    idLocal: e.idLocal,
                    idToko: e.idToko,
                    kategori: e.kategori,
                    sync: 'Y')
                .updateInit(),
            id: e.idLocal);
      }
    });

    // if (up != null) {
    //  print(up.toString());
    print('init success---------------------------------------------------->');
    await fetchBebanlocal(id_toko);
    await fetchJenisBebanlocal(id_toko);
  }

  var databebanlistlocal = <DataBeban>[].obs;
  var jenisbebanlistlocal = <DataJenisBeban>[].obs;
  String? databebanlistlocalval;
  var databebanlistlocalv2 = <DataBeban>[].obs;

  var pilihbeban = '-'.obs;

  fetchBebansync(id_toko) async {
    print('-------------------fetch beban sync---------------------');
    //succ.value = false;
    List<Map<String, Object?>> query = await DBHelper().FETCH(
        'SELECT * FROM beban_local WHERE id_toko = $id_toko ORDER BY ID DESC');
    List<DataBeban> beban = query.isNotEmpty
        ? query.map((e) => DataBeban.fromJson(e)).toList()
        : [];
    databebanlistlocal.value = beban;
    // print('fect produk local --->' + produk.toList().toString());
    //succ.value = true;
    return beban;
  }

  fetchBebanlocal(id_toko) async {
    print('-------------------fetch beban local---------------------');
    succ.value = false;
    List<Map<String, Object?>> query = await DBHelper().FETCH(
        'SELECT * FROM beban_local WHERE id_toko = $id_toko AND aktif = "Y" ORDER BY ID DESC');
    List<DataBeban> beban = query.isNotEmpty
        ? query.map((e) => DataBeban.fromJson(e)).toList()
        : [];
    databebanlistlocal.value = beban;
    // print('fect produk local --->' + produk.toList().toString());
    succ.value = true;
    return beban;
  }

  fetchBebanlocalhariini(id_toko) async {
    print('-------------------fetch beban local---------------------');
    succ.value = false;
    List<Map<String, Object?>> query = await DBHelper().FETCH(
        'SELECT * FROM beban_local WHERE id_toko = $id_toko AND aktif = "Y" GROUP BY nama ORDER BY ID DESC');
    List<DataBeban> beban = query.isNotEmpty
        ? query.map((e) => DataBeban.fromJson(e)).toList()
        : [];
    databebanlistlocalv2.value = beban;
    // print('fect produk local --->' + produk.toList().toString());
    succ.value = true;
    return beban;
  }

  //TODO : chek join2 table, validasi edit di table lain

  fetchBebanlocalv2(id_toko) async {
    print('-------------------fetch beban local---------------------');
    succ.value = false;
    List<Map<String, Object?>> query = await DBHelper().FETCH(
        'SELECT beban_local.*,beban_kategori_local.kategori FROM beban_local JOIN beban_kategori_local on beban_local.id_ktr_beban = beban_kategori_local.id  WHERE beban_local.id_toko = $id_toko AND beban_local.aktif = "Y" AND beban_kategori_local.aktif = "Y" ORDER BY ID DESC');
    List<DataBeban> beban = query.isNotEmpty
        ? query.map((e) => DataBeban.fromJson(e)).toList()
        : [];
    databebanlistlocal.value = beban;
    // print('fect produk local --->' + produk.toList().toString());
    succ.value = true;
    return beban;
  }

  String stringGenerator(int len) {
    var random = Random.secure();
    var values = List<int>.generate(len, (i) => random.nextInt(255));

    var uniqueId = base64UrlEncode(values);
    print(uniqueId);
    return uniqueId;
  }

  //DateFormat dateFormat = DateFormat("dd-MM-yyyy");
  var bebanharian = <DataBeban>[].obs;

  //TODO : check beban check diskon bayar kasir kalok di check via persen

  bebanTambahlocal() async {
    print('-------------------tambah beban local---------------------');

    Get.dialog(showloading(), barrierDismissible: false);

    var query = await DBHelper().INSERT(
        'beban_local',
        DataBeban(
                idLocal: stringGenerator(10),
                aktif: 'Y',
                sync: 'N',
                idToko: int.parse(id_toko),
                idKtrBeban: jenisbebanval!,
                namaKtrBeban: jenisbebanlistlocal
                    .where((e) => e.idLocal == jenisbebanval)
                    .first
                    .kategori
                    .toString(),
                idUser: id_user,
                nama: nama.value.text,
                keterangan: keterangan.value.text,
                tgl: datedata.first!.toString(),
                jumlah: jumlahbeban.value.toInt())
            .toMapForDb());

    if (query != null) {
      print(query);
      print('id user------------>');
      print(id_user);
      await fetchBebanlocal(id_toko);
      await fetchBebanlocalhariini(id_toko);
      await Get.find<dashboardController>().loadbebanhariini();
      await Get.find<dashboardController>().loadpendapatanhariini();
      await Get.find<dashboardController>().loadpendapatantotal();
      clear();
      Get.back(closeOverlays: true);
      Get.showSnackbar(toast()
          .bottom_snackbar_success('Sukses', 'Produk berhasil ditambah'));
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

  bebanTambahlocalhariini() async {
    print(
        '-------------------tambah beban local hari ini---------------------');

    Get.dialog(showloading(), barrierDismissible: false);

    var query = await DBHelper().INSERT(
        'beban_local',
        DataBeban(
                idLocal: bebanharian.map((e) => e.idLocal).first,
                aktif: 'Y',
                sync: 'N',
                idToko: int.parse(id_toko),
                idKtrBeban: bebanharian.map((e) => e.idKtrBeban).first,
                namaKtrBeban: bebanharian.map((e) => e.namaKtrBeban).first,
                idUser: bebanharian.map((e) => e.idUser).first,
                nama: bebanharian.map((e) => e.nama).first,
                keterangan: bebanharian.map((e) => e.keterangan).first,
                tgl: datedata.first!.toString(),
                jumlah: jumlahbeban.value.toInt())
            .toMapForDb());

    if (query != null) {
      print(query);
      print('id user------------>');
      print(id_user);
      await fetchBebanlocal(id_toko);
      await fetchBebanlocalhariini(id_toko);
      await Get.find<dashboardController>().loadbebanhariini();
      await Get.find<dashboardController>().loadpendapatanhariini();
      await Get.find<dashboardController>().loadpendapatantotal();
      clear();
      pilihbeban.value = '-';
      Get.back(closeOverlays: true);
      Get.showSnackbar(toast()
          .bottom_snackbar_success('Sukses', 'Produk berhasil ditambah'));
    } else {
      Get.back(closeOverlays: true);
      Get.showSnackbar(
          toast().bottom_snackbar_error('error', 'gagal tambah data local'));
    }
  }

  fetchJenisBebansync(id_toko) async {
    print('-------------------fetch jenis beban sync---------------------');
    //succ.value = false;
    List<Map<String, Object?>> query = await DBHelper().FETCH(
        'SELECT * FROM beban_kategori_local WHERE id_toko = $id_toko ORDER BY ID DESC');
    List<DataJenisBeban> beban_kategori = query.isNotEmpty
        ? query.map((e) => DataJenisBeban.fromJson(e)).toList()
        : [];
    jenisbebanlistlocal.value = beban_kategori;
    // print('fect produk local --->' + produk.toList().toString());
    //succ.value = true;
    return beban_kategori;
  }

  fetchJenisBebanlocal(id_toko) async {
    print('-------------------fetch jenis beban local---------------------');
    succ.value = false;
    List<Map<String, Object?>> query = await DBHelper().FETCH(
        'SELECT * FROM beban_kategori_local WHERE id_toko = $id_toko AND aktif = "Y" ORDER BY ID DESC');
    List<DataJenisBeban> beban_kategori = query.isNotEmpty
        ? query.map((e) => DataJenisBeban.fromJson(e)).toList()
        : [];
    jenisbebanlistlocal.value = beban_kategori;
    // print('fect produk local --->' + produk.toList().toString());
    succ.value = true;
    return beban_kategori;
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

        jenisbebanlist.value = dataJenis.data;
        // totalpagejenis.value = dataJenis.meta.pagination.totalPages;
        // totaldatajenis.value = dataJenis.meta.pagination.total;
        // perpagejenis.value = dataJenis.meta.pagination.perPage;
        // currentpagejenis.value = jenis['meta']['pagination']['current_page'];
        // countjenis.value = dataJenis.meta.pagination.count;
        // if (totalpagejenis > 1) {
        //   nextdatajenis = jenis['meta']['pagination']['links']['next'];
        // }

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
        // totalpage.value = dataBeban.meta.pagination.totalPages;
        // totaldata.value = dataBeban.meta.pagination.total;
        // perpage.value = dataBeban.meta.pagination.perPage;
        // currentpage.value = beban['meta']['pagination']['current_page'];
        // count.value = dataBeban.meta.pagination.count;
        // if (totalpage > 1) {
        //   nextdata = beban['meta']['pagination']['links']['next'];
        // }

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
          jumlahbeban.value.toString());
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

  bebanjenisTambahlocal() async {
    print('-------------------tambah beban jenis local---------------------');

    Get.dialog(showloading(), barrierDismissible: false);

    var query = await DBHelper().INSERT(
        'beban_kategori_local',
        DataJenisBeban(
                idLocal: stringGenerator(10),
                aktif: 'Y',
                idToko: int.parse(id_toko),
                kategori: kategori.value.text,
                sync: 'N')
            .toMapForDb());

    if (query != null) {
      print(query);
      List<DataJenisBeban> jenis = await fetchJenisBebanlocal(id_toko);
      var select = jenis.where((element) => element.id == query).first;
      jenisbebanval = select.idLocal.toString();
      await fetchBebanlocal(id_toko);

      Get.back();
      Get.back();
      Get.showSnackbar(
          toast().bottom_snackbar_success('Sukses', 'kategori beban ditambah'));
    } else {
      Get.back(closeOverlays: true);
      Get.showSnackbar(toast()
          .bottom_snackbar_error('error', 'kategori beban gagal ditambah'));
    }

    // if (add == 1) {
    //
    // } else {
    //   Get.back(closeOverlays: true);
    //   Get.showSnackbar(
    //       toast().bottom_snackbar_error('error', 'gagal tambah data local'));
    // }
  }

  clearbeban() {}

  tambahJenisBeban() async {
    print('-------------------tambah jenis beban---------------------');

    Get.dialog(showloading(), barrierDismissible: false);
    var checkconn = await check_conn.check();
    if (checkconn == true) {
      var jenis =
          await REST.bebanTambahJenis(token, id_toko, kategori.value.text);
      if (jenis != null) {
        await fetchJenisBeban();
        update();
        // await Get.find<editbebanController>().fetchJenisBeban();

        Get.back();
        Get.back();
        Get.showSnackbar(toast().bottom_snackbar_success(
            'Berhasil', 'jenis beban Berhasil di tambah'));
      } else {
        Get.back(closeOverlays: true);
        Get.showSnackbar(toast()
            .bottom_snackbar_error('Error', 'jenis beban Gagal di tambah'));
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

  editJenisBebanLocal() async {
    print('-------------------edit jenis beban local---------------------');

    Get.dialog(const showloading(), barrierDismissible: false);

    var query = await DBHelper().UPDATE(
        table: 'beban_kategori_local',
        data: DataJenisBeban(
                aktif: 'Y',
                sync: 'N',
                kategori: kategori.value.text,
                idToko: int.parse(id_toko),
                id: data.id,
                idLocal: data.idLocal)
            .toMapForDb(),
        id: data.idLocal);
    print(
        'edit jenis beban local berhasil------------------------------------->');
    print(query);
    if (query == 1) {
      await Get.find<bebanController>().fetchJenisBebanlocal(id_toko);
      Get.back(closeOverlays: true);
      Get.showSnackbar(toast()
          .bottom_snackbar_success('sukses', 'Kategori beban berhasil diedit'));
    } else {
      Get.back(closeOverlays: true);
      Get.showSnackbar(
          toast().bottom_snackbar_error('error', 'gagal edit data local'));
    }

    // if (add != null) {
    //   print(add);
    //   await Get.find<produkController>().fetchProduk();
    //   Get.back();
    // }
  }

  editJenisBeban() async {
    print('-------------------edit jenis beban---------------------');

    Get.dialog(showloading(), barrierDismissible: false);
    var checkconn = await check_conn.check();
    if (checkconn == true) {
      var jenis = await REST.bebanEditJenis(
          token, data.id.toString(), id_toko, kategori.value.text);
      if (jenis != null) {
        print(jenis);
        await Get.find<bebanController>().fetchJenisBeban();
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

class editbebanController extends GetxController {
  @override
  Future<void> onInit() async {
    // TODO: implement onInit
    super.onInit();
    print('-------------edit beban conn-----------');
    fetchJenisBebanlocal(id_toko);
    nama.value = TextEditingController(text: data.nama);
    keterangan.value = TextEditingController(text: data.keterangan);
    tanggal.value = TextEditingController(
        text: dateFormatdisplay.format(DateTime.parse(data.tgl)));
    jumlah.value = TextEditingController(text: data.jumlah.toString());
    jenisbebanval.value = data.idKtrBeban.toString();
    // await chekjj();
    jumlahbeban.value = double.parse(jumlah.value.text);
    datedata.add(DateTime.tryParse(data.tgl));
  }

  RxList databebanlist = <DataBeban>[].obs;
  var id_user = GetStorage().read('id_user');
  var token = GetStorage().read('token');
  var id_toko = GetStorage().read('id_toko');

  var jenisbebanlist = <DataJenisBeban>[].obs;
  var jenisbebanlistlocal = <DataJenisBeban>[].obs;

  var data = Get.arguments;

  jjj() {
    var x = jenisbebanlistlocal
            .firstWhereOrNull((e) => e.idLocal == jenisbebanval.value)
            ?.kategori ??
        '-';
    print(x);
    return x;
  }

  chekjj() async {
    var xxx = await jenisbebanlistlocal.first.kategori.toString();
    var c =
        jenisbebanlistlocal.firstWhereOrNull((e) => e.id == data.idKtrBeban);
    if (c == null) {
      jenisbebanval.value = xxx;
    } else {
      jenisbebanval.value = data.idKtrBeban.toString();
    }
  }

  late var jenisbebanval = data.idKtrBeban.toString().obs;

  var formKeybeban = GlobalKey<FormState>().obs;
  var nama = TextEditingController().obs;
  var search = TextEditingController().obs;
  var kategori = TextEditingController().obs;
  var keterangan = TextEditingController().obs;
  var tanggal = TextEditingController().obs;
  var jumlah = TextEditingController().obs;

  var jumlahbeban = 0.0.obs;

  DateFormat dateFormat = DateFormat("dd-MM-yyyy HH:mm:ss");

  DateFormat dateFormatdisplay = DateFormat("dd-MM-yyyy");

  stringdate() {
    print(datedata.first);
    var ff = dateFormatdisplay.format(datedata.first!);
    tanggal.value.text = ff;
  }

  fetchJenisBebanlocal(id_toko) async {
    print('-------------------fetch Produk local---------------------');
    //succ.value = false;
    List<Map<String, Object?>> query = await DBHelper().FETCH(
        'SELECT * FROM beban_kategori_local WHERE id_toko = $id_toko AND aktif = "Y" ORDER BY ID DESC');
    List<DataJenisBeban> beban_kategori = query.isNotEmpty
        ? query.map((e) => DataJenisBeban.fromJson(e)).toList()
        : [];
    jenisbebanlistlocal.value = beban_kategori;
    // print('fect produk local --->' + produk.toList().toString());
    //succ.value = true;
    return beban_kategori;
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

  editBebanLocal() async {
    print('-------------------edit beban local---------------------');

    Get.dialog(const showloading(), barrierDismissible: false);

    var query = await DBHelper().UPDATE(
        table: 'beban_local',
        data: DataBeban(
                aktif: 'Y',
                idUser: data.idUser,
                namaKtrBeban: jjj(),
                sync: 'N',
                id: data.id,
                idLocal: data.idLocal,
                idToko: int.parse(id_toko),
                idKtrBeban: jenisbebanval.value,
                nama: nama.value.text,
                keterangan: keterangan.value.text,
                tgl: datedata.first.toString(),
                jumlah: jumlahbeban.value.toInt())
            .toMapForDb(),
        id: data.idLocal);
    print('edit beban local berhasil------------------------------------->');
    print(query);
    if (query == 1) {
      await Get.find<bebanController>().fetchBebanlocal(id_toko);

      await Get.find<dashboardController>().loadbebanhariini();
      await Get.find<dashboardController>().loadpendapatanhariini();
      await Get.find<dashboardController>().loadpendapatantotal();
      Get.back(closeOverlays: true);
      Get.showSnackbar(toast()
          .bottom_snackbar_success('sukses', 'Kategori beban berhasil diedit'));
    } else {
      Get.back(closeOverlays: true);
      Get.showSnackbar(
          toast().bottom_snackbar_error('error', 'gagal edit data local'));
    }

    // if (add != null) {
    //   print(add);
    //   await Get.find<produkController>().fetchProduk();
    //   Get.back();
    // }
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
          jumlahbeban.value.toString());
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
    datedata.clear();
    jumlah.value.clear();
    jumlahbeban.value = 0;
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

  List<DateTime?> datedata = [];
}
