import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:rims_waserda/Modules/Widgets/loading.dart';
import 'package:rims_waserda/Modules/dashboard/controller_dashboard.dart';
import 'package:rims_waserda/Modules/history/model_penjualan.dart';
import 'package:rims_waserda/Modules/kasir/controller_kasir.dart';
import 'package:rims_waserda/Modules/produk/data%20produk/model_produk.dart';

import '../../Services/handler.dart';
import '../../db_helper.dart';
import '../Widgets/toast.dart';
import '../pelanggan/data pelanggan/controller_data_pelanggan.dart';
import '../pelanggan/hutang/controller_hutang.dart';
import '../pelanggan/hutang/model_hutang.dart';
import '../produk/data produk/controller_data_produk.dart';
import 'model_detail_penjualan_v2.dart';

class historyController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchPenjualanlocal(id_toko: id_toko, id_user: id_user, role: role);
  }

  var sort = false.obs;
  var ColIndex = 0.obs;

  String? valstatus;

  var stts = false.obs;
  var role = GetStorage().read('role');

  var liststatus = [
    {'id': 0, 'nama': 'status'},
    {'id': 1, 'nama': 'Selesai'},
    {'id': 3, 'nama': 'Hutang'},
    {'id': 4, 'nama': 'Reversal'}
  ].obs;

  next() async {
    final respon = await http.post(Uri.parse(nextdata), body: {
      'token': token,
      'id_toko': id_toko,
      'id_user': id_user.toString(),
    });
    final datav2 = json.decode(respon.body);
    var dataPenjualan = ModelPenjualan.fromJson(datav2);
    final data = json.decode(respon.body)['meta'];
    penjualan_list.value = dataPenjualan.data;
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
      'id_user': id_user.toString(),
    });
    final datav2 = json.decode(respon.body);
    var dataPenjualan = ModelPenjualan.fromJson(datav2);
    final data = json.decode(respon.body)['meta'];
    penjualan_list.value = dataPenjualan.data;

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

  var penjualan_list = <DataPenjualan>[].obs;
  final nominal = NumberFormat("#,##0");
  var detail_list = <DataPenjualan>[].obs;
  var id_kas = TextEditingController().obs;
  var id_user = GetStorage().read('id_user');
  var token = GetStorage().read('token');
  var id_toko = GetStorage().read('id_toko');

  var succ = true.obs;

  var search = TextEditingController().obs;

  Map<String, dynamic> synclocal(data) {
    var map = <String, dynamic>{};

    map['sync'] = data;

    return map;
  }

  List<DateTime?> datedata = [
    //DateTime.now(),
  ];

  stringdate() {
    var ff = dateFormat.format(datedata.first!);
    search.value.text = ff;
  }

  DateFormat dateFormatsearch = DateFormat("yyyy-MM-dd");

  searchpenjualanlocal() async {
    List<Map<String, Object?>> query = await DBHelper().FETCH(
        'SELECT penjualan_local.*,pelanggan_local.nama_pelanggan from penjualan_Local LEFT JOIN pelanggan_local on penjualan_local.id_pelanggan = pelanggan_local.id WHERE penjualan_local.id_toko = $id_toko AND tgl_penjualan LIKE "%${dateFormatsearch.format(datedata.first!)}%" ORDER BY ID DESC');
    List<DataPenjualan> penjualan = query.isNotEmpty
        ? query.map((e) => DataPenjualan.fromJson(e)).toList()
        : [];
    penjualan_list_local.value = penjualan;
    // print('fect produk local --->' + produk.toList().toString());

    return penjualan;
  }

  searchpenjualanstatuslocal(status) async {
    List<Map<String, Object?>> query = await DBHelper().FETCH(
        'SELECT penjualan_local.*,pelanggan_local.nama_pelanggan from penjualan_Local LEFT JOIN pelanggan_local on penjualan_local.id_pelanggan = pelanggan_local.id WHERE penjualan_local.id_toko = $id_toko AND status = $status AND penjualan_local.tgl_penjualan LIKE "%${dateFormatsearch.format(datedata.first!)}%" ORDER BY ID DESC');
    List<DataPenjualan> penjualan = query.isNotEmpty
        ? query.map((e) => DataPenjualan.fromJson(e)).toList()
        : [];
    penjualan_list_local.value = penjualan;
    // print('fect produk local --->' + produk.toList().toString());

    return penjualan;
  }

  DateFormat dateFormat = DateFormat("dd-MM-yyyy");

  syncPenjualan(id_toko) async {
    print('-----------------SYNC PENJUALAN LOCAL TO HOST-------------------');

    //Get.dialog(showloading(), barrierDismissible: false);
    var checkconn = await check_conn.check();
    if (checkconn == true) {
      List<DataPenjualan> penjualan = await fetchPenjualansync(id_toko);
      //penjualan_list_local.refresh();
      print(
          'start up DB SYNC PELANGGAN--------------------------------------->');
      var query = penjualan.where((x) => x.sync == 'N').toList();
      if (query.isEmpty) {
        print(query.toString() +
            '----------------------------------------------->');
        print(' all data sync -------------------------------->');
      } else {
        await Future.forEach(query, (e) async {
          await REST.syncpenjualan(
              token: token,
              id_hutang: e.idHutang,
              bayar: e.bayar,
              id: e.id,
              id_pelanggan: e.idPelanggan,
              status: e.status,
              total: e.total,
              meja: e.meja,
              kembalian: e.kembalian,
              aktif: e.aktif,
              idtoko: e.idToko.toString(),
              iduser: e.idUser.toString(),
              diskon_total: e.diskonTotal,
              metode_bayar: e.metodeBayar,
              sub_total: e.subTotal,
              tgl_penjualan: e.tglPenjualan,
              total_item: e.totalItem);
          print("PENJUALAN UP ---->   " +
              e.metodeBayar.toString() +
              "------------------------------------------>");

          await DBHelper()
              .UPDATE(table: 'penjualan_local', data: synclocal('Y'), id: e.id);
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

  initPenjualanToLocal(id_toko) async {
    List<DataPenjualan> penjualan_local = await fetchPenjualan();
    //List<DataDetailPenjualan> beban_detail_local = await fetchJenisBeban();

    print('-------------------init penjualan local---------------------');
    //Get.dialog(showloading(), barrierDismissible: false);
    await Future.forEach(penjualan_local, (e) async {
      await DBHelper().INSERT(
          'penjualan_local',
          DataPenjualan(
                  id: e.id,
                  status: e.status,
                  bayar: e.bayar,
                  diskonTotal: e.diskonTotal,
                  idToko: e.idToko,
                  idUser: e.idUser,
                  kembalian: e.kembalian,
                  meja: e.meja,
                  metodeBayar: e.metodeBayar,
                  namaPelanggan: e.namaPelanggan,
                  namaUser: e.namaUser,
                  subTotal: e.subTotal,
                  tglPenjualan: e.tglPenjualan,
                  total: e.total,
                  totalItem: e.totalItem,
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
    //await fetchPenjualanlocal(id_toko:id_toko,id_user: id_user,role: role);
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

  var penjualan_list_local = <DataPenjualan>[].obs;

  // var beban_jenis_local = <DataJenisBeban>[].obs;
  fetchPenjualansync(id_toko) async {
    print('-------------------fetch Penjualan local sync---------------------');
    //succ.value = false;
    List<Map<String, Object?>> query = await DBHelper().FETCH(
        'SELECT * FROM penjualan_local WHERE id_toko = $id_toko ORDER BY ID DESC');
    List<DataPenjualan> penjualan = query.isNotEmpty
        ? query.map((e) => DataPenjualan.fromJson(e)).toList()
        : [];
    penjualan_list_local.value = penjualan;
    // print('fect produk local --->' + produk.toList().toString());
    //succ.value = true;
    return penjualan;
  }

  fetchPenjualanlocal({id_toko, id_user, role}) async {
    print('-------------------fetch Penjualan local---------------------');
    succ.value = false;
    if (role == 1) {
      List<Map<String, Object?>> query = await DBHelper().FETCH(
          'SELECT penjualan_local.*,pelanggan_local.nama_pelanggan from penjualan_Local LEFT JOIN pelanggan_local on penjualan_local.id_pelanggan = pelanggan_local.id WHERE penjualan_local.id_toko = $id_toko AND penjualan_local.id_user = $id_user ORDER BY ID DESC');
      List<DataPenjualan> penjualan = query.isNotEmpty
          ? query.map((e) => DataPenjualan.fromJson(e)).toList()
          : [];
      penjualan_list_local.value = penjualan;
      // print('fect produk local --->' + produk.toList().toString());
      succ.value = true;
      return penjualan;
    } else {
      List<Map<String, Object?>> query = await DBHelper().FETCH(
          'SELECT penjualan_local.*,pelanggan_local.nama_pelanggan from penjualan_Local LEFT JOIN pelanggan_local on penjualan_local.id_pelanggan = pelanggan_local.id WHERE penjualan_local.id_toko = $id_toko ORDER BY ID DESC');
      List<DataPenjualan> penjualan = query.isNotEmpty
          ? query.map((e) => DataPenjualan.fromJson(e)).toList()
          : [];
      penjualan_list_local.value = penjualan;
      // print('fect produk local --->' + produk.toList().toString());
      succ.value = true;
      return penjualan;
    }
  }

  fetchPenjualanlocaldashboard(id_toko) async {
    print('-------------------fetch Penjualan local---------------------');
    //succ.value = false;
    List<Map<String, Object?>> query = await DBHelper().FETCH(
        'SELECT penjualan_local.*,pelanggan_local.nama_pelanggan from penjualan_Local LEFT JOIN pelanggan_local on penjualan_local.id_pelanggan = pelanggan_local.id WHERE penjualan_local.id_toko = $id_toko AND penjualan_local.status != 4 ORDER BY ID DESC');
    List<DataPenjualan> penjualan = query.isNotEmpty
        ? query.map((e) => DataPenjualan.fromJson(e)).toList()
        : [];
    penjualan_list_local.value = penjualan;
    // print('fect produk local --->' + produk.toList().toString());
    //succ.value = true;
    return penjualan;
  }

  fetchPenjualanlocaldashboardreversal(id_toko) async {
    print('-------------------fetch Penjualan local---------------------');
    //succ.value = false;
    List<Map<String, Object?>> query = await DBHelper().FETCH(
        'SELECT penjualan_local.*,pelanggan_local.nama_pelanggan from penjualan_Local LEFT JOIN pelanggan_local on penjualan_local.id_pelanggan = pelanggan_local.id WHERE penjualan_local.id_toko = $id_toko AND penjualan_local.status = 4 ORDER BY ID DESC');
    List<DataPenjualan> penjualan = query.isNotEmpty
        ? query.map((e) => DataPenjualan.fromJson(e)).toList()
        : [];
    penjualan_list_local.value = penjualan;
    // print('fect produk local --->' + produk.toList().toString());
    //succ.value = true;
    return penjualan;
  }

  fetchPenjualan() async {
    print('-------------------fetch penjualan---------------------');
    succ.value = false;
    var checkconn = await check_conn.check();
    if (checkconn == true) {
      var penjualan =
          await REST.penjualanData(token, id_user, id_toko, search.value.text);
      if (penjualan != null) {
        succ.value = true;
        print('-------------------data penjualan--------------------');
        var dataPenjualan = ModelPenjualan.fromJson(penjualan);

        penjualan_list.value = dataPenjualan.data;

        // totalpage.value = dataPenjualan.meta.pagination.totalPages;
        // totaldata.value = dataPenjualan.meta.pagination.total;
        // perpage.value = dataPenjualan.meta.pagination.perPage;
        // currentpage.value = penjualan['meta']['pagination']['current_page'];
        // count.value = dataPenjualan.meta.pagination.count;
        // if (totalpage > 1) {
        //   nextdata = penjualan['meta']['pagination']['links']['next'];
        // }

        //update();
        print('--------------------list penjualan---------------');
        print(penjualan_list);

        // Get.back(closeOverlays: true);

        return penjualan_list;
      } else {
        succ.value = true;
        // Get.back(closeOverlays: true);
        Get.showSnackbar(
            toast().bottom_snackbar_error('Error', 'Gagal fecth penjualan'));
      }
    } else {
      succ.value = true;
      //Get.back(closeOverlays: true);
      Get.showSnackbar(
          toast().bottom_snackbar_error('Error', 'Periksa koneksi'));
    }
    return [];
  }

  fetchPenjualanHariIni() async {
    print('-------------------fetch penjualan hari ini---------------------');

    var checkconn = await check_conn.check();
    if (checkconn == true) {
      var penjualan =
          await REST.penjualanDataHariIni(token, id_user.toString(), id_toko);
      if (penjualan['success'] == true) {
        print('-------------------data penjualan hari ini--------------------');
        var dataPenjualan = ModelPenjualan.fromJson(penjualan);

        penjualan_list.value = dataPenjualan.data;
        penjualan_list.refresh();
        //update();
        print('--------------------list penjualan---------------');
        print(penjualan_list);

        // Get.back(closeOverlays: true);

        return penjualan_list;
      } else {
        penjualan_list.value = [];
        Get.back(closeOverlays: true);
        Get.showSnackbar(
            toast().bottom_snackbar_error('Error', 'Gagal fecth penjualan'));
      }
    } else {
      Get.back(closeOverlays: true);
      Get.showSnackbar(
          toast().bottom_snackbar_error('Error', 'Periksa koneksi'));
    }
    return [];
  }

  Map<String, dynamic> reversal_qty(data) {
    var map = <String, dynamic>{};

    map['qty'] = data;
    map['sync'] = 'N';

    return map;
  }

  Map<String, dynamic> reversal_hutang() {
    var map = <String, dynamic>{};

    map['status'] = 3;
    map['sync'] = 'N';

    return map;
  }

  reversalPenjualanlocal(id) async {
    print('-------------------reversal Penjualan local---------------------');

    Get.dialog(showloading(), barrierDismissible: false);

    var select = penjualan_list_local.where((e) => e.id == id).first;

    if (select.idHutang == 0) {
      var query = await DBHelper().UPDATE(
          table: 'penjualan_local',
          data: DataPenjualan(
                  aktif: 'N',
                  status: 4,
                  id: select.id,
                  idUser: select.idUser,
                  sync: 'N',
                  totalItem: select.totalItem,
                  tglPenjualan: select.tglPenjualan,
                  namaUser: select.namaUser,
                  metodeBayar: select.metodeBayar,
                  kembalian: select.kembalian,
                  diskonTotal: select.diskonTotal,
                  meja: select.meja,
                  total: select.totalItem,
                  idHutang: select.idHutang,
                  bayar: select.bayar,
                  idToko: select.idToko,
                  idPelanggan: select.idPelanggan,
                  namaPelanggan: select.namaPelanggan,
                  subTotal: select.subTotal)
              .toMapForDb(),
          id: select.id);
      print(
          'edit reversal local berhasil------------------------------------->');
      print(query);
      if (query == 1) {
        List<DataPenjualanDetailV2> selectdetail =
            await fetchPenjualanDetaillocal(id_toko);

        List<DataProduk> selectproduk =
            await Get.find<produkController>().fetchProduklocal(id_toko);

        var detail = selectdetail.where((e) => e.idPenjualan == id).toList();
        print('detai---------------------------------->' + detail.toString());

        await Future.forEach(detail, (element) async {
          if (element.idJenisStock == 1) {
            var produk =
                selectproduk.where((e) => e.id == element.idProduk).first;
            await DBHelper().UPDATE(
                table: 'produk_local',
                data: reversal_qty(produk.qty! + element.qty!),
                id: produk.id);
            print('update qty --------------------------------->' +
                produk.namaProduk);
          }
        });

        await fetchPenjualanlocal(
            id_toko: id_toko, id_user: id_user, role: role);
        print(
            'find produk------------------------------------------------------->');
        await Get.find<produkController>().fetchProduklocal(id_toko);
        print(
            'find kasir------------------------------------------------------->');
        await Get.find<kasirController>().fetchProduklocal(id_toko);
        await Get.find<dashboardController>().loadpendapatanhariini();
        await Get.find<dashboardController>().loadpendapatantotal();
        await Get.find<dashboardController>().loadtransaksitotal();
        await Get.find<dashboardController>().loadtransaksihariini();
        await Get.find<dashboardController>().loadtotalreversal();
        Get.back(closeOverlays: true);
        Get.showSnackbar(
            toast().bottom_snackbar_success('sukses', 'Penjualan di batalkan'));
      } else {
        Get.back(closeOverlays: true);
        Get.showSnackbar(toast()
            .bottom_snackbar_error('error', 'Penjualan gagal dibatalkan'));
      }
    } else {
      var query = await DBHelper().UPDATE(
          table: 'penjualan_local',
          data: DataPenjualan(
                  aktif: 'N',
                  status: 4,
                  id: select.id,
                  idUser: select.idUser,
                  sync: 'N',
                  totalItem: select.totalItem,
                  tglPenjualan: select.tglPenjualan,
                  namaUser: select.namaUser,
                  metodeBayar: select.metodeBayar,
                  kembalian: select.kembalian,
                  diskonTotal: select.diskonTotal,
                  meja: select.meja,
                  total: select.totalItem,
                  idHutang: select.idHutang,
                  bayar: select.bayar,
                  idToko: select.idToko,
                  idPelanggan: select.idPelanggan,
                  namaPelanggan: select.namaPelanggan,
                  subTotal: select.subTotal)
              .toMapForDb(),
          id: select.id);
      print('edit local berhasil------------------------------------->');
      print(query);
      if (query == 1) {
        List<DataPenjualanDetailV2> selectdetail =
            await fetchPenjualanDetaillocal(id_toko);
        List<DataProduk> selectproduk =
            await Get.find<produkController>().fetchProduklocal(id_toko);
        List<DataHutang> selecthutang =
            await Get.find<hutangController>().fetchDataHutanglocal(id_toko);
        var hutang = selecthutang
            .where((element) => element.id == select.idHutang)
            .first;

        var detail = selectdetail.where((e) => e.idPenjualan == id).toList();

        await Future.forEach(detail, (element) async {
          if (element.idJenisStock == 1) {
            var produk =
                selectproduk.where((e) => e.id == element.idProduk).first;
            await DBHelper().UPDATE(
                table: 'produk_local',
                data: reversal_qty(produk.qty! + element.qty!),
                id: produk.id);
            print('update qty --------------------------------->' +
                produk.namaProduk);
          }
        });

        var queryhutang = await DBHelper().UPDATE(
            table: 'hutang_local', data: reversal_hutang(), id: hutang.id);

        await fetchPenjualanlocal(
            id_toko: id_toko, id_user: id_user, role: role);
        await Get.find<produkController>().fetchProduklocal(id_toko);
        await Get.find<kasirController>().fetchProduklocal(id_toko);
        await Get.find<dashboardController>().loadpendapatanhariini();
        await Get.find<dashboardController>().loadpendapatantotal();
        await Get.find<dashboardController>().loadtransaksitotal();
        await Get.find<dashboardController>().loadtransaksihariini();
        await Get.find<hutangController>().fetchDataHutanglocal(id_toko);
        await Get.find<pelangganController>().fetchDataPelangganlocal(id_toko);
        await Get.find<pelangganController>()
            .fetchstatusPelangganlocal(id_toko);
        await Get.find<dashboardController>().loadhutangtotal();
        await Get.find<dashboardController>().loadtotalreversal();
        Get.back(closeOverlays: true);
        Get.showSnackbar(
            toast().bottom_snackbar_success('sukses', 'Penjualan di batalkan'));
      } else {
        Get.back(closeOverlays: true);
        Get.showSnackbar(toast()
            .bottom_snackbar_error('error', 'Penjualan gagal dibatalkan'));
      }
    }
  }

  var penjualan_list_detail_local = <DataPenjualanDetailV2>[].obs;

  fetchPenjualanDetaillocal(id_toko) async {
    print(
        '-------------------fetch detail Penjualan local---------------------');
    //succ.value = false;
    List<Map<String, Object?>> query = await DBHelper()
        .FETCH('SELECT * FROM penjualan_detail_local ORDER BY ID DESC');
    List<DataPenjualanDetailV2> penjualan = query.isNotEmpty
        ? query.map((e) => DataPenjualanDetailV2.fromJson(e)).toList()
        : [];
    penjualan_list_detail_local.value = penjualan;
    // print('fect produk local --->' + produk.toList().toString());
    //succ.value = true;
    return penjualan;
  }

  reversalPenjualan(String id) async {
    print('-------------------fetch penjualan---------------------');
    Get.dialog(showloading(), barrierDismissible: false);
    var checkconn = await check_conn.check();
    if (checkconn == true) {
      var penjualan = await REST.penjualanReversal(token, id, id_toko);
      if (penjualan != null) {
        print(
            '-------------------reversal penjualan penjualan--------------------');
        await fetchPenjualan();
        Get.back(closeOverlays: true);
        Get.showSnackbar(toast()
            .bottom_snackbar_success('Berhasil', 'Berhasil di reversal'));
      } else {
        Get.back(closeOverlays: true);
        // Get.back(closeOverlays: true);
        Get.showSnackbar(
            toast().bottom_snackbar_error('Error', 'Gagal reversal penjualan'));
      }
    } else {
      Get.back(closeOverlays: true);
      //Get.back(closeOverlays: true);
      Get.showSnackbar(
          toast().bottom_snackbar_error('Error', 'Periksa koneksi'));
    }
  }
}
