import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:pattern_formatter/numeric_formatter.dart';
import 'package:rims_waserda/Modules/Widgets/loading.dart';
import 'package:rims_waserda/Modules/dashboard/controller_dashboard.dart';
import 'package:rims_waserda/Modules/history/Controller_history.dart';
import 'package:rims_waserda/Modules/pelanggan/data%20pelanggan/controller_data_pelanggan.dart';
import 'package:rims_waserda/Modules/pelanggan/hutang/model_hutang_detail.dart';

import '../../../Services/handler.dart';
import '../../../Templates/setting.dart';
import '../../../db_helper.dart';
import '../../Widgets/buttons.dart';
import '../../Widgets/toast.dart';
import '../../history/model_penjualan.dart';
import 'model_hutang.dart';

class hutangController extends GetxController {
  @override
  Future<void> onInit() async {
    // TODO: implement onInit
    super.onInit();
    await fetchDataHutanglocal(id_toko);
    await fetchDataHutangDetaillocal(id_toko);
  }

  var role = GetStorage().read('role');

  var search = TextEditingController().obs;

  var totalpage = 0.obs;
  var totaldata = 0.obs;
  var currentpage = 0.obs;
  var nextpage;
  var count = 0.obs;

  var nextdata;
  var previouspage;
  var perpage = 0.obs;

  // next() async {
  //   final respon = await http.post(Uri.parse(nextdata), body: {
  //     'token': token,
  //     'id_toko': id_toko,
  //   });
  //   final datav2 = json.decode(respon.body);
  //   var dataHutang = ModelHutang.fromJson(datav2);
  //   final data = json.decode(respon.body)['meta'];
  //   list_hutang.value = dataHutang.data;
  //   previouspage = data['pagination']['links']['previous'];
  //   nextdata = data['pagination']['links']['next'];
  //   currentpage.value = data['pagination']['current_page'];
  //   count.value = data['pagination']['count'];
  //   totaldata.value = data['pagination']['total'];
  //   perpage.value = data['pagination']['per_page'];
  //   print(nextdata);
  //   print(data);
  //
  //   //return produk_list;
  // }
  //
  // back() async {
  //   final respon = await http.post(Uri.parse(previouspage), body: {
  //     'token': token,
  //     'id_toko': id_toko,
  //   });
  //   final datav2 = json.decode(respon.body);
  //   var dataHutang = ModelHutang.fromJson(datav2);
  //   final data = json.decode(respon.body)['meta'];
  //   list_hutang.value = dataHutang.data;
  //
  //   previouspage = data['pagination']['links']['previous'];
  //   nextdata = data['pagination']['links']['next'];
  //   count.value = data['pagination']['count'];
  //   totaldata.value = data['pagination']['total'];
  //   currentpage.value = data['pagination']['current_page'];
  //   perpage.value = data['pagination']['per_page'];
  //   print(previouspage);
  //
  //   //return produk_list;
  // }

  var id_user = GetStorage().read('id_user');
  var token = GetStorage().read('token');
  var id_toko = GetStorage().read('id_toko');

  var bayarhutang = TextEditingController().obs;
  var list_hutang = <DataHutang>[].obs;

  //var list_hutangv2 = <DataHutangv2>[].obs;
  var list_hutang_detail = <DataHutangDetail>[].obs;

  Map<String, dynamic> synclocal(data) {
    var map = <String, dynamic>{};

    map['sync'] = data;

    return map;
  }

  searchhutanglocal() async {
    List<Map<String, Object?>> query = await DBHelper().FETCH(
        'SELECT hutang_local.*, pelanggan_local.nama_pelanggan FROM hutang_local JOIN pelanggan_local ON hutang_local.id_pelanggan = pelanggan_local.id_local WHERE hutang_local.id_toko = $id_toko AND pelanggan_local.nama_pelanggan LIKE "%${search.value.text}%" ORDER BY ID DESC');
    List<DataHutang> hutang = query.isNotEmpty
        ? query.map((e) => DataHutang.fromJson(e)).toList()
        : [];
    list_hutanglocal.value = hutang;
    // print('fect produk local --->' + produk.toList().toString());
    return hutang;
  }

  var succ = true.obs;

