import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rims_waserda/Modules/beban/data%20beban/view_beban_base.dart';
import 'package:rims_waserda/Modules/user/data%20user/view_data_user_base.dart';

import '../dashboard/view_dashboard_base.dart';
import '../history/view_history_base.dart';
import '../kasir/view_kasir_basev2.dart';
import '../laporan/view_laporan_base.dart';
import '../produk/data produk/view_produk_base.dart';

class base_menuController extends GetxController {
  List<Widget> views = const [
    dashboard(),
    kasirv2(),
    produk(),
    beban(),
    data_user(),
    history(),
    laporan(),
  ];
  var selectedIndex = 0.obs;
  var extended = false.obs;

  var scaffoldKey = GlobalKey<ScaffoldState>().obs;

  void openDrawer() {
    scaffoldKey.value.currentState!.openEndDrawer();
  }

  void closeDrawer() {
    scaffoldKey.value.currentState!.openEndDrawer();
  }
}
