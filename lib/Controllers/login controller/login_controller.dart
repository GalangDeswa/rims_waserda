import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:rims_waserda/Services/handler.dart';

import 'package:http/http.dart' as http;

import '../../Models/loginv2.dart';

class loginController extends GetxController {
  List<String> iklan = [
    'assets/animation/30826-online-shopping.json',
    'assets/animation/74384-swipe-for-shopping.json',
    'assets/animation/lf20_4nze9dc4.json',
    'assets/animation/110910-seasonal-shopping-scene.json'
  ].obs;

  var email = TextEditingController().obs;
  var pass = TextEditingController().obs;
  var token = ''.obs;
  var nama = ''.obs;

  var current = 0.obs;
  var body = {"email": "galang@gmail.com", "password": "12345"};

  final loginKey = GlobalKey<FormState>().obs;
  var showpass = false.obs;

  login() async {
    Get.dialog(
        Center(
          child: CircularProgressIndicator(),
        ),
        barrierDismissible: false);
    Loginv2 loginmodel =
        Loginv2(email: email.value.text, password: pass.value.text);
    var response =
        await networkHandler.postApi(loginv2ToJson(loginmodel), 'login');
    var data = json.decode(response);
    print('dari login controller----------------------------------------->');
    // print(data['data']['nama']);
    if (data['accessToken'] != null) {
      networkHandler.storeToken(data['accessToken']);
      GetStorage().write('nama', data['data']['nama']);
      GetStorage().write('email', data['data']['email']);
      GetStorage().write('toko', data['data']['store_id']);
      List toko = data['data']['store_id'];
      if (toko.length > 1) {
        Get.back();
        Get.snackbar('sukses', 'pilih toko');
        print(data['data']['store_id']);
        Get.offAndToNamed('/pilih_toko');
      } else {
        Get.back();
        Get.snackbar('sukses', 'berhasil login');
        Get.offAndToNamed('/base_menu');
      }

      //Get.snackbar('sukses', data['data']['nama']);
      //print(data['data']['store_id']);
      //print(networkHandler.getToken().toString());
    } else {
      Get.back();
      Get.snackbar(
        "Error",
        "Login gagal, Periksa email/password",
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

  /* login() async {
    var url = Uri.parse(link().api + 'login');
    var res = await http.post(url,
        body: {"email": email.value.text, "password": pass.value.text});
    var hasil = jsonDecode(res.body);

    print(hasil);
    print(hasil['token']);
    if (hasil['token'] != null) {
      Get.toNamed('/base_menu');
      return hasil;
    }

    //token = hasil['accessToken'];
    //nama = hasil['data']['nama'];

    */ /*if (token != null) {
      Get.snackbar('success', 'login');
      //savelogin();
      print(token);
      Get.toNamed('/base_menu');
    } else {
      Get.snackbar('error', 'error login');
    }*/ /*
  }*/
}