  syncHutang(id_toko) async {
    print('-----------------SYNC HUTANG LOCAL TO HOST-------------------');

    List<DataHutang> hutang = await fetchDataHutangsync(id_toko);
    // list_hutanglocal.refresh();
    print('start up DB SYNC HUTANG--------------------------------------->');
    var query = hutang.where((x) => x.sync == 'N').toList();
    if (query.isEmpty) {
      print(query.toString() +
          '----------------------------------------------->');
      print(' all data sync -------------------------------->');
    } else {
      await Future.forEach(query, (e) async {
        var up = await REST.synchutang(
            token: token,
            id_toko: e.idToko.toString(),
            aktif: e.aktif!,
            id: e.idLocal,
            status: e.status,
            hutang: e.hutang.toString(),
            sisa_hutang: e.sisaHutang.toString(),
            id_pelanggan: e.idPelanggan.toString(),
            tgl_hutang: e.tglHutang);

        if (up != null) {
          print("HUTANG UP ---->   " +
              e.hutang.toString() +
              "------------------------------------------>");
          await DBHelper().UPDATE(
              table: 'hutang_local', data: synclocal('Y'), id: e.idLocal);
        }
      });
    }
  }

  String stringGenerator(int len) {
    var random = Random.secure();
    var values = List<int>.generate(len, (i) => random.nextInt(255));

    var uniqueId = base64UrlEncode(values);
    print(uniqueId);
    return uniqueId;
  }

  syncHutangDetail(id_toko) async {
    print(
        '-----------------SYNC HUTANG DETAIL LOCAL TO HOST-------------------');

    List<DataHutangDetail> hutangdetail =
        await fetchDataHutangDetailsync(id_toko);
    //list_hutang_detaillocal.refresh();
    print(
        'start up DB SYNC HUTANG DETAIL--------------------------------------->');
    var query = hutangdetail.where((x) => x.sync == 'N').toList();
    if (query.isEmpty) {
      print(query.toString() +
          '----------------------------------------------->');
      print(' all data sync -------------------------------->');
    } else {
      await Future.forEach(query, (e) async {
        var up = await REST.synchutangdetail(
            token: token,
            id_toko: e.idToko.toString(),
            aktif: e.aktif!,
            tgl_hutang: e.tglHutang,
            id_pelanggan: e.idPelanggan.toString(),
            id: e.idLocal,
            bayar: e.bayar.toString(),
            sisa: e.sisa.toString(),
            id_hutang: e.idHutang.toString(),
            tgl_bayar: e.tglBayar,
            tgl_lunas: e.tglLunas);
        if (up != null) {
          print("HUTANG DETAIL UP ---->   " +
              e.bayar.toString() +
              "------------------------------------------>");

          await DBHelper().UPDATE(
              table: 'hutang_detail_local',
              data: synclocal('Y'),
              id: e.idLocal);
        }
      });
    }
  }

  initHutangToLocal(id_toko) async {
    List<DataHutang> hutang_local = await fetchDataHutang();
    List<DataHutang> check_hutang_local = await fetchDataHutangsync(id_toko);

    print('-------------------init hutang local---------------------');

    //Get.dialog(showloading(), barrierDismissible: false);
    await Future.forEach(hutang_local, (e) async {
      var x = check_hutang_local
          .where((element) => element.idLocal == e.idLocal)
          .firstOrNull;
      if (x == null) {
        print('insert------------------------------------------> ' +
            ' ' +
            e.hutang.toString());
        await DBHelper().INSERT(
            'hutang_local',
            DataHutang(
                    id: e.id,
                    aktif: e.aktif,
                    sync: 'Y',
                    namaPelanggan: e.namaPelanggan,
                    idToko: e.idToko,
                    status: e.status,
                    idLocal: e.idLocal,
                    hutang: e.hutang,
                    sisaHutang: e.sisaHutang,
                    idPelanggan: e.idPelanggan,
                    tglHutang: e.tglHutang)
                .toMapForDb());
      } else {
        print('update------------------------------------------> ' +
            ' ' +
            e.hutang.toString());
        DBHelper().UPDATE(
            table: 'hutang_local',
            data: DataHutang(
                    aktif: e.aktif,
                    sync: 'Y',
                    namaPelanggan: e.namaPelanggan,
                    idToko: e.idToko,
                    status: e.status,
                    idLocal: e.idLocal,
                    hutang: e.hutang,
                    sisaHutang: e.sisaHutang,
                    idPelanggan: e.idPelanggan,
                    tglHutang: e.tglHutang)
                .updateInit(),
            id: e.idLocal);
      }
    });

    print('init success---------------------------------------------------->');
    await fetchDataHutanglocal(id_toko);
  }

  var list_hutanglocal = <DataHutang>[].obs;

