import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:rims_waserda/Modules/Login/model_login.dart';
import 'package:rims_waserda/Modules/Widgets/loading.dart';
import 'package:rims_waserda/Services/handler.dart';
import 'package:rims_waserda/Templates/setting.dart';

import '../dashboard/model_toko.dart';

class loginController extends GetxController {
  final googleSignIn = GoogleSignIn();
  GoogleSignInAccount? _user;

  GoogleSignInAccount get user => _user!;
  var username = ''.obs;
  var useremail = ''.obs;

  Future<void> handleSignIn() async {
    Get.dialog(
        Center(
          child: Container(
            width: 300,
            height: 250,
            child: LoadingIndicator(
              indicatorType: Indicator.ballPulseSync,
              colors: [color_template().primary, color_template().select],
            ),
          ),
        ),
        barrierDismissible: false);
    try {
      final googleUser = await googleSignIn.signIn();
      final googleAuth = await googleUser?.authentication;
      var tc;
      var id;
      final credential = GoogleAuthProvider.credential(
          accessToken: tc = googleAuth!.accessToken,
          idToken: id = googleAuth.idToken);

      username.value = googleUser!.displayName!;
      useremail.value = googleUser.email;
      GetStorage().write('name', googleUser.displayName);
      GetStorage().write('email', googleUser.email);
      Get.back(closeOverlays: true);
      Get.snackbar(
        "berhasil",
        googleUser.displayName.toString(),
      );
      Get.offAndToNamed('/base_menu');

      print(username);
      print(useremail);
    } catch (error) {
      Get.back(closeOverlays: true);
      print(error);
      Get.snackbar('gagal', error.toString());
    }
  }

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
  var nama_toko;
  var alamat_toko;
  var jenis_toko;
  var email_toko;
  var logo_toko;

  var listkonten = <Konten>[];

  // login() async {
  //   Get.dialog(
  //       Center(
  //         child: CircularProgressIndicator(),
  //       ),
  //       barrierDismissible: false);
  //   Loginv2 loginmodel =
  //       Loginv2(email: email.value.text, password: pass.value.text);
  //   var response = await REST.postApi(loginv2ToJson(loginmodel), 'login');
  //   var data = json.decode(response);
  //   print('dari login controller----------------------------------------->');
  //   // print(data['data']['nama']);
  //   if (data['accessToken'] != null) {
  //     REST.storeToken(data['accessToken']);
  //     GetStorage().write('nama', data['data']['nama']);
  //     GetStorage().write('email', data['data']['email']);
  //     GetStorage().write('toko', data['data']['store_id']);
  //     List toko = data['data']['store_id'];
  //     if (toko.length > 1) {
  //       Get.back();
  //       Get.snackbar('sukses', 'pilih toko');
  //       print(data['data']['store_id']);
  //       Get.offAndToNamed('/pilih_toko');
  //     } else {
  //       Get.back();
  //       Get.snackbar('sukses', 'berhasil login');
  //       Get.offAndToNamed('/base_menu');
  //     }
  //
  //     //Get.snackbar('sukses', data['data']['nama']);
  //     //print(data['data']['store_id']);
  //     //print(networkHandler.getToken().toString());
  //   } else {
  //     Get.back();
  //     Get.snackbar(
  //       "Error",
  //       "Login gagal, Periksa email/password",
  //       icon: Icon(Icons.error, color: Colors.white),
  //       snackPosition: SnackPosition.BOTTOM,
  //       backgroundColor: Colors.red,
  //       borderRadius: 20,
  //       margin: EdgeInsets.all(15),
  //       colorText: Colors.white,
  //       duration: Duration(seconds: 4),
  //       isDismissible: true,
  //       dismissDirection: DismissDirection.horizontal,
  //       forwardAnimationCurve: Curves.elasticInOut,
  //       reverseAnimationCurve: Curves.easeOut,
  //     );
  //   }
  // }

  loginv2() async {
    Get.dialog(loading(), barrierDismissible: false);
    var checkconn = await check_conn.check();
    if (checkconn == true) {
      var login = await REST.login(email.value.text, pass.value.text);
      if (login != null) {
        print('--------------login controller Write storage--------------');
        print(login['message']);
        print(login['success']);
        var dataUser = ModelLogin.fromJson(login);
        GetStorage().write('name', dataUser.name);
        GetStorage().write('email', dataUser.email);
        GetStorage().write('id_toko', dataUser.idToko);
        GetStorage().write('token', dataUser.token);
        GetStorage().write('id_user', dataUser.id);

        var toko = await REST.loadToko(dataUser.token, dataUser.idToko);
        if (toko != null) {
          print('----------------mesaasge---------------');
          var message = ModelToko.fromJson(toko);
          print(message.message);
          print('-------------------datatoko---------------');
          var dataToko = ModelToko.fromJson(toko);
          // dataToko.data
          //     .map((e) => e.konten.map((x) => print(x.link)).toList())
          //     .toList();
          //print(dataToko.data[0].konten[1].link);
          nama_toko = dataToko.data[0].toko.namaToko;
          jenis_toko = dataToko.data[0].toko.jenisusaha;
          alamat_toko = dataToko.data[0].toko.alamat;
          email_toko = dataToko.data[0].toko.email;
          logo_toko = dataToko.data[0].toko.logo;

          GetStorage().write('nama_toko', nama_toko);
          GetStorage().write('jenis_toko', jenis_toko);
          GetStorage().write('alamat_toko', alamat_toko);
          GetStorage().write('email_toko', email_toko);
          GetStorage().write('logo_toko', logo_toko);
          print(dataToko.data[0].toko.namaToko);
          print(logo_toko);
          print('-------------------konten---------------');

          var dataKonten = ModelToko.fromJson(toko);
          dataKonten.data.forEach((element) {
            listkonten = element.konten;
          });
          GetStorage().write('konten', listkonten);
          print(listkonten);

          print('------------------pendapatan----------------');
          var dataPendapatan = ModelToko.fromJson(toko);
          var pendapatan = dataPendapatan.data[0].pendapatan;
          GetStorage().write('pendapatan', pendapatan);
          print(pendapatan);

          print('------------------beban----------------');
          var dataBeban = ModelToko.fromJson(toko);
          var beban = dataBeban.data[0].beban;
          GetStorage().write('beban', beban);
          print(beban);
        } else {
          Get.back(closeOverlays: true);
          Get.snackbar(
            "Error",
            "Data toko tidak tersedia",
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

        Get.back(closeOverlays: true);
        Get.snackbar('sukses', 'login api');
        Get.offNamed('/base_menu');
      } else {
        Get.back(closeOverlays: true);
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
    } else {
      Get.back(closeOverlays: true);
      Get.snackbar(
        "Error",
        "Login gagal,koneksi",
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
