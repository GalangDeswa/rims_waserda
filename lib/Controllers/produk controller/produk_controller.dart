import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';
import 'package:rims_waserda/Models/produkv2.dart';
import 'package:rims_waserda/Models/testmodel.dart';

import '../../Services/api.dart';

class produkController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getproduk();
    //check_conn.check();
    Get.snackbar('sukses', 'produk controller init');


    print('produk controller--------------------------------------->');
  }

  var formKey = GlobalKey<FormState>();
  var loading = true.obs;
  var produk_list = <Produk>[].obs;

  void getproduk() async {
    try {
      loading(true);
      var checkconn = await check_conn.check();
      if (checkconn == true) {
        var produk = await api.getproduk();
        if (produk != null) {
          produk_list.value = produk;
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
