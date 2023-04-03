import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:rims_waserda/Services/handler.dart';

import '../../Widgets/loading.dart';
import 'model_data_user.dart';

class datauserController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    print(
        '-------------------------userdataController INIT-------------------');
    userdata();
    update();

    //userdatav2();
  }

  reload() {
    //userdata();
    print('-----------------reload------------');
    onInit();
    // listUser.refresh();
  }

  var listUser = <DataUser>[].obs;
  var token = GetStorage().read('token');
  var id_toko = GetStorage().read('id_toko');

  Future<List<DataUser>> userdata() async {
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
        //listUser.value.clear();
        listUser.value = dataUser.data;
        //listUser.refresh();
        update();
        print('--------------------list user---------------');
        print(listUser);

        Get.back(closeOverlays: true);

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

  var password = TextEditingController().obs;
  var nama = TextEditingController().obs;
  var alamat = TextEditingController().obs;
  var hp = TextEditingController().obs;
  var email = TextEditingController().obs;
  var formKey = GlobalKey<FormState>().obs;

  List role = ['Pilih Role', 'Kasir', 'Admin'].obs;

  var roleval = 0.obs;

  //var token = GetStorage().read('token');
  //var id_toko = GetStorage().read('id_toko');
  var id_user = GetStorage().read('id_user');

  tambahuser() async {
    Get.dialog(showloading(), barrierDismissible: false);
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
        await userdata();
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

  deleteuser(String id) async {
    Get.dialog(
      showloading(),
      barrierDismissible: false,
    );
    var checkconn = await check_conn.check();
    if (checkconn == true) {
      var user = await REST.userDelete(token, id_toko, id);
      if (user != null) {
        print(user);
        //get.back close overlay otomatis close dan back page sebelumnya?
        await userdata();
        Get.back(closeOverlays: true);

        Get.snackbar(
          "Berhasil",
          "user di hapus",
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
