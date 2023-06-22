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
  //Timer.periodic(Duration(secon), (timer) { })

  // Future askPermission() async {
  //   return await [
  //     Permission.photos,
  //     //Permission.videos,
  //     //Permission.audio,
  //     //Permission.manageExternalStorage,
  //     //Permission.accessMediaLocation,
  //   ].request().then((permission) async {
  //     print(
  //         'permisison----------------------------------------------------------');
  //     print(permission);
  //     if (permission.containsValue(PermissionStatus.denied) ||
  //         permission.containsValue(PermissionStatus.permanentlyDenied)) {
  //       isGranted(false);
  //       await [
  //         Permission.photos,
  //         Permission.videos,
  //         Permission.audio,
  //         //Permission.manageExternalStorage,
  //         // Permission.accessMediaLocation,
  //         // Permission.locationAlways,
  //       ].request();
  //     } else {
  //       isGranted(true);
  //     }
  //   });
  // }

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
    var toko_user = await GetStorage().read('id_toko');
    //var db = await GetStorage().read('db_local');

    print("LOGIN " + loginStatus.toString());
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
      Timer(const Duration(seconds: 2), () {
        Get.offAndToNamed('/login');
      });
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

        print('--------------------list konten square---------------');
        print(konten);

        return konten;
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
