import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:rims_waserda/Services/handler.dart';

import 'model_data_user.dart';

class datauserController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    print('---------------------------userdataController-------------------');
    userdata();
    //userdatav2();
  }

  var listUser = <Datum>[].obs;
  var token = GetStorage().read('token');
  var id_toko = GetStorage().read('id_toko');

  Future<List<Datum>> userdata() async {
    print('-------------------userdata---------------------');

    // SchedulerBinding.instance.addPostFrameCallback(
    //     (_) => Get.dialog(loading(), barrierDismissible: false));
    //call dialog tidak bisa di init tanpa coding di atas

    var checkconn = await check_conn.check();
    if (checkconn == true) {
      var user = await REST.userData(token, id_toko);
      if (user != null) {
        print('-------------------datauser---------------');
        var dataUser = ModelUser.fromJson(user);
        listUser.value = dataUser.data;
        Get.back(closeOverlays: true);
        print('--------------------list user---------------');
        print(listUser);
        return listUser;
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

// Future<List<Datum>> userdatav2() async {
//   var user = await REST.userData(token, id_toko);
//   if (user != null) {
//     print('-------------------datauser---------------');
//     var dataUser = ModelUser.fromJson(user);
//     print(dataUser);
//     print('--------------------------------------------------------------');
//     listUser.value = dataUser.data;
//
//     print(listUser.map((element) => element.nama));
//     return listUser.value;
//   } else {
//     return [];
//   }
// }
}
