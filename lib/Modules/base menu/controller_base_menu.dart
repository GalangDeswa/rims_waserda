import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:blue_thermal_printer/blue_thermal_printer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rims_waserda/Modules/beban/data%20beban/view_beban_base.dart';
import 'package:rims_waserda/Modules/dashboard/controller_dashboard.dart';
import 'package:rims_waserda/Modules/dashboard/view_dashboard_base_v2.dart';
import 'package:rims_waserda/Modules/pelanggan/data%20pelanggan/view_data_pelanggan_base.dart';
import 'package:rims_waserda/Modules/user/data%20user/view_data_user_base.dart';

import '../../Services/handler.dart';
import '../Widgets/toast.dart';
import '../beban/data beban/controller_beban.dart';
import '../history/Controller_history.dart';
import '../history/controller_detail_penjualan.dart';
import '../history/view_history_base.dart';
import '../kasir/controller_kasir.dart';
import '../kasir/view_kasir_basev2.dart';
import '../laporan/view_laporan_base.dart';
import '../pelanggan/data pelanggan/controller_data_pelanggan.dart';
import '../pelanggan/hutang/controller_hutang.dart';
import '../produk/data produk/controller_data_produk.dart';
import '../produk/data produk/view_produk_base.dart';

class base_menuController extends GetxController {
  @override
  Future<void> onInit() async {
    // TODO: implement onInit
    super.onInit();
    await loadtoko();
    await getlayout();
    printer.disconnect();
    await getDevice();
    await checkprinter();
    print('--------------------------- kasit layout index');
    print(layoutIndex.value);
    await initSavetoPath();
    await initSavetoPathstruk();
  }

  var pathImage = ''.obs;

  void tesPrint() async {
    //SIZE
    // 0- normal size text
    // 1- only bold text
    // 2- bold with medium text
    // 3- bold with large text
    //ALIGN
    // 0- ESC_ALIGN_LEFT
    // 1- ESC_ALIGN_CENTER
    // 2- ESC_ALIGN_RIGHT
    printer.isConnected.then((isConnected) {
      if (isConnected == true) {
        // printer.printNewLine();
        // printer.printCustom("HEADER", 3, 1);
        // printer.printNewLine();
        // printer.printLeftRight("LEFT", "RIGHT", 0);
        // printer.printLeftRight("LEFT", "RIGHT", 1);
        // printer.printLeftRight("LEFT", "RIGHT", 1, format: "%-15s %15s %n");
        // printer.printNewLine();
        // printer.printLeftRight("LEFT", "RIGHT", 2);
        // printer.printLeftRight("LEFT", "RIGHT", 3);
        // printer.printLeftRight("LEFT", "RIGHT", 4);
        // printer.printNewLine();
        // printer.print3Column("Col1", "Col2", "Col3", 1);
        // printer.print3Column("Col1", "Col2", "Col3", 1,
        //     format: "%-10s %10s %10s %n");
        // printer.printNewLine();
        // printer.print4Column("Col1", "Col2", "Col3", "Col4", 1);
        String qwe = 'Ice americano special 15ml';
        if (qwe.length > 15) {
          qwe = qwe.substring(0, 15) + '...';
        }
        printer.print4Column('Nama produk', 'QTY', 'Harga', 'Subtotal', 0,
            format: "%-20s %-5s %-2s %5s %n");
        printer.printNewLine();
        printer.printNewLine();
        printer.printNewLine();
        // String testString = " čĆžŽšŠ-H-ščđ";
        // printer.printCustom(testString, 1, 1, charset: "windows-1250");
        // printer.printLeftRight("Številka:", "18000001", 1,
        //     charset: "windows-1250");
        // printer.printCustom("Body left", 1, 0);
        // printer.printCustom("Body right", 0, 2);
        // printer.printNewLine();
        // printer.printCustom("Thank You", 2, 1);
        // printer.printNewLine();
        // printer.printQRcode("Insert Your Own Text to Generate", 200, 200, 1);
        // printer.printNewLine();
        // printer.printNewLine();
        // printer.paperCut();
      }
    });
  }

  initSavetoPath() async {
    //read and write
    //image max 300px X 300px
    final filename = 'logoprintv2.png';
    var bytes = await rootBundle.load("assets/icons/logoprintv2.png");
    String dir = (await getApplicationDocumentsDirectory()).path;
    writeToFile(bytes, '$dir/$filename');

    pathImage.value = '$dir/$filename';
    print(pathImage);
  }

  Future<void> writeToFile(ByteData data, String path) {
    final buffer = data.buffer;
    return new File(path).writeAsBytes(
        buffer.asUint8List(data.offsetInBytes, data.lengthInBytes));
  }

  var isConnected = false.obs;
  var listPrinter = <BluetoothDevice>[].obs;
  BluetoothDevice? selectedPrinter;
  BlueThermalPrinter printer = BlueThermalPrinter.instance;
  var loading = ''.obs;

  checkprinter() async {
    if (await printer.isConnected == true) {
      isConnected.value = true;
      loading.value = 'done';
    } else {
      isConnected.value = false;
      loading.value = '';
    }
  }

  getDevice() async {
    print('get printer-----------------');
    listPrinter.value.clear();
    listPrinter.value = await printer.getBondedDevices();
    print(listPrinter.map((element) => element.name));
  }

  DateFormat dateFormat = DateFormat("dd-MM-yyyy");

  loadtoko() async {
    namatoko.value = await GetStorage().read('nama_toko');
    alamat_toko.value = await GetStorage().read('alamat_toko');
    namauser.value = await GetStorage().read('name');

    logo.value = await GetStorage().read('logo_toko') ?? '-';
  }

