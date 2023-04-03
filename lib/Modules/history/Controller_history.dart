import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:rims_waserda/Modules/Widgets/loading.dart';
import 'package:rims_waserda/Modules/history/model_penjualan.dart';

import '../../Services/handler.dart';
import '../Widgets/toast.dart';

class historyController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchPenjualan();
  }

  var penjualan_list = <DataPenjualan>[].obs;

  var detail_list = <DataPenjualan>[].obs;
  var id_kas = TextEditingController().obs;
  var id_user = GetStorage().read('id_user');
  var token = GetStorage().read('token');
  var id_toko = GetStorage().read('id_toko');

  fetchPenjualan() async {
    print('-------------------fetch penjualan---------------------');

    var checkconn = await check_conn.check();
    if (checkconn == true) {
      var penjualan = await REST.penjualanData(token, id_user, id_toko);
      if (penjualan != null) {
        print('-------------------data penjualan--------------------');
        var dataPenjualan = ModelPenjualan.fromJson(penjualan);

        penjualan_list.value = dataPenjualan.data;

        //update();
        print('--------------------list penjualan---------------');
        print(penjualan_list);

        // Get.back(closeOverlays: true);

        return penjualan_list;
      } else {
        // Get.back(closeOverlays: true);
        Get.showSnackbar(
            toast().bottom_snackbar_error('Error', 'Gagal fecth penjualan'));
      }
    } else {
      //Get.back(closeOverlays: true);
      Get.showSnackbar(
          toast().bottom_snackbar_error('Error', 'Periksa koneksi'));
    }
    return [];
  }

  fetchPenjualanHariIni() async {
    print('-------------------fetch penjualan hari ini---------------------');

    var checkconn = await check_conn.check();
    if (checkconn == true) {
      var penjualan =
          await REST.penjualanDataHariIni(token, id_user.toString(), id_toko);
      if (penjualan['success'] == true) {
        print('-------------------data penjualan hari ini--------------------');
        var dataPenjualan = ModelPenjualan.fromJson(penjualan);

        penjualan_list.value = dataPenjualan.data;
        penjualan_list.refresh();
        //update();
        print('--------------------list penjualan---------------');
        print(penjualan_list);

        // Get.back(closeOverlays: true);

        return penjualan_list;
      } else {
        penjualan_list.value = [];
        Get.back(closeOverlays: true);
        Get.showSnackbar(
            toast().bottom_snackbar_error('Error', 'Gagal fecth penjualan'));
      }
    } else {
      Get.back(closeOverlays: true);
      Get.showSnackbar(
          toast().bottom_snackbar_error('Error', 'Periksa koneksi'));
    }
    return [];
  }

  reversalPenjualan(String id) async {
    print('-------------------fetch penjualan---------------------');
    Get.dialog(showloading(), barrierDismissible: false);
    var checkconn = await check_conn.check();
    if (checkconn == true) {
      var penjualan = await REST.penjualanReversal(token, id, id_toko);
      if (penjualan != null) {
        print(
            '-------------------reversal penjualan penjualan--------------------');
        await fetchPenjualan();
        Get.back(closeOverlays: true);
        Get.showSnackbar(toast()
            .bottom_snackbar_success('Berhasil', 'Berhasil di reversal'));
      } else {
        Get.back(closeOverlays: true);
        // Get.back(closeOverlays: true);
        Get.showSnackbar(
            toast().bottom_snackbar_error('Error', 'Gagal reversal penjualan'));
      }
    } else {
      Get.back(closeOverlays: true);
      //Get.back(closeOverlays: true);
      Get.showSnackbar(
          toast().bottom_snackbar_error('Error', 'Periksa koneksi'));
    }
  }

// Future<List<HistoryElement>> gethistory(String id) async {
//   var response = await api().client.post(link().POST_gethistory,
//       body: ({
//         'id_kasir': id,
//       }));
//   if (response.statusCode == 200) {
//     var hasil = json.decode(response.body);
//     var res = History.fromJson(hasil);
//     print('--------------------------------------------------------------');
//     print(res);
//     history_list.value = res.history;
//     return history_list;
//   } else {
//     return [];
//   }
// }
}
