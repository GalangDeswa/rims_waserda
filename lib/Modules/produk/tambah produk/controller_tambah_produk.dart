import 'dart:async';
import 'dart:io';
import 'dart:math' as Math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
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

  // Future<List> getjenis() async {
  //   var response = await api().client.get(link().GET_jenisproduk);
  //   if (response.statusCode == 200) {
  //     var hasil = json.decode(response.body);
  //     jenisproduk.value = hasil;
  //
  //     print('--------------------------------------------------------------');
  //     print(jenisproduk);
  //     return jenisproduk;
  //   } else {
  //     return [];
  //   }
  // }

  // Future<dynamic> tambahbarang() async {
  //   Get.dialog(
  //       Center(
  //         child: CircularProgressIndicator(),
  //       ),
  //       barrierDismissible: false);
  //
  //   var response = await api().client.post(link().POST_tambahproduk,
  //       body: ({
  //         'nama_produk': nama_produk.value.text,
  //         'harga': harga_jual.value.text,
  //         'id_kategori': '1',
  //         'kode_produk': kode_produk.value.text,
  //         'barcode': barcode.value.text,
  //         'id_jenis': '1',
  //         'satuan': satuan.value.text,
  //         'stock': stock.value.text,
  //       }));
  //
  //   if (response != null) {
  //     var hasil = json.decode(response.body);
  //     Get.back();
  //     Get.snackbar('sukses', 'user di tambah');
  //
  //     return hasil;
  //   } else {
  //     Get.back();
  //     Get.snackbar(
  //       "Error",
  //       'gagal tambah',
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

  Future<void> scan() async {
    try {
      scaned_qr_code = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'cancel', true, ScanMode.QR);
      Get.snackbar('result', scaned_qr_code);
      barcodetext.value.text = scaned_qr_code;
    } on PlatformException {}
  }

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

  // void getsuplier() async {
  //   try {
  //     loading(true);
  //     var checkconn = await check_conn.check();
  //     if (checkconn == true) {
  //       var suplier = await api.get_suplier();
  //       if (suplier != null) {
  //         suplier_list.value = suplier;
  //       }
  //     } else {
  //       Get.snackbar('conn', 'tidak ada konenksi');
  //     }
  //   } finally {
  //     loading(false);
  //   }
  // }

  // void getkategori() async {
  //   try {
  //     loading(true);
  //     var checkconn = await check_conn.check();
  //     if (checkconn == true) {
  //       var list = await api.get_kategori();
  //       if (list != null) {
  //         kat_list.value = list;
  //       }
  //     } else {
  //       Get.snackbar('conn', 'tidak ada konenksi');
  //     }
  //   } finally {
  //     loading(false);
  //   }
  // }

  var barang_kode = TextEditingController().obs;
  var barang_jenis = TextEditingController().obs;
  var barang_nama = TextEditingController().obs;
  var barang_id_kategori = TextEditingController().obs;
  var barang_id_supliyer = TextEditingController().obs;
  var barang_harga = TextEditingController().obs;
  var barang_qty = TextEditingController().obs;
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

// Future<Map<String, dynamic>?> register_tambah_barang() async {
//   final postbarang = http.MultipartRequest('POST', link().POST_produk);
//   if (imgFile != null) {
//     /* postbarang.files
//         .add(await http.MultipartFile.fromPath('foto[]', imgFile!.path));*/
//     final mimeTypeData =
//         lookupMimeType(imgFile!.path, headerBytes: [0xFF, 0xD8])!.split('/');
//     final foto = await http.MultipartFile.fromPath('foto[]', imgFile!.path,
//         contentType: MediaType(mimeTypeData[0], mimeTypeData[1]));
//
//     postbarang.files.add(foto);
//   }
//
//   postbarang.fields['kode_barang'] = barang_kode.value.text;
//   postbarang.fields['jenis_barang'] = barang_jenis.value.text;
//   postbarang.fields['nama_barang'] = barang_nama.value.text;
//
//   postbarang.fields['id_kategori'] = selected.value;
//   postbarang.fields['id_supliyer'] = selected_sup.value;
//
//   postbarang.fields['harga'] = barang_harga.value.text;
//
//   postbarang.fields['qty'] = barang_qty.value.text;
//
//   try {
//     final streamedResponse = await postbarang.send();
//     final response = await http.Response.fromStream(streamedResponse);
//     if (response.statusCode != 200) {
//       print(response.statusCode);
//       return null;
//     }
//     final Map<String, dynamic> responseData = json.decode(response.body);
//     print(responseData);
//     Get.snackbar('pesan', 'Berhasil di tambah');
//     return responseData;
//   } catch (e) {
//     print(e);
//     return null;
//   }
// }

/*void start_register_tambah_barang() async {
    if (barang_namaText != '' ||
        barang_hargaText != '' ||
        barang_descText != '') {
      formKey.currentState?.save();

      final Map<String, dynamic>? response = await register_tambah_barang();

      // Check if any error occured
      if (response == null) {
        pr.hide();
        BotToast.showSimpleNotification(title: 'gagal');

        print(response);
      } else {
        Get.off(() => detail_toko_setting());
        BotToast.showText(
            text: 'Berhasil di tambah',
            contentColor: Colors.green,
            textStyle:
                TextStyle(fontWeight: FontWeight.bold, color: Colors.white));
      }
    }
  }*/
}
