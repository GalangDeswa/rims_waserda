import 'package:audioplayers/audioplayers.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class dashboardController extends GetxController {
  @override
  Future<void> onInit() async {
    // TODO: implement onInit
    super.onInit();
    await initstorage();

    print('dashboard controller ------------------------------------------->');
    print('konten list------------------------------------------->');
    print(kontenlists.toString());
    // print(GetStorage().read('konten_banner'));

    print(id_toko);

    //loadkonten();
    //loadkontenv2();
    //loadToko();
  }

  initstorage() async {
    nama.value = await GetStorage().read('name');
    email.value = await GetStorage().read('email');
    id_toko.value = await GetStorage().read('id_toko');
    token.value = await GetStorage().read('token');
    nama_toko.value = await GetStorage().read('nama_toko');
    alamat_toko.value = await GetStorage().read('alamat_toko');
    jenis_toko.value = await GetStorage().read('jenis_toko');
    email_toko.value = await GetStorage().read('email_toko');
    pendapatan.value = await GetStorage().read('pendapatan');
    beban.value = await GetStorage().read('beban');
    logo.value = await GetStorage().read('logo_toko');
    kontenlists.value = await GetStorage().read('konten_banner');
  }

  var nama = ''.obs;
  var email = ''.obs;
  var id_toko = ''.obs;
  var token = ''.obs;

  var nama_toko = ''.obs;
  var alamat_toko = ''.obs;
  var jenis_toko = ''.obs;
  var email_toko = ''.obs;
  var pendapatan = 0.obs;
  var beban = 0.obs;
  var logo = ''.obs;

  var listkonten = [].obs;

  // loadkonten() {
  //   //tanpa logout error
  //   //dengan di ganti jd list biasa bukan list<konten> bisa?
  //   print('---------------------load konten--------------');
  //   listkonten.value = GetStorage().read('konten');
  //   print(listkonten);
  // }

  // loadkontenv2() async {
  //   //Get.dialog(loading(), barrierDismissible: false);
  //   var checkconn = await check_conn.check();
  //   if (checkconn == true) {
  //     var toko = await REST.loadToko(token, id_toko);
  //     if (toko != null) {
  //       var dataKonten = ModelToko.fromJson(toko);
  //       dataKonten.data.forEach((element) {
  //         listkonten.value = element.konten;
  //       });
  //       print('---------------load konten v2-------------');
  //       print(listkonten);
  //     } else {
  //       //Get.back(closeOverlays: true);
  //       Get.snackbar(
  //         "Error",
  //         "Data toko gagal,toko tidak terserdia",
  //         icon: Icon(Icons.error, color: Colors.white),
  //         snackPosition: SnackPosition.BOTTOM,
  //         backgroundColor: Colors.red,
  //         borderRadius: 20,
  //         margin: EdgeInsets.all(15),
  //         colorText: Colors.white,
  //         duration: Duration(seconds: 4),
  //         isDismissible: true,
  //         dismissDirection: DismissDirection.horizontal,
  //         forwardAnimationCurve: Curves.elasticInOut,
  //         reverseAnimationCurve: Curves.easeOut,
  //       );
  //     }
  //   } else {
  //     // Get.back(closeOverlays: true);
  //     Get.snackbar(
  //       "Error",
  //       "Data toko gagal,periksa koneksi",
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

  var kontenlists = [].obs;

//var toko = Get.arguments as Map;

// loadToko() async {
//   print('-------------------load toko---------------------');
//   Get.dialog(showloading(), barrierDismissible: false);
//   var checkconn = await check_conn.check();
//   if (checkconn == true) {
//     var toko = await REST.loadToko(token, id_toko);
//     if (toko != null) {
//       print('----------------mesaasge---------------');
//       var message = ModelToko.fromJson(toko);
//       print(message.message);
//       print('-------------------datatoko---------------');
//       var dataToko = ModelToko.fromJson(toko);
//       // dataToko.data
//       //     .map((e) => e.konten.map((x) => print(x.link)).toList())
//       //     .toList();
//       //print(dataToko.data[0].konten[1].link);
//       nama_toko.value = dataToko.data[0].toko.namaToko;
//       jenis_toko.value = dataToko.data[0].toko.jenisusaha;
//       alamat_toko.value = dataToko.data[0].toko.alamat;
//       var email_toko = dataToko.data[0].toko.email;
//       var logo_toko = dataToko.data[0].toko.logo;
//
//       GetStorage().write('nama_toko', nama_toko);
//       GetStorage().write('jenis_toko', jenis_toko);
//       GetStorage().write('alamat_toko', alamat_toko);
//       GetStorage().write('email_toko', email_toko);
//       GetStorage().write('logo_toko', logo_toko);
//
//       print(dataToko.data[0].toko.namaToko);
//       print('-------------------konten---------------');
//       // var dataKonten = Datum.fromJson(toko);
//       // print(dataKonten.konten[0].judul);
//       //tidak muncul
//
//       // var dataKonten = ModelToko.fromJson(toko);
//       // dataKonten.data.forEach((element) {
//       //   element.konten.forEach((element) {
//       //     print(element.link);
//       //   });
//       // });
//       //loop
//
//       // var dataKonten = ModelToko.fromJson(toko);
//       // dataKonten.data
//       //     .map((e) => e.konten.map((x) => print(x.link)).toList())
//       //     .toList();
//       //map
//
//       // var dataKonten = ModelToko.fromJson(toko);
//       // listkonten.value = dataKonten.data[0].konten;
//       // print(listkonten);
//       //pakai data[0] untuk masukan list baru
//
//       // var dataKonten = ModelToko.fromJson(toko);
//       // dataKonten.data.forEach((element) {
//       //   listkonten.value = element.konten;
//       // });
//       // //listkonten.value = dataKonten;
//       // print(listkonten);
//       //pakai loop untuk masukan list baru
//
//       var dataKonten = ModelToko.fromJson(toko);
//       dataKonten.data.forEach((element) {
//         listkonten.value = element.konten;
//       });
//       GetStorage().write('konten', listkonten.value);
//       print(listkonten);
//
//       print('------------------pendapatan----------------');
//       var dataPendapatan = ModelToko.fromJson(toko);
//       var pendapatan = dataPendapatan.data[0].pendapatan;
//       GetStorage().write('pendapatan', pendapatan);
//       print(pendapatan);
//
//       print('------------------beban----------------');
//       var dataBeban = ModelToko.fromJson(toko);
//       var beban = dataBeban.data[0].beban;
//       GetStorage().write('beban', beban);
//       print(beban);
//       Get.back(closeOverlays: true);
//     } else {
//       Get.back(closeOverlays: true);
//       Get.snackbar(
//         "Error",
//         "Data toko tidak tersedia",
//         icon: Icon(Icons.error, color: Colors.white),
//         snackPosition: SnackPosition.BOTTOM,
//         backgroundColor: Colors.red,
//         borderRadius: 20,
//         margin: EdgeInsets.all(15),
//         colorText: Colors.white,
//         duration: Duration(seconds: 4),
//         isDismissible: true,
//         dismissDirection: DismissDirection.horizontal,
//         forwardAnimationCurve: Curves.elasticInOut,
//         reverseAnimationCurve: Curves.easeOut,
//       );
//     }
//   } else {
//     Get.back(closeOverlays: true);
//     Get.snackbar(
//       "Error",
//       "Data toko gagal,periksa koneksi",
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
}