  fetchDataHutangsync(id_toko) async {
    print('-------------------fetch hutang local sync---------------------');
    //  succ.value = false;
    List<Map<String, Object?>> query = await DBHelper().FETCH(
        'SELECT * FROM hutang_local WHERE id_toko = $id_toko ORDER BY ID DESC');
    List<DataHutang> hutang = query.isNotEmpty
        ? query.map((e) => DataHutang.fromJson(e)).toList()
        : [];
    list_hutanglocal.value = hutang;
    // print('fect produk local --->' + produk.toList().toString());
    //  succ.value = true;
    return hutang;
  }

  fetchDataHutanglocal(id_toko) async {
    print('-------------------fetch hutang local---------------------');
    succ.value = false;
    List<Map<String, Object?>> query = await DBHelper().FETCH(
        'SELECT hutang_local.*, pelanggan_local.nama_pelanggan FROM hutang_local JOIN pelanggan_local ON hutang_local.id_pelanggan = pelanggan_local.id_local WHERE hutang_local.id_toko = $id_toko AND hutang_local.aktif = "Y" ORDER BY ID DESC');
    List<DataHutang> hutang = query.isNotEmpty
        ? query.map((e) => DataHutang.fromJson(e)).toList()
        : [];
    list_hutanglocal.value = hutang;
    // print('fect produk local --->' + produk.toList().toString());
    succ.value = true;
    return hutang;
  }

  fetchDataHutanglocaldashboard(id_toko) async {
    print('-------------------fetch hutang local---------------------');
    succ.value = false;
    List<Map<String, Object?>> query = await DBHelper().FETCH(
        'SELECT hutang_local.*, pelanggan_local.nama_pelanggan FROM hutang_local JOIN pelanggan_local ON hutang_local.id_pelanggan = pelanggan_local.id_local WHERE hutang_local.id_toko = $id_toko AND hutang_local.aktif = "Y" AND hutang_local.status = 2 ORDER BY ID DESC');
    List<DataHutang> hutang = query.isNotEmpty
        ? query.map((e) => DataHutang.fromJson(e)).toList()
        : [];
    list_hutanglocal.value = hutang;
    // print('fect produk local --->' + produk.toList().toString());
    succ.value = true;
    return hutang;
  }

  fetchDataHutangbayarhariinidashboard(id_toko) async {
    print('-------------------fetch hutang local---------------------');
    //succ.value = false;
    List<Map<String, Object?>> query = await DBHelper().FETCH(
        'SELECT * FROM hutang_detail_local WHERE id_toko = $id_toko ORDER BY ID DESC');
    List<DataHutangDetail> hutang = query.isNotEmpty
        ? query.map((e) => DataHutangDetail.fromJson(e)).toList()
        : [];
    //list_hutanglocal.value = hutang;
    // print('fect produk local --->' + produk.toList().toString());
    // succ.value = true;
    return hutang;
  }

  fetchDataHutang() async {
    print('-------------------fetch data hutang---------------------');

    var hutang = await REST.hutangAll(token: token, id_toko: id_toko);
    if (hutang['status_code'] == 200) {
      print('-------------------data beban---------------');
      var dataHutang = ModelHutang.fromJson(hutang);

      list_hutang.value = dataHutang.data;

      print('--------------------list data hutang---------------');
      print(list_hutang);

      return list_hutang;
    } else {
      Get.showSnackbar(
          toast().bottom_snackbar_error('Error', 'Gagal fecth butang'));
    }

    return [];
  }

