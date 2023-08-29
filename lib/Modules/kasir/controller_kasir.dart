import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:blue_thermal_printer/blue_thermal_printer.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:group_button/group_button.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pattern_formatter/numeric_formatter.dart';
import 'package:rims_waserda/Modules/Widgets/toast.dart';
import 'package:rims_waserda/Modules/base%20menu/controller_base_menu.dart';
import 'package:rims_waserda/Modules/dashboard/controller_dashboard.dart';
import 'package:rims_waserda/Modules/history/Controller_history.dart';
import 'package:rims_waserda/Modules/history/model_penjualan.dart';
import 'package:rims_waserda/Modules/kasir/model_keranjang_cache.dart';
import 'package:rims_waserda/Modules/pelanggan/data%20pelanggan/model_data_pelanggan.dart';
import 'package:rims_waserda/Modules/produk/data%20produk/controller_data_produk.dart';
import 'package:rims_waserda/Templates/setting.dart';

import '../../Services/handler.dart';
import '../../db_helper.dart';
import '../Widgets/buttons.dart';
import '../Widgets/header.dart';
import '../Widgets/loading.dart';
import '../Widgets/popup.dart';
import '../history/model_detail_penjualan_v2.dart';
import '../pelanggan/data pelanggan/controller_data_pelanggan.dart';
import '../pelanggan/hutang/controller_hutang.dart';
import '../pelanggan/hutang/model_hutang.dart';
import '../produk/data produk/model_produk.dart';
import '../produk/jenis produk/model_jenisproduk.dart';
import 'model_kasir.dart';
import 'model_meja.dart';

class kasirController extends GetxController {
  @override
  Future<void> onInit() async {
    // TODO: implement onInit
    super.onInit();
    print('------------------------id toko-------------------------' + id_toko);
    print('kasir init------------------------------------------------->');
    await fetchProduklocal(id_toko);
    await fetchjenislocal(id_toko);
    await fetchPenjualanDetaillocal(id_toko);
    await fetchPenjualanDetaillocalduplicate(id_toko);
    await getfavorite();
    // produkcache.value = await GetStorage().read('produk');
    // await fetchjenis();
    // jeniscache.value = await GetStorage().read('jenis');
    await fetchDataPelangganlocal(id_toko);
    await initSavetoPath();
    await initSavetoPathstruk();
    layout.value = await GetStorage().read('layout');
    await fetchmeja();
  }

  var logo = GetStorage().read('logo_toko') ?? '-';
  var namatoko = GetStorage().read('nama_toko');
  var alamat_toko = GetStorage().read('alamat_toko');

  searchproduklocal(id_toko) async {
    succ.value = false;
    List<Map<String, Object?>> query = await DBHelper().FETCH(
        'SELECT * FROM produk_local WHERE id_toko = $id_toko AND status = 1 AND nama_produk LIKE "%${search.value.text}%" ORDER BY ID DESC');
    List<DataProduk> produk = query.isNotEmpty
        ? query.map((e) => DataProduk.fromJson(e)).toList()
        : [];
    produklistlocal.value = produk;
    // print('fect produk local --->' + produk.toList().toString());
    succ.value = true;
    return produk;
  }

  var layout = false.obs;
  var kasir = GetStorage().read('name');

  var produkcache = <DataProduk>[].obs;
  var jeniscache = <DataJenis>[].obs;
  var nama_user = GetStorage().read('name');
  var role = GetStorage().read('role');

  var id_toko = GetStorage().read('id_toko');
  var logo_toko = GetStorage().read('logo_toko');
  var id_user = GetStorage().read('id_user');
  var pathImage = ''.obs;

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

  Future<void> writeToFile(ByteData data, String path) {
    final buffer = data.buffer;
    return new File(path).writeAsBytes(
        buffer.asUint8List(data.offsetInBytes, data.lengthInBytes));
  }

  var isConnected = Get.find<base_menuController>().isConnected;
  var listPrinter = Get.find<base_menuController>().listPrinter;
  BluetoothDevice? selectedPrinter =
      Get.find<base_menuController>().selectedPrinter;
  BlueThermalPrinter printer = Get.find<base_menuController>().printer;

  Future<void> refresh() async {
    await fetchProduklocal(id_toko);
    await fetchjenislocal(id_toko);
  }

  final nominal = NumberFormat("#,##0");
  final formatCurrency =
      NumberFormat.currency(decimalDigits: 0, locale: 'id', symbol: '');

  var kembalian = TextEditingController().obs;
  var kembalian_prebill = TextEditingController().obs;
  var keypadController = TextEditingController().obs;
  var keypadController_prebill = TextEditingController().obs;
  var keypadvalue = 0.0.obs;
  var keypadvalue_prebill = 0.0.obs;

  var selectedIndex = 0.obs;

  var search = TextEditingController().obs;
  var meja = TextEditingController().obs;
  var jenislist = <DataJenis>[].obs;
  var keranjanglist = <DataKeranjang>[].obs;

  var token = GetStorage().read('token');

  var namakasir = GetStorage().read('name');
  var produklist = <DataProduk>[].obs;

  var scroll = ScrollController().obs;

  var totalpage = 0.obs;
  var totaldata = 0.obs;
  var currentpage = 0.obs;
  var nextpage;
  var count = 0.obs;

  var nextdata;
  var previouspage;
  var perpage = 0.obs;

  var listpelanggan = <DataPelanggan>[].obs;

