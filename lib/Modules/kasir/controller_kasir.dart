import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../Models/dummy.dart';
import '../../Models/keranjang.dart';
import '../../Models/produkv2.dart';
import '../../Modules/produk/data produk/model_produk.dart';

class kasirController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    //Get.delete<kasirController>();
    // getproduct();
    // getbarang();
    //getprodukall();
    //getkeranjang();
    groupindex.value = 9;
    print(
        'kasir init---------------------------------------------------------->');
  }

  /*RxDouble _total = 0.0.obs;

  double get total => _total.value;

  void addValue(double value) {
    _total.value += value;
  }

  void clear() {
    _total.value = 0.0;
  }*/

  var num = 1.obs;
  var i = 0.obs;
  var groupindex = 9.obs;

  var currencyFormatter = NumberFormat('#,##0', 'ID');

  //int newnum1 = int.parse(str.replaceAll(RegExp(r'[^0-9]'), ''));
  //var groupbutton = GroupButtonController(selectedIndex: 3).obs;

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

  var subtotal = 0.0.obs;
  var kembalian = 0.0.obs;
  var totalitem = 0.obs;

  totalqty() {
    int qty = keranjang_list
        .map((element) => element.qty)
        .fold(1, (prev, amount) => prev + int.parse(amount!));
    totalitem.value = qty;
    return totalitem;
  }

  totalkeranjang() {
    double sum = keranjang_list
        .map((expense) => expense.harga)
        .fold(0, (prev, amount) => prev + int.parse(amount!));
    subtotal.value = sum;
    return subtotal;
  }

  change() {
    return int.parse(keypadController.value.text) <= subtotal.value
        ? kembalian.value = 0.0
        : kembalian.value =
            subtotal.value - int.parse(keypadController.value.text);
  }

  var loading = true.obs;
  var productlist = <Product>[].obs;
  var listbaru = <Product>[].obs;
  var listbarang_baru = <Barang>[].obs;
  var listets = ['lol', 'lmao', 'XD'].obs;
  var isitest = [].obs;
  var produk_list = <ProdukElement>[].obs;
  var produklist_baru = <ProdukElement>[].obs;
  var keranjang_list = <KeranjangElement>[].obs;

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

  // void getbarang() async {
  //   try {
  //     loading(true);
  //     var checkconn = await check_conn.check();
  //     if (checkconn == true) {
  //       var barang = await api.get_barang();
  //       if (barang != null) {
  //         barang_list.value = barang;
  //       }
  //     } else {
  //       Get.snackbar('conn', 'tidak ada konenksi');
  //     }
  //   } finally {
  //     loading(false);
  //   }
  // }

  // Future<List<ProdukElement>> getprodukall() async {
  //   var response = await api().client.get(link().GET_produkv2);
  //   if (response.statusCode == 200) {
  //     var hasil = json.decode(response.body);
  //     var res = Produk.fromJson(hasil);
  //     print('--------------------------------------------------------------');
  //     print(res);
  //     produk_list.value = res.produk;
  //     return produk_list;
  //   } else {
  //     return [];
  //   }
  // }

  // void getproduct() async {
  //   try {
  //     loading(true);
  //     var checkconn = await check_conn.check();
  //     if (checkconn == true) {
  //       var product = await api.getproduct();
  //       if (product != null) {
  //         productlist.value = product;
  //       }
  //     } else {
  //       Get.snackbar('conn', 'tidak ada konenksi');
  //     }
  //   } finally {
  //     loading(false);
  //   }
  // }

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

  var qtydisplay = 0.obs;

  addqty() {
    qtydisplay.value + 1;
  }

// Future<dynamic> isikeranjang(String id) async {
//   var response = await api().client.post(link().POST_tambahkeranjang,
//       body: ({
//         'kode_produk': id,
//         'qty': '1',
//         'tgl': '123123',
//       }));
//   if (response.statusCode == 200) {
//     var hasil = json.decode(response.body);
//
//     print(
//         '-----------------------------keranjang add--------------------------');
//     getkeranjang();
//     return hasil;
//   } else {
//     Get.snackbar('error', response.statusCode.toString());
//     return [];
//   }
// }

// Future<List<KeranjangElement>> getkeranjang() async {
//   var response = await api().client.get(link().GET_keranjang);
//   if (response.statusCode == 200) {
//     var hasil = json.decode(response.body);
//     var res = Keranjang.fromJson(hasil);
//
//     print(
//         '-----------------------------get keranjang---------------------------------');
//     print(hasil);
//
//     keranjang_list.value = res.keranjang;
//     return keranjang_list;
//   } else {
//     Get.snackbar('error', response.statusCode.toString());
//     return [];
//   }
// }

// Future<dynamic> deletekeranjang(String id) async {
//   var response = await api().client.post(link().POST_deletekeranjang,
//       body: ({
//         'kode_produk': id,
//       }));
//   if (response.statusCode == 200) {
//     var hasil = json.decode(response.body);
//     print(
//         '-----------------------------keranjang delete--------------------------');
//     getkeranjang();
//     return hasil;
//   } else {
//     Get.snackbar('error', response.statusCode.toString());
//     return [];
//   }
// }

// Future<dynamic> deleteqty(String id) async {
//   var response = await api().client.post(link().POST_deleteqty,
//       body: ({
//         'kode_produk': id,
//       }));
//   if (response.statusCode == 200) {
//     var hasil = json.decode(response.body);
//     print(
//         '-----------------------------qty delete--------------------------');
//     getkeranjang();
//     return hasil;
//   } else {
//     Get.snackbar('error', response.statusCode.toString());
//     return [];
//   }
// }

// Future<dynamic> tambah_chekout() async {
//   var response =
//       await api().client.post(link().POST_tambahchekout, body: ({}));
//   if (response.statusCode == 200) {
//     var hasil = json.decode(response.body);
//     print(
//         '-----------------------------add chekout--------------------------');
//     //getkeranjang();
//     return hasil;
//   } else {
//     Get.snackbar('error', response.statusCode.toString());
//     return [];
//   }
// }

// Future<dynamic> tambah_history() async {
//   var response = await api().client.post(link().POST_tambahistory,
//       body: ({
//         'tgl': '3432',
//         'nomor_transaksi': '003939',
//         'id_kasir': '1',
//         'total': subtotal.value.toString(),
//       }));
//   if (response.statusCode == 200) {
//     var hasil = json.decode(response.body);
//     print(
//         '-----------------------------add history--------------------------');
//     //getkeranjang();
//     return hasil;
//   } else {
//     Get.snackbar('error', response.statusCode.toString());
//     return [];
//   }
// }
}
