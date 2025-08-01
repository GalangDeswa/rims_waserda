import 'dart:async';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../Services/handler.dart';
import '../Widgets/toast.dart';

class splashController extends GetxController {
  @override
  Future<void> onInit() async {
    // TODO: implement onInit
    super.onInit();
    print(
        'splash init---------------------------------------------------------->');
    print(
        'check banner splach init-------------------------------------------->');

    await checkLogin();
    // await fetchKontenSquare();
  }

  var x = Duration(seconds: 1);

  checkbanner() async {
    var konten = await GetStorage().read('konten_banner');
    if (konten != null) {
      print(
          'konten banner masih ada dari init spalsh------------------------------');
    } else {
      print(
          'konten banner tidak ada dari inint spalsh--------------------------------');
    }
  }

  checkKonten() async {
    var konten = await GetStorage().read('konten_square');
    if (konten != null) {
      print('konten masih ada ---------------------');
    } else {
      print('konten tidak ada--------------------------');
      await fetchKontenSquare();
    }
  }

  checkLogin() async {
    await checkbanner();
    await checkKonten();

    var loginStatus = await GetStorage().read('token');
    // var toko_user = await GetStorage().read('id_toko');
    var check = await GetStorage().read('intro');
    print(
        'check intro----------------------------------------------------------->');
    print(check);

    print("LOGIN " + loginStatus.toString());
    if (check == null) {
      await GetStorage().write('intro', true);
      Timer(const Duration(seconds: 3), () {
        Get.offAndToNamed('/intro');
      });
    } else {
      if (loginStatus != null) {
        //await fetchKontenSquare();
        Timer(const Duration(seconds: 3), () {
          Get.offAndToNamed('/base_menu');
        }
            //     {
            //   Get.off(const Dashboard());
            // }
            );
      } else {
        //await fetchKontenSquare();
        // await GetStorage().read('konten_banner');
        Timer(const Duration(seconds: 3), () {
          Get.offAndToNamed('/login');
        });
      }
    }
  }

  fetchKontenSquare() async {
    print('-------------------fetch konten square---------------------');
    // succ.value = false;
    var checkconn = await check_conn.check();
    if (checkconn == true) {
      var konten = await REST.kontenSquare();
      if (konten != null) {
        print('-------------------data konten square---------------');
        //   var dataKonten = ModelKonten.fromJson(konten);

        await GetStorage().write('konten_square', konten['data']);

        return konten;
      } else {
        Get.back(closeOverlays: true);
        Get.showSnackbar(
            toast().bottom_snackbar_error('Error', 'Konten gagal ditampilkan'));
      }
    } else {
      Get.back(closeOverlays: true);
      Get.showSnackbar(
          toast().bottom_snackbar_error('Error', 'Periksa koneksi internet'));
    }
    // return [];
  }
}
