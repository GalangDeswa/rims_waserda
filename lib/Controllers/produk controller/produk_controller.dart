import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';

import '../../Services/api.dart';

class produkController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    //check_conn.check();
    Get.snackbar('sukses', 'produk controller init');
    print('produk controller--------------------------------------->');
  }

  var formKey = GlobalKey<FormState>();
}
