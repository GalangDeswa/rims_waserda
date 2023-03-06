import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rims_waserda/Views/history/history.dart';
import 'package:rims_waserda/jsontest.dart';

import '../../Views/Dashboard/dashboard.dart';
import '../../Views/Login/login.dart';
import '../../Views/base_menu/base_menu.dart';
import '../../Views/kasir/kasir.dart';
import '../../Views/produk/produk.dart';
import '../../Views/tambah_stock/tambah_stock.dart';
import '../../Views/tambah_user/tambah_user.dart';
import '../dashboard controller/dashboard_binding.dart';
import '../kasir controller/kasir_binding.dart';
import '../login controller/login_binding.dart';
import 'base_menu_binding.dart';

class base_menuController extends GetxController {
  List<Widget> views = const [
    dashboard(),
    kasir(),
    tambah_user(),
    tambah_stock(),
    produk(),
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