  initHutangDetailToLocal(id_toko) async {
    //login -> sync -> init

    List<DataHutangDetail> hutang_detail_local = await fetchDataHutangDetail();
    List<DataHutangDetail> check_hutang_detail_local =
        await fetchDataHutangDetailsync(id_toko);

    print('-------------------init hutang detail local---------------------');

    //Get.dialog(showloading(), barrierDismissible: false);
    await Future.forEach(hutang_detail_local, (e) async {
      var x = check_hutang_detail_local
          .where((element) => element.idLocal == e.idLocal)
          .firstOrNull;
      if (x == null) {
        print(
            'insert -------------------------------------- > ' + e.tglHutang!);
        await DBHelper().INSERT(
            'hutang_detail_local',
            DataHutangDetail(
                    id: e.id,
                    tglLunas: e.tglLunas,
                    sisa: e.sisa,
                    tglBayar: e.tglBayar,
                    aktif: e.aktif,
                    sync: 'Y',
                    tglHutang: e.tglHutang,
                    idPelanggan: e.idPelanggan,
                    idLocal: e.idLocal,
                    idToko: e.idToko,
                    bayar: e.bayar,
                    idHutang: e.idHutang)
                .toMapForDb());
      } else {
        print(
            'update -------------------------------------- > ' + e.tglHutang!);
        DBHelper().UPDATE(
            table: 'hutang_detail_local',
            data: DataHutangDetail(
                    tglLunas: e.tglLunas,
                    sisa: e.sisa,
                    tglBayar: e.tglBayar,
                    aktif: e.aktif,
                    sync: 'Y',
                    tglHutang: e.tglHutang,
                    idPelanggan: e.idPelanggan,
                    idLocal: e.idLocal,
                    idToko: e.idToko,
                    bayar: e.bayar,
                    idHutang: e.idHutang)
                .updateInit(),
            id: e.idLocal);
      }
    });

    // if (up != null) {
    //  print(up.toString());
    print('init success---------------------------------------------------->');
    await fetchDataHutangDetaillocal(id_toko);
  }

  var list_hutang_detaillocal = <DataHutangDetail>[].obs;

  fetchDataHutangDetailsync(id_toko) async {
    print(
        '-------------------fetch hutang detail local sync---------------------');
    //  succ.value = false;
    List<Map<String, Object?>> query = await DBHelper().FETCH(
        'SELECT * FROM hutang_detail_local WHERE id_toko = $id_toko ORDER BY ID DESC');
    List<DataHutangDetail> hutang = query.isNotEmpty
        ? query.map((e) => DataHutangDetail.fromJson(e)).toList()
        : [];
    list_hutang_detaillocal.value = hutang;
    // print('fect produk local --->' + produk.toList().toString());
    //  succ.value = true;
    return hutang;
  }

  fetchDataHutangDetaillocal(id_toko) async {
    print('-------------------fetch hutang detail local---------------------');
    //  succ.value = false;
    List<Map<String, Object?>> query = await DBHelper().FETCH(
        'SELECT * FROM hutang_detail_local WHERE id_toko = $id_toko AND aktif = "Y" ORDER BY ID DESC');
    List<DataHutangDetail> hutang = query.isNotEmpty
        ? query.map((e) => DataHutangDetail.fromJson(e)).toList()
        : [];
    list_hutang_detaillocal.value = hutang;
    print(hutang);
    // print('fect produk local --->' + produk.toList().toString());
    //  succ.value = true;
    return hutang;
  }

  fetchDataHutangDetail() async {
    print('-------------------fetch data hutang detail---------------------');

    var hutang = await REST.hutangDetail(token: token, id_toko: id_toko);
    if (hutang['status_code'] == 200) {
      print('-------------------data beban---------------');
      var dataHutang = ModelHutangDetail.fromJson(hutang);

      list_hutang_detail.value = dataHutang.data;

      print('--------------------list data hutang detail---------------');
      print(list_hutang_detail);

      return list_hutang_detail;
    } else {
      Get.showSnackbar(
          toast().bottom_snackbar_error('Error', 'Gagal fecth butang'));
    }
  }

  bayarHutang(String id) async {
    Get.dialog(showloading(), barrierDismissible: false);
    print('-------------------fetch data hutang---------------------');

    var checkconn = await check_conn.check();
    if (checkconn == true) {
      var hutang = await REST.hutangBayar(
          token: token,
          id_toko: id_toko,
          id_hutang: id,
          bayar: jumlahbayarhutang.value.toString());
      if (hutang != null) {
        print('------------------bayar hutang---------------');

        await fetchDataHutang();

        bayarhutang.value.clear();

        Get.back(closeOverlays: true);

        Get.showSnackbar(toast()
            .bottom_snackbar_success('Berhasil', 'Hutang berhasil di bayar'));
      } else {
        Get.back(closeOverlays: true);

        Get.showSnackbar(
            toast().bottom_snackbar_error('Error', 'Gagal bayar hutang'));
      }
    } else {
      Get.back(closeOverlays: true);
      Get.showSnackbar(
          toast().bottom_snackbar_error('Error', 'Periksa koneksi'));
    }
    return [];
  }

  DateFormat dateFormat = DateFormat("dd-MM-yyyy HH:mm:ss");

  DateFormat dateFormatdisplay = DateFormat("dd-MM-yyyy");

