import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:rims_waserda/Modules/pelanggan/data%20pelanggan/controller_data_pelanggan.dart';

import '../../../Services/handler.dart';
import '../../Widgets/loading.dart';
import '../../Widgets/toast.dart';

class editpelangganController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    nama_pelanggan.value = TextEditingController(text: data.namaPelanggan);
    no_hp.value = TextEditingController(text: data.noHp);
  }

  var data = Get.arguments;
  var formKeypelanggan = GlobalKey<FormState>().obs;
  var id_user = GetStorage().read('id_user');
  var token = GetStorage().read('token');
  var id_toko = GetStorage().read('id_toko');

  var search = TextEditingController().obs;
  var nama_pelanggan = TextEditingController().obs;
  var no_hp = TextEditingController().obs;

  editpelanggan() async {
    print('-------------------tambah beban---------------------');

    Get.dialog(showloading(), barrierDismissible: false);
    var checkconn = await check_conn.check();
    if (checkconn == true) {
      var edit = await REST.pelangganEdit(
          token, id_toko, data.id, nama_pelanggan.value.text, no_hp.value.text);
      if (edit != null) {
        print(edit);

        //kalok edit gak terupdate ui, karna beda con untuk list di table?
        //solusi : bisa pakek get.find controller yg controller.list nya ada di view
        //bisa get.put juga
        // var con = Get.put(bebanController());
        // await con.fetchDataBeban();
        await Get.find<pelangganController>().fetchDataPelanggan();

        // Get.back(
        //   closeOverlays: true,
        // );
        Get.back(closeOverlays: true);

        Get.showSnackbar(toast()
            .bottom_snackbar_success('Berhasil', 'beban Berhasil di edit'));
      } else {
        Get.back(closeOverlays: true);
        Get.showSnackbar(toast().bottom_snackbar_error('Error', 'hgagal'));
      }
    } else {
      Get.back(closeOverlays: true);
      Get.showSnackbar(
          toast().bottom_snackbar_error('Error', 'Periksa Koneksi Internet'));
    }
    return [];
  }
}
