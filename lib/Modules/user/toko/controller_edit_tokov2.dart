import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rims_waserda/Modules/base%20menu/controller_base_menu.dart';

import '../../../Services/handler.dart';
import '../../../Templates/setting.dart';
import '../../Widgets/buttons.dart';
import '../../Widgets/header.dart';
import '../../Widgets/loading.dart';
import '../../Widgets/toast.dart';
import '../../dashboard/controller_dashboard.dart';

class edittokov2Controller extends GetxController {
  @override
  Future<void> onInit() async {
    // TODO: implement onInit
    super.onInit();
    await loadtoko();
    print([
      NamaToko.value,
      JenisToko.value,
      Alamat.value,
      Email.value,
      NoHp.value,
      Logo.value
    ]);
    nama_toko.value = TextEditingController(text: NamaToko.value);
    jenis_usaha.value = TextEditingController(text: JenisToko.value);
    alamat.value = TextEditingController(text: Alamat.value);
    email.value = TextEditingController(text: Email.value);
    no_hp.value = TextEditingController(text: NoHp.value);

    Logo.value == '' || Logo.value == null || Logo.value == '-'
        ? checkfoto.value = false
        : checkfoto.value = true;
  }

  var NamaToko = ''.obs;
  var JenisToko = ''.obs;
  var Alamat = ''.obs;
  var Email = ''.obs;
  var Logo = ''.obs;
  var NoHp = ''.obs;
  var token = GetStorage().read('token');
  var id_toko = GetStorage().read('id_toko');

  loadtoko() async {
    NamaToko.value = await GetStorage().read('nama_toko');
    JenisToko.value = await GetStorage().read('jenis_toko');
    Alamat.value = await GetStorage().read('alamat_toko');
    Email.value = await GetStorage().read('email_toko');
    Logo.value = await GetStorage().read('logo_toko') ?? '-';
    NoHp.value = await GetStorage().read('no_hp');
  }

  var nama_toko = TextEditingController().obs;
  var jenis_usaha = TextEditingController().obs;
  var alamat = TextEditingController().obs;
  var no_hp = TextEditingController().obs;
  var email = TextEditingController().obs;
  var jumlahbeban = 0.0.obs;

  var formKeytoko = GlobalKey<FormState>().obs;

  var checkfoto = false.obs;

  File? pickedImageFile;
  var pikedImagePath = ''.obs;
  final ImagePicker picker = ImagePicker();
  List<XFile> images = [];
  List<String> listimagepath = [];
  var selectedfilecount = 0.obs;

  String stringGenerator(int len) {
    var random = Random.secure();
    var values = List<int>.generate(len, (i) => random.nextInt(255));
    var uniqueId = base64UrlEncode(values);
    print(uniqueId);
    return uniqueId;
  }

  pilihsourcefoto() {
    Get.dialog(AlertDialog(
      title: header(
          iscenter: false,
          title: 'Foto toko',
          icon: Icons.image,
          icon_color: Colors.white,
          base_color: Colors.white),
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

  var image64;

  Future pickImageCamera() async {
    try {
      final image = await ImagePicker().pickImage(
          source: ImageSource.camera,
          imageQuality: 85,
          maxHeight: 300,
          maxWidth: 300);
      if (image == null) return;
      pickedImageFile = File(image.path);
      final bytes = File(image!.path).readAsBytesSync();
      String base64Image = base64Encode(bytes);
      image64 = base64Image;
      pikedImagePath.value = pickedImageFile!.path;
      print(pikedImagePath);
      print(image64);
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
      final bytes = File(image!.path).readAsBytesSync();
      String base64Image = base64Encode(bytes);
      image64 = base64Image;
      pikedImagePath.value = pickedImageFile!.path;
      print(pikedImagePath);
      print(image64);
      Get.back();
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  clear() {
    nama_toko.value.clear();
    jenis_usaha.value.clear();
    alamat.value.clear();
    email.value.clear();
    no_hp.value.clear();
  }

  editToko() async {
    print('-------------------edit toko---------------------');

    Get.dialog(showloading(), barrierDismissible: false);
    var checkconn = await check_conn.check();
    if (checkconn == true) {
      var toko = await REST.editToko(
          token: token,
          id: id_toko,
          alamat: alamat.value.text,
          email: email.value.text,
          jenisusaha: jenis_usaha.value.text,
          logo: image64 ?? '-',
          nama_toko: nama_toko.value.text,
          nohp: no_hp.value.text);
      if (toko['success'] == true) {
        await GetStorage().write('nama_toko', nama_toko.value.text);
        await GetStorage().write('jenis_toko', jenis_usaha.value.text);
        await GetStorage().write('alamat_toko', alamat.value.text);
        await GetStorage().write('email_toko', email.value.text);
        await GetStorage().write('logo_toko', image64);
        await GetStorage().write('no_hp', no_hp.value.text);
        await Get.find<dashboardController>().initstorage();
        await Get.find<base_menuController>().onInit();
        clear();
        Get.back(closeOverlays: true);
        Get.showSnackbar(
            toast().bottom_snackbar_success('Berhasil', toko['message']));
      } else {
        Get.back(closeOverlays: true);
        Get.showSnackbar(
            toast().bottom_snackbar_error('Error', ' Toko gagal edit'));
      }
    } else {
      Get.back(closeOverlays: true);
      Get.showSnackbar(
          toast().bottom_snackbar_error('Error', 'Periksa Koneksi Internet'));
    }
    return [];
  }
}
