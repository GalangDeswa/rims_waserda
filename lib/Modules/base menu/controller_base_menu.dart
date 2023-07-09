import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:rims_waserda/Modules/beban/data%20beban/view_beban_base.dart';
import 'package:rims_waserda/Modules/dashboard/view_dashboard_base_v2.dart';
import 'package:rims_waserda/Modules/pelanggan/data%20pelanggan/view_data_pelanggan_base.dart';
import 'package:rims_waserda/Modules/user/data%20user/view_data_user_base.dart';

import '../../Services/handler.dart';
import '../Widgets/toast.dart';
import '../beban/data beban/controller_beban.dart';
import '../history/Controller_history.dart';
import '../history/controller_detail_penjualan.dart';
import '../history/view_history_base.dart';
import '../kasir/controller_kasir.dart';
import '../kasir/view_kasir_basev2.dart';
import '../laporan/view_laporan_base.dart';
import '../pelanggan/data pelanggan/controller_data_pelanggan.dart';
import '../pelanggan/hutang/controller_hutang.dart';
import '../produk/data produk/controller_data_produk.dart';
import '../produk/data produk/view_produk_base.dart';

class base_menuController extends GetxController {
  @override
  Future<void> onInit() async {
    // TODO: implement onInit
    super.onInit();
    namauser.value = GetStorage().read('name') ?? 'user';
    namatoko.value = GetStorage().read('nama_toko') ?? 'toko';
    token.value = await GetStorage().read('token');
    await getlayout();
    print('--------------------------- kasit layout index');
    print(layoutIndex.value);
  }

  var token = ''.obs;
  var id_toko = GetStorage().read('id_toko');
  var id_user = GetStorage().read('id_user');
  var role = GetStorage().read('role');
  var point_loading = 0.0.obs;

  syncAll(id_toko) async {
    try {
      print("id toko---------------------------->");
      print(id_toko);

      print("sync produk jenis---------------------------->");
      await produkController().syncProdukJenis(id_toko);
      point_loading.value = 0.1;

      print("sync produk---------------------------->");
      await produkController().syncProduk(id_toko);
      point_loading.value = 0.2;

      print("sync beban jenis--------------------------->");
      await bebanController().syncBebanKategori(id_toko);
      point_loading.value = 0.3;

      print("sync beban---------------------------->");
      await bebanController().syncBeban(id_toko);
      point_loading.value = 0.5;

      print("sync pelanggan---------------------------->");
      await pelangganController().syncPelanggan(id_toko);
      point_loading.value = 0.6;

      print("sync hutang---------------------------->");
      await hutangController().syncHutang(id_toko);
      point_loading.value = 0.7;

      print("sync hutang detail---------------------------->");
      await hutangController().syncHutangDetail(id_toko);
      point_loading.value = 0.8;

      print("sync penjualan---------------------------->");
      await historyController().syncPenjualan(id_toko);
      point_loading.value = 0.9;

      print("sync penjualan detail---------------------------->");
      await detailpenjualanController().syncPenjualanDetail(id_toko);
      point_loading.value = 1.0;
    } catch (e) {
      Get.back();
      print(e);
      Get.showSnackbar(toast().bottom_snackbar_error('error', e.toString()));
    }
  }

  List<Widget> views_kasir = const [
    dashboard_v2(),
    kasirv2(),
    //produk(),
    beban(),
    // data_user(),
    pelanggan(),
    history(),
    laporan(),
  ];

  List<Widget> views_admin = const [
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

  getlayout() {
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