  bayarHutanglocal(String id_local) async {
    Get.dialog(showloading(), barrierDismissible: false);
    print('-------------------bayar hutang local---------------------');

    var ss = list_hutanglocal.where((e) => e.idLocal == id_local).first;
    print('jumlah hutang--------------------------------------.>');
    print(ss.hutang);
    var sisa = ss.sisaHutang! - jumlahbayarhutang.value;
    var con1 = Get.find<historyController>();
    await con1.fetchPenjualanlocal(
        id_toko: id_toko, id_user: id_user, role: role);

    var pp1 =
        con1.penjualan_list_local.where((e) => e.idHutang == id_local).first;

    var sisabayar = pp1.bayar! + jumlahbayarhutang.value;

    var hutang = await DBHelper().INSERT(
        'hutang_detail_local',
        DataHutangDetail(
                aktif: 'Y',
                sync: 'N',
                idLocal: ss.idPelanggan! + stringGenerator(10),
                tglHutang: ss.tglHutang,
                idPelanggan: ss.idPelanggan,
                idToko: ss.idToko,
                idHutang: ss.idLocal,
                bayar: jumlahbayarhutang.value,
                tglBayar: DateTime.now().toString(),
                sisa: sisa,
                tglLunas: null)
            .toMapForDb());

    await DBHelper().UPDATE(
        table: 'hutang_local',
        data: DataHutang(
                idToko: ss.idToko,
                idPelanggan: ss.idPelanggan,
                tglHutang: ss.tglHutang,
                sync: 'N',
                aktif: 'Y',
                namaPelanggan: ss.namaPelanggan,
                hutang: ss.hutang,
                sisaHutang: sisa,
                id: ss.id,
                idLocal: ss.idLocal,
                status: 2)
            .toMapForDb(),
        id: ss.idLocal);

    await DBHelper().UPDATE(
        table: 'penjualan_local',
        data: DataPenjualan(
                aktif: 'Y',
                ppn: pp1.ppn,
                status: pp1.status,
                id: pp1.id,
                idLocal: pp1.idLocal,
                namaPelanggan: pp1.namaPelanggan,
                sync: 'N',
                idPelanggan: pp1.idPelanggan,
                idToko: pp1.idToko,
                bayar: sisabayar,
                idHutang: pp1.idHutang,
                total: pp1.total,
                meja: pp1.meja,
                diskonTotal: pp1.diskonTotal,
                diskonKasir: pp1.diskonKasir,
                kembalian: pp1.kembalian,
                metodeBayar: pp1.metodeBayar,
                namaUser: pp1.namaUser,
                subTotal: pp1.subTotal,
                tglPenjualan: pp1.tglPenjualan,
                totalItem: pp1.totalItem,
                idUser: pp1.idUser)
            .toMapForDb(),
        id: pp1.idLocal);

    print('sisa------------------------------------>');
    print(sisa);

    await fetchDataHutangDetaillocal(id_toko);
    await fetchDataHutanglocal(id_toko);
    await Get.find<dashboardController>().loadhutangtotal();
    var con = Get.find<historyController>();
    await Get.find<historyController>()
        .fetchPenjualanlocal(id_toko: id_toko, id_user: id_user, role: role);
    await Get.find<historyController>().fetchDataHutangDetaillocal(id_toko);
    await Get.find<pelangganController>().fetchDataPelangganlocal(id_toko);
    await Get.find<pelangganController>().fetchstatusPelangganlocal(id_toko);
    var selectv2 =
        list_hutang_detaillocal.where((e) => e.idHutang == id_local).first;
    var ssv2 = list_hutanglocal.where((e) => e.idLocal == id_local).first;

    var pp =
        con.penjualan_list_local.where((e) => e.idHutang == ssv2.idLocal).first;
    if (selectv2.sisa! <= 0) {
      await DBHelper().UPDATE(
          table: 'hutang_detail_local',
          id: selectv2.idLocal,
          data: DataHutangDetail(
            id: selectv2.id,
            idLocal: selectv2.idLocal,
            aktif: 'Y',
            sync: 'N',
            tglHutang: ssv2.tglHutang,
            idPelanggan: ssv2.idPelanggan,
            idToko: ssv2.idToko,
            idHutang: ssv2.idLocal,
            bayar: ss.sisaHutang,
            tglBayar: DateTime.now().toString(),
            sisa: 0,
            tglLunas: DateTime.now().toString(),
          ).toMapForDb());
      var query = await DBHelper().UPDATE(
          table: 'hutang_local',
          data: DataHutang(
                  idToko: ssv2.idToko,
                  idPelanggan: ssv2.idPelanggan,
                  tglHutang: ssv2.tglHutang,
                  sync: 'N',
                  aktif: 'Y',
                  namaPelanggan: ssv2.namaPelanggan,
                  hutang: ssv2.hutang,
                  sisaHutang: 0,
                  id: ssv2.id,
                  idLocal: ssv2.idLocal,
                  status: 1)
              .toMapForDb(),
          id: ssv2.idLocal);

      var penjualan = await DBHelper().UPDATE(
          table: 'penjualan_local',
          data: DataPenjualan(
                  aktif: 'Y',
                  ppn: pp.ppn,
                  status: 1,
                  id: pp.id,
                  idLocal: pp.idLocal,
                  namaPelanggan: pp.namaPelanggan,
                  sync: 'N',
                  idPelanggan: pp.idPelanggan,
                  idToko: pp.idToko,
                  bayar: pp.total,
                  idHutang: pp.idHutang,
                  total: pp.total,
                  meja: pp.meja,
                  diskonTotal: pp.diskonTotal,
                  kembalian: pp.kembalian,
                  metodeBayar: pp.metodeBayar,
                  namaUser: pp.namaUser,
                  subTotal: pp.subTotal,
                  tglPenjualan: pp.tglPenjualan,
                  totalItem: pp.totalItem,
                  diskonKasir: pp.diskonKasir,
                  idUser: pp.idUser)
              .toMapForDb(),
          id: pp.idLocal);
    }

    print('bayar hutang  local berhasil------------------------------------->');
    await fetchDataHutanglocal(id_toko);
    await fetchDataHutangDetaillocal(id_toko);
    await Get.find<historyController>()
        .fetchPenjualanlocal(id_toko: id_toko, id_user: id_user, role: role);
    await Get.find<historyController>().fetchDataHutangDetaillocal(id_toko);
    await Get.find<pelangganController>().fetchDataPelangganlocal(id_toko);
    await Get.find<pelangganController>().fetchstatusPelangganlocal(id_toko);
    await Get.find<dashboardController>().loadhutangtotal();
    await Get.find<dashboardController>().loadpendapatantotal();
    await Get.find<dashboardController>().loadpendapatanhariini();
    bayarhutang.value.clear();
    jumlahbayarhutang.value = 0;
    Get.back(closeOverlays: true);
    Get.showSnackbar(toast()
        .bottom_snackbar_success('Sukses', 'Pembayaran hutang berhasil'));
  }

