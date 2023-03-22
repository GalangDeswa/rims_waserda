import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:rims_waserda/Modules/user/data%20user/controller_data_user.dart';
import 'package:rims_waserda/Services/handler.dart';

import '../../Widgets/loading.dart';

class tambah_userController extends GetxController {
  var password = TextEditingController().obs;
  var nama = TextEditingController().obs;
  var alamat = TextEditingController().obs;
  var hp = TextEditingController().obs;
  var email = TextEditingController().obs;
  var formKey = GlobalKey<FormState>().obs;

  List role = ['Pilih Role', 'Kasir', 'Admin'].obs;

  var roleval = 0.obs;

  var token = GetStorage().read('token');
  var id_toko = GetStorage().read('id_toko');
  var id_user = GetStorage().read('id_user');

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

// Future<dynamic> tambahuser() async {
//   Get.dialog(
//       Center(
//         child: CircularProgressIndicator(),
//       ),
//       barrierDismissible: false);
//   var checkconn = await check_conn.check();
//   if (checkconn == true) {
//     var response = await api().client.post(link().POST_tambahpelanggan,
//         body: ({
//           'nomor_identitas': nomor_iden.value.text,
//           'nama_pelanggan': nama.value.text,
//           'alamat_pelanggan': alamat.value.text,
//           'no_hp': hp.value.text,
//           'email': email.value.text,
//         }));
//     if (response != null) {
//       var hasil = json.decode(response.body);
//       if (hasil['message'] == 'berhasil') {
//         print(
//             '-----------------------------user add--------------------------');
//         Get.back();
//         Get.snackbar('sukses', 'user di tambah');
//
//         return hasil;
//       } else {
//         Get.back();
//         print(hasil['message']);
//         Get.snackbar(
//           "Error",
//           hasil['message'],
//           icon: Icon(Icons.error, color: Colors.white),
//           snackPosition: SnackPosition.BOTTOM,
//           backgroundColor: Colors.red,
//           borderRadius: 20,
//           margin: EdgeInsets.all(15),
//           colorText: Colors.white,
//           duration: Duration(seconds: 4),
//           isDismissible: true,
//           dismissDirection: DismissDirection.horizontal,
//           forwardAnimationCurve: Curves.elasticInOut,
//           reverseAnimationCurve: Curves.easeOut,
//         );
//       }
//     } else {
//       Get.back();
//       Get.snackbar('gagal', 'chek kon');
//     }
//   } else {
//     Get.back();
//     Get.snackbar('gagal', 'chek koneksi');
//   }
// }

  tambahuser() async {
    Get.dialog(loading(), barrierDismissible: false);
    var checkconn = await check_conn.check();
    if (checkconn == true) {
      var user = await REST.userTambah(
          token,
          id_toko,
          id_user.toString(),
          nama.value.text,
          email.value.text,
          password.value.text,
          roleval.value.toString(),
          hp.value.text);
      if (user != null) {
        print(user);

        Get.back(closeOverlays: true, result: user);
        Get.snackbar(
          "Berhasil",
          "Data user ditambah",
          icon: Icon(Icons.check_box, color: Colors.white),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.blueAccent,
          borderRadius: 20,
          margin: EdgeInsets.all(15),
          colorText: Colors.white,
          duration: Duration(seconds: 4),
          isDismissible: true,
          dismissDirection: DismissDirection.horizontal,
          forwardAnimationCurve: Curves.elasticInOut,
          reverseAnimationCurve: Curves.easeOut,
        );
      } else {
        Get.back(closeOverlays: true);
        Get.snackbar(
          "Error",
          "Data user gagal,user error",
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
        "Data user gagal,koneksi tidak ada",
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
  }
}
