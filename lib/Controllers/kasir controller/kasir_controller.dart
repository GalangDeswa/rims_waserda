import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';

import '../../Models/produk.dart';
import '../../Models/testmodel.dart';
import '../../Services/api.dart';
import 'package:collection/collection.dart';

class kasirController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    //Get.delete<kasirController>();
    getproduct();
    getbarang();
    print(
        'kasir init---------------------------------------------------------->');
    print(productlist.value);
  }

  var num = 1.obs;

  var list = [].obs;
  void tambahkasir() {
    print(num);
    num++;
    Get.snackbar(
      "GeeksforGeeks",
      "Hello everyone",
    );
  }

  void addlist() {
    num++;

    list.add(num);
  }

  totalharga() {
    double sum = listbarang_baru
        .map((expense) => expense.harga)
        .fold(0, (prev, amount) => prev + int.parse(amount!));

    return sum;
  }

  var loading = true.obs;
  var productlist = <Product>[].obs;
  var listbaru = <Product>[].obs;
  var listbarang_baru = <Barang>[].obs;
  var listets = ['lol', 'lmao', 'XD'].obs;
  var isitest = [].obs;

  var keypadController = TextEditingController().obs;

  void reset() {
    Get.snackbar('result', "delete kon");
    Get.delete<kasirController>();
    Get.put<kasirController>;
  }

  void refresh() {
    onInit();
    Get.snackbar('conn', 'refreshed');

  }

  var barang_list = <Barang>[].obs;

  void getbarang() async {
    try {
      loading(true);
      var checkconn = await check_conn.check();
      if (checkconn == true) {
        var barang = await api.get_barang();
        if (barang != null) {
          barang_list.value = barang;
        }
      } else {
        Get.snackbar('conn', 'tidak ada konenksi');
      }
    } finally {
      loading(false);
    }
  }

  void getproduct() async {
    try {
      loading(true);
      var checkconn = await check_conn.check();
      if (checkconn == true) {
        var product = await api.getproduct();
        if (product != null) {
          productlist.value = product;
        }
      } else {
        Get.snackbar('conn', 'tidak ada konenksi');
      }
    } finally {
      loading(false);
    }
  }

  var barcodetext = TextEditingController().obs;
  var qrcode = ''.obs;
  String scaned_qr_code = '';

  Future<void> scan() async {
    try {
      scaned_qr_code = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'cancel', true, ScanMode.QR);
      Get.snackbar('result', scaned_qr_code);
      barcodetext.value.text = scaned_qr_code;
    } on PlatformException {}
  }

  Future<void> scankasir() async {
    try {
      scaned_qr_code = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'cancel', true, ScanMode.QR);
      if (scaned_qr_code != '-1') {
        Get.snackbar('result', scaned_qr_code);
        var qr = productlist
            .where((e) => e.id.toString().contains(scaned_qr_code.toString()))
            .first;
        print(
            'test scan kasir-------------------------------------------------');
        print(qr);
        listbaru.add(qr);
      } else {
        Get.snackbar('result', "scan canceled");
      }
    } on PlatformException {}
  }
}
