import 'package:get/get.dart';
import 'package:rims_waserda/Modules/history/controller_detail_penjualan.dart';
import 'package:rims_waserda/Modules/pelanggan/data%20pelanggan/controller_data_pelanggan.dart';
import 'package:rims_waserda/Modules/pembelian/view_pembelian_table.dart';
import 'package:rims_waserda/Modules/produk/jenis%20produk/controller_edit_jenis.dart';
import 'package:rims_waserda/Modules/user/toko/controller_edit_tokov2.dart';

import '../beban/data beban/controller_beban.dart';
import '../dashboard/controller_dashboard.dart';
import '../history/Controller_history.dart';
import '../kasir/controller_kasir.dart';
import '../laporan/Controller_laporan.dart';
import '../pelanggan/hutang/controller_hutang.dart';
import '../pelanggan/hutang/controller_hutang_detail.dart';
import '../pembelian/controller_pembelian.dart';
import '../produk/data produk/controller_data_produk.dart';
import '../user/data user/controller_data_user.dart';
import '../user/edit user/controller_edit_user.dart';
import '../user/tambah user/controller_tambah_user.dart';
import 'controller_base_menu.dart';

class base_menuBinding extends Bindings {
  @override
  void dependencies() {
    //get.put = langsung aktif, destroy setelah page di buang
    //get.lazyput = hanya aktif ketika page mintak controller, tidak di buat lagi meskipun page di buang, fenix = true untuk buat lagi kalok page di buang
    Get.lazyPut<base_menuController>(() => base_menuController());
    Get.lazyPut<dashboardController>(() => dashboardController());
    Get.lazyPut<kasirController>(() => kasirController());
    Get.lazyPut<tambah_userController>(() => tambah_userController(),
        fenix: true);
    // Get.lazyPut<tambah_stockController>(() => tambah_stockController());
    // Get.lazyPut<tambah_produkController>(() => tambah_produkController());
    Get.lazyPut<produkController>(() => produkController(), fenix: true);
    Get.lazyPut<historyController>(() => historyController(), fenix: true);
    Get.lazyPut<bebanController>(() => bebanController(), fenix: true);
    Get.lazyPut<datauserController>(() => datauserController(), fenix: true);

    Get.lazyPut<edituserController>(() => edituserController(), fenix: true);
    Get.lazyPut<editbebanController>(() => editbebanController(), fenix: true);
    Get.lazyPut<editjenisController>(() => editjenisController(), fenix: true);
    Get.lazyPut<laporanController>(() => laporanController());
    Get.lazyPut<detailpenjualanController>(() => detailpenjualanController(),
        fenix: true);

    Get.lazyPut<pelangganController>(() => pelangganController(), fenix: true);

    Get.lazyPut<hutangController>(() => hutangController(), fenix: true);
    Get.lazyPut<hutang_detailController>(() => hutang_detailController(),
        fenix: true);
    Get.lazyPut<edittokov2Controller>(() => edittokov2Controller(),
        fenix: true);
    Get.lazyPut<pembelianController>(() => pembelianController(), fenix: true);
  }
}
