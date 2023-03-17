import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rims_waserda/Views/beban/beban.dart';
import 'package:rims_waserda/Views/history/history.dart';

import '../../Views/Dashboard/dashboard.dart';
import '../../Views/kasir/kasir.dart';
import '../../Views/produk/produk.dart';
import '../../Views/tambah_user/tambah_user.dart';

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
