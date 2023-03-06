import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';
import 'package:rims_waserda/Models/dummy.dart';
import 'package:rims_waserda/Services/handler.dart';

import 'Models/produkv2.dart';
import 'Services/api.dart';

class jsontestController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    print(
        '----------------------------- texst json con---------------------------------');
    getprodukall();
    //list();
    //getdummy();
  }

  var loading = true.obs;
  var produk_list = <ProdukElement>[].obs;
  var dummy_list = <Dummy>[].obs;
  var stts = ''.obs;
  //RxMap plist = [].obs;

  Future getprodukall() async {
    var response = await api().client.get(link().GET_produkv2);
    if (response.statusCode == 200) {
      var hasil = json.decode(response.body);
      var res = Produk.fromJson(hasil);
      print('--------------------------------------------------------------');
      print(res.toJson());
      stts.value = res.message;
      produk_list.value = res.produk;
      return produk_list;
    } else {
      return [];
    }
  }

  Future getdummy() async {
    var response = await api().client.get(link().GET_produkv3);
    if (response.statusCode == 200) {
      var hasil = json.decode(response.body);
      var res = Dummy.fromJson(hasil);
      print(
          '---------------------------json test-----------------------------------');
      print(res.toJson());
      //dummy_list.value = hasil;
      return dummy_list;
    } else {
      return [];
    }

    void getproduk() async {
      try {
        loading(true);
        var checkconn = await check_conn.check();
        if (checkconn == true) {
          var produk = await getprodukall();
          if (produk != null) {
            produk_list.value = produk;
            print(
                "produk controller api ------------------------------------------------");
            print(produk_list.value);
          }
        } else {
          Get.snackbar('conn', 'tidak ada konenksi');
        }
      } finally {
        loading(false);
      }
    }
  }
}
