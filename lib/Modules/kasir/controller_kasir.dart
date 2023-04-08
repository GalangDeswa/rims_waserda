import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:rims_waserda/Modules/Widgets/toast.dart';

import '../../Services/handler.dart';
import '../produk/data produk/model_produk.dart';
import '../produk/jenis produk/model_jenisproduk.dart';
import 'model_kasir.dart';

class kasirController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    print('kasir init------------------------------------------------->');
    fetchProduk();
    fetchjenis();
    //keypadController.value = TextEditingController(text: '0');
    // kembalian.value = TextEditingController(text: '0');

    fetchkeranjang();
  }

  Future<void> refresh() async {
    await fetchProduk();
    await fetchjenis();
  }

  final nominal = NumberFormat("#,##0");

  var kembalian = TextEditingController().obs;
  var keypadController = TextEditingController().obs;
  var keypadvalue = 0.0.obs;

  balik() {
    var kem = int.parse(keypadController.value.text) - int.parse(total.value);
    kem < 0
        ? kembalian.value.text = '0'
        : kembalian.value.text = kem.toString();
    //kembalian.value.text = kem.toString();
    print('---kembalian----');
    print(kembalian.value.text);
  }

  add_5000(String x) {
    if (keypadController.value.text.isEmpty) {
      keypadController.value.text = '5000';
    } else {
      var sum = int.parse(x) + 5000;
      print(sum);
      keypadController.value.text = sum.toString();
    }
  }

  add_10000(String x) {
    if (keypadController.value.text.isEmpty) {
      keypadController.value.text = '10000';
    } else {
      var sum = int.parse(x) + 10000;
      print(sum);
      keypadController.value.text = sum.toString();
    }
  }

  add_20000(String x) {
    if (keypadController.value.text.isEmpty) {
      keypadController.value.text = '20000';
    } else {
      var sum = int.parse(x) + 20000;
      print(sum);
      keypadController.value.text = sum.toString();
    }
  }

  add_50000(String x) {
    if (keypadController.value.text.isEmpty) {
      keypadController.value.text = '50000';
    } else {
      var sum = int.parse(x) + 50000;
      print(sum);
      keypadController.value.text = sum.toString();
    }
  }

  add_100000(String x) {
    if (keypadController.value.text.isEmpty) {
      keypadController.value.text = '100000';
    } else {
      var sum = int.parse(x) + 100000;
      print(sum);
      keypadController.value.text = sum.toString();
    }
  }

  var selectedIndex = 0.obs;

  var search = TextEditingController().obs;
  var meja = TextEditingController().obs;
  var jenislist = <DataJenis>[].obs;
  var keranjanglist = <DataKeranjang>[].obs;

  var id_user = GetStorage().read('id_user');
  var token = GetStorage().read('token');
  var id_toko = GetStorage().read('id_toko');
  var namakasir = GetStorage().read('name');
  var produklist = <DataProduk>[].obs;

  var subtotal = ''.obs;
  var total = ''.obs;

  fetchProduk() async {
    print('-------------------fetchProduk---------------------');

    // SchedulerBinding.instance.addPostFrameCallback(
    //     (_) => Get.dialog(loading(), barrierDismissible: false));
    //call dialog tidak bisa di init tanpa coding di atas

    var checkconn = await check_conn.check();
    if (checkconn == true) {
      var produk = await REST.produkAll(token, id_toko, search.value.text);
      if (produk != null) {
        print('-------------------dataproduk---------------');
        var dataProduk = ModelProduk.fromJson(produk);

        produklist.value = dataProduk.data;
        //produklist.refresh();
        //update();
        print('--------------------list produk---------------');
        print(produklist);

        //Get.back(closeOverlays: true);

        return produklist;
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

  fetchProdukByJenis(String id) async {
    print('-------------------fetchProdukbyjenis---------------------');

    var checkconn = await check_conn.check();
    if (checkconn == true) {
      var produk = await REST.produkbyjenis(token, id, id_toko);
      if (produk != null) {
        print('-------------------dataprodukbyjenis---------------');
        var dataProduk = ModelProduk.fromJson(produk);

        produklist.value = dataProduk.data;
        // produklist.refresh();
        //update();
        print('--------------------list produk by jneis---------------');
        print(produklist);

        //Get.back(closeOverlays: true);

        return produklist;
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

  fetchkeranjang() async {
    print('-------------------fetchkeranjang---------------------');

    var checkconn = await check_conn.check();
    if (checkconn == true) {
      var keranjang = await REST.kasirKeranjangData(
          token, id_user.toString(), id_toko, meja.value.text);
      if (keranjang != null) {
        print('-------------------data keranjang---------------');
        var dataKeranjang = ModelKeranjang.fromJson(keranjang);
        keranjanglist.value = dataKeranjang.data;
        subtotal.value = dataKeranjang.meta.subtotal;
        total.value = dataKeranjang.meta.total;
        print('-------------keranjang total---------');
        print(total);
        //keranjanglist.refresh();
        //update();
        print('--------------------list keranjang---------------');
        print(keranjanglist);

        //Get.back(closeOverlays: true);

        return keranjanglist;
      } else {
        // Get.back(closeOverlays: true);
        Get.showSnackbar(
            toast().bottom_snackbar_error('Error', 'Terjadi kesalahan'));
      }
    } else {
      //  Get.back(closeOverlays: true);
      Get.showSnackbar(
          toast().bottom_snackbar_error('Error', 'Periksa koneksi'));
    }
    return [];
  }

  fetchjenis() async {
    print('-------------------fetchJenis---------------------');

    var checkconn = await check_conn.check();
    if (checkconn == true) {
      var jenis = await REST.produkJenis(token, id_toko);
      if (jenis != null) {
        print('-------------------datajenis---------------');
        var dataJenis = ModelJenis.fromJson(jenis);

        jenislist.value = dataJenis.data;
        // jenislist.refresh();
        //update();
        print('--------------------list jenis---------------');
        print(jenislist);

        //Get.back(closeOverlays: true);

        return jenislist;
      } else {
        //Get.back(closeOverlays: true);
        Get.showSnackbar(
            toast().bottom_snackbar_error('Error', 'gagal fect jenis'));
      }
    } else {
      Get.back(closeOverlays: true);
      Get.showSnackbar(
          toast().bottom_snackbar_error('Error', 'periksa koneksi'));
    }
    return [];
  }

  tambahKeranjang(String idproduk, diskon_brg, qty) async {
    print('-------------------Tambah keranjang---------------------');

    var checkconn = await check_conn.check();
    if (checkconn == true) {
      var keranjang = await REST.kasirKeranjangTambah(token, id_user, id_toko,
          meja.value.text, idproduk.toString(), diskon_brg, qty);
      if (keranjang != null) {
        print('------------------tambah keranjang---------------');
        await fetchkeranjang();
        // Get.showSnackbar(
        //     toast().bottom_snackbar_success('Berhasil', 'berhasil di tambah'));
      } else {
        //Get.back(closeOverlays: true);
        Get.showSnackbar(
            toast().bottom_snackbar_error('Error', 'Gagal di tambah'));
      }
    } else {
      Get.back(closeOverlays: true);
      Get.showSnackbar(
          toast().bottom_snackbar_error('Error', 'periksa koneksi'));
    }
    return [];
  }

  deleteKeranjang(String id, idproduk) async {
    print('-------------------delete keranjang---------------------');

    var checkconn = await check_conn.check();
    if (checkconn == true) {
      var keranjang = await REST.kasirKeranjangHapus(
          token, id, id_user, id_toko, idproduk, meja.value.text);
      if (keranjang != null) {
        print('------------------delete keranjang---------------');
        await fetchkeranjang();
        Get.back();
        // Get.showSnackbar(
        //     toast().bottom_snackbar_success('Berhasil', 'berhasil di hapus'));
      } else {
        //Get.back(closeOverlays: true);
        Get.showSnackbar(
            toast().bottom_snackbar_error('Error', 'Gagal di hapus'));
      }
    } else {
      Get.back(closeOverlays: true);
      Get.showSnackbar(toast().bottom_snackbar_error('Error', 'periksa hapus'));
    }
    return [];
  }

  pembayaran() async {
    print('------------------pembayaran---------------------');

    var checkconn = await check_conn.check();
    if (checkconn == true) {
      var keranjang = await REST.kasirPembayaran(token, id_user, id_toko,
          meja.value.text, keypadController.value.text);
      if (keranjang != null) {
        print('------------------pembayaran--------------');
        await fetchkeranjang();
        //popscreen().popberhasil();
        Get.back();
        Get.showSnackbar(
            toast().bottom_snackbar_success('Berhasil', 'pembayaran berhasil'));
      } else {
        //Get.back(closeOverlays: true);
        Get.showSnackbar(
            toast().bottom_snackbar_error('Error', 'Gagal di bayar'));
      }
    } else {
      Get.back(closeOverlays: true);
      Get.showSnackbar(toast().bottom_snackbar_error('Error', 'periksa hapus'));
    }
    return [];
  }

  var num = 1.obs;
  var i = 0.obs;
  var groupindex = 9.obs;

  var currencyFormatter = NumberFormat('#,##0', 'ID');

  //int newnum1 = int.parse(str.replaceAll(RegExp(r'[^0-9]'), ''));
  //var groupbutton = GroupButtonController(selectedIndex: 3).obs;

  var list = [].obs;

  void addlist() {
    num++;

    list.add(num);
  }

  // totalqty() {
  //   int qty = keranjang_list
  //       .map((element) => element.qty)
  //       .fold(1, (prev, amount) => prev + int.parse(amount!));
  //   totalitem.value = qty;
  //   return totalitem;
  // }

  // totalkeranjang() {
  //   double sum = keranjang_list
  //       .map((expense) => expense.harga)
  //       .fold(0, (prev, amount) => prev + int.parse(amount!));
  //   subtotal.value = sum;
  //   return subtotal;
  // }

  // change() {
  //   return int.parse(keypadController.value.text) <= subtotal.value
  //       ? kembalian.value = 0.0
  //       : kembalian.value =
  //           subtotal.value - int.parse(keypadController.value.text);
  // }

  void reset() {
    Get.snackbar('result', "delete kon");
    Get.delete<kasirController>();
    Get.put<kasirController>;
  }

  var barcodetext = TextEditingController().obs;
  var qrcode = ''.obs;
  String scaned_qr_code = '';

  // Future<void> scan() async {
  //   try {
  //     scaned_qr_code = await FlutterBarcodeScanner.scanBarcode(
  //         '#ff6666', 'cancel', true, ScanMode.QR);
  //     Get.snackbar('result', scaned_qr_code);
  //     barcodetext.value.text = scaned_qr_code;
  //   } on PlatformException {}
  // }

  // Future<void> scankasir() async {
  //   try {
  //     scaned_qr_code = await FlutterBarcodeScanner.scanBarcode(
  //         '#ff6666', 'cancel', true, ScanMode.QR);
  //     if (scaned_qr_code != '-1') {
  //       Get.snackbar('result', scaned_qr_code);
  //       var qr = productlist
  //           .where((e) => e.id.toString().contains(scaned_qr_code.toString()))
  //           .first;
  //       print(
  //           'test scan kasir-------------------------------------------------');
  //       print(qr);
  //       listbaru.add(qr);
  //     } else {
  //       Get.snackbar('result', "scan canceled");
  //     }
  //   } on PlatformException {}
  // }

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