  var jumlahbayarhutang = 0.obs;
  final nominal = NumberFormat("#,##0");

  bayarhutangpop(String id_local, hutang) {
    Get.dialog(AlertDialog(
      contentPadding: EdgeInsets.all(10),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(12.0),
        ),
      ),
      content: Builder(
        builder: (context) {
          return SingleChildScrollView(
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                width: context.width_query / 2.6,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Sisa hutang : ' +
                          'Rp.' +
                          nominal.format(int.parse(hutang)),
                      style: font().header_black,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text('Masukan jumlah bayar'),
                    SizedBox(
                      height: 15,
                    ),
                    TextField(
                      inputFormatters: [ThousandsFormatter()],
                      onChanged: ((String num) {
                        jumlahbayarhutang.value =
                            int.parse(num.toString().replaceAll(',', ''));
                        print(jumlahbayarhutang.value);
                      }),
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        prefixText: 'Rp. ',
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      textAlign: TextAlign.center,
                      controller: bayarhutang.value,
                      style: font().header_black,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: button_border_custom(
                              onPressed: () {
                                Get.back();
                              },
                              child: Text(
                                'Batal',
                                style: font().primary,
                              ),
                              width: context.width_query,
                              height: context.height_query / 11),
                        ),
                        SizedBox(
                          width: 25,
                        ),
                        Expanded(
                          child: button_solid_custom(
                              onPressed: () {
                                if (bayarhutang.value.text.isEmpty) {
                                  Get.showSnackbar(toast()
                                      .bottom_snackbar_error(
                                          'Gagal', 'masukan jumlah bayar'));
                                } else {
                                  bayarHutanglocal(id_local);
                                }
                              },
                              child: Text(
                                'Bayar',
                                style: font().primary_white,
                              ),
                              width: context.width_query,
                              height: context.height_query / 11),
                        ),
                      ],
                    ),
                  ],
                )),
          );
        },
      ),
    ));
  }
}
