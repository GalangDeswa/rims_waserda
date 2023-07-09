import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart';
import 'package:rims_waserda/Modules/Login/model_login.dart';
import 'package:rims_waserda/Modules/Widgets/toast.dart';
import 'package:rims_waserda/Modules/history/Controller_history.dart';
import 'package:rims_waserda/Modules/pelanggan/data%20pelanggan/controller_data_pelanggan.dart';
import 'package:rims_waserda/Modules/pelanggan/hutang/controller_hutang.dart';
import 'package:rims_waserda/Services/handler.dart';
import 'package:rims_waserda/main.dart';
import 'package:workmanager/workmanager.dart';

import '../../Services/api.dart';
import '../beban/data beban/controller_beban.dart';
import '../dashboard/model_toko.dart';
import '../history/controller_detail_penjualan.dart';
import '../produk/data produk/controller_data_produk.dart';

class loginController extends GetxController {
  @override
  Future<void> onInit() async {
    // TODO: implement onInit
    super.onInit();

    kontensquare.value = await GetStorage().read('konten_square');

    print(kontensquare);
  }

  var kontensquare = [].obs;
  var kontenbanner = [].obs;

  final googleSignIn = GoogleSignIn();
  GoogleSignInAccount? _user;

  GoogleSignInAccount get user => _user!;
  var username = ''.obs;
  var useremail = ''.obs;

  var points = 0.0.obs;

