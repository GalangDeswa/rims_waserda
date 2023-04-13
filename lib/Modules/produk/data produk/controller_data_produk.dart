import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:rims_waserda/Models/produkv2.dart';
import 'package:rims_waserda/Modules/Widgets/toast.dart';
import 'package:rims_waserda/Modules/kasir/controller_kasir.dart';
import 'package:rims_waserda/Modules/produk/data%20produk/view_produk_table.dart';
import 'package:rims_waserda/Modules/produk/jenis%20produk/model_jenisproduk.dart';
import 'package:rims_waserda/Modules/produk/jenis%20produk/view_jenis_table.dart';
import 'package:rims_waserda/Services/handler.dart';

import '../../../Templates/setting.dart';
import '../../Widgets/buttons.dart';
import '../../Widgets/header.dart';
import '../../Widgets/loading.dart';
import 'model_produk.dart';

class produkController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    //getprodukall();
    //check_conn.check();
    fetchProduk();
    fetchjenis();
    //nama_jenis.value = TextEditingController(text: data.namaJenis);
    //Get.snackbar('sukses', 'produk controller init');

    print('produk controller--------------------------------------->');
  }

  final nominal = NumberFormat("#,##0");
  var formKeyproduk = GlobalKey<FormState>().obs;
  var formKeyjenis = GlobalKey<FormState>().obs;
  var loading = true.obs;
  var produk_list = <ProdukElement>[].obs;
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

  List<Widget> table = const [
    produk_table(),
    jenis_table(),
  ];
  RxInt selectedindex = 0.obs;

  var search = TextEditingController().obs;

  next() async {
    final respon = await http.post(Uri.parse(nextdata), body: {
      'token': token,
      'id_toko': id_toko,
      'search': search.value.text,
    });
    final datav2 = json.decode(respon.body);
    var dataProduk = ModelProduk.fromJson(datav2);
    final data = json.decode(respon.body)['meta'];
    produklist.value = dataProduk.data;
    previouspage = data['pagination']['links']['previous'];
    nextdata = data['pagination']['links']['next'];
    currentpage.value = data['pagination']['current_page'];
    count.value = data['pagination']['count'];
    totaldata.value = data['pagination']['total'];
    perpage.value = data['pagination']['per_page'];
    print(nextdata);
    print(data);

    //return produk_list;
  }

  back() async {
    final respon = await http.post(Uri.parse(previouspage), body: {
      'token': token,
      'id_toko': id_toko,
      'search': search.value.text,
    });
    final datav2 = json.decode(respon.body);
    var dataProduk = ModelProduk.fromJson(datav2);
    final data = json.decode(respon.body)['meta'];
    produklist.value = dataProduk.data;

    previouspage = data['pagination']['links']['previous'];
    nextdata = data['pagination']['links']['next'];
    count.value = data['pagination']['count'];
    totaldata.value = data['pagination']['total'];
    currentpage.value = data['pagination']['current_page'];
    perpage.value = data['pagination']['per_page'];
    print(previouspage);

    //return produk_list;
  }

  var totalpage = 0.obs;
  var totaldata = 0.obs;
  var currentpage = 0.obs;
  var nextpage;
  var count = 0.obs;

  var nextdata;
  var previouspage;
  var perpage = 0.obs;

  fetchProduk() async {
    print('-------------------fetchProduk---------------------');

    var checkconn = await check_conn.check();
    if (checkconn == true) {
      var produk = await REST.produkAll(token, id_toko, search.value.text);
      if (produk != null) {
        print('-------------------dataproduk---------------');
        var dataProduk = ModelProduk.fromJson(produk);

        produklist.value = dataProduk.data;
        totalpage.value = dataProduk.meta.pagination.totalPages;
        totaldata.value = dataProduk.meta.pagination.total;
        perpage.value = dataProduk.meta.pagination.perPage;
        currentpage.value = produk['meta']['pagination']['current_page'];
        count.value = dataProduk.meta.pagination.count;
        if (totalpage > 1) {
          nextdata = produk['meta']['pagination']['links']['next'];
        }

        print('--------------------list produk---------------');
        print(produklist);

        Get.back(closeOverlays: true);

        return produklist;
      } else {
        Get.back(closeOverlays: true);
        Get.showSnackbar(
            toast().bottom_snackbar_error('Error', 'Produk gagal ditampilkan'));
      }
    } else {
      Get.back(closeOverlays: true);
      Get.showSnackbar(
          toast().bottom_snackbar_error('Error', 'Produk gagal ditampilkan'));
    }
    // return [];
  }

  var totalpagejenis = 0.obs;
  var totaldatajenis = 0.obs;
  var currentpagejenis = 0.obs;
  var nextpagejeis;
  var countjenis = 0.obs;

  var nextdatajenis;
  var previouspagejenis;
  var perpagejenis = 0.obs;

  nextjenis() async {
    final respon = await http.post(Uri.parse(nextdatajenis), body: {
      'token': token,
      'id_toko': id_toko,
      'search': search.value.text,
    });
    final datav2 = json.decode(respon.body);
    var dataJenis = ModelJenis.fromJson(datav2);
    final data = json.decode(respon.body)['meta'];
    jenislist.value = dataJenis.data;
    previouspagejenis = data['pagination']['links']['previous'];
    nextdatajenis = data['pagination']['links']['next'];
    currentpagejenis.value = data['pagination']['current_page'];
    countjenis.value = data['pagination']['count'];
    totaldatajenis.value = data['pagination']['total'];
    perpagejenis.value = data['pagination']['per_page'];
    print(nextdatajenis);
    print(data);

    //return produk_list;
  }

  backjenis() async {
    final respon = await http.post(Uri.parse(previouspagejenis), body: {
      'token': token,
      'id_toko': id_toko,
      'search': search.value.text,
    });
    final datav2 = json.decode(respon.body);
    var dataJenis = ModelJenis.fromJson(datav2);
    final data = json.decode(respon.body)['meta'];
    jenislist.value = dataJenis.data;

    previouspagejenis = data['pagination']['links']['previous'];
    nextdatajenis = data['pagination']['links']['next'];
    countjenis.value = data['pagination']['count'];
    totaldatajenis.value = data['pagination']['total'];
    currentpagejenis.value = data['pagination']['current_page'];
    perpagejenis.value = data['pagination']['per_page'];
    print(previouspagejenis);

    //return produk_list;
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
        totalpagejenis.value = dataJenis.meta.pagination.totalPages;
        totaldatajenis.value = dataJenis.meta.pagination.total;
        perpagejenis.value = dataJenis.meta.pagination.perPage;
        currentpagejenis.value = jenis['meta']['pagination']['current_page'];
        countjenis.value = dataJenis.meta.pagination.count;
        if (totalpagejenis > 1) {
          nextdatajenis = jenis['meta']['pagination']['links']['next'];
        }
        print('--------------------list jenis---------------');
        print(jenislist);

        return jenislist;
      } else {
        Get.back(closeOverlays: true);
        Get.showSnackbar(toast().bottom_snackbar_error(
            'Error', 'Terjadi kesalahan mohon coba lagi'));
      }
    } else {
      Get.back(closeOverlays: true);
      Get.showSnackbar(toast().bottom_snackbar_error(
          'Error', 'Terjadi kesalahan periksa koneksi internet'));
    }
    return [];
  }

  var data = Get.arguments;

  String? jenisvalue;

  var desc = TextEditingController().obs;
  var nama_produk = TextEditingController().obs;
  var harga = TextEditingController().obs;
  var nama_jenis = TextEditingController().obs;

  var qty = TextEditingController().obs;
  var image;

  clear() {
    desc.value.clear();
    nama_produk.value.clear();
    harga.value.clear();
    nama_jenis.value.clear();

    qty.value.clear();
    pikedImagePath.value = '';
  }

  ProdukTambah() async {
    print('-------------------tambah Produk---------------------');

    Get.dialog(showloading(), barrierDismissible: false);
    var checkconn = await check_conn.check();
    if (checkconn == true) {
      var produk = await REST.produkTambah(
          token,
          id_toko,
          id_user,
          jenisvalue,
          nama_produk.value.text,
          desc.value.text,
          qty.value.text,
          harga.value.text,
          pickedImageFile!);
      if (produk != null) {
        print(produk);
        clear();
        await fetchProduk();
        await Get.find<kasirController>().fetchProduk();

        Get.back(closeOverlays: true, result: true);
        Get.showSnackbar(toast()
            .bottom_snackbar_success('Berhasil', 'Produk Berhasil diTambah'));
      } else {
        Get.back(closeOverlays: true);
        Get.showSnackbar(
            toast().bottom_snackbar_error('Error', 'Produk Gagal diTambah'));
      }
    } else {
      Get.back(closeOverlays: true);
      Get.showSnackbar(
          toast().bottom_snackbar_error('Error', 'Periksa Koneksi Internet'));
    }
    return [];
  }

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

  var qtyadd = TextEditingController().obs;

  editqty(String id, stock) async {
    print('-------------------edit jenis---------------------');

    Get.dialog(showloading(), barrierDismissible: false);
    var checkconn = await check_conn.check();
    if (checkconn == true) {
      var qty =
          await REST.produkqtytambah(token, id, id_toko, qtyadd.value.text);
      if (qty != null) {
        print(qty);
        var sum = int.parse(stock) + int.parse(qtyadd.value.text);
        qty = sum.toString();
        qtyadd.value.clear();
        await fetchProduk();
        Get.back(closeOverlays: true, result: true);
        Get.showSnackbar(toast()
            .bottom_snackbar_success('Berhasil', 'qty Berhasil ditambah'));
      } else {
        Get.back(closeOverlays: true);
        Get.showSnackbar(
            toast().bottom_snackbar_error('Error', 'qty Gagal ditambah'));
      }
    } else {
      Get.back(closeOverlays: true);
      Get.showSnackbar(
          toast().bottom_snackbar_error('Error', 'Periksa Koneksi Internet'));
    }
    return [];
  }

  addqty(produkController controller, DataProduk arg) {
    Get.dialog(AlertDialog(
      title: header(
          title: 'Tambah Stock',
          icon: Icons.add,
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
          return SingleChildScrollView(
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                width: context.width_query / 2.6,
                height: context.height_query / 2.6,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Text('Masukan jumlah yang akan di tambah'),
                    SizedBox(
                      height: 10,
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10)),
                              ),
                              textAlign: TextAlign.center,
                              controller: qtyadd.value,
                              style: font().header_black,
                            ),
                          ),
                        ],
                      ),
                    ),
                    button_solid_custom(
                        onPressed: () {
                          editqty(arg.id.toString(), arg.qty);
                        },
                        child: Text(
                          'Tambah Stock',
                          style: font().primary_white,
                        ),
                        width: context.width_query,
                        height: context.height_query / 11),
                    SizedBox(
                      height: 10,
                    ),
                    button_border_custom(
                        onPressed: () {
                          Get.back();
                        },
                        child: Text(
                          'Batal',
                          style: font().primary,
                        ),
                        width: context.width_query,
                        height: context.height_query / 11)
                  ],
                )),
          );
        },
      ),
    ));
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

//
}