  var namatoko = ''.obs;
  var alamat_toko = ''.obs;
  var namauser = ''.obs;
  var logo = ''.obs;

  var token = ''.obs;
  var id_toko = GetStorage().read('id_toko');
  var logo_toko = GetStorage().read('logo_toko');
  var id_user = GetStorage().read('id_user');
  var role = GetStorage().read('role');
  var point_loading = 0.0.obs;

  String stringGenerator(int len) {
    var random = Random.secure();
    var values = List<int>.generate(len, (i) => random.nextInt(255));
    var uniqueId = base64UrlEncode(values);
    print(uniqueId);
    return uniqueId;
  }

  syncAll(id_toko) async {
    try {
      print("id toko---------------------------->");
      print(id_toko);

      print("sync produk jenis---------------------------->");
      await produkController().syncProdukJenis(id_toko);
      point_loading.value = 0.1;

      print("sync produk---------------------------->");
      await produkController().syncProduk(id_toko);
      //get.find membuat refresh ui?
      await Get.find<produkController>().initProdukToLocal(id_toko);
      point_loading.value = 0.2;

      print("sync beban jenis--------------------------->");
      await bebanController().syncBebanKategori(id_toko);
      point_loading.value = 0.3;

      print("sync beban---------------------------->");
      await bebanController().syncBeban(id_toko);
      await Get.find<bebanController>().initBebanToLocal(id_toko);
      point_loading.value = 0.5;

      print("sync pelanggan---------------------------->");
      await pelangganController().syncPelanggan(id_toko);
      await Get.find<pelangganController>().initPelangganToLocal(id_toko);
      point_loading.value = 0.6;

      print("sync hutang---------------------------->");
      await hutangController().syncHutang(id_toko);
      await Get.find<hutangController>().initHutangToLocal(id_toko);
      point_loading.value = 0.7;

      print("sync hutang detail---------------------------->");
      await hutangController().syncHutangDetail(id_toko);
      await Get.find<hutangController>().initHutangDetailToLocal(id_toko);
      point_loading.value = 0.8;

      print("sync penjualan---------------------------->");
      await historyController().syncPenjualan(id_toko);
      await Get.find<historyController>().initPenjualanToLocal(id_toko);
      point_loading.value = 0.9;

      print("sync penjualan detail---------------------------->");
      await detailpenjualanController().syncPenjualanDetail(id_toko);
      await Get.find<detailpenjualanController>()
          .initPenjualanDetailToLocal(id_toko);

      await Get.find<historyController>()
          .fetchPenjualanlocal(id_toko: id_toko, id_user: id_user, role: role);

      await Get.find<dashboardController>().loadall();

      point_loading.value = 1.0;
    } catch (e) {
      print(
          '-----------------------------------------------------------------------error------------------------------------------------------------------------------------------------------------->');
      print(e);
      Get.back();
      Get.showSnackbar(toast().bottom_snackbar_error('error', e.toString()));
    }
  }

  List<Widget> views_kasir = const [
    dashboard_v2(),
    kasirv2(),
    //produk(),
    beban(),
    // data_user(),
    pelanggan(),
    history(),
    laporan(),
  ];

  List<Widget> views_admin = const [
    dashboard_v2(),
    kasirv2(),
    produk(),
    beban(),
    data_user(),
    pelanggan(),
    history(),
    laporan(),
  ];

  var selectedIndex = 0.obs;
  var extended = false.obs;

  var layoutIndex = 0.obs;

  getlayout() {
    if (Get.find<kasirController>().layout.value == true) {
      var truex = layoutIndex.value = 0;
      return truex;
    } else if (Get.find<kasirController>().layout.value == false) {
      var falsex = layoutIndex.value = 1;
      return falsex;
    } else {
      return 10;
    }
  }

  var printstruklogo = ''.obs;

  initSavetoPathstruk() async {
    //read and write
    //image max 300px X 300px
    final filename = 'logoprintstruk.png';
    var bytes = await rootBundle.load("assets/icons/logoprintstruk.png");
    String dir = (await getApplicationDocumentsDirectory()).path;
    writeToFile(bytes, '$dir/$filename');

    printstruklogo.value = '$dir/$filename';
    print(pathImage);
  }

  var scaffoldKey = GlobalKey<ScaffoldState>().obs;

  void openDrawer() {
    scaffoldKey.value.currentState!.openEndDrawer();
  }

  void closeDrawer() {
    scaffoldKey.value.currentState!.openEndDrawer();
  }

  logout() async {
    print('-------------------fetchProdukbyjenis---------------------');

    var checkconn = await check_conn.check();
    if (checkconn == true) {
      var logout = await REST.logout(token.value);
      if (logout != null) {
        print('-----------------logout--------------');
        print(logout);

        await GetStorage().remove('name');
        await GetStorage().remove('email');
        await GetStorage().remove('id_toko');
        await GetStorage().remove('token');
        await GetStorage().remove('id_user');
        await GetStorage().remove('pendapatan');
        await GetStorage().remove('beban');
        await GetStorage().remove('konten_banner');
        await GetStorage().remove('produk');
        await GetStorage().remove('jenis');
        await GetStorage().remove('nama_toko');
        await GetStorage().remove('jenis_toko');
        await GetStorage().remove('alamat_toko');
        await GetStorage().remove('email_toko');
        await GetStorage().remove('logo_toko');
        Get.offAllNamed('/login');
      } else {
        // Get.back(closeOverlays: true);
        Get.showSnackbar(
            toast().bottom_snackbar_error('Error', 'Terjadi kesalahan'));
      }
    } else {
      Get.back(closeOverlays: true);
      Get.showSnackbar(
          toast().bottom_snackbar_error('Error', 'Periksa koneksi'));
    }
    return [];
  }
}
