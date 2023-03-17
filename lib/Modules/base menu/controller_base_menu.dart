import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rims_waserda/Modules/beban/view_beban.dart';

import '../dashboard/view_dashboard_base.dart';
import '../history/view_history_base.dart';
import '../kasir/view_kasir_base.dart';
import '../produk/data produk/view_produk_base.dart';
import '../user/tambah user/view_tambah_user_base.dart';

class base_menuController extends GetxController {
  List<Widget> views = const [
    dashboard(),
    kasir(),
    produk(),
    beban(),
    tambah_user(),
    history(),
  ];
  var selectedIndex = 0.obs;
  var extended = false.obs;

// List<GetPage<dynamic>> route = [
//   GetPage(name: "/login", page: () => login(), binding: loginBinding()),
//   GetPage(
//       name: "/base_menu",
//       page: () => base_menu(),
//       binding: base_menuBinding()),
//   GetPage(
//       name: "/dashboard",
//       page: () => dashboard(),
//       binding: dashboardBinding()),
//   GetPage(name: "/kasir", page: () => kasir(), binding: kasirBinding()),
// ];
}
