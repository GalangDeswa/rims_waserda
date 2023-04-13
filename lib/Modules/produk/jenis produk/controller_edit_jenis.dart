import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../Services/handler.dart';
import '../../Widgets/loading.dart';
import '../../Widgets/toast.dart';

class editjenisController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    nama_jenis.value = TextEditingController(text: data.namaJenis);
    print('------------edit jenis-----------');
    print(data.namaJenis);
    print(data.id.toString());
  }

  var formKeyjenis = GlobalKey<FormState>().obs;
  var data = Get.arguments;
  var nama_jenis = TextEditingController().obs;
  var id_user = GetStorage().read('id_user');
  var token = GetStorage().read('token');
  var id_toko = GetStorage().read('id_toko');

  var totalpage = 0.obs;
  var totaldata = 0.obs;
  var currentpage = 0.obs;
  var nextpage;
  var count = 0.obs;

  var nextdata;
  var previouspage;
  var perpage = 0.obs;

  jenisEdit() async {
    print('-------------------edit jenis---------------------');

    Get.dialog(showloading(), barrierDismissible: false);
    var checkconn = await check_conn.check();
    if (checkconn == true) {
      var jenis = await REST.produkJenisedit(
          token, data.id.toString(), id_toko, nama_jenis.value.text);
      if (jenis != null) {
        print(jenis);
        Get.back(closeOverlays: true, result: true);
        Get.showSnackbar(toast()
            .bottom_snackbar_success('Berhasil', 'jenis Berhasil diedit'));
      } else {
        Get.back(closeOverlays: true);
        Get.showSnackbar(
            toast().bottom_snackbar_error('Error', 'jenis Gagal diedit'));
      }
    } else {
      Get.back(closeOverlays: true);
      Get.showSnackbar(
          toast().bottom_snackbar_error('Error', 'Periksa Koneksi Internet'));
    }
    return [];
  }
}
