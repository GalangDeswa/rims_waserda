import 'dart:convert';
import 'dart:math';

import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:rims_waserda/Views/produk/produk.dart';

import '../Models/kategori.dart';
import '../Models/produk.dart';
import '../Models/produkv2.dart';
import '../Models/supliyer.dart';
import '../Models/testmodel.dart';

class check_conn {
  static Future<bool> check() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      Get.snackbar('conn', 'mobile');
      // try {
      // final result = await InternetAddress.lookup("www.google.com");
      // if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      //   print('connected');
      return true;
      // }
      // } on SocketException catch (_) {
      //   print('not connected');
      //   AppAlert.getOnlyAlert(FAILED, CANNOT_ACCESS_WEB);
      // }
    } else if (connectivityResult == ConnectivityResult.wifi) {
      Get.snackbar('conn', 'wifi');
      // try {
      // final result = await InternetAddress.lookup("www.google.com");
      // if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      //   print('connected');
      return true;
      // }
      // } on SocketException catch (_) {
      //   print('not connected');
      //   AppAlert.getOnlyAlert(FAILED, CANNOT_ACCESS_WEB);
      // }
    } else {
      // AppAlert.getOnlyAlert(FAILED, NO_INTERNET_CONNECTION);
      Get.snackbar("Gagal", "Kesalahan Jaringan");
      //     backgroundColor: AppColor.APP_BUTTON, colorText: Colors.white);

    }
    return false;
  }
}

class link {
  final String api = 'https://rimswaserdaapi.herokuapp.com/';
  final Uri GET_kategori =
      Uri.parse('http://192.168.100.33:8000/api/show_kategori');
  final Uri GET_supliyer =
      Uri.parse('http://192.168.100.33:8000/api/show_supliyer');
  final Uri GET_produk =
      Uri.parse('http://192.168.100.33:8000/api/show_produk');
  final Uri POST_produk =
      Uri.parse('http://192.168.100.33:8000/api/tambah_produk');
  final Uri POST_foto_multi =
      Uri.parse('http://192.168.100.33:8000/api/tambah_foto_multi');
  final Uri GET_produkv2 =
  Uri.parse('http://192.168.100.33/waserda/waserda/getall');
}

class api extends GetConnect {
  var client = http.Client();


  static Future<List<Produk>> getproduk() async {
    var error = 'error';

    var response = await api().client.get(link().GET_produkv2);
    if (response.statusCode == 200) {
      var hasil = jsonDecode(response.body);
      var res = Produk.fromJson(hasil);
      return res;
    } else {
      return [];
    }
  }


}
