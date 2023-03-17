import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Services/api.dart';

class tambah_userController extends GetxController {
  var nomor_iden = TextEditingController().obs;
  var nama = TextEditingController().obs;
  var alamat = TextEditingController().obs;
  var hp = TextEditingController().obs;
  var email = TextEditingController().obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  Future<dynamic> tambahuser() async {
    Get.dialog(
        Center(
          child: CircularProgressIndicator(),
        ),
        barrierDismissible: false);
    var checkconn = await check_conn.check();
    if (checkconn == true) {
      var response = await api().client.post(link().POST_tambahpelanggan,
          body: ({
            'nomor_identitas': nomor_iden.value.text,
            'nama_pelanggan': nama.value.text,
            'alamat_pelanggan': alamat.value.text,
            'no_hp': hp.value.text,
            'email': email.value.text,
          }));
      if (response != null) {
        var hasil = json.decode(response.body);
        if (hasil['message'] == 'berhasil') {
          print(
              '-----------------------------user add--------------------------');
          Get.back();
          Get.snackbar('sukses', 'user di tambah');

          return hasil;
        } else {
          Get.back();
          print(hasil['message']);
          Get.snackbar(
            "Error",
            hasil['message'],
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
        Get.back();
        Get.snackbar('gagal', 'chek kon');
      }
    } else {
      Get.back();
      Get.snackbar('gagal', 'chek koneksi');
    }
  }
}
