import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:rims_waserda/Models/produkv2.dart';
import 'package:rims_waserda/Services/handler.dart';

import 'model_produk.dart';

class produkController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    //getprodukall();
    //check_conn.check();
    fetchProduk();
    //Get.snackbar('sukses', 'produk controller init');

    print('produk controller--------------------------------------->');
  }

  var formKey = GlobalKey<FormState>();
  var loading = true.obs;
  var produk_list = <ProdukElement>[].obs;
  var id_user = GetStorage().read('id_user');
  var token = GetStorage().read('token');
  var id_toko = GetStorage().read('id_toko');

  var produklist = <DataProduk>[].obs;

  fetchProduk() async {
    print('-------------------fetchProduk---------------------');

    // SchedulerBinding.instance.addPostFrameCallback(
    //     (_) => Get.dialog(loading(), barrierDismissible: false));
    //call dialog tidak bisa di init tanpa coding di atas

    var checkconn = await check_conn.check();
    if (checkconn == true) {
      var produk = await REST.produkAll(token, id_toko);
      if (produk != null) {
        print('-------------------dataproduk---------------');
        var dataProduk = ModelProduk.fromJson(produk);

        produklist.value = dataProduk.data;
        //listUser.refresh();
        update();
        print('--------------------list user---------------');
        print(produklist);

        Get.back(closeOverlays: true);

        return produklist;
      } else {
        Get.back(closeOverlays: true);
        Get.snackbar(
          "Error",
          "Data user gagal,user tidak ada",
          icon: Icon(Icons.error, color: Colors.white),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          borderRadius: 20,
          margin: EdgeInsets.all(15),
          colorText: Colors.white,
          duration: Duration(seconds: 4),
          isDismissible: true,
          dismissDirection: DismissDirection.horizontal,
          forwardAnimationCurve: Curves.elasticInOut,
          reverseAnimationCurve: Curves.easeOut,
        );
      }
    } else {
      Get.back(closeOverlays: true);
      Get.snackbar(
        "Error",
        "Data user gagal,periksa koneksi",
        icon: Icon(Icons.error, color: Colors.white),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        borderRadius: 20,
        margin: EdgeInsets.all(15),
        colorText: Colors.white,
        duration: Duration(seconds: 4),
        isDismissible: true,
        dismissDirection: DismissDirection.horizontal,
        forwardAnimationCurve: Curves.elasticInOut,
        reverseAnimationCurve: Curves.easeOut,
      );
    }
    return [];
  }

// void getproduk() async {
//   try {
//     loading(true);
//     var checkconn = await check_conn.check();
//     if (checkconn == true) {
//       var produk = await api.getproduk();
//       if (produk != null) {
//         produk_list.value = produk;
//         print("produk controller api ------------------------------------------------");
//         print(produk_list.value);
//       }
//     } else {
//       Get.snackbar('conn', 'tidak ada konenksi');
//     }
//   } finally {
//     loading(false);
//   }
// }

// Future<List<ProdukElement>> getprodukall() async {
//   var response = await api().client.get(link().GET_produkv2);
//   if (response.statusCode == 200) {
//     var hasil = json.decode(response.body);
//     var res = Produk.fromJson(hasil);
//     print('--------------------------------------------------------------');
//     print(res);
//     produk_list.value = res.produk;
//     return produk_list;
//   } else {
//     return [];
//   }
// }
}
