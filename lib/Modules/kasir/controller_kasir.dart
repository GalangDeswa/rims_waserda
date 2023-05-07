import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:rims_waserda/Modules/Widgets/toast.dart';
import 'package:rims_waserda/Modules/kasir/model_keranjang_cache.dart';
import 'package:rims_waserda/Modules/pelanggan/data%20pelanggan/model_data_pelanggan.dart';
import 'package:rims_waserda/Templates/setting.dart';

import '../../Services/handler.dart';
import '../Widgets/buttons.dart';
import '../Widgets/header.dart';
import '../Widgets/loading.dart';
import '../produk/data produk/model_produk.dart';
import '../produk/jenis produk/model_jenisproduk.dart';
import 'model_kasir.dart';

class kasirController extends GetxController {
  @override
  Future<void> onInit() async {
    // TODO: implement onInit
    super.onInit();

    print('kasir init------------------------------------------------->');
    await fetchProduk();
    produkcache.value = await GetStorage().read('produk');
    await fetchjenis();
    jeniscache.value = await GetStorage().read('jenis');
    fetchpelanggan();
    await MobileScannerController().stop();

    // fetchkeranjangcache();

    //keypadController.value = TextEditingController(text: '0');
    // kembalian.value = TextEditingController(text: '0');

    // fetchkeranjang();
    nextscroll();
    layout.value = await GetStorage().read('layout');
  }

  var layout = false.obs;
  var kasir = GetStorage().read('name');

  var produkcache = <DataProduk>[].obs;
  var jeniscache = <DataJenis>[].obs;

  Future<void> refresh() async {
    await fetchProduk();
    await fetchjenis();
  }

  final nominal = NumberFormat("#,##0");
  final formatCurrency =
      NumberFormat.currency(decimalDigits: 0, locale: 'id', symbol: '');

  var kembalian = TextEditingController().obs;
  var keypadController = TextEditingController().obs;
  var keypadvalue = 0.0.obs;

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
    return [];
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
        totalpage.value = dataProduk.meta.pagination.totalPages;
        totaldata.value = dataProduk.meta.pagination.total;
        perpage.value = dataProduk.meta.pagination.perPage;
        currentpage.value = produk['meta']['pagination']['current_page'];
        count.value = dataProduk.meta.pagination.count;
        if (totalpage > 1) {
          nextdata = produk['meta']['pagination']['links']['next'] ?? '';
        }
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

  tambahqty(int index) async {
    cache.refresh();
    var qty = cache.value[index].qty;
    var add = qty + 1;
    var sum = cache[index].qty = add;
    print(produklist[index].qty);
    // var pp = produklist.where((e) => e.id == cache[index].id).first;
    // if (int.parse(pp.qty) <= sum) {
    //   max.value = true;
    // } else {
    //   max.value = false;
    // }

    await subtotalval();
    await totalval();
    print('qty cache ------------------------------------------');

    //cache.refresh();

    print(cache[index].qty);
    return sum;
  }

  deleteqty(int index, int idproduk) async {
    max.value = false;
    var qty = cache.value[index].qty;
    var del = qty - 1;
    var sum = cache[index].qty = del;
    await subtotalval();
    await totalval();
    if (sum < 1) {
      cache.value.removeWhere((element) => element.id == idproduk);
      print('qty cache deldete ------------------------------------------');
      cache.refresh();
    } else {
      cache.refresh();
      return sum;
    }
  }

  deleteitemcache(int idproduk) {
    max.value = false;
    cache.value.removeWhere((element) => element.id == idproduk);
    subtotalval();
    totalval();
    cache.refresh();
  }

  var excache = <String>[];
  RxDouble subtotal = 0.0.obs;
  RxDouble total = 0.0.obs;
  var diskon = 0.15.obs;
  RxDouble displaydiskon = 0.0.obs;

  displayDiskon() {
    return displaydiskon.value = jumlahdiskonkasir.value;
  }

  var textdiskon = TextEditingController().obs;

  var jumlahdiskonkasir = 0.0.obs;

