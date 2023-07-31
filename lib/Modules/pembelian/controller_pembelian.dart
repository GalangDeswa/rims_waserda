import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:rims_waserda/Modules/pembelian/view_hutang_pembelian_table.dart';
import 'package:rims_waserda/Modules/pembelian/view_pembelian_table.dart';

class pembelianController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  var selectedIndex = 0.obs;

  List<Widget> table = [
    pembelian_table(),
    hutang_pembelian_table(),
  ];
}
