import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rims_waserda/Modules/beban/data%20beban/view_beban_base.dart';
import 'package:rims_waserda/Modules/pelanggan/data%20pelanggan/view_data_pelanggan_base.dart';
import 'package:rims_waserda/Modules/user/data%20user/view_data_user_base.dart';

import '../dashboard/view_dashboard_base.dart';
import '../history/view_history_base.dart';
import '../kasir/controller_kasir.dart';
import '../kasir/view_kasir_basev2.dart';
import '../laporan/view_laporan_base.dart';
import '../produk/data produk/view_produk_base.dart';

class base_menuController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getlayout();
  }

  List<Widget> views = const [
    dashboard(),
    kasirv2(),
    produk(),
    beban(),
    data_user(),
    pelanggan(),
    history(),
    laporan(),
  ];
  var selectedIndex = 0.obs;
  var extended = false.obs;

  var layoutIndex = 0.obs;

  int getlayout() {
    if (Get.find<kasirController>().layout.value = true) {
      return layoutIndex.value = 0;
    } else if (Get.find<kasirController>().layout.value = false) {
      return layoutIndex.value = 1;
    }
    return layoutIndex.value;
  }

  var scaffoldKey = GlobalKey<ScaffoldState>().obs;

  void openDrawer() {
    scaffoldKey.value.currentState!.openEndDrawer();
  }

  void closeDrawer() {
    scaffoldKey.value.currentState!.openEndDrawer();
  }
}
