import 'package:get/get.dart';

import 'package:rims_waserda/jsontestController.dart';

import '../beban/controller_beban.dart';
import '../dashboard/controller_dashboard.dart';
import '../history/Controller_history.dart';
import '../kasir/controller_kasir.dart';
import '../produk/data produk/controller_data_produk.dart';
import '../produk/tambah produk/controller_tambah_produk.dart';
import '../produk/tambah_stock/controller_tambah_stock.dart';
import '../user/tambah user/controller_tambah_user.dart';
import 'controller_base_menu.dart';

class base_menuBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<base_menuController>(() => base_menuController());
    Get.lazyPut<dashboardController>(() => dashboardController());
    Get.lazyPut<kasirController>(() => kasirController());
    Get.lazyPut<tambah_userController>(() => tambah_userController());
    Get.lazyPut<tambah_stockController>(() => tambah_stockController());
    Get.lazyPut<tambah_produkController>(() => tambah_produkController());
    Get.lazyPut<produkController>(() => produkController());
    Get.lazyPut<jsontestController>(() => jsontestController());
    Get.lazyPut<historyController>(() => historyController());
    Get.lazyPut<bebanController>(() => bebanController());
  }
}
