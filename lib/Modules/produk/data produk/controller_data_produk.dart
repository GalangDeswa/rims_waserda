import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rims_waserda/Models/produkv2.dart';

class produkController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    //getprodukall();
    //check_conn.check();
    Get.snackbar('sukses', 'produk controller init');

    print('produk controller--------------------------------------->');
  }

  var formKey = GlobalKey<FormState>();
  var loading = true.obs;
  var produk_list = <ProdukElement>[].obs;

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
