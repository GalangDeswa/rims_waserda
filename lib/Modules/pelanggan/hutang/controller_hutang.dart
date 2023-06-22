import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:pattern_formatter/numeric_formatter.dart';
import 'package:rims_waserda/Modules/Widgets/loading.dart';
import 'package:rims_waserda/Modules/history/Controller_history.dart';
import 'package:rims_waserda/Modules/pelanggan/data%20pelanggan/controller_data_pelanggan.dart';
import 'package:rims_waserda/Modules/pelanggan/hutang/model_hutang_detail.dart';

import '../../../Services/handler.dart';
import '../../../Templates/setting.dart';
import '../../../db_helper.dart';
import '../../Widgets/buttons.dart';
import '../../Widgets/header.dart';
import '../../Widgets/toast.dart';
import '../../history/model_penjualan.dart';
import 'model_hutang.dart';

class hutangController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchDataHutanglocal(id_toko);
    fetchDataHutangDetaillocal(id_toko);
  }

  var search = TextEditingController().obs;

  var totalpage = 0.obs;
  var totaldata = 0.obs;
  var currentpage = 0.obs;
  var nextpage;
  var count = 0.obs;

  var nextdata;
  var previouspage;
  var perpage = 0.obs;

  next() async {
    final respon = await http.post(Uri.parse(nextdata), body: {
      'token': token,
      'id_toko': id_toko,
    });
    final datav2 = json.decode(respon.body);
    var dataHutang = ModelHutang.fromJson(datav2);
    final data = json.decode(respon.body)['meta'];
    list_hutang.value = dataHutang.data;
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
    var dataHutang = ModelHutang.fromJson(datav2);
    final data = json.decode(respon.body)['meta'];
    list_hutang.value = dataHutang.data;

    previouspage = data['pagination']['links']['previous'];
    nextdata = data['pagination']['links']['next'];
    count.value = data['pagination']['count'];
    totaldata.value = data['pagination']['total'];
    currentpage.value = data['pagination']['current_page'];
    perpage.value = data['pagination']['per_page'];
    print(previouspage);

    //return produk_list;
  }

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
        'SELECT hutang_local.*, pelanggan_local.nama_pelanggan FROM hutang_local JOIN pelanggan_local ON hutang_local.id_pelanggan = pelanggan_local.id WHERE hutang_local.id_toko = $id_toko AND nama_pelanggan LIKE "%${search.value.text}%" ORDER BY ID DESC');
    List<DataHutang> hutang = query.isNotEmpty
        ? query.map((e) => DataHutang.fromJson(e)).toList()
        : [];
    list_hutanglocal.value = hutang;
    // print('fect produk local --->' + produk.toList().toString());
    return hutang;
  }

  syncHutang(id_toko) async {
    print('-----------------SYNC HUTANG LOCAL TO HOST-------------------');

    //Get.dialog(showloading(), barrierDismissible: false);
    var checkconn = await check_conn.check();
    if (checkconn == true) {
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
          await REST.synchutang(
              token: token,
              id_toko: e.idToko.toString(),
              aktif: e.aktif!,
              id: e.id,
              status: e.status,
              hutang: e.hutang.toString(),
              id_pelanggan: e.idPelanggan.toString(),
              tgl_hutang: e.tglHutang);
          print("HUTANG UP ---->   " +
              e.hutang.toString() +
              "------------------------------------------>");

          await DBHelper()
              .UPDATE(table: 'hutang_local', data: synclocal('Y'), id: e.id);
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

  syncHutangDetail(id_toko) async {
    print(
        '-----------------SYNC HUTANG DETAIL LOCAL TO HOST-------------------');

    //Get.dialog(showloading(), barrierDismissible: false);
    var checkconn = await check_conn.check();
    if (checkconn == true) {
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
          await REST.synchutangdetail(
              token: token,
              id_toko: e.idToko.toString(),
              aktif: e.aktif!,
              tgl_hutang: e.tglHutang,
              id_pelanggan: e.idPelanggan.toString(),
              id: e.id,
              bayar: e.bayar.toString(),
              sisa: e.sisa.toString(),
              id_hutang: e.idHutang.toString(),
              tgl_bayar: e.tglBayar,
              tgl_lunas: e.tglLunas);
          //TODO : chek hutang detail up datetime null tgl lunas
          print("HUTANG DETAIL UP ---->   " +
              e.bayar.toString() +
              "------------------------------------------>");

          await DBHelper().UPDATE(
              table: 'hutang_detail_local', data: synclocal('Y'), id: e.id);
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

  initHutangToLocal(id_toko) async {
    //login -> sync -> init

    List<DataHutang> hutang_local = await fetchDataHutang();

    print('-------------------init hutang local---------------------');

    //Get.dialog(showloading(), barrierDismissible: false);
    await Future.forEach(hutang_local, (e) async {
      await DBHelper().INSERT(
          'hutang_local',
          DataHutang(
                  aktif: e.aktif,
                  sync: 'Y',
                  namaPelanggan: e.namaPelanggan,
                  idToko: e.idToko,
                  status: e.status,
                  id: e.id,
                  hutang: e.hutang,
                  idPelanggan: e.idPelanggan,
                  tglHutang: e.tglHutang)
              .toMapForDb());
    });

    // if (up != null) {
    //  print(up.toString());
    print('init success---------------------------------------------------->');
    await fetchDataHutanglocal(id_toko);
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
    //  succ.value = false;
    List<Map<String, Object?>> query = await DBHelper().FETCH(
        'SELECT hutang_local.*, pelanggan_local.nama_pelanggan FROM hutang_local JOIN pelanggan_local ON hutang_local.id_pelanggan = pelanggan_local.id WHERE hutang_local.id_toko = $id_toko AND hutang_local.aktif = "Y" ORDER BY ID DESC');
    List<DataHutang> hutang = query.isNotEmpty
        ? query.map((e) => DataHutang.fromJson(e)).toList()
        : [];
    list_hutanglocal.value = hutang;
    // print('fect produk local --->' + produk.toList().toString());
    //  succ.value = true;
    return hutang;
  }

  fetchDataHutang() async {
    print('-------------------fetch data hutang---------------------');

    var checkconn = await check_conn.check();
    if (checkconn == true) {
      var hutang = await REST.hutangAll(token: token, id_toko: id_toko);
      if (hutang['status_code'] == 200) {
        print('-------------------data beban---------------');
        var dataHutang = ModelHutang.fromJson(hutang);

        list_hutang.value = dataHutang.data;

        print('--------------------list data beban---------------');
        print(list_hutang);

        // Get.back(closeOverlays: true);

        return list_hutang;
      } else {
        // Get.back(closeOverlays: true);
        Get.showSnackbar(
            toast().bottom_snackbar_error('Error', 'Gagal fecth butang'));
      }
    } else {
      //Get.back(closeOverlays: true);
      Get.showSnackbar(
          toast().bottom_snackbar_error('Error', 'Periksa koneksi'));
    }
    return [];
  }

  initHutangDetailToLocal(id_toko) async {
    //login -> sync -> init

    List<DataHutangDetail> hutang_detail_local = await fetchDataHutangDetail();

    print('-------------------init hutang local---------------------');

    //Get.dialog(showloading(), barrierDismissible: false);
    await Future.forEach(hutang_detail_local, (e) async {
      await DBHelper().INSERT(
          'hutang_detail_local',
          DataHutangDetail(
                  tglLunas: e.tglLunas,
                  sisa: e.sisa,
                  tglBayar: e.tglBayar,
                  aktif: e.aktif,
                  sync: 'Y',
                  tglHutang: e.tglHutang,
                  idPelanggan: e.idPelanggan,
                  id: e.id,
                  idToko: e.idToko,
                  bayar: e.bayar,
                  idHutang: e.idHutang)
              .toMapForDb());
    });

    // if (up != null) {
    //  print(up.toString());
    print('init success---------------------------------------------------->');
    await fetchDataHutangDetaillocal(id_toko);
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
    // print('fect produk local --->' + produk.toList().toString());
    //  succ.value = true;
    return hutang;
  }

  fetchDataHutangDetail() async {
    print('-------------------fetch data hutang detail---------------------');

    var checkconn = await check_conn.check();
    if (checkconn == true) {
      var hutang = await REST.hutangDetail(token: token, id_toko: id_toko);
      if (hutang['status_code'] == 200) {
        print('-------------------data beban---------------');
        var dataHutang = ModelHutangDetail.fromJson(hutang);

        list_hutang_detail.value = dataHutang.data;
        // totalpage.value = dataHutang.meta.pagination.totalPages;
        // totaldata.value = dataHutang.meta.pagination.total;
        // perpage.value = dataHutang.meta.pagination.perPage;
        // currentpage.value = hutang['meta']['pagination']['current_page'];
        // count.value = dataHutang.meta.pagination.count;
        // if (totalpage > 1) {
        //   nextdata = hutang['meta']['pagination']['links']['next'];
        // }

        print('--------------------list data hutang detail---------------');
        print(list_hutang_detail);

        // Get.back(closeOverlays: true);

        return list_hutang_detail;
      } else {
        // Get.back(closeOverlays: true);
        Get.showSnackbar(
            toast().bottom_snackbar_error('Error', 'Gagal fecth butang'));
      }
    } else {
      //Get.back(closeOverlays: true);
      Get.showSnackbar(
          toast().bottom_snackbar_error('Error', 'Periksa koneksi'));
    }
    return [];
  }

  // bayarHutanglocal(id) async {
  //   print('-------------------tambah Produk local---------------------');
  //
  //   Get.dialog(const showloading(), barrierDismissible: false);
  //
  //   var select = list_hutanglocal.where((e) => e.id == id).first;
  //
  //   var query = await DBHelper().INSERT(
  //       'hutang_detail_local',
  //       DataHutangDetail(
  //         idToko: id_toko,
  //         idHutang: id,
  //         bayar: jumlahbayarhutang.value,idPelanggan:select.idPelanggan,tglHutang: select.tglHutang,sync: 'N',aktif: 'Y',tglBayar: DateTime.now().toString(),sisa: select.hutang! - jumlahbayarhutang.value,tglLunas:
  //       ).toMapForDb());
  //
  //   if (query != null) {
  //     print(query);
  //
  //     await fetchDataHutanglocal(id_toko);
  //     Get.back(closeOverlays: true);
  //     Get.showSnackbar(toast()
  //         .bottom_snackbar_success('Sukses', 'Produk berhasil ditambah'));
  //   } else {
  //     Get.back(closeOverlays: true);
  //     Get.showSnackbar(
  //         toast().bottom_snackbar_error('error', 'gagal tambah data local'));
  //   }
  //
  //   // if (add == 1) {
  //   //
  //   // } else {
  //   //   Get.back(closeOverlays: true);
  //   //   Get.showSnackbar(
  //   //       toast().bottom_snackbar_error('error', 'gagal tambah data local'));
  //   // }
  // }

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

  bayarHutanglocal(int id) async {
    Get.dialog(showloading(), barrierDismissible: false);
    print('-------------------bayar hutang local---------------------');
    //var select = list_hutang_detaillocal.where((e) => e.idHutang == id).first;
    var ss = list_hutanglocal.where((e) => e.id == id).first;
    print('jumlah hutang--------------------------------------.>');
    print(ss.hutang);
    var sisa = ss.hutang! - jumlahbayarhutang.value;

    var hutang = await DBHelper().INSERT(
        'hutang_detail_local',
        DataHutangDetail(
                aktif: 'Y',
                sync: 'N',
                tglHutang: ss.tglHutang,
                idPelanggan: ss.idPelanggan,
                idToko: ss.idToko,
                idHutang: ss.id,
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
                hutang: sisa,
                id: ss.id,
                status: 2)
            .toMapForDb(),
        id: ss.id);

    print('sisa------------------------------------>');
    print(sisa);

    await fetchDataHutangDetaillocal(id_toko);
    await fetchDataHutanglocal(id_toko);
    var con = Get.find<historyController>();
    await con.fetchPenjualanlocal(id_toko);
    Get.find<pelangganController>().fetchDataPelangganlocal(id_toko);
    Get.find<pelangganController>().fetchstatusPelangganlocal(id_toko);
    var selectv2 = list_hutang_detaillocal.where((e) => e.idHutang == id).first;
    var ssv2 = list_hutanglocal.where((e) => e.id == id).first;

    var pp = con.penjualan_list_local.where((e) => e.idHutang == ssv2.id).first;
    if (selectv2.sisa! <= 0) {
      await DBHelper().UPDATE(
          table: 'hutang_detail_local',
          id: selectv2.id,
          data: DataHutangDetail(
            id: selectv2.id,
            aktif: 'Y',
            sync: 'N',
            tglHutang: ssv2.tglHutang,
            idPelanggan: ssv2.idPelanggan,
            idToko: ssv2.idToko,
            idHutang: ssv2.id,
            bayar: jumlahbayarhutang.value,
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
                  id: ssv2.id,
                  status: 1)
              .toMapForDb(),
          id: ssv2.id);

      var penjualan = await DBHelper().UPDATE(
          table: 'penjualan_local',
          data: DataPenjualan(
                  aktif: 'Y',
                  status: 1,
                  id: pp.id,
                  namaPelanggan: pp.namaPelanggan,
                  sync: 'N',
                  idPelanggan: pp.idPelanggan,
                  idToko: pp.idToko,
                  bayar: pp.bayar,
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
                  idUser: pp.idUser)
              .toMapForDb(),
          id: pp.id);
    }

    print('bayar hutang  local berhasil------------------------------------->');
    await fetchDataHutanglocal(id_toko);
    Get.find<historyController>().fetchPenjualanlocal(id_toko);
    Get.find<pelangganController>().fetchDataPelangganlocal(id_toko);
    Get.find<pelangganController>().fetchstatusPelangganlocal(id_toko);

    bayarhutang.value.clear();
    jumlahbayarhutang.value = 0;
    Get.back(closeOverlays: true);
    Get.showSnackbar(toast()
        .bottom_snackbar_success('Sukses', 'Pembayaran hutang berhasil'));
  }

  var jumlahbayarhutang = 0.obs;
  final nominal = NumberFormat("#,##0");

  bayarhutangpop(int id, hutang) {
    Get.dialog(AlertDialog(
      title: header(
        title: 'Bayar hutang',
        icon: FontAwesomeIcons.dollarSign,
        icon_color: color_template().primary,
      ),
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
                    Text('Sisa hutang : ' +
                        'Rp.' +
                        nominal.format(int.parse(hutang))),
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
                    button_solid_custom(
                        onPressed: () {
                          if (bayarhutang.value.text.isEmpty) {
                            Get.showSnackbar(toast().bottom_snackbar_error(
                                'Gagal', 'masukan jumlah bayar'));
                          } else {
                            bayarHutanglocal(id);
                          }
                        },
                        child: Text(
                          'Bayar',
                          style: font().primary_white,
                        ),
                        width: context.width_query,
                        height: context.height_query / 11),
                    SizedBox(
                      height: 10,
                    ),
                    button_border_custom(
                        onPressed: () {
                          Get.back();
                        },
                        child: Text(
                          'Batal',
                          style: font().primary,
                        ),
                        width: context.width_query,
                        height: context.height_query / 11)
                  ],
                )),
          );
        },
      ),
    ));
  }
}
