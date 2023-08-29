import 'dart:async';
import 'dart:io';
import 'dart:math' as Math;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image/image.dart' as Img;
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

import '../../../Models/kategori.dart';
import '../../../Models/supliyer.dart';
import '../../../Services/image_provider.dart';

class tambah_produkController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    print('----------------------tambah produk init--------------------');
    //getjenis();
  }

  var metode_diskon = 9.obs;

  var jenisproduk = ['produk', 'jasa'].obs;
  var kategoriv2 = ['makanan', 'minuman'].obs;
  var defvalue = ''.obs;
  late var defdef = jenisproduk.first.obs;
  late var katkat = kategoriv2.first.obs;

  var defjenis = 'produk'.obs;
  var cc = 'qwe'.obs;
  RxString slideValueOld = "".obs;

  var kode_produk = TextEditingController().obs;
  var barcode = TextEditingController().obs;
  var nama_produk = TextEditingController().obs;
  var harga_jual = TextEditingController().obs;
  var satuan = TextEditingController().obs;
  var stock = TextEditingController().obs;

  var val_jenis = ''.obs;

  List kategori = ['Makanan', "minuman"].obs;

  /*final picker = ImagePicker();
  final cropper = ImageCropper();
  List? imageFileList = [];
  var namaFile = "";
  File? imgFile, imgPreview;

  Future getImageCamera() async {
    var imageFile = await picker.pickImage(source: ImageSource.camera);
    imageFileList!.add(imageFile);
    final tempDir = await getTemporaryDirectory();
    final path = tempDir.path;
    int rand = new Math.Random().nextInt(100000);
    namaFile = "img$rand.jpg";

    Img.Image? image = Img.decodeImage(await imageFile!.readAsBytes());
    Img.Image? smallerImg = Img.copyResize(image!, width: 500);

    var compressImg = new File("$path/$namaFile")
      ..writeAsBytesSync(Img.encodeJpg(smallerImg, quality: 90));

    */ /* setState(() {
      imgFile = compressImg;
    });*/ /*
  }*/

  var formKey = GlobalKey<FormState>().obs;

  void selectImages() async {
    final List<XFile>? selectedImages =
        await ImagePicker().pickMultiImage(imageQuality: 85, maxWidth: 500);
    if (selectedImages!.isNotEmpty) {
      imageFileList!.addAll(selectedImages);
    }
    print("Image List Length:" + imageFileList!.length.toString());
    //setState(() {});
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

  var kat_list = <Kategeori>[].obs;
  var suplier_list = <Supliyer>[].obs;
  var val_kat = ''.obs;
  var selected = ''.obs;
  var selected_sup = ''.obs;

  void setSelected(String value) {
    selected.value = value;
  }

  var checkbox = false.obs;

  void setSelectedsup(String value) {
    selected_sup.value = value;
  }

  var loading = true.obs;

  List? imageFileList = [].obs;
  File? imgFile;
  var imagesize = ''.obs;
  var imagepath = ''.obs;

  var cropimagepath = ''.obs;
  var cropimagesize = ''.obs;

  var compresimagepath = ''.obs;
  var compresimagesize = ''.obs;
  var namaFile = ''.obs;
  File? pickedImageFile;

  void getimagev2(ImageSource imagesource) async {
    final pickedfile = await ImagePicker().pickImage(source: imagesource);
    if (pickedfile != null) {
      /*imagepath.value = pickedfile.path;
      final dir = await Directory.systemTemp;
      final targetpath = dir.absolute.path + '/temp.jpg';
      var compressfile = await FlutterImageCompress.compressAndGetFile(
          imagepath.value, targetpath,
          quality: 90);
      compresimagepath.value = compressfile!.path;*/
      pickedImageFile = File(pickedfile.path);
      print(pickedImageFile.toString());
      up(pickedImageFile!);
    } else {
      Get.snackbar('error', 'no img');
    }
  }

  up(File file) {
    Get.dialog(
        Center(
          child: CircularProgressIndicator(),
        ),
        barrierDismissible: false);
    image_upload().up(file).then((res) {
      Get.back();
      if (res == 'success') {
        Get.snackbar('success', 'berhasil up');
      } else if (res == 'fail') {
        Get.snackbar('error', 'error');
      }
    }).onError((error, stackTrace) {
      Get.back;
      print('error up controller---------------');
      print(error.toString() + 'error up controller---------------');
    });
  }

  void getimage(ImageSource imagesource) async {
    final pickedfile = await ImagePicker().pickImage(source: imagesource);

    final tempDir = await getTemporaryDirectory();
    final path = tempDir.path;
    //imgFile = File(pickedfile!.path);

    int rand = new Math.Random().nextInt(100000);
    namaFile.value = "img$rand.jpg";

    Img.Image? image = Img.decodeImage(await pickedfile!.readAsBytes());
    Img.Image? smallerImg = Img.copyResize(image!, width: 500);

    var compressImg = new File("$path/$namaFile")
      ..writeAsBytesSync(Img.encodeJpg(smallerImg, quality: 85));
    imgFile = compressImg;
  }

  final ImagePicker picker = ImagePicker();
  List<XFile> images = [];
  List<String> listimagepath = [];
  var selectedfilecount = 0.obs;

  multiimage() async {
    images = (await picker.pickMultiImage())!;
    if (images != null) {
      for (XFile file in images) {
        listimagepath.add(file.path);
      }
    } else {
      Get.snackbar('err', 'no img selected');
    }
    selectedfilecount.value = listimagepath.length;
  }

  uploadimage() {
    if (selectedfilecount.value > 0) {
      Get.dialog(
          Center(
            child: CircularProgressIndicator(),
          ),
          barrierDismissible: false);
      image_upload().uploadimage(listimagepath).then((res) {
        Get.back();
        Get.snackbar('success', 'img uploaded');
        if (res == 'success') {
          Get.snackbar('success', 'img uploaded');
          images = [];
          listimagepath = [];
          selectedfilecount.value = listimagepath.length;
        }
      }).onError((error, stackTrace) {
        Get.back();
        print(error);
        Get.snackbar('error', 'fuck you');
      });
    } else {
      Get.snackbar('error', 'no img');
    }
  }
}
