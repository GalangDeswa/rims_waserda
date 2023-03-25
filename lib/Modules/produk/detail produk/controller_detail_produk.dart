import 'dart:io';
import 'dart:math' as Math;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image/image.dart' as Img;
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

import '../../../Models/kategori.dart';
import '../../../Models/supliyer.dart';
import '../../../Services/handler.dart';
import '../../../Services/image_provider.dart';
import '../../../Templates/setting.dart';
import '../../Widgets/buttons.dart';
import '../../Widgets/header.dart';
import '../../Widgets/loading.dart';
import '../../Widgets/toast.dart';
import '../jenis produk/model_jenisproduk.dart';

class detail_produkController extends GetxController {
  var id_user = GetStorage().read('id_user');
  var token = GetStorage().read('token');
  var id_toko = GetStorage().read('id_toko');

  var formKey = GlobalKey<FormState>().obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchjenis();

    nama_produk.value = TextEditingController(text: data.namaProduk);
    harga.value = TextEditingController(text: data.harga);
    desc.value = TextEditingController(text: data.deskripsi);
    qtyv2.value = TextEditingController(text: data.qty);
    jenisvalue.value = data.idJenis.toString();
  }

  var jenislist = <DataJenis>[].obs;

  var qtyv2 = TextEditingController().obs;

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

        //Get.back(closeOverlays: true);

        return jenislist;
      } else {
        // Get.back(closeOverlays: true);
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
      //Get.back(closeOverlays: true);
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

  editqty() async {
    print('-------------------edit jenis---------------------');

    Get.dialog(showloading(), barrierDismissible: false);
    var checkconn = await check_conn.check();
    if (checkconn == true) {
      var qty = await REST.produkqtytambah(
          token, data.id, id_toko, qtyadd.value.text);
      if (qty != null) {
        print(qty);
        Get.back(closeOverlays: true, result: true);
        Get.showSnackbar(
            toast().bottom_snackbar_success('Berhasil', 'qty Berhasil diedit'));
      } else {
        Get.back(closeOverlays: true);
        Get.showSnackbar(
            toast().bottom_snackbar_error('Error', 'qty Gagal diedit'));
      }
    } else {
      Get.back(closeOverlays: true);
      Get.showSnackbar(
          toast().bottom_snackbar_error('Error', 'Periksa Koneksi Internet'));
    }
    return [];
  }

  var qtyadd = TextEditingController().obs;

  add() {
    var sum = int.parse(qtyv2.value.text) + int.parse(qtyadd.value.text);

    print(sum);
    qtyv2.value.text = sum.toString();
    Get.back();
  }

  sumqty() async {
    add();
    editqty();
  }

  void addqty(
    BuildContext context,
    detail_produkController controller,
  ) {
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: header(
                title: 'Tambah Qty',
                icon: Icons.warning,
                icon_color: color_template().tritadery,
                base_color: color_template().tritadery),
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
                        Expanded(
                          child: Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  controller: qtyadd.value,
                                  style: font().header_black,
                                ),
                              ),
                            ],
                          ),
                        ),
                        button_solid_custom(
                            onPressed: () {
                              add();
                            },
                            child: Text(
                              'edit qty',
                              style: font().primary_white,
                            ),
                            width: context.width_query / 4,
                            height: context.height_query / 10),
                        button_border_custom(
                            onPressed: () {
                              Get.back();
                            },
                            child: Text(
                              'Batal',
                              style: font().primary,
                            ),
                            width: context.width_query / 4,
                            height: context.height_query / 10)
                      ],
                    ));
              },
            ),
          );
        });
  }

  var data = Get.arguments;

  late RxString jenisvalue = data.idJenis.toString().obs;

  var desc = TextEditingController().obs;
  var nama_produk = TextEditingController().obs;
  var harga = TextEditingController().obs;
  var nama_jenis = TextEditingController().obs;

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