  editDiskonKasir(kasirController controller) {
    Get.dialog(AlertDialog(
      title: header(
          title: 'Edit diskon',
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
                    Text('Masukan potongan harga'),
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
                                suffixText: '%',
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10)),
                              ),
                              textAlign: TextAlign.center,
                              controller: textdiskon.value,
                              style: font().header_black,
                            ),
                          ),
                        ],
                      ),
                    ),
                    button_solid_custom(
                        onPressed: () {
                          jumlahdiskonkasir.value =
                              double.parse(textdiskon.value.text);
                          totalval();
                          Get.back();
                        },
                        child: Text(
                          'Edit diskon',
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

  tambahKeranjangcache(int idproduk) async {
    print('-------------------Tambah keranjang cache---------------------');
    // keranjangcache.value = await GetStorage().read('keranjang');
    var query = produkcache.value.where((element) => element.id == idproduk);

    final existingIndex = cache.value.indexWhere((item) => item.id == idproduk);

    if (existingIndex == -1) {
      cache.add(
        DataKeranjangCache(
            id: query.map((e) => e.id).first,
            idToko: query.map((e) => e.idToko).first.toString(),
            idUser: query.map((e) => e.idUser).first.toString(),
            idJenis: query.map((e) => e.idJenis).first.toString(),
            idJenisStock: query.map((e) => e.idJenisStock).first,
            namaJenis: query.map((e) => e.namaJenis).first,
            idKategori: query.map((e) => e.idKategori).first.toString(),
            namaProduk: query.map((e) => e.namaProduk).first,
            deskripsi: query.map((e) => e.deskripsi).first,
            qty: 1,
            harga: query.map((e) => e.harga).first,
            diskonBarang:
                query.map((e) => int.parse(e.harga) - e.diskonBarang).first,
            diskonKasir: jumlahdiskonkasir.value.toInt(),
            image: query.map((e) => e.image).first,
            status: query.map((e) => e.status).first.toString(),
            updated: query.map((e) => e.updated).first.toString(),
            createdAt: query.map((e) => e.createdAt).first.toString(),
            updatedAt: query.map((e) => e.updatedAt).first.toString()),
      );
    } else {
      var pp = produklist.where((e) => e.id == cache[existingIndex].id).first;
      // var xx = controller.cache.where((e) => e.id == p.id).first;
      if (int.parse(pp.qty) <= cache[existingIndex].qty &&
          cache[existingIndex].idJenisStock == 1) {
        print('maxxxx-------------------------');
        Get.showSnackbar(toast().bottom_snackbar_error(
            "Error", 'Stock sudah habis! harap isi stock terlebih dahulu'));
      } else {
        cache[existingIndex].qty++;
      }
    }
    // if (int.parse(query.map((e) => e.qty).toString()) <=
    //     cache[existingIndex].qty) {
    //   max.value = true;
    // }

    print(cache.value.map((e) {
      return [e.namaProduk, e.qty, e.diskonKasir];
    }).toList());

    subtotalval();
    totalval();
    print(diskon.value);

    cache.refresh();
  }

  totalval() {
    return total.value =
        subtotal.value - (subtotal.value * jumlahdiskonkasir.value / 100);
  }

  subtotalval() {
    subtotal.value = cache.map((expense) => expense).fold(
        0,
        (total, amount) =>
            total +
            (amount.qty * int.parse(amount.harga) - amount.diskonBarang!));
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
                id: qr.id,
                idToko: qr.idToko.toString(),
                idUser: qr.idUser.toString(),
                idJenis: qr.idJenis.toString(),
                idJenisStock: qr.idJenisStock,
                namaJenis: qr.namaJenis,
                idKategori: qr.idKategori.toString(),
                namaProduk: qr.namaProduk,
                deskripsi: qr.deskripsi,
                qty: 1,
                harga: qr.harga,
                diskonBarang: qr.diskonBarang,
                image: qr.image,
                status: qr.status.toString(),
                updated: qr.updated.toString(),
                createdAt: qr.createdAt.toString(),
                updatedAt: qr.updatedAt.toString()),
          );
        } else {
          var pp =
              produklist.where((e) => e.id == cache[existingIndex].id).first;
          // var xx = controller.cache.where((e) => e.id == p.id).first;
          if (int.parse(pp.qty) <= cache[existingIndex].qty &&
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
