import 'dart:convert';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart';
import 'package:rims_waserda/Services/api.dart';

class check_conn {
  static Future<bool> check() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      try {
        final result = await InternetAddress.lookup("www.google.com");
        if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
          print('connected');
          return true;
        }
      } on SocketException catch (_) {
        print('not connected');
        Get.snackbar('Error', 'Tidak bisa mengakses internet');
      }
    } else if (connectivityResult == ConnectivityResult.wifi) {
      Get.snackbar('conn', 'wifi');
      try {
        final result = await InternetAddress.lookup("www.google.com");
        if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
          print('connected');
          return true;
        }
      } on SocketException catch (_) {
        print('not connected');
        Get.snackbar('Error', 'Tidak bisa mengakses internet');
      }
    } else {
      // AppAlert.getOnlyAlert(FAILED, NO_INTERNET_CONNECTION);
      Get.snackbar("Gagal", "tidak ada jaringan");
      //     backgroundColor: AppColor.APP_BUTTON, colorText: Colors.white);
    }
    return false;
  }
}

class REST extends GetConnect {
  static Future<dynamic> login(String email, password) async {
    var response = await post(link().POST_login,
        body: ({
          'email': email,
          'password': password,
        }));
    if (response.statusCode == 200) {
      print('LOGIN network handler----------------------------------------->');
      var data = jsonDecode(response.body);
      //var data = response.body;
      print(data);
      print(response.statusCode);
      return (data);
    } else {
      print('LOGIN network handler----------------------------------------->');
      print('gagal POST LOGIN');
      print(response.statusCode);
      print(response.body);
    }
  }

  static Future<dynamic> loadToko(String token, idtoko) async {
    var response = await post(link().POST_loadtoko,
        body: ({
          'token': token,
          'id_toko': idtoko,
        }));
    if (response.statusCode == 200) {
      print(
          'LOAD TOKO network handler----------------------------------------->');
      var data = json.decode(response.body);
      //var data = response.body;
      print(data);
      print(response.statusCode);
      return (data);
    } else {
      print(
          'LOAD TOKO network handler----------------------------------------->');
      print('gagal POST LOADTOKO');
      print(response.statusCode);
      print(response.body);
    }
  }

  static Future<dynamic> userData(String token, idtoko) async {
    var response = await post(link().POST_userdata,
        body: ({
          'token': token,
          'id_toko': idtoko,
        }));
    if (response.statusCode == 200) {
      print(
          'USER DATA network handler----------------------------------------->');
      var data = json.decode(response.body);
      //var data = response.body;
      print(data);
      print(response.statusCode);
      return (data);
    } else {
      print(
          'USER DATA network handler----------------------------------------->');
      print('gagal USER DATA');
      print(response.statusCode);
      print(response.body);
    }
  }

  static Future<dynamic> userTambah(
      String token, idtoko, iduser, nama, email, password, role, hp) async {
    var response = await post(link().POST_usertambah,
        body: ({
          'token': token,
          'id_toko': idtoko,
          'id_user': iduser,
          'nama': nama,
          'email': email,
          'password': password,
          'role': role,
          'hp': hp,
        }));
    if (response.statusCode == 200) {
      print(
          'USER TAMBAH network handler----------------------------------------->');
      var data = json.decode(response.body);
      //var data = response.body;
      print(data);
      print(response.statusCode);
      return (data);
    } else {
      print(
          'USER TAMBAH network handler----------------------------------------->');
      print('gagal USER TAMBAH');
      print(response.statusCode);
      print(response.body);
    }
  }

  static Future<String> postApi(var body, String endpoint) async {
    var response = await post(api(endpoint), body: body, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      // 'Authorization': GetStorage().read(PREF_TOKEN)
    });
    print('dari network handler----------------------------------------->');
    print(response.body);
    return response.body;
  }

  static Future getApi(String endpoint) async {
    var response = await get(api(endpoint));
    return response.body;
  }

  static Uri api(String endpoint) {
    String host = 'http://192.168.100.33/waserda/waserda/';
    final apikey = host + endpoint;
    return Uri.parse(apikey);
  }

  static void storeToken(String token) async {
    await GetStorage().write('token', token);
  }

  static Future<String?> getToken() async {
    return await GetStorage().read('token');
  }
}