  Future<List<DataPelanggan>> fetchpelanggan() async {
    print('-------------------userdata---------------------');

    // SchedulerBinding.instance.addPostFrameCallback(
    //     (_) => Get.dialog(loading(), barrierDismissible: false));
    //call dialog tidak bisa di init tanpa coding di atas

    var checkconn = await check_conn.check();
    if (checkconn == true) {
      var user = await REST.pelangganData(token, id_toko);
      if (user != null) {
        print('-------------------datauser---------------');
        var dataPelanggan = ModelPelanggan.fromJson(user);
        //listUser.value.clear();
        listpelanggan.value = dataPelanggan.data;

        print('--------------------list user---------------');
        print(listpelanggan);

        // Get.back(closeOverlays: true);

        return listpelanggan;
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

  var penjualan_list_detail_local = <DataPenjualanDetailV2>[].obs;
  var duplicate = [].obs;

  fetchPenjualanDetaillocal(id_toko) async {
    print(
        '-------------------fetch detail Penjualan local---------------------');
    //succ.value = false;
    List<Map<String, Object?>> query = await DBHelper()
        .FETCH('SELECT * FROM penjualan_detail_local ORDER BY ID DESC');
    List<DataPenjualanDetailV2> penjualan = query.isNotEmpty
        ? query.map((e) => DataPenjualanDetailV2.fromJson(e)).toList()
        : [];
    penjualan_list_detail_local.value = penjualan;
    print(penjualan);
    //succ.value = true;
    return penjualan;
  }

  var favorite = <DataProduk>[].obs;

  getfavorite() async {
    List<DataProduk> produk = await fetchProduklocal(id_toko);
    print('produk--------------------->');
    print(produk);
    await fetchPenjualanDetaillocalduplicate(id_toko);
    var fav = duplicate.value;

    var x = fav.where((element) => element['COUNT(*)'] >= 10).toList();
    print('xx------------------>');
    print(x);

    await Future.forEach(x, (element) {
      final existingIndex = favorite.value
          .indexWhere((item) => item.namaProduk == element['nama_brg']);
      if (existingIndex == -1) {
        print(existingIndex);
        favorite.add(
            produk.where((e) => e.namaProduk == element['nama_brg']).first);
      }
    });

    print('favorite---------------------------------------->');

    print(favorite);

    return favorite;
  }

  fetchPenjualanDetaillocalduplicate(id_toko) async {
    print(
        '-------------------fetch detail Penjualan duplicatetette---------------------');
    //succ.value = false;
    List<Map<String, Object?>> query = await DBHelper().FETCH(
        'SELECT penjualan_detail_local.nama_brg,produk_local.nama_produk,COUNT(*) FROM penjualan_detail_local JOIN produk_local on penjualan_detail_local.id_produk = produk_local.id_local WHERE produk_local.status = 1 GROUP BY penjualan_detail_local.nama_brg HAVING COUNT(*) > 1');
    // List<DataPenjualanDetailV2> penjualan = query.isNotEmpty
    //     ? query.map((e) => DataPenjualanDetailV2.fromJson(e)).toList()
    //     : [];
    duplicate.value = query;
    print(duplicate);
    //succ.value = true;
    return query;
  }

  Future<List<DataProduk>> fetchprodukv2() async {
    print('-------------------userdata---------------------');

    var checkconn = await check_conn.check();
    if (checkconn == true) {
      var produk = await REST.produkAll(token, id_toko, search.value.text);
      if (produk != null) {
        print('-------------------dataproduk---------------');
        return ModelProduk.fromJson(produk).data;

        // produklist.value = dataProduk.data;
        // totalpage.value = dataProduk.meta.pagination.totalPages;
        // totaldata.value = dataProduk.meta.pagination.total;
        // perpage.value = dataProduk.meta.pagination.perPage;
        // currentpage.value = produk['meta']['pagination']['current_page'];
        // count.value = dataProduk.meta.pagination.count;
        // if (totalpage > 1) {
        //   nextdata = produk['meta']['pagination']['links']['next'] ?? '';
        // }
        // print(
        //     '--------------------list produk cache----------------------------');
        // await GetStorage().write('produk', produklist.value);
        //
        // // print(produklist);
        //
        // //Get.back(closeOverlays: true);
        //
        // return produklist;
      } else {
        // Get.back(closeOverlays: true);

        Get.showSnackbar(
            toast().bottom_snackbar_error('Error', 'Terjadi kesalahan'));
        return [];
      }
    } else {
      Get.back(closeOverlays: true);
      Get.showSnackbar(
          toast().bottom_snackbar_error('Error', 'Periksa koneksi'));
      return [];
    }
  }

  nextscroll() {
    scroll.value.addListener(() async {
      if (scroll.value.position.maxScrollExtent ==
          scroll.value.position.pixels) {
        if (totalpage.value != currentpage.value) {
          next();
        } else {
          print(
              "end of the line --------------------------------------------------");
        }

        print('scroll--------------------------------------------------');
      }
    });
  }

  next() async {
    if (nextdata == '') {
      return null;
    } else {
      final respon = await http.post(Uri.parse(nextdata), body: {
        'token': token,
        'id_toko': id_toko,
        'search': search.value.text,
      });
      final datav2 = json.decode(respon.body);
      var dataProduk = ModelProduk.fromJson(datav2);
      final data = json.decode(respon.body)['meta'];

      produklist.value += dataProduk.data;
      produkcache.value += dataProduk.data;
      await GetStorage().write('produk', produkcache.value);
      previouspage = data['pagination']['links']['previous'];
      nextdata = data['pagination']['links']['next'] ?? '';
      currentpage.value = data['pagination']['current_page'];
      count.value = data['pagination']['count'];
      totaldata.value = data['pagination']['total'];
      perpage.value = data['pagination']['per_page'];
      print(nextdata);
      print(data);
    }

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

  var produklistlocal = <DataProduk>[].obs;
  var jenislistlocal = <DataJenis>[].obs;

  fetchProduklocal(id_toko) async {
    print('-------------------fetch Produk local---------------------');
    succ.value = false;
    List<Map<String, Object?>> query = await DBHelper().FETCH(
        'SELECT * FROM produk_local WHERE id_toko = $id_toko AND status = 1 ORDER BY ID DESC');
    List<DataProduk> produk = query.isNotEmpty
        ? query.map((e) => DataProduk.fromJson(e)).toList()
        : [];
    produklistlocal.value = produk;
    // print('fect produk local --->' + produk.toList().toString());
    succ.value = true;
    return produk;
  }

  fetchProduklocalbyjenis(id_toko, id_jenis) async {
    print('-------------------fetch Produk local---------------------');
    succ.value = false;
    List<Map<String, Object?>> query = await DBHelper().FETCH(
        'SELECT * FROM produk_local WHERE id_toko = $id_toko AND status = 1 AND id_jenis = "$id_jenis" ORDER BY ID DESC');
    List<DataProduk> produk = query.isNotEmpty
        ? query.map((e) => DataProduk.fromJson(e)).toList()
        : [];
    produklistlocal.value = produk;
    // print('fect produk local --->' + produk.toList().toString());
    succ.value = true;
    return produk;
  }

  fetchjenislocal(id_toko) async {
    print('-------------------fetch jenis local---------------------');

    List<Map<String, Object?>> query = await DBHelper().FETCH(
        'SELECT * FROM produK_jenis_local WHERE id_toko = $id_toko AND aktif = "Y" ORDER BY ID DESC');
    List<DataJenis> jenis = query.isNotEmpty
        ? query.map((e) => DataJenis.fromJson(e)).toList()
        : [];
    jenislistlocal.value = jenis;
    print(jenislistlocal);

    return jenis;
  }

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
        // totalpage.value = dataProduk.meta.pagination.totalPages;
        // totaldata.value = dataProduk.meta.pagination.total;
        // perpage.value = dataProduk.meta.pagination.perPage;
        // currentpage.value = produk['meta']['pagination']['current_page'];
        // count.value = dataProduk.meta.pagination.count;
        // if (totalpage > 1) {
        //   nextdata = produk['meta']['pagination']['links']['next'] ?? '';
        // }
        print(
            '--------------------list produk cache----------------------------');
        await GetStorage().write('produk', produklist.value);

        // print(produklist);

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

        return produklist.value;
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

  fetchProdukByJeniscache(String id) async {
    print('-------------------fetchProdukbyjenis cache---------------------');
    produkcache.value = await GetStorage().read('produk');
    var jenis = produkcache.value
        .where((element) => element.idJenis == int.parse(id))
        .toList();
    print(produkcache.map((element) => element.namaProduk).toList());
    print('<-- jnis');
    print(jenis.map((e) => e.namaProduk));
    print('<-- jnis');
    produkcache.value = jenis;
    produkcache.refresh();
  }

  var keranjangcache = <DataKeranjangCache>[].obs;
  var qtycache = 0.obs;
  var cache = <DataKeranjangCache>[].obs;
  var max = false.obs;

  var editqty = TextEditingController().obs;
  var editqtyprebill = TextEditingController().obs;

  popeditqty(index) {
    editqty.value.clear();
    Get.dialog(AlertDialog(
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
                    Text(
                      'Masukan jumlah QTY',
                      style: font().header_black,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Expanded(
                      child: TextField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: 'Qty',
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                        textAlign: TextAlign.center,
                        controller: editqty.value,
                        style: font().header_black,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: button_border_custom(
                              onPressed: () {
                                Get.back();
                              },
                              child: Text(
                                'Batal',
                                style: font().primary,
                              ),
                              width: context.width_query,
                              height: context.height_query / 11),
                        ),
                        SizedBox(
                          width: 25,
                        ),
                        Expanded(
                          child: button_solid_custom(
                              onPressed: () async {
                                //editqty.value.text = cache[index].qty.toString();
                                cache.refresh();

                                var pp = produklistlocal
                                    .where((e) => e.id == cache[index].id)
                                    .first;

                                var qty = int.parse(editqty.value.text);
                                if (qty > pp.qty! &&
                                    cache[index].idJenisStock == 1) {
                                  Get.showSnackbar(toast()
                                      .bottom_snackbar_error(
                                          'Gagal', 'Stock tidak mencukupi'));
                                } else {
                                  cache[index].qty =
                                      int.parse(editqty.value.text);
                                  await subtotalval();
                                  await hitungbesardiskonkasir();
                                  await totalval();

                                  Get.back();
                                }
                              },
                              child: Text(
                                'Tambah Qty',
                                style: font().primary_white,
                              ),
                              width: context.width_query,
                              height: context.height_query / 11),
                        ),
                      ],
                    ),
                  ],
                )),
          );
        },
      ),
    ));
  }

  popeditqtyprebill(index, id_meja) {
    editqtyprebill.value.clear();
    Get.dialog(AlertDialog(
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
                    Text(
                      'Masukan jumlah QTY',
                      style: font().header_black,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Expanded(
                      child: TextField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: 'Qty',
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                        textAlign: TextAlign.center,
                        controller: editqtyprebill.value,
                        style: font().header_black,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: button_border_custom(
                              onPressed: () {
                                Get.back();
                              },
                              child: Text(
                                'Batal',
                                style: font().primary,
                              ),
                              width: context.width_query,
                              height: context.height_query / 11),
                        ),
                        SizedBox(
                          width: 25,
                        ),
                        Expanded(
                          child: button_solid_custom(
                              onPressed: () async {
                                //editqty.value.text = cache[index].qty.toString();
                                cachemejadetail.refresh();

                                var pp = produklistlocal
                                    .where((e) =>
                                        e.idLocal ==
                                        cachemejadetail[index].idProdukLocal)
                                    .first;

                                var qty = int.parse(editqtyprebill.value.text);
                                if (qty > pp.qty! &&
                                    cachemejadetail[index].idJenisStock == 1) {
                                  Get.showSnackbar(toast()
                                      .bottom_snackbar_error(
                                          'Gagal', 'Stock tidak mencukupi'));
                                } else {
                                  cachemejadetail[index].qty =
                                      int.parse(editqtyprebill.value.text);
                                  await subtotalvalprebill(id_meja);

                                  Get.back();
                                }
                              },
                              child: Text(
                                'Tambah Qty',
                                style: font().primary_white,
                              ),
                              width: context.width_query,
                              height: context.height_query / 11),
                        ),
                      ],
                    ),
                  ],
                )),
          );
        },
      ),
    ));
  }

  tambahqty(int index) async {
    cache.refresh();
    var qty = cache.value[index].qty;
    var add = qty + 1;
    var sum = cache[index].qty = add;
    print(produklistlocal[index].qty);
    // var pp = produklist.where((e) => e.id == cache[index].id).first;
    // if (int.parse(pp.qty) <= sum) {
    //   max.value = true;
    // } else {
    //   max.value = false;
    // }

    await subtotalval();
    await hitungbesardiskonkasir();
    await totalval();
    print('qty cache ------------------------------------------');

    //cache.refresh();

    print(cache[index].qty);
    print(cache[index]);
    return sum;
  }

  tambahqtyprebill(int index, String idproduklocal, id_meja) async {
    cachemejadetail.refresh();
    var qty = cachemejadetail.value[index].qty;
    var add = qty! + 1;
    var sum = cachemejadetail[index].qty = add;
    print(produklistlocal[index].qty);

    await DBHelper().UPDATEMEJADETAIL(
        table: 'meja_detail', data: qtymejadetail(sum), id: idproduklocal);

    await subtotalvalprebill(id_meja);

    //cache.refresh();

    print(cachemejadetail[index].qty);
    print(cachemejadetail[index]);
    return sum;
  }

  deleteqty(int index, String idproduklocal) async {
    max.value = false;
    var qty = cache.value[index].qty;
    var del = qty - 1;
    var sum = cache[index].qty = del;
    await subtotalval();
    await hitungbesardiskonkasir();
    await totalval();

    if (sum < 1) {
      cache.value.removeWhere((element) => element.idLocal == idproduklocal);
      print('qty cache deldete ------------------------------------------');
      cache.refresh();
    } else {
      cache.refresh();
      return sum;
    }
  }

  Map<String, dynamic> qtymejadetail(qty) {
    var map = <String, dynamic>{};

    map['qty'] = qty;

    return map;
  }

  deleteqtyprebill(int index, String idproduklocal, int id_meja) async {
    max.value = false;
    var qty = cachemejadetail.value[index].qty;
    var del = qty! - 1;
    var sum = cachemejadetail[index].qty = del;
    // print('qty cache prebill ------------------------------------------');

    await subtotalvalprebill(id_meja);

    if (sum < 1) {
      cachemejadetail.value
          .removeWhere((element) => element.idProdukLocal == idproduklocal);
      print('qty cache deldete ------------------------------------------');

      await DBHelper().DELETEITEMMEJADETAIL('meja_detail', idproduklocal);
      cachemejadetail.refresh();
      //  await fetchmejadetail(id_meja);
    } else {
      await DBHelper().UPDATEMEJADETAIL(
          table: 'meja_detail', data: qtymejadetail(sum), id: idproduklocal);
      cachemejadetail.refresh();
      // await fetchmejadetail(id_meja);
      return sum;
    }
  }

  deleteitemcache(String idproduklocal) {
    max.value = false;
    cache.value.removeWhere((element) => element.idLocal == idproduklocal);
    subtotalval();
    hitungbesardiskonkasir();
    totalval();
    cache.refresh();
  }

  var excache = <String>[];
  RxDouble subtotal = 0.0.obs;
  RxDouble total = 0.0.obs;

  // var diskon = 0.15.obs;
  RxDouble displaydiskon = 0.0.obs;

  // displayDiskon() {
  //   return displaydiskon.value = jumlahdiskonkasir.value;
  // }

  var textdiskon = TextEditingController().obs;

  hitungbesardiskonkasir() {
    if (metode_diskon.value == 1) {
      print(
          '------------------------------ persen diskon ------------------------------');
      return jumlahdiskonkasir.value =
          subtotal.value * displaydiskon.value / 100;
    } else {
      print(
          '------------------------------ nominal diskon ------------------------------');
      print(displaydiskon);
      return jumlahdiskonkasir.value = displaydiskon.value;
    }
  }

  var jumlahdiskonkasir = 0.0.obs;
  var metode_diskon = 9.obs;

  editDiskonKasir(kasirController controller) {
    Get.dialog(
        AlertDialog(
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
                        Text(
                          'Masukan jumlah dikon',
                          style: font().header_black,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Obx(() {
                          return Expanded(
                            child: Row(
                              children: [
                                metode_diskon.value == 9
                                    ? Expanded(
                                        child: Container(
                                            child: Center(
                                                child: Text(
                                        'pilih metode diskon',
                                        style: font().reguler_bold,
                                      ))))
                                    : metode_diskon.value == 1
                                        ? Expanded(
                                            child: TextField(
                                              keyboardType:
                                                  TextInputType.number,
                                              onChanged: ((String num) {
                                                displaydiskon.value =
                                                    double.parse(num.toString()
                                                        .replaceAll(',', ''));
                                                print(displaydiskon);
                                              }),
                                              decoration: InputDecoration(
                                                hintText: 'Persentase diskon',
                                                suffixText: '%',
                                                suffixStyle: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10)),
                                                border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                              ),
                                              textAlign: TextAlign.center,
                                              controller: textdiskon.value,
                                              style: font().header_black,
                                            ),
                                          )
                                        : Expanded(
                                            child: TextField(
                                              inputFormatters: [
                                                ThousandsFormatter()
                                              ],
                                              onChanged: ((String num) {
                                                displaydiskon.value =
                                                    double.parse(num.toString()
                                                        .replaceAll(',', ''));
                                                print(displaydiskon);
                                              }),
                                              keyboardType:
                                                  TextInputType.number,
                                              decoration: InputDecoration(
                                                hintText: 'Potongan harga',
                                                prefixText: 'Rp.',
                                                suffixStyle: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10)),
                                                border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                              ),
                                              textAlign: TextAlign.center,
                                              controller: textdiskon.value,
                                              style: font().header_black,
                                            ),
                                          ),
                                Container(
                                  margin: EdgeInsets.only(left: 15),
                                  child: GroupButton(
                                    isRadio: true,
                                    controller: GroupButtonController(
                                        selectedIndex: metode_diskon.value - 1),
                                    onSelected: (string, index, bool) {
                                      metode_diskon.value = index + 1;
                                      print(metode_diskon.value);
                                    },
                                    buttons: [
                                      "Persen",
                                      "Nominal",
                                    ],
                                    options: GroupButtonOptions(
                                      selectedShadow: const [],
                                      selectedTextStyle: const TextStyle(
                                        fontSize: 20,
                                        color: Colors.white,
                                      ),
                                      selectedColor: color_template().select,
                                      unselectedShadow: const [],
                                      unselectedColor: Colors.white,
                                      unselectedTextStyle: const TextStyle(
                                        fontSize: 15,
                                        color: Colors.black,
                                      ),
                                      //selectedBorderColor: Colors.pink[900],
                                      unselectedBorderColor:
                                          color_template().select,
                                      borderRadius: BorderRadius.circular(10),
                                      spacing: 5,
                                      runSpacing: 5,
                                      groupingType: GroupingType.column,
                                      direction: Axis.vertical,
                                      buttonHeight: context.height_query / 15,
                                      buttonWidth: context.width_query / 15,
                                      mainGroupAlignment:
                                          MainGroupAlignment.spaceAround,
                                      crossGroupAlignment:
                                          CrossGroupAlignment.center,
                                      groupRunAlignment:
                                          GroupRunAlignment.spaceBetween,
                                      textAlign: TextAlign.center,
                                      textPadding: EdgeInsets.zero,
                                      alignment: Alignment.center,
                                      elevation: 3,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: button_border_custom(
                                  onPressed: () {
                                    metode_diskon.value = 9;
                                    textdiskon.value.clear();

                                    Get.back();
                                  },
                                  child: Text(
                                    'Batal',
                                    style: font().primary,
                                  ),
                                  width: context.width_query,
                                  height: context.height_query / 11),
                            ),
                            SizedBox(
                              width: 25,
                            ),
                            Expanded(
                              child: button_solid_custom(
                                  onPressed: () {
                                    if (metode_diskon.value == 9) {
                                      Get.showSnackbar(toast()
                                          .bottom_snackbar_error('Gagal',
                                              'Pilih metode diskon terlebih dahulu'));
                                    } else if (textdiskon.value.text.isEmpty) {
                                      Get.showSnackbar(toast()
                                          .bottom_snackbar_error('Gagal',
                                              'masukan diskon terlebih dahulu'));
                                    } else {
                                      // displaydiskon.value =
                                      //     double.parse(textdiskon.value.text);
                                      hitungbesardiskonkasir();
                                      totalval();

                                      print(
                                          ' jumalh diskon kasir ---------------------> == $jumlahdiskonkasir');
                                      Get.back();
                                    }
                                  },
                                  child: Text(
                                    'Edit diskon',
                                    style: font().primary_white,
                                  ),
                                  width: context.width_query,
                                  height: context.height_query / 11),
                            ),
                          ],
                        ),
                      ],
                    )),
              );
            },
          ),
        ),
        barrierDismissible: false);
  }

  var nomor_meja = ''.obs;

  editMejaKasir(kasirController controller) {
    Get.dialog(AlertDialog(
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
                    Text(
                      'Masukan nomor meja',
                      style: font().header_black,
                    ),
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
                                hintText: 'Nomor meja',
                                suffixStyle:
                                    TextStyle(fontWeight: FontWeight.bold),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10)),
                              ),
                              textAlign: TextAlign.center,
                              controller: meja.value,
                              style: font().header_black,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: button_border_custom(
                              onPressed: () {
                                Get.back();
                              },
                              child: Text(
                                'Batal',
                                style: font().primary,
                              ),
                              width: context.width_query,
                              height: context.height_query / 11),
                        ),
                        SizedBox(
                          width: 25,
                        ),
                        Expanded(
                          child: button_solid_custom(
                              onPressed: () {
                                if (meja.value.text.isEmpty) {
                                  Get.showSnackbar(toast().bottom_snackbar_error(
                                      'Gagal',
                                      'Masukan nomor meja terlebih dahulu'));
                                } else {
                                  popscreen().popprintstrukprebill(
                                      context,
                                      controller,
                                      controller.cachemejadetail,
                                      controller.meja.value.text,
                                      controller.total.value.round(),
                                      controller.jumlahdiskonkasir.value
                                          .round());
                                }
                              },
                              child: Text(
                                'Simpan',
                                style: font().primary_white,
                              ),
                              width: context.width_query,
                              height: context.height_query / 11),
                        ),
                      ],
                    ),
                  ],
                )),
          );
        },
      ),
    ));
  }

  var cachemeja = <DataMeja>[].obs;
  var cachemejadetail = <DataMeja>[].obs;
  var tgl_penjualan = <DateTime?>[].obs;

