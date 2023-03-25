import 'dart:convert';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
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
      //Get.snackbar('conn', 'wifi');
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

      //var data = json.decode(response.body);
      //var data = response.body;
      var data = response;
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

  static Future<dynamic> userEdit(
      String token, idtoko, id, iduser, nama, email, hp) async {
    var response = await post(link().POST_useredit,
        body: ({
          'token': token,
          'id_toko': idtoko,
          'id': id.toString(),
          'id_user': iduser.toString(),
          'nama': nama,
          'email': email,
          'hp': hp,
        }));
    if (response.statusCode == 200) {
      print(
          'USER EDIT network handler----------------------------------------->');
      var data = json.decode(response.body);
      //var data = response.body;
      print(data);
      print(response.statusCode);
      return (data);
    } else {
      print(
          'USER EDIT network handler----------------------------------------->');
      print('gagal USER EDIT');
      print(response.statusCode);
      print(response.body);
    }
  }

  static Future<dynamic> userEditPassword(
    String token,
    idtoko,
    id,
    iduser,
    password,
  ) async {
    var response = await post(link().POST_usereditpassword,
        body: ({
          'token': token,
          'id_toko': idtoko,
          'id': id.toString(),
          'id_user': iduser.toString(),
          'password': password,
        }));
    if (response.statusCode == 200) {
      print(
          'USER EDIT network handler----------------------------------------->');
      var data = json.decode(response.body);
      //var data = response.body;
      print(data);
      print(response.statusCode);
      return (data);
    } else {
      print(
          'USER EDIT network handler----------------------------------------->');
      print('gagal USER EDIT');
      print(response.statusCode);
      print(response.body);
    }
  }

  static Future<dynamic> userDelete(String token, idtoko, id) async {
    var response = await post(link().POST_userdelete,
        body: ({
          'token': token,
          'id_toko': idtoko,
          'id': id.toString(),
        }));
    if (response.statusCode == 200) {
      print(
          'USER DELETE network handler----------------------------------------->');
      var data = json.decode(response.body);
      //var data = response.body;
      print(data);
      print(response.statusCode);
      return (data);
    } else {
      print(
          'USER DELETE network handler----------------------------------------->');
      print('gagal USER DATA');
      print(response.statusCode);
      print(response.body);
    }
  }

  //-------------------------------------------------------------------------

  static Future<dynamic> produkAll(String token, idtoko, search) async {
    var response = await post(link().POST_produkall,
        body: ({
          'token': token,
          'id_toko': idtoko,
          'search': search,
        }));
    if (response.statusCode == 200) {
      print(
          'PRODUKALL network handler----------------------------------------->');

      var data = json.decode(response.body);
      //var data = response.body;
      //var data = response;
      print(data);
      print(response.statusCode);
      return (data);
    } else {
      print(
          'PRODUKALLnetwork handler----------------------------------------->');
      print('gagal PRODUKALL');
      print(response.statusCode);
      print(response.body);
    }
  }

  static Future<dynamic> produkJenis(String token, idtoko) async {
    var response = await post(link().POST_produkjenis,
        body: ({
          'token': token,
          'id_toko': idtoko,
        }));
    if (response.statusCode == 200) {
      print(
          'PRODUKALL network handler----------------------------------------->');

      var data = json.decode(response.body);
      //var data = response.body;
      //var data = response;
      print(data);
      print(response.statusCode);
      return (data);
    } else {
      print(
          'PRODUKALLnetwork handler----------------------------------------->');
      print('gagal PRODUKALL');
      print(response.statusCode);
      print(response.body);
    }
  }

  static Future<dynamic> produkTambah(String token, idtoko, iduser, idjenis,
      namaproduk, desc, qty, harga) async {
    var response = await post(link().POST_produktambah,
        body: ({
          'token': token,
          'id_toko': idtoko,
          'id_user': iduser.toString(),
          'id_jenis': idjenis.toString(),
          'nama_produk': namaproduk,
          'deskripsi': desc,
          'qty': qty.toString(),
          'harga': harga.toString(),
        }));
    if (response.statusCode == 200) {
      print(
          'PRODUK TAMBAH network handler----------------------------------------->');

      var data = json.decode(response.body);
      //var data = response.body;
      //var data = response;
      print(data);
      print(response.statusCode);
      return (data);
    } else {
      print(
          'PRODUKALL TAMBAH handler----------------------------------------->');
      print('gagal PRODUK TAMBAH');
      print(response.statusCode);
      print(response.body);
    }
  }

  static Future<dynamic> produkJenisTambah(
      String token, idtoko, namajenis) async {
    var response = await post(link().POST_produkjenistambah,
        body: ({
          'token': token,
          'id_toko': idtoko,
          'nama_jenis': namajenis,
        }));
    if (response.statusCode == 200) {
      print(
          'TAMBAH JENIS network handler----------------------------------------->');

      var data = json.decode(response.body);
      //var data = response.body;
      //var data = response;
      print(data);
      print(response.statusCode);
      return (data);
    } else {
      print(
          'TAMBAH JENIS network handler----------------------------------------->');
      print('gagal TAMBAH JENIS');
      print(response.statusCode);
      print(response.body);
    }
  }

  static Future<dynamic> produkJenisedit(
      String token, id, idtoko, namajenis) async {
    var response = await post(link().POST_produkjeniedit,
        body: ({
          'token': token,
          'id': id,
          'id_toko': idtoko,
          'nama_jenis': namajenis,
        }));
    if (response.statusCode == 200) {
      print(
          'EDIT JENIS network handler----------------------------------------->');

      var data = json.decode(response.body);
      //var data = response.body;
      //var data = response;
      print(data);
      print(response.statusCode);
      return (data);
    } else {
      print(
          'EDIT JENIS network handler----------------------------------------->');
      print('gagal EDIT JENIS');
      print(response.statusCode);
      print(response.body);
    }
  }

  static Future<dynamic> produkJenidelete(
    String token,
    id,
    idtoko,
  ) async {
    var response = await post(link().POST_produkjenisdelete,
        body: ({
          'token': token,
          'id': id,
          'id_toko': idtoko,
        }));
    if (response.statusCode == 200) {
      print(
          'DELETE JENIS network handler----------------------------------------->');

      var data = json.decode(response.body);
      //var data = response.body;
      //var data = response;
      print(data);
      print(response.statusCode);
      return (data);
    } else {
      print(
          'DELETE JENIS network handler----------------------------------------->');
      print('gagal DELETE JENIS');
      print(response.statusCode);
      print(response.body);
    }
  }

  static Future<dynamic> produkbyjenis(
    String token,
    idjenis,
    idtoko,
  ) async {
    var response = await post(link().POST_produkbyjenis,
        body: ({
          'token': token,
          'id_jenis': idjenis,
          'id_toko': idtoko,
        }));
    if (response.statusCode == 200) {
      print(
          'PRODUK BY JENISnetwork handler----------------------------------------->');

      var data = json.decode(response.body);
      //var data = response.body;
      //var data = response;
      print(data);
      print(response.statusCode);
      return (data);
    } else {
      print(
          'PRODUK BY JENIS network handler----------------------------------------->');
      print('gagal PRODUK BY JENIS');
      print(response.statusCode);
      print(response.body);
    }
  }

  static Future<dynamic> produkdelete(
    String token,
    id,
    idtoko,
  ) async {
    var response = await post(link().POST_produkhapus,
        body: ({
          'token': token,
          'id': id.toString(),
          'id_toko': idtoko,
        }));
    if (response.statusCode == 200) {
      print(
          'DELETE PRODUK network handler----------------------------------------->');

      var data = json.decode(response.body);
      //var data = response.body;
      //var data = response;
      print(data);
      print(response.statusCode);
      return (data);
    } else {
      print(
          'DELETE PRODUK network handler----------------------------------------->');
      print('gagal DELETE PRODUK');
      print(response.statusCode);
      print(response.body);
    }
  }

  static Future<dynamic> produkqtytambah(String token, id, idtoko, qty) async {
    var response = await post(link().POST_produkqtytambah,
        body: ({
          'token': token,
          'id': id.toString(),
          'id_toko': idtoko,
          'qty': qty.toString(),
        }));
    if (response.statusCode == 200) {
      print(
          'TAMBAH QTY network handler----------------------------------------->');

      var data = json.decode(response.body);
      //var data = response.body;
      //var data = response;
      print(data);
      print(response.statusCode);
      return (data);
    } else {
      print(
          'TAMBAH QTY network handler----------------------------------------->');
      print('gagal DTAMBAH QTY');
      print(response.statusCode);
      print(response.body);
    }
  }

// static Future<String> postApi(var body, String endpoint) async {
//   var response = await post(api(endpoint), body: body, headers: {
//     'Content-Type': 'application/json',
//     'Accept': 'application/json',
//     // 'Authorization': GetStorage().read(PREF_TOKEN)
//   });
//   print('dari network handler----------------------------------------->');
//   print(response.body);
//   return response.body;
// }
//
// static Future getApi(String endpoint) async {
//   var response = await get(api(endpoint));
//   return response.body;
// }
//
// static Uri api(String endpoint) {
//   String host = 'http://192.168.100.33/waserda/waserda/';
//   final apikey = host + endpoint;
//   return Uri.parse(apikey);
// }
//
// static void storeToken(String token) async {
//   await GetStorage().write('token', token);
// }
//
// static Future<String?> getToken() async {
//   return await GetStorage().read('token');
// }
}
