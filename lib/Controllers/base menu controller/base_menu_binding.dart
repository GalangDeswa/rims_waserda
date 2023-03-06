import 'package:get/get.dart';
import 'package:rims_waserda/jsontestController.dart';

import '../dashboard controller/dashboard_controller.dart';
import '../history controller/historyController.dart';
import '../kasir controller/kasir_controller.dart';
import '../produk controller/produk_controller.dart';
import '../produk controller/tambah_produk_controller.dart';
import '../stock controller/tambah_stock.dart';
import '../supliyer controller/supliyer_controller.dart';
import '../user controller/tambah_user_controller.dart';
import 'base_menu_controller.dart';

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
    Get.lazyPut<suplierController>(() => suplierController());
    Get.lazyPut<jsontestController>(() => jsontestController());
    Get.lazyPut<historyController>(() => historyController());
    /*Get.put(dashboardController());
    Get.put(base_menuController());
    Get.put(kasirController());*/
  }
}
