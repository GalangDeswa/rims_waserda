import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rims_waserda/Modules/Widgets/toast.dart';
import 'package:rims_waserda/Modules/beban/data%20beban/controller_beban.dart';
import 'package:rims_waserda/Modules/history/Controller_history.dart';
import 'package:rims_waserda/Modules/history/controller_detail_penjualan.dart';
import 'package:rims_waserda/Modules/pelanggan/data%20pelanggan/controller_data_pelanggan.dart';
import 'package:rims_waserda/Modules/pelanggan/hutang/controller_hutang.dart';
import 'package:workmanager/workmanager.dart';

import 'Modules/produk/data produk/controller_data_produk.dart';
import 'Modules/produk/data produk/model_produk.dart';
import 'Routes/routes.dart';
import 'Templates/setting.dart';
import 'db_helper.dart';

const syncManual = 'syncManual';
const syncAuto = 'syncAuto';
Completer up = Completer();
List<DataProduk> produklistlocal = [];

syncAll(id_toko) async {
  try {
    print("id toko---------------------------->");
    print(id_toko);

    print("sync produk jenis---------------------------->");
    await produkController().syncProdukJenis(id_toko);

    print("sync produk---------------------------->");
    await produkController().syncProduk(id_toko);

    print("sync beban jenis--------------------------->");
    await bebanController().syncBebanKategori(id_toko);

    print("sync beban---------------------------->");
    await bebanController().syncBeban(id_toko);

    print("sync pelanggan---------------------------->");
    await pelangganController().syncPelanggan(id_toko);

    print("sync hutang---------------------------->");
    await hutangController().syncHutang(id_toko);

    print("sync hutang detail---------------------------->");
    await hutangController().syncHutangDetail(id_toko);

    print("sync penjualan---------------------------->");
    await historyController().syncPenjualan(id_toko);

    print("sync penjualan detail---------------------------->");
    await detailpenjualanController().syncPenjualanDetail(id_toko);
  } catch (e) {
    print(e);
    Get.showSnackbar(toast().bottom_snackbar_error('error', 'error sync'));
  }
}

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    //await GetStorage.init();
    //await DBHelper().db;
    // var con = Get.put(produkController());
    await GetStorage.init();
    var storage = GetStorage();
    var id_user = await storage.read('id_user');
    var id_toko = await storage.read('id_toko');
    var token = await storage.read('token');
    FlutterLocalNotificationsPlugin flip = FlutterLocalNotificationsPlugin();
    var android = AndroidInitializationSettings('logo');
    //var IOS = new IOSInitializationSettings();
    // initialise settings for both Android and iOS device.
    var settings = InitializationSettings(android: android);
    flip.initialize(settings);

    switch (task) {
      case syncManual:
        try {
          await syncAll(id_toko);
          showNotificationWithDefaultSound(flip);
          return Future.value(true);
        } catch (e) {
          Get.showSnackbar(
              toast().bottom_snackbar_error('error', 'error sync'));
        }

        break;

      case syncAuto:
        try {
          await syncAll(id_toko);
          showNotificationWithDefaultSound(flip);
          return Future.value(true);
        } catch (e) {
          Get.showSnackbar(
              toast().bottom_snackbar_error('error', 'error sync'));
        }
        break;
    }
    return Future.value(true);
  });
}

Future showNotificationWithDefaultSound(flip) async {
  var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'id_1', 'sync_auto',
      importance: Importance.max, priority: Priority.high);
  var platformChannelSpecifics = new NotificationDetails(
    android: androidPlatformChannelSpecifics,
  );
  await flip.show(0, 'Rims Waserda - backup data rutin',
      'Data berhasil di backup', platformChannelSpecifics,
      payload: 'Default_Sound');
}

Future<void> requestNotificationPermissions() async {
  final PermissionStatus status = await Permission.notification.request();
  if (status.isGranted) {
    // Notification permissions granted
  } else if (status.isDenied) {
    // Notification permissions denied
  } else if (status.isPermanentlyDenied) {
    // Notification permissions permanently denied, open app settings
    await openAppSettings();
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await DBHelper().db;
  await requestNotificationPermissions();
  await Workmanager().initialize(callbackDispatcher, isInDebugMode: false);

  SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft]);
  // Intl.systemLocale = await findSystemLocale();
  //await DBHelper().initDb();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'RIMS WASERDA',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.blue,
          colorScheme: ThemeData().colorScheme.copyWith(
                primary: color_template().select,
              )),
      getPages: route,
      initialRoute: '/splash',
      //initialBinding: splashBinding(),
    );
  }
}
