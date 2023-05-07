import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:rims_waserda/Modules/beban/data%20beban/view_beban_base.dart';
import 'package:rims_waserda/Modules/dashboard/view_dashboard_base_v2.dart';
import 'package:rims_waserda/Modules/pelanggan/data%20pelanggan/view_data_pelanggan_base.dart';
import 'package:rims_waserda/Modules/user/data%20user/view_data_user_base.dart';

import '../../Services/handler.dart';
import '../Widgets/toast.dart';
import '../history/view_history_base.dart';
import '../kasir/controller_kasir.dart';
import '../kasir/view_kasir_basev2.dart';
import '../laporan/view_laporan_base.dart';
import '../produk/data produk/view_produk_base.dart';

class base_menuController extends GetxController {
  @override
  Future<void> onInit() async {
    // TODO: implement onInit
    super.onInit();
    namauser.value = GetStorage().read('namec') ?? 'user';
    namatoko.value = GetStorage().read('nama_toko') ?? 'toko';
    token.value = await GetStorage().read('token');
    await getlayout();
    print('--------------------------- kasit layout index');
    print(layoutIndex.value);
  }

  var token = ''.obs;

  List<Widget> views = const [
    dashboard_v2(),
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

  var namauser = ''.obs;
  var namatoko = ''.obs;

  int getlayout() {
    if (Get.find<kasirController>().layout.value == true) {
      var truex = layoutIndex.value = 0;
      return truex;
    } else if (Get.find<kasirController>().layout.value == false) {
      var falsex = layoutIndex.value = 1;
      return falsex;
    } else {
      return 10;
    }
  }

  var scaffoldKey = GlobalKey<ScaffoldState>().obs;

  void openDrawer() {
    scaffoldKey.value.currentState!.openEndDrawer();
  }

  void closeDrawer() {
    scaffoldKey.value.currentState!.openEndDrawer();
  }

  logout() async {
    print('-------------------fetchProdukbyjenis---------------------');

    var checkconn = await check_conn.check();
    if (checkconn == true) {
      var logout = await REST.logout(token.value);
      if (logout != null) {
        print('-----------------logout--------------');
        print(logout);

        await GetStorage().remove('name');
        await GetStorage().remove('email');
        await GetStorage().remove('id_toko');
        await GetStorage().remove('token');
        await GetStorage().remove('id_user');
        await GetStorage().remove('pendapatan');
        await GetStorage().remove('beban');
        await GetStorage().remove('konten_banner');
        await GetStorage().remove('produk');
        await GetStorage().remove('jenis');
        await GetStorage().remove('nama_toko');
        await GetStorage().remove('jenis_toko');
        await GetStorage().remove('alamat_toko');
        await GetStorage().remove('email_toko');
        await GetStorage().remove('logo_toko');
        Get.offAllNamed('/login');
      } else {
        // Get.back(closeOverlays: true);
        Get.showSnackbar(
            toast().bottom_snackbar_error('Error', 'Terjadi kesalahan'));
      }
    } else {
      Get.back(closeOverlays: true);
      Get.showSnackbar(
          toast().bottom_snackbar_error('Error', 'Periksa koneksi'));
    }
    return [];
  }
}