//TODO :

// -Menu pembatalan

  // edit meja dan tgl penjualan

  // tampilan bayar meja di area kasir lama
  // check update ga di update berubah sync apa ngak di local -> sync berubah n
  // print ulang bayar prebill

  addmeja() async {
    var dbClient = await DBHelper().db;

    final existingIndex =
        cachemeja.value.indexWhere((item) => item.meja == meja.value.text);

    if (existingIndex == -1) {
      await DBHelper().INSERT(
          'meja',
          DataMeja(
                  meja: meja.value.text,
                  diskonKasir: jumlahdiskonkasir.value.round(),
                  subtotal: subtotal.value.round(),
                  ppn: ppn.value.round(),
                  total: total.value.round())
              .toMapForDbMEJA());

      await Future.forEach(cache, (e) async {
        var diskonbarang = e.harga! * e.diskonBarang! / 100;
        await DBHelper().INSERT(
            'meja_detail',
            DataMeja(
              idMeja: int.parse(meja.value.text),
              idProduk: e.idProduk,
              namaProduk: e.namaProduk,
              qty: e.qty,
              harga: e.harga,
              diskonBrg: e.diskonBarang,
              hargaModal: e.hargaModal,
              idKategori: e.idKategori,
              idProdukLocal: e.idLocal,
              idJenisStock: e.idJenisStock,
            ).toMapForDbMEJADETAIL());
      });
    } else {
      dbClient!.update(
          'meja',
          DataMeja(
                  diskonKasir: jumlahdiskonkasir.value.round(),
                  meja: meja.value.text,
                  subtotal: cachemeja[existingIndex].subtotal!.round() +
                      subtotal.value.round(),
                  ppn: cachemeja[existingIndex].ppn,
                  total: cachemeja[existingIndex].total! + total.value.round())
              .toMapForDbMEJAUPDATE(),
          where: 'id = ?',
          whereArgs: [cachemeja[existingIndex].id]);

      await Future.forEach(cache, (e) async {
        var diskonbarang = e.harga! * e.diskonBarang! / 100;
        var indexdetail = cachemejadetail
            .indexWhere((element) => element.idProdukLocal == e.idLocal);
        if (indexdetail == -1) {
          await DBHelper().INSERT(
              'meja_detail',
              DataMeja(
                idMeja: int.parse(meja.value.text),
                idProduk: e.idProduk,
                namaProduk: e.namaProduk,
                qty: e.qty,
                harga: e.harga,
                diskonBrg: e.diskonBarang,
                idJenisStock: e.idJenisStock,
                idProdukLocal: e.idLocal,
                idKategori: e.idKategori,
                hargaModal: e.hargaModal,
              ).toMapForDbMEJADETAIL());
        } else {
          await dbClient.update(
              'meja_detail',
              DataMeja(
                idMeja: cachemejadetail[indexdetail].idMeja,
                idProduk: cachemejadetail[indexdetail].idProduk,
                namaProduk: cachemejadetail[indexdetail].namaProduk,
                qty: cachemejadetail[indexdetail].qty! + e.qty,
                harga: cachemejadetail[indexdetail].harga,
                diskonBrg: cachemejadetail[indexdetail].diskonBrg,
                hargaModal: cachemejadetail[indexdetail].hargaModal,
                idKategori: cachemejadetail[indexdetail].idKategori,
                idProdukLocal: cachemejadetail[indexdetail].idProdukLocal,
                idJenisStock: cachemejadetail[indexdetail].idJenisStock,
              ).toMapForDbMEJADETAILUPDATE(),
              where: 'id = ?',
              whereArgs: [cachemejadetail[indexdetail].id]);
        }
      });
    }

    await fetchmeja();
    await clear();
    // cache.value.clear();
    // cache.refresh();
    // meja.value.clear();
    // ppn.value = 0.0;
    // jumlahdiskonkasir.value = 0.0;
    // displaydiskon.value = 0.0;
    Get.showSnackbar(toast()
        .bottom_snackbar_success('Berhasil', 'Pesanan berhasil di simpan'));
  }

  deletemeja(meja) async {
    var dbClient = await DBHelper().db;
    await dbClient!.delete('meja', where: 'meja = ?', whereArgs: [meja]);
  }

  deletemejadetail(id_meja) async {
    var dbClient = await DBHelper().db;
    await dbClient!
        .delete('meja_detail', where: 'id_meja = ?', whereArgs: [id_meja]);
  }

  fetchmeja() async {
    List<Map<String, Object?>> query =
        await DBHelper().FETCH('SELECT * FROM meja ORDER BY id DESC');
    List<DataMeja> mejaquery =
        query.isNotEmpty ? query.map((e) => DataMeja.fromJson(e)).toList() : [];
    cachemeja.value = mejaquery;
    // print('fect produk local --->' + produk.toList().toString());

    return mejaquery;
  }

  fetchmejadetail(id_meja) async {
    List<Map<String, Object?>> query = await DBHelper().FETCH(
        'SELECT * FROM meja_detail WHERE id_meja = $id_meja ORDER BY id DESC');
    List<DataMeja> mejaquery =
        query.isNotEmpty ? query.map((e) => DataMeja.fromJson(e)).toList() : [];
    cachemejadetail.value = mejaquery;
    // print('fect produk local --->' + produk.toList().toString());

    return mejaquery;
  }

  var totalprebill = 0.0.obs;

  var editnomormejaprebillCon = TextEditingController().obs;

  Map<String, dynamic> updatenomormeja(nomeja) {
    var map = <String, dynamic>{};

    map['meja'] = nomeja;

    return map;
  }

  Map<String, dynamic> updatenomormejadetail(nomeja) {
    var map = <String, dynamic>{};

    map['id_meja'] = nomeja;

    return map;
  }

  editnomormejaprebill(id, nomor_meja) {
    Get.dialog(AlertDialog(
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
                    Text(
                      'Edit nomor meja',
                      style: font().header_black,
                    ),
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
                                hintText: 'Nomor meja',
                                suffixStyle:
                                    TextStyle(fontWeight: FontWeight.bold),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10)),
                              ),
                              textAlign: TextAlign.center,
                              controller: editnomormejaprebillCon.value,
                              style: font().header_black,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: button_border_custom(
                              onPressed: () {
                                Get.back();
                              },
                              child: Text(
                                'Batal',
                                style: font().primary,
                              ),
                              width: context.width_query,
                              height: context.height_query / 11),
                        ),
                        SizedBox(
                          width: 25,
                        ),
                        Expanded(
                          child: button_solid_custom(
                              onPressed: () async {
                                if (editnomormejaprebillCon
                                    .value.text.isEmpty) {
                                  Get.showSnackbar(toast().bottom_snackbar_error(
                                      'Gagal',
                                      'Masukan nomor meja terlebih dahulu'));
                                } else {
                                  List<DataMeja> item = await fetchmejadetail(
                                      nomor_meja.toString());
                                  print(item.toString() +
                                      ' <------------------------------');
                                  Future.forEach(item, (element) async {
                                    print('update meja detail');
                                    await DBHelper().UPDATEMEJADETAILNOMORMEJA(
                                        table: 'meja_detail',
                                        data: updatenomormejadetail(
                                            editnomormejaprebillCon.value.text),
                                        id_meja: nomor_meja.toString());
                                  });
                                  await DBHelper().UPDATEMEJA(
                                      table: 'meja',
                                      data: updatenomormeja(
                                          editnomormejaprebillCon.value.text),
                                      id: id);

                                  await fetchmeja();
                                  editnomormejaprebillCon.value.clear();
                                  Get.back();
                                  Get.showSnackbar(toast()
                                      .bottom_snackbar_success('Sukses',
                                          'Nomor meja berhasil di edit'));
                                }
                              },
                              child: Text(
                                'Simpan',
                                style: font().primary_white,
                              ),
                              width: context.width_query,
                              height: context.height_query / 11),
                        ),
                      ],
                    ),
                  ],
                )),
          );
        },
      ),
    ));
  }

  Map<String, dynamic> updatesubtotalmeja(subtotal, total, ppn) {
    var map = <String, dynamic>{};

    map['subtotal'] = subtotal;
    map['total'] = total;
    map['ppn'] = ppn;

    return map;
  }

  var bayarprebill = false.obs;
  var nomormejabayarprebill = ''.obs;

  pindahbayarprebill(String id_meja) async {
    bayarprebill.value = true;
    List<DataMeja> datameja = await fetchmeja();
    List<DataMeja> datadetail = await fetchmejadetail(id_meja);
    var mejafilter = datameja.where((element) => element.meja == id_meja).first;
    await Future.forEach(
        datadetail,
        (e) => {
              cache.add(DataKeranjangCache(
                idLocal: e.idProdukLocal,
                id: e.id,
                idToko: int.parse(id_toko),
                idUser: id_user,
                idJenis: '-',
                idJenisStock: e.idJenisStock,
                namaJenis: '-',
                idKategori: e.idKategori,
                namaProduk: e.namaProduk,
                deskripsi: '-',
                qty: e.qty!,
                harga: e.harga,
                hargaModal: e.hargaModal,
                diskonBarang: e.diskonBrg,
                diskonKasir: mejafilter.diskonKasir,
                image: '-',
                status: '1',
                updated: null,
                createdAt: null,
                updatedAt: null,
              ))
            });

    subtotal.value = mejafilter.subtotal!.toDouble();
    if (mejafilter.ppn == 0) {
      ppnSwitch.value = false;
      ppn.value = 0;
    } else {
      ppnSwitch.value = true;
      ppn.value = mejafilter.ppn!.toDouble();
    }
    metode_diskon.value = 2;
    displaydiskon.value = mejafilter.diskonKasir!.toDouble();
    jumlahdiskonkasir.value = mejafilter.diskonKasir!.toDouble();
    total.value = mejafilter.total!.toDouble();
    nomormejabayarprebill.value = id_meja;
    print(bayarprebill.value);
    Get.back();
  }

  listMejaKasir(kasirController controller) {
    Get.dialog(AlertDialog(
      title: header(
          title: 'List meja open bill',
          icon: Icons.table_restaurant,
          iscenter: true,
          icon_color: color_template().primary,
          base_color: Colors.white),
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
                  padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                  width: context.width_query / 1,
                  height: context.height_query / 1,
                  child: Obx(() {
                    return DataTable2(
                      columnSpacing: 0,
                      columns: <DataColumn>[
                        DataColumn(label: Text('Nomor meja')),
                        DataColumn(label: Text('Subtotal')),
                        DataColumn(label: Text('Diskon kasir')),
                        DataColumn(label: Text('PPN')),
                        DataColumn(label: Text('Total')),
                        DataColumn(label: Text('Aksi'))
                      ],
                      rows: List.generate(cachemeja.length, (index) {
                        var subtotal = cachemeja[index].subtotal! -
                            cachemeja[index].diskonKasir!;
                        var ppn = 11 / 100 * subtotal;
                        var totalppn = subtotal + ppn;

                        // totalprebill.value = cachemeja[index].total!.toDouble();
                        return DataRow(cells: <DataCell>[
                          DataCell(Row(
                            children: [
                              Expanded(child: Text(cachemeja[index].meja!)),
                              Container(
                                width: 50,
                                margin: EdgeInsets.only(
                                    right: context.width_query / 15),
                                child: IconButton(
                                  onPressed: () {
                                    editnomormejaprebill(cachemeja[index].meja,
                                        cachemeja[index].meja);
                                  },
                                  icon: Icon(
                                    Icons.edit,
                                    size: 20,
                                  ),
                                  //color: color_template().select,
                                ),
                              ),
                            ],
                          )),
                          DataCell(Text('Rp. ' +
                              nominal.format(cachemeja[index].subtotal))),
                          DataCell(Text('Rp. ' +
                              nominal.format(cachemeja[index].diskonKasir!))),
                          DataCell(Text(
                              'Rp. ' + nominal.format(cachemeja[index].ppn))),
                          DataCell(Text('Rp. ' +
                              nominal.format(cachemeja[index].total!))),
                          DataCell(Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: IconButton(
                                    onPressed: () async {
                                      popscreen().deletemeja(
                                          controller, cachemeja[index]);
                                    },
                                    icon: Icon(
                                      Icons.delete,
                                      color: color_template().tritadery,
                                    )),
                              ),
                              Expanded(
                                child: IconButton(
                                    onPressed: () async {
                                      await fetchmejadetail(
                                          cachemeja[index].meja);
                                      listMejaDetailKasir(controller);
                                    },
                                    icon: Icon(Icons.list)),
                              ),
                              Expanded(
                                child: ElevatedButton(
                                    onPressed: () {
                                      // Get.dialog(
                                      //     Stack(
                                      //       children: [
                                      //         Container(
                                      //             padding: EdgeInsets.symmetric(
                                      //                 horizontal:
                                      //                     context.width_query /
                                      //                         10,
                                      //                 vertical:
                                      //                     context.height_query /
                                      //                         10),
                                      //             child: kasir_keypad_prebill(
                                      //                 cachemeja[index].total!,
                                      //                 cachemejadetail.value,
                                      //                 cachemeja[index].meja!,
                                      //                 cachemeja[index]
                                      //                     .diskonKasir!,
                                      //                 cachemeja[index].subtotal,
                                      //                 cachemeja[index].ppn)),
                                      //         Positioned(
                                      //           top: context.height_query / 14,
                                      //           left: context.width_query / 12,
                                      //           child: Material(
                                      //             borderRadius:
                                      //                 BorderRadius.circular(30),
                                      //             color:
                                      //                 color_template().tritadery,
                                      //             child: IconButton(
                                      //                 onPressed: () {
                                      //                   groupindex.value = 9;
                                      //
                                      //                   keypadController_prebill
                                      //                       .value
                                      //                       .clear();
                                      //                   kembalian_prebill.value
                                      //                       .clear();
                                      //                   Get.back();
                                      //                 },
                                      //                 icon: Icon(
                                      //                   FontAwesomeIcons.xmark,
                                      //                   color: Colors.white,
                                      //                 )),
                                      //           ),
                                      //         )
                                      //       ],
                                      //     ),
                                      //     barrierDismissible: false)
                                      pindahbayarprebill(
                                          cachemeja[index].meja!);
                                    },
                                    child: Icon(
                                      FontAwesomeIcons.cashRegister,
                                      color: Colors.white,
                                    )),
                              )
                            ],
                          ))
                        ]);
                      }),
                    );
                  })));
        },
      ),
    ));
  }

  listMejaDetailKasir(kasirController controller) {
    Get.dialog(AlertDialog(
      title: header(
          title: 'Detail meja',
          icon: Icons.table_restaurant,
          iscenter: true,
          icon_color: color_template().primary,
          base_color: Colors.white),
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
                  width: context.width_query / 1.3,
                  height: context.height_query / 1.3,
                  child: Column(
                    children: [
                      Expanded(
                        child: Obx(() {
                          return DataTable2(
                            columns: <DataColumn>[
                              DataColumn(label: Text('Nama produk')),
                              DataColumn(label: Text('qty')),
                              DataColumn(label: Text('harga')),
                              DataColumn(label: Text('Subtotal')),
                              DataColumn(label: Text('Aksi')),
                            ],
                            rows:
                                List.generate(cachemejadetail.length, (index) {
                              var pp = controller.produklistlocal
                                  .where((e) =>
                                      e.idLocal ==
                                      controller
                                          .cachemejadetail[index].idProdukLocal)
                                  .first;
                              var hargadiskon = cachemejadetail[index].harga! -
                                  (cachemejadetail[index].harga! *
                                      cachemejadetail[index].diskonBrg! /
                                      100);

                              var subtotal =
                                  hargadiskon * cachemejadetail[index].qty!;
                              return DataRow(cells: <DataCell>[
                                DataCell(Text(cachemejadetail[index]
                                    .namaProduk!
                                    .toString())),
                                DataCell(
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      // Container(
                                      //   margin: const EdgeInsets.only(right: 5),
                                      //   padding: const EdgeInsets.all(3),
                                      //   decoration: BoxDecoration(
                                      //       shape: BoxShape.circle,
                                      //       color: color_template().select),
                                      //   child: InkWell(
                                      //     onTap: () {
                                      //       controller.deleteqtyprebill(
                                      //           index,
                                      //           cachemejadetail[index]
                                      //               .idProdukLocal!,
                                      //           cachemejadetail[index].idMeja!);
                                      //     },
                                      //     child: Icon(
                                      //       Icons.remove,
                                      //       color: Colors.white,
                                      //       size: context.height_query / 40,
                                      //     ),
                                      //   ),
                                      // ),
                                      InkWell(
                                        splashColor: color_template().select,
                                        onTap: () {
                                          // controller.popeditqtyprebill(index,cachemejadetail[index].idMeja);
                                        },
                                        child: Container(
                                          width: 55,
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 5),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              border: Border.all(
                                                  color: color_template()
                                                      .primary)),
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 10),
                                          child: Center(
                                            heightFactor: 1,
                                            child: Text(
                                                controller
                                                    .cachemejadetail[index].qty
                                                    .toString(),
                                                style: font().reguler),
                                          ),
                                        ),
                                      ),
                                      // controller.cachemejadetail[index].qty! >=
                                      //             pp.qty! &&
                                      //         controller.cachemejadetail[index]
                                      //                 .idJenisStock ==
                                      //             1
                                      //     ? Container(
                                      //         margin: const EdgeInsets.only(
                                      //           left: 5,
                                      //         ),
                                      //         padding: const EdgeInsets.all(3),
                                      //         decoration: const BoxDecoration(
                                      //             shape: BoxShape.circle,
                                      //             color: Colors.grey),
                                      //         child: Icon(
                                      //           Icons.add,
                                      //           color: Colors.white,
                                      //           size: context.height_query / 40,
                                      //         ),
                                      //       )
                                      //     : InkWell(
                                      //         onTap: () {
                                      //           controller.tambahqtyprebill(
                                      //               index,
                                      //               cachemejadetail[index]
                                      //                   .idProdukLocal!,
                                      //               cachemejadetail[index]
                                      //                   .idMeja);
                                      //         },
                                      //         child: Container(
                                      //           margin: const EdgeInsets.only(
                                      //             left: 5,
                                      //           ),
                                      //           padding:
                                      //               const EdgeInsets.all(3),
                                      //           decoration: BoxDecoration(
                                      //               shape: BoxShape.circle,
                                      //               color: color_template()
                                      //                   .primary),
                                      //           child: Icon(
                                      //             Icons.add,
                                      //             color: Colors.white,
                                      //             size:
                                      //                 context.height_query / 40,
                                      //           ),
                                      //         ),
                                      //       )
                                    ],
                                  ),
                                ),
                                DataCell(cachemejadetail[index].diskonBrg == 0
                                    ? Text('Rp. ' +
                                        nominal.format(
                                            cachemejadetail[index].harga!))
                                    : Text(
                                        'Rp. ' + nominal.format(hargadiskon))),
                                DataCell(
                                    Text('Rp. ' + nominal.format(subtotal))),
                                DataCell(IconButton(
                                  onPressed: () async {
                                    popscreen().deletemejadetail(
                                        controller, cachemejadetail[index]);
                                  },
                                  icon: Icon(Icons.delete),
                                  color: color_template().tritadery,
                                )),
                              ]);
                            }),
                          );
                        }),
                      ),
                      // Padding(
                      //   padding: const EdgeInsets.all(8.0),
                      //   child: Expanded(
                      //     child: Row(
                      //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //       children: [Text('PPN : '), Text('11 %')],
                      //     ),
                      //   ),
                      // ),
                    ],
                  )));
        },
      ),
    ));
  }

  tambahKeranjangcache(String idproduklocal) async {
    print('-------------------Tambah keranjang cache---------------------');
    // keranjangcache.value = await GetStorage().read('keranjang');
    var query = produklistlocal.value
        .where((element) => element.idLocal == idproduklocal);

    final existingIndex =
        cache.value.indexWhere((item) => item.idLocal == idproduklocal);

    if (query.map((e) => e.qty).first == 0 &&
        query.map((e) => e.idJenisStock).first == 1) {
      Get.showSnackbar(toast().bottom_snackbar_error(
          "Error", 'Stock sudah habis! harap isi stock terlebih dahulu'));
    } else {
      if (existingIndex == -1) {
        cache.add(
          DataKeranjangCache(
              idLocal: query.map((e) => e.idLocal).first,
              id: query.map((e) => e.id).first,
              idToko: query.map((e) => e.idToko).first,
              idUser: query.map((e) => e.idUser!).first,
              idJenis: query.map((e) => e.idJenis).first,
              idJenisStock: query.map((e) => e.idJenisStock).first,
              namaJenis: query.map((e) => e.namaJenis!).first,
              idKategori: query.map((e) => e.idKategori!).first,
              namaProduk: query.map((e) => e.namaProduk).first,
              deskripsi: query.map((e) => e.deskripsi).first,
              qty: 1,
              harga: query.map((e) => e.harga).first,
              hargaModal: query.map((e) => e.hargaModal).first,
              diskonBarang: query.map((e) => e.diskonBarang!).first,
              diskonKasir: jumlahdiskonkasir.value.round(),
              image: query.map((e) => e.image).first ?? '-',
              status: query.map((e) => e.status).first.toString(),
              updated: query.map((e) => e.updated).first.toString(),
              createdAt: query.map((e) => e.createdAt).first.toString(),
              updatedAt: query.map((e) => e.updatedAt).first.toString()),
        );
      } else {
        var pp = produklistlocal
            .where((e) => e.idLocal == cache[existingIndex].idLocal)
            .first;
        // var xx = controller.cache.where((e) => e.id == p.id).first;
        if (cache[existingIndex].qty >= pp.qty! &&
            cache[existingIndex].idJenisStock == 1) {
          print('maxxxx-------------------------');
          Get.showSnackbar(toast().bottom_snackbar_error(
              "Error", 'Stock sudah habis! harap isi stock terlebih dahulu'));
        } else {
          cache[existingIndex].qty++;
        }
      }
    }

    // if (int.parse(query.map((e) => e.qty).toString()) <=
    //     cache[existingIndex].qty) {
    //   max.value = true;
    // }

    // print(cache.value.map((e) {
    //   return [e.namaProduk, e.qty, e.diskonKasir];
    // }).toList());
    print('diskon barang -------------------------->');
    print(cache.value.map((e) {
      return [e.idLocal, e.namaProduk, e.diskonBarang];
    }).toList());

    subtotalval();
    hitungbesardiskonkasir();
    totalval();
    print(total.value);

    cache.refresh();
  }

  var ppn = 0.0.obs;
  var ppnSwitch = false.obs;

  totalval() {
    var total1 = subtotal.value - jumlahdiskonkasir.value;
    var ppn1 = 11 / 100 * total1;
    if (ppnSwitch.value == true) {
      ppn.value = ppn1;
      return total.value = total1 + ppn1;
    } else {
      ppn.value = 0.0;
      return total.value = total1;
    }
  }

  subtotalval() {
    subtotal.value = cache.map((expense) => expense).fold(
        0,
        (total, amount) =>
            total +
            (amount.qty *
                (amount.harga! -
                    (amount.harga! * amount.diskonBarang! / 100))));
  }

  Map<String, dynamic> datasubtotalprebill(subtotal, total) {
    var map = <String, dynamic>{};

    map['subtotal'] = subtotal;
    map['total'] = total;

    return map;
  }

  subtotalvalprebill(id_meja) async {
    print('subtotal prebil--------');
    List<DataMeja> sub = await fetchmejadetail(id_meja);
    List<DataMeja> total = await fetchmeja();
    var s = sub
        .map((e) => e.subtotal)
        .fold(0, (previousValue, element) => previousValue + element!);
    var t = total.where((element) => element.meja == id_meja).first;

    var totaltotal = s - t.diskonKasir!.toInt() - t.ppn!.toInt();

    await DBHelper().UPDATEMEJASUBTOTAL(
        table: 'meja', data: datasubtotalprebill(s, totaltotal), id: id_meja);
  }

  fetchkeranjangcache() async {
    print('-------------------fetchkeranjang cache---------------------');
    cache.value = await GetStorage().read('keranjang');
  }

  // fetchkeranjang() async {
  //   print('-------------------fetchkeranjang---------------------');
  //
  //   var checkconn = await check_conn.check();
  //   if (checkconn == true) {
  //     var keranjang = await REST.kasirKeranjangData(
  //         token, id_user.toString(), id_toko, meja.value.text);
  //     if (keranjang != null) {
  //       print('-------------------data keranjang---------------');
  //       var dataKeranjang = ModelKeranjang.fromJson(keranjang);
  //       keranjanglist.value = dataKeranjang.data;
  //
  //       subtotal.value = dataKeranjang.meta.subtotal;
  //       total.value = double.parse(dataKeranjang.meta.total);
  //       print('-------------keranjang total---------');
  //       print(total);
  //       //keranjanglist.refresh();
  //       //update();
  //       print('--------------------list keranjang---------------');
  //       print(keranjanglist);
  //       // await GetStorage().write('keranjang', keranjanglist.value);
  //       //keranjangcache.value = await GetStorage().read('keranjang');
  //
  //       //Get.back(closeOverlays: true);
  //
  //       return keranjanglist;
  //     } else {
  //       // Get.back(closeOverlays: true);
  //       Get.showSnackbar(
  //           toast().bottom_snackbar_error('Error', 'Terjadi kesalahan'));
  //     }
  //   } else {
  //     //  Get.back(closeOverlays: true);
  //     Get.showSnackbar(
  //         toast().bottom_snackbar_error('Error', 'Periksa koneksi'));
  //   }
  //   return [];
  // }

  fetchjenis() async {
    print('-------------------fetchJenis---------------------');

    var checkconn = await check_conn.check();
    if (checkconn == true) {
      var jenis = await REST.produkJenis(token, id_toko);
      if (jenis != null) {
        print('-------------------datajenis---------------');
        var dataJenis = ModelJenis.fromJson(jenis);

        jenislist.value = dataJenis.data;
        GetStorage().write('jenis', jenislist.value);
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

  var succ = false.obs;

  tambahKeranjang() async {
    print('-------------------Tambah keranjang---------------------');

    var checkconn = await check_conn.check();
    if (checkconn == true) {
      cache.forEach((element) async {
        var keranjang = await REST.kasirKeranjangTambah(
            token: token,
            iduser: id_user,
            idtoko: id_toko,
            idjenisstock: element.idJenisStock.toString(),
            meja: meja.value.text,
            idproduk: element.id.toString(),
            diskon_brg: element.diskonBarang.toString(),
            qty: element.qty.toString(),
            diskon_kasir: jumlahdiskonkasir.toString());

        if (keranjang['success'] == true) {
          print('------------------tambah keranjang---------------');
          print(keranjang['message']);
          //Get.back();

          //await fetchkeranjang();

          // Get.showSnackbar(
          //     toast().bottom_snackbar_success('Berhasil', 'berhasil di tambah'));
        } else {
          print(keranjang['message']);
          Get.back(closeOverlays: true);

          Get.showSnackbar(
              toast().bottom_snackbar_error('Error', keranjang['message']));
        }
      });

      // if (keranjang != null) {
      //   print('------------------tambah keranjang---------------');
      //   //await fetchkeranjang();
      //
      //   // Get.showSnackbar(
      //   //     toast().bottom_snackbar_success('Berhasil', 'berhasil di tambah'));
      // } else {
      //   //Get.back(closeOverlays: true);
      //   Get.showSnackbar(
      //       toast().bottom_snackbar_error('Error', 'Gagal di tambah'));
      // }
    } else {
      Get.back(closeOverlays: true);
      Get.showSnackbar(
          toast().bottom_snackbar_error('Error', 'periksa koneksi'));
    }
    return [];
  }

  tambahKeranjanglocal() async {
    print('-------------------Tambah keranjang local---------------------');
    await Future.forEach(cache, (e) async {
      await DBHelper().INSERT(
          'keranjang_local',
          DataKeranjangCachev2(
                  qty: 1,
                  idToko: e.idToko,
                  id: e.idProduk,
                  idUser: e.idUser,
                  idKategori: e.idKategori,
                  meja: '1',
                  idJenisStock: e.idJenisStock,
                  namaBrg: e.namaProduk,
                  hargaBrg: e.harga,
                  diskonBrg: e.diskonBarang)
              .toMapForDb());

      print('in keranjang local--------------------------------->');
      print(e.idProduk);
      print(e.id);
    });

    // if (keranjang != null) {
    //   print('------------------tambah keranjang---------------');
    //   //await fetchkeranjang();
    //
    //   // Get.showSnackbar(
    //   //     toast().bottom_snackbar_success('Berhasil', 'berhasil di tambah'));
    // } else {
    //   //Get.back(closeOverlays: true);
    //   Get.showSnackbar(
    //       toast().bottom_snackbar_error('Error', 'Gagal di tambah'));
    // }
  }

  deleteKeranjang(String id, idproduk) async {
    print('-------------------delete keranjang---------------------');

    var checkconn = await check_conn.check();
    if (checkconn == true) {
      var keranjang = await REST.kasirKeranjangHapus(
          token, id, id_user, id_toko, idproduk, meja.value.text);
      if (keranjang != null) {
        print('------------------delete keranjang---------------');
        // await fetchkeranjang();
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

  RxString id_pelanggan = ''.obs;
  var nama_pelanggan = TextEditingController().obs;
  var nohp = TextEditingController().obs;

  tambahPelanggan() async {
    print('-------------------tambah beban---------------------');

    Get.dialog(showloading(), barrierDismissible: false);
    var checkconn = await check_conn.check();
    if (checkconn == true) {
      var pelanggan = await REST.pelangganTambah(
          token, id_toko, nama_pelanggan.value.text, nohp.value.text);
      if (pelanggan != null) {
        print(pelanggan);
        var ui = await fetchpelanggan();
        if (ui != null) {
          Get.back();
          Get.back();
          Get.showSnackbar(toast()
              .bottom_snackbar_success('Berhasil', 'beban Berhasil di tambah'));
        } else {
          Get.showSnackbar(
              toast().bottom_snackbar_error('Error', ' beban Gagal di tambah'));
        }
      } else {
        Get.back();
        Get.showSnackbar(
            toast().bottom_snackbar_error('Error', ' beban Gagal di tambah'));
      }
    } else {
      Get.back();
      Get.showSnackbar(
          toast().bottom_snackbar_error('Error', 'Periksa Koneksi Internet'));
    }
    return [];
  }

  // caridiskonproper() {
  //   var x =
  //   diskonpropervalue.value = jumlahharga.value * jumlahdiskon.value / 100;
  //   print(x);
  // }
  DateFormat dateFormat = DateFormat("dd-MM-yyyy HH:mm:ss");
  DateFormat dateFormatprint = DateFormat("dd-MM-yyyy");

  String stringGenerator(int len) {
    var random = Random.secure();
    var values = List<int>.generate(len, (i) => random.nextInt(255));

    var uniqueId = base64UrlEncode(values);
    print(uniqueId);
    return uniqueId;
  }

  // todo : final check;

  pembayaranlocal(id_toko) async {
    print('-------------------pembayaran local local---------------------');

    Get.dialog(const showloading(), barrierDismissible: false);

    var diskonbarangtotal = cache
        .map((e) => e)
        .fold(0, (total, x) => (x.harga! * x.diskonBarang! / 100).round());

    var id_localgenerator = stringGenerator(10);

    if (groupindex.value != 2) {
      print('pembayaran local------------------------------------->');
      var query = await DBHelper().INSERT(
          'penjualan_local',
          DataPenjualan(
                  aktif: 'Y',
                  idLocal: id_localgenerator,
                  sync: 'N',
                  idUser: id_user,
                  idToko: int.parse(id_toko),
                  total: total.value.round(),
                  totalItem: cache
                      .map((e) => e.qty)
                      .fold(0, (previous, current) => previous! + current),
                  tglPenjualan: tgl_penjualan.value.isEmpty
                      ? DateTime.now().toString()
                      : tgl_penjualan.value.first.toString(),
                  subTotal: subtotal.value.round(),
                  namaUser: nama_user,
                  namaPelanggan:
                      groupindex.value == 2 ? nama_pelanggan.value.text : '-',
                  // idPelanggan: listpelanggan.,
                  metodeBayar: groupindex.value,
                  //meja:  meja.value.text.isEmpty ? '0' : meja.value.text,
                  meja:
                      bayarprebill == true ? nomormejabayarprebill.value : '-',
                  kembalian: balikvalue.value.round(),
                  diskonTotal:
                      diskonbarangtotal + jumlahdiskonkasir.value.round(),
                  bayar: bayarvalue.value,
                  diskonKasir: jumlahdiskonkasir.value.round(),
                  ppn: ppn.value.round(),
                  status: groupindex.value == 2 ? 2 : 1)
              .toMapForDb());
      // print('diskon barang total------------------------->');
      // print(diskonbarangtotal);

      if (query != null) {
        print('insert detail penjualan---------------------->');
        var detailpenjualan = await Future.forEach(cache, (e) async {
          var dd = e.harga! * e.diskonBarang! / 100;
          await DBHelper().INSERT(
              'penjualan_detail_local',
              DataPenjualanDetailV2(
                      idLocal: stringGenerator(10),
                      aktif: 'Y',
                      sync: 'N',
                      idUser: id_user,
                      idPenjualan: id_localgenerator,
                      idJenisStock: e.idJenisStock,
                      idKategori: e.idKategori,
                      idProduk: e.idLocal,
                      namaBrg: e.namaProduk,
                      hargaBrg: e.harga,
                      diskonBrg: dd.round(),
                      qty: e.qty,
                      tgl: tgl_penjualan.value.isEmpty
                          ? DateTime.now().toString()
                          : tgl_penjualan.value.first.toString(),
                      hargaModal: e.hargaModal,
                      diskonKasir: jumlahdiskonkasir.value.round(),
                      total: total.value.round())
                  .toMapForDb());
          // print('diskon barang------------>');
          // print(dd);
        });

        // kurang qty ----------------------------------------------------->

        List<DataProduk> qty =
            await Get.find<produkController>().fetchProduklocal(id_toko);
        await Future.forEach(cache, (e) async {
          var kurangqty = qty.where((x) => x.idLocal == e.idLocal).first;
          if (kurangqty.idJenisStock == 1) {
            await DBHelper().UPDATE(
                table: 'produk_local',
                data: DataProduk(
                        idToko: kurangqty.idToko,
                        hargaModal: kurangqty.hargaModal,
                        idJenisStock: kurangqty.idJenisStock,
                        harga: kurangqty.harga,
                        namaProduk: kurangqty.namaProduk,
                        deskripsi: kurangqty.deskripsi,
                        idJenis: kurangqty.idJenis,
                        id: kurangqty.id,
                        idLocal: kurangqty.idLocal,
                        status: kurangqty.status,
                        sync: 'N',
                        idUser: kurangqty.idUser,
                        idKategori: kurangqty.idKategori,
                        diskonBarang: kurangqty.diskonBarang,
                        namaJenis: kurangqty.namaJenis,
                        image: kurangqty.image,
                        barcode: kurangqty.barcode,
                        qty: kurangqty.qty! - e.qty)
                    .toMapForDb(),
                id: kurangqty.idLocal);
          }
        });

        await fetchProduklocal(id_toko);
        await Get.find<historyController>().fetchPenjualanlocal(
            id_toko: id_toko, id_user: id_user, role: role);
        await Get.find<dashboardController>().loadhutangtotal();
        await Get.find<dashboardController>().loadpelanggantotal();
        await Get.find<dashboardController>().loadpendapatanhariini();
        await Get.find<dashboardController>().loadpendapatantotal();
        await Get.find<dashboardController>().loadtransaksihariini();
        await Get.find<dashboardController>().loadtransaksitotal();
        await Get.find<pelangganController>().fetchDataPelangganlocal(id_toko);
        await Get.find<pelangganController>()
            .fetchstatusPelangganlocal(id_toko);
        await Get.find<hutangController>().fetchDataHutanglocal(id_toko);
        await Get.find<produkController>().fetchProduklocal(id_toko);
        await getfavorite();
        await clear();
        cache.refresh();
        Get.back();
        Get.back();
        Get.back();
        Get.back();
        print('--------------------- snack bar ---------------------');
        Get.showSnackbar(
            toast().bottom_snackbar_success('Sukses', 'Pembayaran berhasil'));
        // Get.showSnackbar(
        //     toast().bottom_snackbar_success('Sukses', 'Pembayaran berhasil'));
      } else {
        Get.back(closeOverlays: true);
        Get.showSnackbar(
            toast().bottom_snackbar_error('error', 'Pembayaran gagal'));
      }
    } else {
      var id_hutang_generator = stringGenerator(10);
      print('hutang local-------------------------------->');
      var hutang = await DBHelper().INSERT(
          'hutang_local',
          DataHutang(
            idLocal: id_hutang_generator,
            idToko: int.parse(id_toko),
            idPelanggan: id_pelanggan.value,
            tglHutang: tgl_penjualan.value.isEmpty
                ? DateTime.now().toString()
                : tgl_penjualan.value.first.toString(),
            sync: 'N',
            aktif: 'Y',
            hutang: total.value.round(),
            sisaHutang: total.value.round(),
            status: 2,
          ).toMapForDb());
      var id_penjualan_generator2 = stringGenerator(10);
      var query = await DBHelper().INSERT(
          'penjualan_local',
          DataPenjualan(
                  idLocal: id_penjualan_generator2,
                  aktif: 'Y',
                  sync: 'N',
                  idPelanggan: id_pelanggan.value,
                  idHutang: id_hutang_generator,
                  idUser: id_user,
                  idToko: int.parse(id_toko),
                  total: total.value.round(),
                  totalItem: cache
                      .map((e) => e.qty)
                      .fold(0, (previous, current) => previous! + current),
                  tglPenjualan: tgl_penjualan.value.isEmpty
                      ? DateTime.now().toString()
                      : tgl_penjualan.value.first.toString(),
                  subTotal: subtotal.value.round(),
                  namaUser: nama_user,
                  metodeBayar: groupindex.value,
                  //  meja: meja.value.text.isEmpty ? '1' : meja.value.text,
                  meja:
                      bayarprebill == true ? nomormejabayarprebill.value : '-',
                  kembalian: 0,
                  diskonTotal:
                      diskonbarangtotal + jumlahdiskonkasir.value.round(),
                  diskonKasir: jumlahdiskonkasir.value.round(),
                  bayar: 0,
                  ppn: ppn.value.round(),
                  status: 2)
              .toMapForDb());
      print('diskon barang total------------------------->');
      print(diskonbarangtotal);

      if (query != null) {
        print('insert detail penjualan---------------------->');
        var detailpenjualan = await Future.forEach(cache, (e) async {
          var dd = e.harga! * e.diskonBarang! / 100;
          await DBHelper().INSERT(
              'penjualan_detail_local',
              DataPenjualanDetailV2(
                      idLocal: stringGenerator(10),
                      aktif: 'Y',
                      sync: 'N',
                      idUser: id_user,
                      idPenjualan: id_penjualan_generator2,
                      idJenisStock: e.idJenisStock,
                      idKategori: e.idKategori,
                      idProduk: e.idLocal,
                      namaBrg: e.namaProduk,
                      hargaBrg: e.harga,
                      diskonBrg: dd.round(),
                      qty: e.qty,
                      tgl: tgl_penjualan.value.isEmpty
                          ? DateTime.now().toString()
                          : tgl_penjualan.value.first.toString(),
                      hargaModal: e.hargaModal,
                      diskonKasir: jumlahdiskonkasir.value.round(),
                      total: 0)
                  .toMapForDb());
          print('diskon barang------------>');
          print(dd);
        });

        // kurang qty ----------------------------------------------------->
        List<DataProduk> qty =
            await Get.find<produkController>().fetchProduklocal(id_toko);
        await Future.forEach(cache, (e) async {
          var kurangqty = qty.where((x) => x.idLocal == e.idLocal).first;
          if (kurangqty.idJenisStock == 1) {
            await DBHelper().UPDATE(
                table: 'produk_local',
                data: DataProduk(
                        idToko: kurangqty.idToko,
                        hargaModal: kurangqty.hargaModal,
                        idJenisStock: kurangqty.idJenisStock,
                        harga: kurangqty.harga,
                        namaProduk: kurangqty.namaProduk,
                        deskripsi: kurangqty.deskripsi,
                        idJenis: kurangqty.idJenis,
                        id: kurangqty.id,
                        idLocal: kurangqty.idLocal,
                        status: kurangqty.status,
                        sync: 'N',
                        idUser: kurangqty.idUser,
                        idKategori: kurangqty.idKategori,
                        diskonBarang: kurangqty.diskonBarang,
                        namaJenis: kurangqty.namaJenis,
                        image: kurangqty.image,
                        barcode: kurangqty.barcode,
                        qty: kurangqty.qty! - e.qty)
                    .toMapForDb(),
                id: kurangqty.idLocal);
          }
        });

        await Get.find<produkController>().fetchProduklocal(id_toko);
        await fetchProduklocal(id_toko);
        await Get.find<historyController>().fetchPenjualanlocal(
            id_toko: id_toko, id_user: id_user, role: role);
        await Get.find<dashboardController>().loadhutangtotal();
        await Get.find<dashboardController>().loadpelanggantotal();
        await Get.find<dashboardController>().loadpendapatanhariini();
        await Get.find<dashboardController>().loadpendapatantotal();
        await Get.find<dashboardController>().loadtransaksihariini();
        await Get.find<dashboardController>().loadtransaksitotal();
        await Get.find<pelangganController>().fetchDataPelangganlocal(id_toko);
        await Get.find<pelangganController>()
            .fetchstatusPelangganlocal(id_toko);
        await Get.find<hutangController>().fetchDataHutanglocal(id_toko);
        await getfavorite();
        await clear();
        cache.refresh();
        Get.back();
        Get.back();
        Get.back();
        Get.back();
        Get.showSnackbar(
            toast().bottom_snackbar_success('Sukses', 'Hutang berhasil'));
      } else {
        Get.back(closeOverlays: true);
        Get.showSnackbar(
            toast().bottom_snackbar_error('error', 'Hutang gagal'));
      }
    }
    if (bayarprebill == true) {
      await DBHelper()
          .DELETEMEJAITEMKOSONG('meja', nomormejabayarprebill.value);
      await fetchmeja();
      bayarprebill.value = false;
      nomormejabayarprebill.value = '';
    }
  }

  pembayaranlocalprebill(
      id_toko, String nomor_meja, total_prebill, int diskon_kasir) async {
    print('-------------------pembayaran local prebill---------------------');

    Get.dialog(const showloading(), barrierDismissible: false);

    var diskonbarangtotal = cachemejadetail
        .map((e) => e)
        .fold(0, (total, x) => (x.harga! * x.diskonBrg! / 100).round());

    var id_localgenerator = stringGenerator(10);

    if (groupindex.value != 2) {
      print('pembayaran local prebill------------------------------------->');
      var query = await DBHelper().INSERT(
          'penjualan_local',
          DataPenjualan(
                  aktif: 'Y',
                  idLocal: id_localgenerator,
                  sync: 'N',
                  idUser: id_user,
                  idToko: int.parse(id_toko),
                  total: total_prebill,
                  totalItem: cachemejadetail
                      .where((p0) => p0.idMeja.toString() == nomor_meja)
                      .map((e) => e.qty)
                      .fold(0,
                          (previous, current) => previous! + current!.round()),
                  tglPenjualan: tgl_penjualan.value.isEmpty
                      ? DateTime.now().toString()
                      : tgl_penjualan.value.first.toString(),
                  subTotal: cachemeja
                      .where((p0) => p0.meja.toString() == nomor_meja)
                      .map((e) => e.subtotal)
                      .first,
                  namaUser: nama_user,
                  namaPelanggan:
                      groupindex.value == 2 ? nama_pelanggan.value.text : '-',
                  // idPelanggan: listpelanggan.,
                  metodeBayar: groupindex.value,
                  meja: nomor_meja,
                  kembalian: balikvalue_prebill.value.round(),
                  diskonTotal: diskonbarangtotal + diskon_kasir.round(),
                  bayar: bayarvalue_prebill.value,
                  diskonKasir: diskon_kasir.round(),
                  ppn: ppn.value.round(),
                  status: groupindex.value == 2 ? 2 : 1)
              .toMapForDb());
      // print('diskon barang total------------------------->');
      // print(diskonbarangtotal);

      if (query != null) {
        print('insert detail penjualan prebill---------------------->');
        var detailpenjualan = await Future.forEach(cachemejadetail, (e) async {
          var dd = e.harga! * e.diskonBrg! / 100;
          await DBHelper().INSERT(
              'penjualan_detail_local',
              DataPenjualanDetailV2(
                      idLocal: stringGenerator(10),
                      aktif: 'Y',
                      sync: 'N',
                      idUser: id_user,
                      idPenjualan: id_localgenerator,
                      idJenisStock: e.idJenisStock,
                      idKategori: e.idKategori,
                      idProduk: e.idProdukLocal,
                      namaBrg: e.namaProduk,
                      hargaBrg: e.harga,
                      diskonBrg: dd.round(),
                      qty: e.qty,
                      tgl: tgl_penjualan.value.isEmpty
                          ? DateTime.now().toString()
                          : tgl_penjualan.value.first.toString(),
                      hargaModal: e.hargaModal,
                      diskonKasir: diskon_kasir.round(),
                      total: total_prebill)
                  .toMapForDb());
          // print('diskon barang------------>');
          // print(dd);
        });

        // kurang qty ----------------------------------------------------->

        List<DataProduk> qty =
            await Get.find<produkController>().fetchProduklocal(id_toko);
        await Future.forEach(cachemejadetail, (e) async {
          var kurangqty = qty.where((x) => x.idLocal == e.idProdukLocal).first;
          if (kurangqty.idJenisStock == 1) {
            await DBHelper().UPDATE(
                table: 'produk_local',
                data: DataProduk(
                        idToko: kurangqty.idToko,
                        hargaModal: kurangqty.hargaModal,
                        idJenisStock: kurangqty.idJenisStock,
                        harga: kurangqty.harga,
                        namaProduk: kurangqty.namaProduk,
                        deskripsi: kurangqty.deskripsi,
                        idJenis: kurangqty.idJenis,
                        id: kurangqty.id,
                        idLocal: kurangqty.idLocal,
                        status: kurangqty.status,
                        sync: 'N',
                        idUser: kurangqty.idUser,
                        idKategori: kurangqty.idKategori,
                        diskonBarang: kurangqty.diskonBarang,
                        namaJenis: kurangqty.namaJenis,
                        image: kurangqty.image,
                        barcode: kurangqty.barcode,
                        qty: kurangqty.qty! - e.qty!.round())
                    .toMapForDb(),
                id: kurangqty.idLocal);
          }
        });

        await fetchProduklocal(id_toko);
        await Get.find<historyController>().fetchPenjualanlocal(
            id_toko: id_toko, id_user: id_user, role: role);
        await Get.find<dashboardController>().loadhutangtotal();
        await Get.find<dashboardController>().loadpelanggantotal();
        await Get.find<dashboardController>().loadpendapatanhariini();
        await Get.find<dashboardController>().loadpendapatantotal();
        await Get.find<dashboardController>().loadtransaksihariini();
        await Get.find<dashboardController>().loadtransaksitotal();
        await Get.find<pelangganController>().fetchDataPelangganlocal(id_toko);
        await Get.find<pelangganController>()
            .fetchstatusPelangganlocal(id_toko);
        await Get.find<hutangController>().fetchDataHutanglocal(id_toko);
        await Get.find<produkController>().fetchProduklocal(id_toko);
        await getfavorite();
        await clear();
        cache.refresh();
        Get.back();
        Get.back();
        Get.back();
        Get.back();
        Get.showSnackbar(
            toast().bottom_snackbar_success('Sukses', 'Pembayaran berhasil'));
      } else {
        Get.back(closeOverlays: true);
        Get.showSnackbar(
            toast().bottom_snackbar_error('error', 'Pembayaran gagal'));
      }
    } else {
      var id_hutang_generator = stringGenerator(10);
      print('hutang local-------------------------------->');
      var hutang = await DBHelper().INSERT(
          'hutang_local',
          DataHutang(
            idLocal: id_hutang_generator,
            idToko: int.parse(id_toko),
            idPelanggan: id_pelanggan.value,
            tglHutang: tgl_penjualan.value.isEmpty
                ? DateTime.now().toString()
                : tgl_penjualan.value.first.toString(),
            sync: 'N',
            aktif: 'Y',
            hutang: total_prebill,
            sisaHutang: total_prebill,
            status: 2,
          ).toMapForDb());
      var id_penjualan_generator2 = stringGenerator(10);
      var query = await DBHelper().INSERT(
          'penjualan_local',
          DataPenjualan(
                  idLocal: id_penjualan_generator2,
                  aktif: 'Y',
                  sync: 'N',
                  idPelanggan: id_pelanggan.value,
                  idHutang: id_hutang_generator,
                  idUser: id_user,
                  idToko: int.parse(id_toko),
                  total: total_prebill,
                  totalItem: cachemejadetail.map((e) => e.qty).fold(
                      0, (previous, current) => previous! + current!.round()),
                  tglPenjualan: tgl_penjualan.value.isEmpty
                      ? DateTime.now().toString()
                      : tgl_penjualan.value.first.toString(),
                  subTotal: cachemeja
                      .where((p0) => p0.meja.toString() == nomor_meja)
                      .map((e) => e.subtotal)
                      .first,
                  namaUser: nama_user,
                  metodeBayar: groupindex.value,
                  meja: nomor_meja,
                  kembalian: 0,
                  diskonTotal: diskonbarangtotal + diskon_kasir.round(),
                  diskonKasir: diskon_kasir.round(),
                  bayar: 0,
                  ppn: ppn.value.round(),
                  status: 2)
              .toMapForDb());
      print('diskon barang total------------------------->');
      print(diskonbarangtotal);

      if (query != null) {
        print('insert detail penjualan---------------------->');
        var detailpenjualan = await Future.forEach(cachemejadetail, (e) async {
          var dd = e.harga! * e.diskonBrg! / 100;
          await DBHelper().INSERT(
              'penjualan_detail_local',
              DataPenjualanDetailV2(
                      idLocal: stringGenerator(10),
                      aktif: 'Y',
                      sync: 'N',
                      idUser: id_user,
                      idPenjualan: id_penjualan_generator2,
                      idJenisStock: e.idJenisStock,
                      idKategori: e.idKategori,
                      idProduk: e.idProdukLocal,
                      namaBrg: e.namaProduk,
                      hargaBrg: e.harga,
                      diskonBrg: dd.round(),
                      qty: e.qty,
                      tgl: tgl_penjualan.value.isEmpty
                          ? DateTime.now().toString()
                          : tgl_penjualan.value.first.toString(),
                      hargaModal: e.hargaModal,
                      diskonKasir: diskon_kasir.round(),
                      total: 0)
                  .toMapForDb());
          print('diskon barang------------>');
          print(dd);
        });

        // kurang qty ----------------------------------------------------->
        List<DataProduk> qty =
            await Get.find<produkController>().fetchProduklocal(id_toko);
        await Future.forEach(cachemejadetail, (e) async {
          var kurangqty = qty.where((x) => x.idLocal == e.idProdukLocal).first;
          if (kurangqty.idJenisStock == 1) {
            await DBHelper().UPDATE(
                table: 'produk_local',
                data: DataProduk(
                        idToko: kurangqty.idToko,
                        hargaModal: kurangqty.hargaModal,
                        idJenisStock: kurangqty.idJenisStock,
                        harga: kurangqty.harga,
                        namaProduk: kurangqty.namaProduk,
                        deskripsi: kurangqty.deskripsi,
                        idJenis: kurangqty.idJenis,
                        id: kurangqty.id,
                        idLocal: kurangqty.idLocal,
                        status: kurangqty.status,
                        sync: 'N',
                        idUser: kurangqty.idUser,
                        idKategori: kurangqty.idKategori,
                        diskonBarang: kurangqty.diskonBarang,
                        namaJenis: kurangqty.namaJenis,
                        image: kurangqty.image,
                        barcode: kurangqty.barcode,
                        qty: kurangqty.qty! - e.qty!.round())
                    .toMapForDb(),
                id: kurangqty.idLocal);
          }
        });

        await Get.find<produkController>().fetchProduklocal(id_toko);
        await fetchProduklocal(id_toko);
        await Get.find<historyController>().fetchPenjualanlocal(
            id_toko: id_toko, id_user: id_user, role: role);
        await Get.find<dashboardController>().loadhutangtotal();
        await Get.find<dashboardController>().loadpelanggantotal();
        await Get.find<dashboardController>().loadpendapatanhariini();
        await Get.find<dashboardController>().loadpendapatantotal();
        await Get.find<dashboardController>().loadtransaksihariini();
        await Get.find<dashboardController>().loadtransaksitotal();
        await Get.find<pelangganController>().fetchDataPelangganlocal(id_toko);
        await Get.find<pelangganController>()
            .fetchstatusPelangganlocal(id_toko);
        await Get.find<hutangController>().fetchDataHutanglocal(id_toko);
        await getfavorite();
        await clear();
        cache.refresh();
        Get.back();
        Get.back();
        Get.back();
        Get.back();
        Get.showSnackbar(
            toast().bottom_snackbar_success('Sukses', 'Hutang berhasil'));
      } else {
        Get.back(closeOverlays: true);
        Get.showSnackbar(
            toast().bottom_snackbar_error('error', 'Hutang gagal'));
      }
    }
  }

  clear() {
    cache.value.clear();
    cache.refresh();
    meja.value.clear();
    nomor_meja.value = '';
    subtotal.value = 0;
    total.value = 0;
    totalprebill.value = 0;
    displaydiskon.value = 0;
    jumlahdiskonkasir.value = 0;
    textdiskon.value.clear();
    ppn.value = 0;
    groupindex.value = 9;
    keypadController.value.clear();
    keypadController_prebill.value.clear();
    kembalian_prebill.value.clear();
    kembalian.value.clear();
    id_pelanggan.value = '';
    tgl_penjualan.value.clear();
  }

  deletekeranjanglocal(String table) async {
    await DBHelper().DELETEALL(table);
    print("isi ${table} di hapus----------------------->");
  }

  pembayaran() async {
    print('------------------pembayaran---------------------');
// note :
    // untuk tipe yg bukan Rx (bukan yg bis obs) itu harus di buatkan null operator (??)
    var checkconn = await check_conn.check();
    if (checkconn == true) {
      var keranjang = await REST.kasirPembayaran(
          token: token,
          iduser: id_user,
          idtoko: id_toko,
          meja: meja.value.text,
          bayar: bayarvalue.value.toString(),
          metodebayar: groupindex.value.toString(),
          id_pelanggan: id_pelanggan.value);
      if (keranjang != null) {
        print('------------------pembayaran--------------');
        //  await fetchkeranjang();
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

  tambahPelangganlocal() async {
    print('-------------------tambah pelanggan local---------------------');

    Get.dialog(const showloading(), barrierDismissible: false);

    var query = await DBHelper().INSERT(
        'pelanggan_local',
        DataPelanggan(
                idLocal: stringGenerator(10),
                idToko: int.parse(id_toko),
                namaPelanggan: nama_pelanggan.value.text,
                noHp: nohp.value.text,
                sync: 'N',
                aktif: 'Y')
            .toMapForDb());

    if (query != null) {
      print(query);
      await fetchDataPelangganlocal(id_toko);
      nama_pelanggan.value.clear();
      nohp.value.clear();
      Get.back();
      Get.back();
      Get.showSnackbar(toast()
          .bottom_snackbar_success('Sukses', 'Pelanggan berhasil ditambah'));
    } else {
      Get.back();
      Get.showSnackbar(
          toast().bottom_snackbar_error('error', 'gagal tambah data local'));
    }

    // if (add == 1) {
    //
    // } else {
    //   Get.back(closeOverlays: true);
    //   Get.showSnackbar(
    //       toast().bottom_snackbar_error('error', 'gagal tambah data local'));
    // }
  }

  var list_pelanggan_local = <DataPelanggan>[].obs;

  fetchDataPelangganlocal(id_toko) async {
    print('-------------------fetch pelanggan local---------------------');
    //succ.value = false;
    List<Map<String, Object?>> query = await DBHelper().FETCH(
        'SELECT * FROM pelanggan_local WHERE id_toko = $id_toko AND aktif = "Y" ORDER BY ID DESC');
    List<DataPelanggan> pelanggan = query.isNotEmpty
        ? query.map((e) => DataPelanggan.fromJson(e)).toList()
        : [];
    list_pelanggan_local.value = pelanggan;
    // print('fect produk local --->' + produk.toList().toString());
    //succ.value = true;
    return pelanggan;
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
    } on PlatformException catch (e) {
      print(e);
      Get.back();
      Get.showSnackbar(toast().bottom_snackbar_error('Error', e.toString()));
    }
  }

  // Barcode? result;
  // QRViewController? controllerscan;
  // final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  var testlist = [].obs;

  // void onQRViewCreated(QRViewController controller) {
  //   controllerscan = controller;
  //   controller.scannedDataStream.listen((scanData) {
  //     result = scanData;
  //     print(result);
  //     testlist.add(result!.code);
  //     Get.showSnackbar(
  //         toast().bottom_snackbar_success('scan', result!.code.toString()));
  //
  //     // setState(() {
  //     //   result = scanData;
  //     // });
  //   });
  // }

  Future<void> scankasir() async {
    try {
      scaned_qr_code = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'cancel', true, ScanMode.QR);
      if (scaned_qr_code != '-1') {
        // Get.snackbar('result', scaned_qr_code);

        var qr = produklist
            .where((e) => e.id.toString().contains(scaned_qr_code.toString()))
            .first;
        final existingIndex =
            cache.value.indexWhere((item) => item.id == qr.id);
        print(
            'test scan kasir-------------------------------------------------');
        print(qr);
        if (existingIndex == -1) {
          cache.add(
            DataKeranjangCache(
                id: qr.id!,
                idToko: qr.idToko,
                idUser: qr.idUser!,
                idJenis: qr.idJenis,
                idJenisStock: qr.idJenisStock,
                namaJenis: qr.namaJenis!,
                idKategori: qr.idKategori!,
                namaProduk: qr.namaProduk,
                deskripsi: qr.deskripsi,
                qty: 1,
                harga: qr.harga,
                diskonBarang: qr.diskonBarang,
                image: qr.image!,
                status: qr.status.toString(),
                updated: qr.updated.toString(),
                createdAt: qr.createdAt.toString(),
                updatedAt: qr.updatedAt.toString()),
          );
        } else {
          var pp =
              produklist.where((e) => e.id == cache[existingIndex].id).first;
          // var xx = controller.cache.where((e) => e.id == p.id).first;
          if (pp.qty! <= cache[existingIndex].qty &&
              cache[existingIndex].idJenisStock == 1) {
            print('maxxxx-------------------------');
            Get.showSnackbar(toast().bottom_snackbar_error(
                "Error", 'Stock sudah habis! harap isi stock terlebih dahulu'));
          } else {
            cache[existingIndex].qty++;
          }
        }
        subtotalval();
        totalval();
        cache.refresh();
      } else {
        print('scan canceled');
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

  var bayarvalue = 0.obs;

  var bayarvalue_prebill = 0.obs;
  var balikvalue_prebill = 0.0.obs;

  var balikvalue = 0.0.obs;

  balik() {
    var kem = bayarvalue.value - total.value;
    kem < 0
        ? kembalian.value.text = ''
        : kembalian.value.text = kem
            .toStringAsFixed(0)
            .replaceAll(RegExp(r'[^\w\s]+'), '')
            .replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                (Match m) => '${m[1]},');
    balikvalue.value = kem;
    //kembalian.value.text = kem.toString();
    print('---kembalian----');
    print(kembalian.value.text);
    print('balik value---------');
    print(balikvalue.value.toString());
  }

  balikprebill(double total_prebill) {
    var kem = bayarvalue_prebill.value - total_prebill;
    kem < 0
        ? kembalian_prebill.value.text = ''
        : kembalian_prebill.value.text = kem
            .toStringAsFixed(0)
            .replaceAll(RegExp(r'[^\w\s]+'), '')
            .replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                (Match m) => '${m[1]},');
    balikvalue_prebill.value = kem;
    //kembalian.value.text = kem.toString();
    print('---kembalian----');
    print(kembalian_prebill.value.text);
    print('balik value---------');
    print(balikvalue_prebill.value.toString());
  }

  add_5000(String x) {
    if (keypadController.value.text.isEmpty) {
      keypadController.value.text = '5,000';
      bayarvalue.value = 5000;
    } else {
      var sum = int.parse(x.replaceAll(',', '')) + 5000;
      print(sum);
      keypadController.value.text = sum
          .toStringAsFixed(0)
          .replaceAll(RegExp(r'[^\w\s]+'), '')
          .replaceAllMapped(
              RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},');
      bayarvalue.value = sum;
    }
  }

  add_5000_prebill(String x) {
    if (keypadController_prebill.value.text.isEmpty) {
      keypadController_prebill.value.text = '5,000';
      bayarvalue_prebill.value = 5000;
    } else {
      var sum = int.parse(x.replaceAll(',', '')) + 5000;
      print(sum);
      keypadController_prebill.value.text = sum
          .toStringAsFixed(0)
          .replaceAll(RegExp(r'[^\w\s]+'), '')
          .replaceAllMapped(
              RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},');
      bayarvalue_prebill.value = sum;
    }
  }

  add_10000(String x) {
    if (keypadController.value.text.isEmpty) {
      keypadController.value.text = '10,000';
      bayarvalue.value = 10000;
    } else {
      var sum = int.parse(x.replaceAll(',', '')) + 10000;
      print(sum);
      keypadController.value.text = sum
          .toStringAsFixed(0)
          .replaceAll(RegExp(r'[^\w\s]+'), '')
          .replaceAllMapped(
              RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},');
      bayarvalue.value = sum;
    }
  }

  add_10000_prebill(String x) {
    if (keypadController_prebill.value.text.isEmpty) {
      keypadController_prebill.value.text = '10,000';
      bayarvalue_prebill.value = 10000;
    } else {
      var sum = int.parse(x.replaceAll(',', '')) + 10000;
      print(sum);
      keypadController_prebill.value.text = sum
          .toStringAsFixed(0)
          .replaceAll(RegExp(r'[^\w\s]+'), '')
          .replaceAllMapped(
              RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},');
      bayarvalue_prebill.value = sum;
    }
  }

  add_20000(String x) {
    if (keypadController.value.text.isEmpty) {
      keypadController.value.text = '20,000';
      bayarvalue.value = 20000;
    } else {
      var sum = int.parse(x.replaceAll(',', '')) + 20000;
      print(sum);
      keypadController.value.text = sum
          .toStringAsFixed(0)
          .replaceAll(RegExp(r'[^\w\s]+'), '')
          .replaceAllMapped(
              RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},');
      bayarvalue.value = sum;
    }
  }

  add_20000_prebill(String x) {
    if (keypadController_prebill.value.text.isEmpty) {
      keypadController_prebill.value.text = '20,000';
      bayarvalue_prebill.value = 20000;
    } else {
      var sum = int.parse(x.replaceAll(',', '')) + 20000;
      print(sum);
      keypadController_prebill.value.text = sum
          .toStringAsFixed(0)
          .replaceAll(RegExp(r'[^\w\s]+'), '')
          .replaceAllMapped(
              RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},');
      bayarvalue_prebill.value = sum;
    }
  }

  add_50000(String x) {
    if (keypadController.value.text.isEmpty) {
      keypadController.value.text = '50,000';
      bayarvalue.value = 50000;
    } else {
      var sum = int.parse(x.replaceAll(',', '')) + 50000;
      print(sum);
      keypadController.value.text = sum
          .toStringAsFixed(0)
          .replaceAll(RegExp(r'[^\w\s]+'), '')
          .replaceAllMapped(
              RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},');
      bayarvalue.value = sum;
    }
  }

  add_50000_prebill(String x) {
    if (keypadController_prebill.value.text.isEmpty) {
      keypadController_prebill.value.text = '50,000';
      bayarvalue_prebill.value = 50000;
    } else {
      var sum = int.parse(x.replaceAll(',', '')) + 50000;
      print(sum);
      keypadController_prebill.value.text = sum
          .toStringAsFixed(0)
          .replaceAll(RegExp(r'[^\w\s]+'), '')
          .replaceAllMapped(
              RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},');
      bayarvalue_prebill.value = sum;
    }
  }

  add_100000(String x) {
    if (keypadController.value.text.isEmpty) {
      keypadController.value.text = '100,000';
      bayarvalue.value = 100000;
    } else {
      var sum = int.parse(x.replaceAll(',', '')) + 100000;
      print(sum);
      keypadController.value.text = sum
          .toStringAsFixed(0)
          .replaceAll(RegExp(r'[^\w\s]+'), '')
          .replaceAllMapped(
              RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},');
      bayarvalue.value = sum;
    }
  }

  add_100000_prebill(String x) {
    if (keypadController_prebill.value.text.isEmpty) {
      keypadController_prebill.value.text = '100,000';
      bayarvalue_prebill.value = 100000;
    } else {
      var sum = int.parse(x.replaceAll(',', '')) + 100000;
      print(sum);
      keypadController_prebill.value.text = sum
          .toStringAsFixed(0)
          .replaceAll(RegExp(r'[^\w\s]+'), '')
          .replaceAllMapped(
              RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},');
      bayarvalue_prebill.value = sum;
    }
  }

  var formKeypelangganpembayaran = GlobalKey<FormState>().obs;

  tambahpelangganpembayaran() {
    AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0))),
        contentPadding: EdgeInsets.zero,
        backgroundColor: Colors.transparent,
        content: Builder(
          builder: (context) {
            return Container(
                padding: EdgeInsets.zero,
                width: context.width_query / 2,
                height: context.height_query / 2,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: Card(
                      elevation: elevation().def_elevation,
                      //margin: EdgeInsets.all(30),
                      shape: RoundedRectangleBorder(
                        borderRadius: border_radius().def_border,
                        side: BorderSide(
                            color: color_template().primary, width: 3.5),
                      ),

                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Container(
                          width: context.width_query / 1,
                          //height: context.height_query / 1.3,
                          child: Form(
                              key: formKeypelangganpembayaran.value,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  header(
                                    title: 'Tambah Pelanggan',
                                    icon: FontAwesomeIcons.dollarSign,
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  TextFormField(
                                    controller: nama_pelanggan.value,
                                    onChanged: ((String pass) {}),
                                    decoration: InputDecoration(
                                      icon: Icon(FontAwesomeIcons.person),
                                      labelText: "Nama pelanggan",
                                      labelStyle: TextStyle(
                                        color: Colors.black87,
                                      ),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                    ),
                                    textAlign: TextAlign.start,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Masukan nama pelanggan';
                                      }
                                      return null;
                                    },
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  TextFormField(
                                    controller: nohp.value,
                                    onChanged: ((String pass) {}),
                                    decoration: InputDecoration(
                                      icon: Icon(FontAwesomeIcons.phone),
                                      labelText: "Nomor HP",
                                      labelStyle: TextStyle(
                                        color: Colors.black87,
                                      ),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                    ),
                                    textAlign: TextAlign.start,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Masukan nomor hp';
                                      }
                                      return null;
                                    },
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  button_solid_custom(
                                      onPressed: () {
                                        if (formKeypelangganpembayaran
                                            .value.currentState!
                                            .validate()) {
                                          tambahPelanggan();
                                        }
                                      },
                                      child: Text(
                                        'Tambah pelanggan'.toUpperCase(),
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      width: double.infinity,
                                      height: 65)
                                ],
                              )),
                        ),
                      ),
                    )));
          },
        ));
  }
}
