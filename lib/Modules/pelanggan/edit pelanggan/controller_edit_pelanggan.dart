import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:rims_waserda/Modules/pelanggan/data%20pelanggan/controller_data_pelanggan.dart';

import '../../../Services/handler.dart';
import '../../../db_helper.dart';
import '../../Widgets/loading.dart';
import '../../Widgets/toast.dart';
import '../../dashboard/controller_dashboard.dart';
import '../../kasir/controller_kasir.dart';
import '../data pelanggan/model_data_pelanggan.dart';
import '../hutang/controller_hutang.dart';

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

  editpelangganlocal() async {
    print('-------------------edit pelanggan local---------------------');

    Get.dialog(showloading(), barrierDismissible: false);

    var query = await DBHelper().UPDATE(
        table: 'pelanggan_local',
        data: DataPelanggan(
                id: data.id,
                idLocal: data.idLocal,
                idToko: int.parse(id_toko),
                namaPelanggan: nama_pelanggan.value.text,
                noHp: no_hp.value.text,
                sync: 'N',
                aktif: 'Y')
            .toMapForDb(),
        id: data.idLocal);
    print('edit local berhasil------------------------------------->');
    print(query);
    if (query == 1) {
      await Get.find<pelangganController>().fetchDataPelangganlocal(id_toko);
      await Get.find<kasirController>().fetchDataPelangganlocal(id_toko);
      await Get.find<hutangController>().fetchDataHutanglocal(id_toko);
      await Get.find<dashboardController>().loadpelanggantotal();
      Get.back(closeOverlays: true);
      Get.showSnackbar(toast()
          .bottom_snackbar_success('sukses', 'Pelanggan berhasil diedit'));
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
