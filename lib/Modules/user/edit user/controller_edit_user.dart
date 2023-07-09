import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../Services/handler.dart';
import '../../Widgets/loading.dart';
import '../../Widgets/toast.dart';
import '../data user/controller_data_user.dart';

class edituserController extends GetxController {
  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    print('-----------------on ready--------------');
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    nama.value = TextEditingController(text: data.nama);
    email.value = TextEditingController(text: data.email);
    hp.value = TextEditingController(text: data.hp);
    //getdata(xxx);

    print('----------------editusercontoller argument------------');
    print(data.id);
    print(data.nama);
    print(data.email);
    print(data.hp);
  }

  var data = Get.arguments;

  tes() {
    print('---------------csdvwehcbwkjegwygfwkeuf---------------');
  }

  //var xxx = Get.arguments;
  var namastring = ''.obs;
  var passwordlama = TextEditingController().obs;
  var password = TextEditingController().obs;
  var confirmpassword = TextEditingController().obs;
  var nama = TextEditingController().obs;
  var alamat = TextEditingController().obs;
  var hp = TextEditingController().obs;
  var email = TextEditingController().obs;
  var formKeyedituser = GlobalKey<FormState>().obs;

  var show = true.obs;
  var showkon = true.obs;

  List role = ['Pilih Role', 'Kasir', 'Admin'].obs;

  var roleval = 0.obs;

  var token = GetStorage().read('token');
  var id_toko = GetStorage().read('id_toko');
  var id_user = GetStorage().read('id_user');

  edituser() async {
    Get.dialog(
      showloading(),
      barrierDismissible: false,
    );
    var checkconn = await check_conn.check();
    if (checkconn == true) {
      var user = await REST.userEdit(token, id_toko, data.id, id_user,
          nama.value.text, email.value.text, hp.value.text);
      if (user != null) {
        print(user);
        //get.back close overlay otomatis close dan back page sebelumnya?
        await Get.find<datauserController>().userdata();
        Get.back(closeOverlays: true);

        Get.showSnackbar(
            toast().bottom_snackbar_success('Sukses', 'User behasil diedit'));
      } else {
        Get.back(closeOverlays: true);
        Get.showSnackbar(
            toast().bottom_snackbar_error('Gagal', 'User gagal diedit'));
      }
    } else {
      Get.back(closeOverlays: true);
      Get.showSnackbar(
          toast().bottom_snackbar_error('Gagal', 'Periksa konensi internet'));
    }
  }

  edituserpassword() async {
    Get.dialog(
      showloading(),
      barrierDismissible: false,
    );
    var checkconn = await check_conn.check();
    if (checkconn == true) {
      var user = await REST.userEditPassword(
          token, id_toko, data.id, id_user, password.value.text);
      if (user != null) {
        print(user);
        await Get.find<datauserController>().userdata();
        Get.back(closeOverlays: true);

        Get.showSnackbar(toast()
            .bottom_snackbar_success('Sukses', 'Password berhasil diganti'));
      } else {
        Get.back(closeOverlays: true);
        Get.showSnackbar(
            toast().bottom_snackbar_error('Gagal', 'Password gagal diganti'));
      }
    } else {
      Get.back(closeOverlays: true);
      Get.showSnackbar(
          toast().bottom_snackbar_error('Gagal', 'Periksa koneksi internet'));
    }
  }
}
