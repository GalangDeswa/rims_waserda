import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    var toko_user = GetStorage().read('toko_user');
    print("D|LOGIN " + loginStatus.toString());
    if (loginStatus != null) {
      Timer(const Duration(seconds: 2), () {
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
