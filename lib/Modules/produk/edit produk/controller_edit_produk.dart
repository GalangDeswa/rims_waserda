import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:rims_waserda/Modules/produk/data%20produk/controller_data_produk.dart';

import '../../../Services/handler.dart';
import '../../../Templates/setting.dart';
import '../../Widgets/buttons.dart';
import '../../Widgets/header.dart';
import '../../Widgets/loading.dart';
import '../../Widgets/toast.dart';
import '../data produk/model_produk.dart';
import '../jenis produk/model_jenisproduk.dart';

class editprodukController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchjenis();
    nama_produk.value = TextEditingController(text: data.namaProduk);
    desc.value = TextEditingController(text: data.deskripsi);
    harga.value = TextEditingController(text: data.harga);
    qty.value = TextEditingController(text: data.qty);
    diskon_barang.value =
        TextEditingController(text: data.diskonBarang.toString());

    pikedImagePath.value = data.image.toString();
    //pickedImageFile = File(data.image);

    jenisvalue.value = data.idJenis.toString();
    jenisstokval.value = data.idJenisStock.toString();
    print('id jenis stock-----------------------------------');
    print(jenisstokval);
    jj.value = data.idJenisStock.toString();
  }

  pilihsourcefoto() {
    Get.dialog(AlertDialog(
      title: header(
          iscenter: true,
          title: 'Foto Produk',
          icon: Icons.image,
          icon_color: color_template().primary,
          base_color: color_template().primary),
      contentPadding: EdgeInsets.all(10),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(12.0),
        ),
      ),
      content: Builder(
        builder: (context) {
          return Container(
              width: context.width_query / 2.6,
              height: context.height_query / 2.6,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "pilih sumber foto",
                    style: font().header_black,
                  ),
                  button_solid_custom(
                      onPressed: () {
                        pickImageGallery();
                      },
                      child: Text(
                        'Galery',
                        style: font().primary_white,
                      ),
                      width: context.width_query / 4,
                      height: context.height_query / 10),
                  button_border_custom(
                      onPressed: () {
                        pickImageCamera();
                      },
                      child: Text(
                        'Kamera',
                        style: font().primary,
                      ),
                      width: context.width_query / 4,
                      height: context.height_query / 10)
                ],
              ));
        },
      ),
    ));
  }

  Future pickImageCamera() async {
    try {
      final image = await ImagePicker().pickImage(
          source: ImageSource.camera,
          imageQuality: 85,
          maxHeight: 300,
          maxWidth: 300);
      if (image == null) return;
      pickedImageFile = File(image.path);
      pikedImagePath.value = pickedImageFile!.path;
      print(pikedImagePath);
      Get.back();
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  Future pickImageGallery() async {
    try {
      final image = await ImagePicker().pickImage(
          source: ImageSource.gallery,
          imageQuality: 85,
          maxHeight: 300,
          maxWidth: 300);
      if (image == null) return;
      pickedImageFile = File(image.path);
      pikedImagePath.value = pickedImageFile!.path;
      print(pikedImagePath);
      Get.back();
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  var jj = ''.obs;

  var jumlahharga = 0.obs;
  var jumlahdiskon = 0.0.obs;

  var diskon_barang = TextEditingController().obs;
  late var jenisvalue = data.idJenis.toString().obs;
  late var jenisstokval = data.idJenisStock.toString().obs;

  var jenisstok = [
    {'id': 1, 'nama': 'Stock'},
    {
      'id': 2,
      'nama': 'Non stock',
    }
  ].obs;

  ProdukEdit() async {
    print('-------------------edit Produk---------------------');

    Get.dialog(showloading(), barrierDismissible: false);
    var checkconn = await check_conn.check();
    if (checkconn == true) {
      var produk = await REST.produkEdit(
          token: token,
          idjenis: jenisvalue.value,
          id: data.id,
          // idjenisstock: jenisstokval.value,
          idtoko: id_toko,
          iduser: id_user,
          desc: desc.value.text,
          diskon_barang: jumlahdiskon.value.toString(),
          harga: jumlahharga.value.toString(),
          namaproduk: nama_produk.value.text,
          image: pickedImageFile);
      if (produk != null) {
        print(produk);

        await Get.find<produkController>().fetchProduk();
        Get.back(closeOverlays: true, result: true);
        Get.showSnackbar(toast().bottom_snackbar_success(
            'Berhasil', 'Produk Berhasil diperbaharui'));
      } else {
        Get.back(closeOverlays: true);
        Get.showSnackbar(toast()
            .bottom_snackbar_error('Error', 'Produk Gagal diperbaharui'));
      }
    } else {
      Get.back(closeOverlays: true);
      Get.showSnackbar(
          toast().bottom_snackbar_error('Error', 'Periksa Koneksi Internet'));
    }
    return [];
  }

  var data = Get.arguments;

  final nominal = NumberFormat("#,##0");
  var formKeyprodukedit = GlobalKey<FormState>().obs;
  var formKeyjenis = GlobalKey<FormState>().obs;
  var loading = true.obs;

  var id_user = GetStorage().read('id_user');
  var token = GetStorage().read('token');
  var id_toko = GetStorage().read('id_toko');

  var produklist = <DataProduk>[].obs;
  var jenislist = <DataJenis>[].obs;

  var compresimagepath = ''.obs;
  var compresimagesize = ''.obs;
  var namaFile = ''.obs;
  File? pickedImageFile;
  var pikedImagePath = ''.obs;
  final ImagePicker picker = ImagePicker();
  List<XFile> images = [];
  List<String> listimagepath = [];
  var selectedfilecount = 0.obs;

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(
          source: ImageSource.camera,
          imageQuality: 85,
          maxHeight: 300,
          maxWidth: 300);
      if (image == null) return;
      pickedImageFile = File(image.path);
      pikedImagePath.value = pickedImageFile!.path;
      print(pikedImagePath);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  var search = TextEditingController().obs;

  fetchProduk() async {
    print('-------------------fetchProduk---------------------');

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

        Get.back(closeOverlays: true);

        return produklist;
      } else {
        Get.back(closeOverlays: true);
        Get.snackbar(
          "Error",
          "Data user gagal,user tidak ada",
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
        "Data user gagal,periksa koneksi",
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
        jenislist.refresh();
        //update();
        print('--------------------list jenis---------------');
        print(jenislist);

        return jenislist;
      } else {
        Get.back(closeOverlays: true);
        Get.snackbar(
          "Error",
          "Data jenis tidak ada",
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
        "Data user gagal,periksa koneksi",
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
    return [];
  }

  var desc = TextEditingController().obs;
  var nama_produk = TextEditingController().obs;
  var harga = TextEditingController().obs;
  var nama_jenis = TextEditingController().obs;

  var qty = TextEditingController().obs;
  var image;

  deleteproduk(String id) async {
    Get.dialog(showloading(), barrierDismissible: false);
    var checkconn = await check_conn.check();
    if (checkconn == true) {
      var produk = await REST.produkdelete(token, id, id_toko);
      if (produk != null) {
        print(produk);
        await fetchProduk();

        Get.back(closeOverlays: true, result: true);
        Get.showSnackbar(toast()
            .bottom_snackbar_success('Berhasil', 'produk Berhasil dihapus'));

        print('-----------batas----toasrp0-------------');
      } else {
        Get.back(closeOverlays: true);
        Get.showSnackbar(
            toast().bottom_snackbar_error('Error', 'gagal menghapus'));
      }
    } else {
      Get.back(closeOverlays: true);
      Get.showSnackbar(
          toast().bottom_snackbar_success('Error', 'periksa koneksi'));
    }
  }

  jenisTambah() async {
    print('-------------------tambah jenis---------------------');

    Get.dialog(showloading(), barrierDismissible: false);
    var checkconn = await check_conn.check();
    if (checkconn == true) {
      var jenis =
          await REST.produkJenisTambah(token, id_toko, nama_jenis.value.text);
      if (jenis != null) {
        print(jenis);

        await fetchjenis();
        update();
        nama_jenis.value.clear();
        Get.back();
        Get.back();
        Get.showSnackbar(toast()
            .bottom_snackbar_success('Berhasil', 'kategori Berhasil diTambah'));
      } else {
        Get.back(closeOverlays: true);
        Get.showSnackbar(
            toast().bottom_snackbar_error('Error', 'jenis Gagal diTambah'));
      }
    } else {
      Get.back(closeOverlays: true);
      Get.showSnackbar(
          toast().bottom_snackbar_error('Error', 'Periksa Koneksi Internet'));
    }
    return [];
  }

  jenisEdit() async {
    print('-------------------edit jenis---------------------');

    Get.dialog(showloading(), barrierDismissible: false);
    var checkconn = await check_conn.check();
    if (checkconn == true) {
      var jenis = await REST.produkJenisedit(
          token, data.id, id_toko, nama_jenis.value.text);
      if (jenis != null) {
        print(jenis);
        Get.showSnackbar(toast()
            .bottom_snackbar_success('Berhasil', 'jenis Berhasil diedit'));
        Get.back(closeOverlays: true, result: true);
      } else {
        Get.back(closeOverlays: true);
        Get.showSnackbar(
            toast().bottom_snackbar_error('Error', 'jenis Gagal diedit'));
      }
    } else {
      Get.back(closeOverlays: true);
      Get.showSnackbar(
          toast().bottom_snackbar_error('Error', 'Periksa Koneksi Internet'));
    }
    return [];
  }

  deletejenis(String id) async {
    Get.dialog(
      showloading(),
      barrierDismissible: false,
    );
    var checkconn = await check_conn.check();
    if (checkconn == true) {
      var jenis = await REST.produkJenidelete(token, id, id_toko);
      if (jenis != null) {
        print(jenis);
        //get.back close overlay otomatis close dan back page sebelumnya?

        Get.back(closeOverlays: true);

        Get.showSnackbar(toast()
            .bottom_snackbar_success('Berhasil', 'jenis Berhasil dihapus'));
      } else {
        Get.back(closeOverlays: true);
        Get.showSnackbar(
            toast().bottom_snackbar_error('Error', 'gagal menghapus'));
      }
    } else {
      Get.back(closeOverlays: true);
      Get.showSnackbar(
          toast().bottom_snackbar_success('Error', 'periksa koneksi'));
    }
  }
}
