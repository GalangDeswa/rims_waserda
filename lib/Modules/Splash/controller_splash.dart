import 'dart:async';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class splashController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    checkLogin();
    print(
        'splash init---------------------------------------------------------->');
  }

  checkLogin() async {
    var loginStatus = GetStorage().read('token');
    var toko_user = GetStorage().read('id_toko');
    print("LOGIN " + loginStatus.toString());
    if (loginStatus != null) {
      Timer(const Duration(seconds: 3), () {
        Get.offAndToNamed('/base_menu');
      }
          //     {
          //   Get.off(const Dashboard());
          // }
          );
    } else {
      Timer(const Duration(seconds: 2), () {
        Get.offAndToNamed('/login');
      });
    }
  }
}
