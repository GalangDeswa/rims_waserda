import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:rims_waserda/Modules/Widgets/loading.dart';
import 'package:rims_waserda/Modules/history/model_penjualan.dart';

import '../../Services/handler.dart';
import '../Widgets/toast.dart';

class historyController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchPenjualan();
  }

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

  fetchPenjualan() async {
    print('-------------------fetch penjualan---------------------');

    var checkconn = await check_conn.check();
    if (checkconn == true) {
      var penjualan = await REST.penjualanData(token, id_user, id_toko);
      if (penjualan != null) {
        print('-------------------data penjualan--------------------');
        var dataPenjualan = ModelPenjualan.fromJson(penjualan);

        penjualan_list.value = dataPenjualan.data;

        totalpage.value = dataPenjualan.meta.pagination.totalPages;
        totaldata.value = dataPenjualan.meta.pagination.total;
        perpage.value = dataPenjualan.meta.pagination.perPage;
        currentpage.value = penjualan['meta']['pagination']['current_page'];
        count.value = dataPenjualan.meta.pagination.count;
        if (totalpage > 1) {
          nextdata = penjualan['meta']['pagination']['links']['next'];
        }

        //update();
        print('--------------------list penjualan---------------');
        print(penjualan_list);

        // Get.back(closeOverlays: true);

        return penjualan_list;
      } else {
        // Get.back(closeOverlays: true);
        Get.showSnackbar(
            toast().bottom_snackbar_error('Error', 'Gagal fecth penjualan'));
      }
    } else {
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