  Future<void> handleSignIn() async {
    Get.dialog(
        Center(
          child: Container(
              width: 300,
              height: 250,
              child: CircularProgressIndicator(
                value: points.value,
              )),
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

  var email = TextEditingController().obs;
  var pass = TextEditingController().obs;
  var token = ''.obs;
  var nama = ''.obs;

  var current = 0.obs;
  var body = {"email": "galang@gmail.com", "password": "12345"};

  final loginKey = GlobalKey<FormState>().obs;
  var showpass = true.obs;
  var nama_toko;
  var alamat_toko;
  var jenis_toko;
  var email_toko;
  var logo_toko;

  var listkonten = <Konten>[];

  // checkidproduk(token) async {
  //   var checkconn = await check_conn.check();
  //   if (checkconn == true) {
  //     var data = await REST.checkIdProduk(token: token);
  //     if (data == 0) {
  //       await GetStorage().write('id_produk', 0);
  //       return 0;
  //     } else {
  //       print(
  //           'check produk id------------------------------------------------->');
  //       print(data['id']);
  //       await GetStorage().write('id_produk', data['id']);
  //       return [data['id']];
  //     }
  //   } else {
  //     Get.back(closeOverlays: true);
  //     Get.showSnackbar(
  //         toast().bottom_snackbar_error('Error', 'Periksa Koneksi Internet'));
  //   }
  // }

  loginv2() async {
    try {
      var checkconn = await check_conn.check();
      if (checkconn == true) {
        var response = await post(link().POST_login,
            body: ({
              'email': email.value.text,
              'password': pass.value.text,
            }));
        //var login = await REST.login(email.value.text, pass.value.text);

        if (response.statusCode == 200) {
          var login = json.decode(response.body);
          print('--------------login controller Write storage--------------');
          print(login['message']);
          print(login['success']);
          var dataUser = ModelLogin.fromJson(login);
          await GetStorage().write('name', dataUser.name);
          await GetStorage().write('email', dataUser.email);
          await GetStorage().write('id_toko', dataUser.idToko);
          await GetStorage().write('token', dataUser.token);
          await GetStorage().write('id_user', dataUser.id);
          await GetStorage().write('role', dataUser.role);

          points.value = points.value + 0.1;

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

            await GetStorage().write('nama_toko', nama_toko);
            await GetStorage().write('jenis_toko', jenis_toko);
            await GetStorage().write('alamat_toko', alamat_toko);
            await GetStorage().write('email_toko', email_toko);
            await GetStorage().write('logo_toko', logo_toko);
            print(dataToko.data[0].toko.namaToko);
            print(logo_toko);
            print('-------------------konten---------------');

            await checkKonenBanner();

            points.value = points.value + 0.1;

            print('------------------pendapatan----------------');
            var dataPendapatan = ModelToko.fromJson(toko);
            var pendapatan = dataPendapatan.data[0].pendapatan;
            await GetStorage().write('pendapatan', pendapatan);
            print(pendapatan);

            print('------------------beban----------------');
            var dataBeban = ModelToko.fromJson(toko);
            var beban = dataBeban.data[0].beban;
            await GetStorage().write('beban', beban);
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
          print(
              '<------------------------------------ loading database init ------------------------------------>');

          var db = await GetStorage().read('db_local');
          print(db);

          if (db == 'new') {
            try {
              print(
                  'init beban-------------------------------------------------------->');
              await bebanController().initBebanToLocal(dataUser.idToko);
              points.value = points.value + 0.1;
              print(
                  'init produk-------------------------------------------------------->');
              await produkController().initProdukToLocal(dataUser.idToko);
              points.value = points.value + 0.1;

              print(
                  'init pelanggan-------------------------------------------------------->');
              await pelangganController().initPelangganToLocal(dataUser.idToko);
              points.value = points.value + 0.1;

              print(
                  'init penjualan-------------------------------------------------------->');
              await historyController().initPenjualanToLocal(dataUser.idToko);

              points.value = points.value + 0.1;

              print(
                  'init detail penjualan-------------------------------------------------------->');
              await detailpenjualanController()
                  .initPenjualanDetailToLocal(dataUser.idToko);

              points.value = points.value + 0.1;
              print(
                  'init hutang-------------------------------------------------------->');
              await hutangController().initHutangToLocal(dataUser.idToko);
              points.value = points.value + 0.1;
              print(
                  'init hutang detail-------------------------------------------------------->');
              await hutangController().initHutangDetailToLocal(dataUser.idToko);
            } catch (e) {
              print('-----eerrrorrr init------');
              print(e);
              Get.back();
              Get.showSnackbar(
                  toast().bottom_snackbar_error('Error', 'Error init databse'));
            }
          }

          //TODO : check api untuk id_local
          //TODO : CRUD ULANG UNTUK ID_LOCAL

          // await checkidproduk(dataUser.token);
          //var checkid = GetStorage().read('id_produk');

          points.value = points.value + 0.1;

          await Workmanager().registerPeriodicTask('sync_auto', syncAuto,
              frequency: Duration(hours: 12),
              constraints: Constraints(networkType: NetworkType.connected));
          points.value = points.value + 0.1;

          Get.back(closeOverlays: true);
          Get.showSnackbar(toast().bottom_snackbar_success(
              'Selamat datang', GetStorage().read('nama_toko')));
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
    } catch (e) {
      print(e);
      Get.back();
      Get.showSnackbar(toast().bottom_snackbar_error('Error', e.toString()));
    }
    // Get.dialog(showloading(), barrierDismissible: false);
  }

  checkKonenBanner() async {
    var banner = await GetStorage().read('konten_banner');
    if (banner != null) {
      print('konten banner masih ada----------------------------');
    } else {
      print('konten banner tidak ada-----------------------------');
      await fetchKontenBanner();
    }
  }

  fetchKontenBanner() async {
    print(
        '--fetching konten banner--------------------------------------------------------------------->');
    // succ.value = false;
    var checkconn = await check_conn.check();
    if (checkconn == true) {
      var konten = await REST.kontenBanner();
      if (konten != null) {
        await GetStorage().write('konten_banner', konten['data']);
        print(konten['data']);
        return konten['data'];
      } else {
        Get.back(closeOverlays: true);
        Get.showSnackbar(
            toast().bottom_snackbar_error('Error', 'Produk gagal ditampilkan'));
      }
    } else {
      Get.back(closeOverlays: true);
      Get.showSnackbar(
          toast().bottom_snackbar_error('Error', 'Produk gagal ditampilkan'));
    }
    // return [];
  }
}
