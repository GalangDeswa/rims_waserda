import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:rims_waserda/Modules/produk/jenis%20produk/model_jenisproduk.dart';

import '../../../Services/handler.dart';
import '../../../db_helper.dart';
import '../../Widgets/loading.dart';
import '../../Widgets/toast.dart';
import '../../kasir/controller_kasir.dart';
import '../data produk/controller_data_produk.dart';

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

  jenisEditlocal() async {
    print('-------------------edit Produk local---------------------');

    Get.dialog(const showloading(), barrierDismissible: false);

    var query = await DBHelper().UPDATE(
        table: 'produk_jenis_local',
        data: DataJenis(
                aktif: 'Y',
                idLocal: data.idLocal,
                sync: 'N',
                idToko: id_toko,
                namaJenis: nama_jenis.value.text,
                id: data.id)
            .toMapForDb(),
        id: data.idLocal);
    print('edit local berhasil------------------------------------->');
    print(query);
    if (query == 1) {
      await Get.find<produkController>().fetchjenislocal(id_toko);
      await Get.find<kasirController>().fetchjenislocal(id_toko);
      Get.back(closeOverlays: true);
      Get.showSnackbar(
          toast().bottom_snackbar_success('sukses', 'Produk berhasil diedit'));
    } else {
      Get.back(closeOverlays: true);
      Get.showSnackbar(
          toast().bottom_snackbar_error('error', 'gagal edit data local'));
    }

    // if (add != null) {
    //   print(add);
    //   await Get.find<produkController>().fetchProduk();
    //   Get.back();
    // }
  }

  jenisEdit() async {
    print('-------------------edit jenis---------------------');

    Get.dialog(const showloading(), barrierDismissible: false);
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
