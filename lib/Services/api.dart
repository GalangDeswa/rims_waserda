import 'dart:math';

import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;
import 'package:connectivity_plus/connectivity_plus.dart';

import '../Models/kategori.dart';
import '../Models/produk.dart';
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
}

class api extends GetConnect {
  var client = http.Client();
  static Future<List<Product>> getproduct() async {
    var error = 'error';
    var response = await api().client.get(Uri.parse(
        'http://makeup-api.herokuapp.com/api/v1/products.json?brand=maybelline'));
    if (response.statusCode == 200) {
      var jsonstring = response.body;
      var hasil = productFromJson(jsonstring);
      return hasil;
    } else {
      return [];
    }
  }

  static Future<List<Kategeori>> get_kategori() async {
    var error = 'error';
    final String get_kategori = "http://192.168.100.33:8000/api/show_kategori";
    var response = await api().client.get(link().GET_kategori);
    if (response.statusCode == 200) {
      var jsonstring = response.body;
      var hasil_kat = kategeoriFromJson(jsonstring);
      return hasil_kat;
    } else {
      return [];
    }
  }

  static Future<List<Supliyer>> get_suplier() async {
    var error = 'error';
    final String get_kategori = "http://192.168.100.33:8000/api/show_supliyer";
    var response = await api().client.get(link().GET_supliyer);
    if (response.statusCode == 200) {
      var jsonstring = response.body;
      var hasil_supliyer = supliyerFromJson(jsonstring);
      return hasil_supliyer;
    } else {
      return [];
    }
  }

  static Future<List<Barang>> get_barang() async {
    var error = 'error';
    final String get_kategori = "http://192.168.100.33:8000/api/show_produk";
    var response = await api().client.get(link().GET_produk);
    if (response.statusCode == 200) {
      var jsonstring = response.body;
      var hasil_barang = barangFromJson(jsonstring);
      return hasil_barang;
    } else {
      return [];
    }
  }
}
