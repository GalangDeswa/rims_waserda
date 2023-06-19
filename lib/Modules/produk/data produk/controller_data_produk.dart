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
import 'package:rims_waserda/Modules/dashboard/controller_dashboard.dart';
import 'package:rims_waserda/Modules/kasir/controller_kasir.dart';
import 'package:rims_waserda/Modules/produk/data%20produk/view_produk_table.dart';
import 'package:rims_waserda/Modules/produk/jenis%20produk/model_jenisproduk.dart';
import 'package:rims_waserda/Modules/produk/jenis%20produk/view_jenis_table.dart';
import 'package:rims_waserda/Services/handler.dart';
import 'package:rims_waserda/db_helper.dart';
import 'package:rims_waserda/db_helperv2.dart';

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
    print(
        '-------------------------------PRODUK CONTROLLER INIT--------------------------->');
    //getprodukall();
    //check_conn.check();
    //fetchProduk();
    //DBHelper().init();
    fetchProduklocal(id_toko);
    fetchjenislocal(id_toko);
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

  var check = false.obs;
  var checkfoto = false.obs;
  var checkbarcode = false.obs;

  var barcode = TextEditingController().obs;

  var jumlahharga = 0.obs;
  var jumlahdiskon = 0.0.obs;

  // carikdiskon(){
  //   jumlahharga.value * (jumlahharga.value - jumlahdiskon.value/jumlahharga)
  // }

  var produklist = <DataProduk>[].obs;

  var produklistlocal = <DataProduk>[].obs;

  var jenislist = <DataJenis>[].obs;
  var jenislistlocal = <DataJenis>[].obs;

  var compresimagepath = ''.obs;
  var compresimagesize = ''.obs;
  var namaFile = ''.obs;
  File? pickedImageFile;
  var image64;

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
      final bytes = File(image!.path).readAsBytesSync();
      String base64Image = base64Encode(bytes);
      image64 = base64Image;
      //  final temppath = File(image!.path);
      pikedImagePath.value = pickedImageFile!.path;
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
  var searchjenis = TextEditingController().obs;

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
  var succ = true.obs;

  searchproduklocal() async {
    List<Map<String, Object?>> query = await DBHelper().FETCH(
        'SELECT * FROM produk_local WHERE id_toko = $id_toko AND status = 1 AND nama_produk LIKE "%${search.value.text}%" OR  barcode LIKE "%${search.value.text}%" OR  nama_jenis LIKE "%${search.value.text}%" ORDER BY ID DESC');
    List<DataProduk> produk = query.isNotEmpty
        ? query.map((e) => DataProduk.fromJson(e)).toList()
        : [];
    produklistlocal.value = produk;
    // print('fect produk local --->' + produk.toList().toString());

    return produk;
  }

  searchjenislocal() async {
    List<Map<String, Object?>> query = await DBHelper().FETCH(
        'SELECT * FROM produk_jenis_local WHERE id_toko = $id_toko AND nama_jenis LIKE "%${searchjenis.value.text}%" ORDER BY ID DESC');
    List<DataJenis> jenis = query.isNotEmpty
        ? query.map((e) => DataJenis.fromJson(e)).toList()
        : [];
    jenislistlocal.value = jenis;

    return jenis;
  }

  fetchProduk() async {
    print('-------------------fetchProduk---------------------');
    //succ.value = false;
    var checkconn = await check_conn.check();
    if (checkconn == true) {
      var produk = await REST.produkAllv2(token, id_toko);
      if (produk != null) {
        print('-------------------dataproduk---------------');
        //   succ.value = true;

        var dataProduk = ModelProduk.fromJson(produk);
        // if (produk['success'] == false) {
        //   succ.value = false;
        //   print('faslese');
        //   print(produk['messages']);
        //   // produklist.value = [];
        // } else {
        //   succ.value = true;
        // }
        //produklist.value = dataProduk.data;

        produklistlocal.value = dataProduk.data;

        // totalpage.value = dataProduk.meta.pagination.totalPages;
        // totaldata.value = dataProduk.meta.pagination.total;
        // perpage.value = dataProduk.meta.pagination.perPage;
        // currentpage.value = produk['meta']['pagination']['current_page'];
        // count.value = dataProduk.meta.pagination.count;
        // if (totalpage > 1) {
        //   nextdata = produk['meta']['pagination']['links']['next'];
        //   previouspage = produk['meta']['pagination']['links']['previous'];
        // }

        print('--------------------list produk---------------');
        print(produklistlocal);

        //   Get.back(closeOverlays: true);

        return produklistlocal;
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

  fetchProduksync(id_toko) async {
    print('-------------------fetch Produk local sync---------------------');
    //succ.value = false;
    List<Map<String, Object?>> query = await DBHelper().FETCH(
        'SELECT * FROM produk_local WHERE id_toko = $id_toko ORDER BY ID DESC');
    List<DataProduk> produk = query.isNotEmpty
        ? query.map((e) => DataProduk.fromJson(e)).toList()
        : [];
    produklistlocal.value = produk;
    // print('fect produk local --->' + produk.toList().toString());
    // succ.value = true;
    return produk;
  }

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

  fetchProduklocalv2() async {
    print('-------------------fetchProduk---------------------');
    succ.value = false;
    var db = DatabaseHelper.instance;

    var produk = await db.getProdukv2();
    produklistlocal.value = produk;
    succ.value = true;

    return produklistlocal;

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
        // totalpagejenis.value = dataJenis.meta.pagination.totalPages;
        // totaldatajenis.value = dataJenis.meta.pagination.total;
        // perpagejenis.value = dataJenis.meta.pagination.perPage;
        // currentpagejenis.value = jenis['meta']['pagination']['current_page'];
        // countjenis.value = dataJenis.meta.pagination.count;
        // if (totalpagejenis > 1) {
        //   nextdatajenis = jenis['meta']['pagination']['links']['next'];
        // }
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

  fetchjenissync(id_toko) async {
    print('-------------------fetch jenis local sync---------------------');

    List<Map<String, Object?>> query = await DBHelper().FETCH(
        'SELECT * FROM produK_jenis_local WHERE id_toko = $id_toko ORDER BY ID DESC');
    List<DataJenis> jenis = query.isNotEmpty
        ? query.map((e) => DataJenis.fromJson(e)).toList()
        : [];
    jenislistlocal.value = jenis;
    //print(jenislistlocal);

    return jenis;
  }

  fetchjenislocal(id_toko) async {
    print('-------------------fetch jenis local---------------------');

    List<Map<String, Object?>> query = await DBHelper().FETCH(
        'SELECT * FROM produK_jenis_local WHERE id_toko = $id_toko AND aktif = "Y" ORDER BY ID DESC');
    List<DataJenis> jenis = query.isNotEmpty
        ? query.map((e) => DataJenis.fromJson(e)).toList()
        : [];
    jenislistlocal.value = jenis;
    print(jenislistlocal.map((element) => element.namaJenis));

    return jenis;
  }

  var data = Get.arguments;

  String? jenisvalue;

  var jenisstok = [
    {'id': 1, 'nama': 'Stock'},
    {
      'id': 2,
      'nama': 'Non stock',
    }
  ].obs;
  var jj = ''.obs;
  String? jenisstokval;

  var desc = TextEditingController().obs;
  var nama_produk = TextEditingController().obs;
  var harga = TextEditingController().obs;
  var diskon_barang = TextEditingController().obs;
  var nama_jenis = TextEditingController().obs;

  var qty = TextEditingController().obs;
  var displaydiskon = 0.0.obs;

  var image;

  var sort = false.obs;
  var ColIndex = 0.obs;

  clear() {
    desc.value.clear();
    nama_produk.value.clear();
    harga.value.clear();
    nama_jenis.value.clear();
    jenisvalue = null;
    jenisstokval = null;
    diskon_barang.value.clear();
    jumlahharga.value = 0;
    jumlahdiskon.value = 0.0;
    check.value = false;
    checkbarcode.value = false;
    checkfoto.value = false;
    qty.value.clear();
    barcode.value.clear();
    pikedImagePath.value = '';
    hargamodal.value.clear();
    jumlahhargamodal.value = 0;
    jj.value = '';
  }

  var jumlahhargamodal = 0.obs;
  var hargamodal = TextEditingController().obs;

  ProdukTambah() async {
    print('-------------------tambah Produk---------------------');

    Get.dialog(const showloading(), barrierDismissible: false);
    var checkconn = await check_conn.check();
    if (checkconn == true) {
      var produk = await REST.produkTambah(
          token: token,
          idtoko: id_toko,
          iduser: id_user,
          idjenis: jenisvalue,
          idjenisstock: jenisstokval.toString(),
          namaproduk: nama_produk.value.text,
          desc: desc.value.text,
          qty: qty.value.text,
          harga: jumlahharga.value.toString(),
          harga_modal: jumlahhargamodal.value.toString(),
          diskon_barang: jumlahdiskon.value.toString(),
          barcode: barcode.value.text.toString(),
          image: pickedImageFile);

      if (produk != null) {
        print(produk['message']);
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

  var diskonpropervalue = 0.0.obs;

  caridiskonproper() {
    var x =
        diskonpropervalue.value = jumlahharga.value * jumlahdiskon.value / 100;
    print(x);
  }

  //TODO : chek hasil diskon barang proper di local db,coba di carik pas masukin ke detail penjulaan bukan di tbl produk

  ProdukTambahlocal() async {
    print('-------------------tambah Produk local---------------------');

    Get.dialog(const showloading(), barrierDismissible: false);

    var query = await DBHelper().INSERT(
        'produk_local',
        DataProduk(
                idKategori: 1,
                idToko: int.parse(id_toko),
                idUser: id_user,
                idJenis: int.parse(jenisvalue!),
                idJenisStock: int.parse(jenisstokval!),
                namaProduk: nama_produk.value.text,
                deskripsi: desc.value.text,
                qty: jenisstokval == '1' ? int.parse(qty.value.text) : 0,
                harga: int.parse(jumlahharga.value.toString()),
                hargaModal: int.parse(jumlahhargamodal.value.toString()),
                diskonBarang: int.parse(jumlahdiskon.value.toInt().toString()),
                barcode: barcode.value.text.isEmpty
                    ? barcode.value.text = '-'
                    : barcode.value.text,
                image: image64 ?? null,
                //  createdAt: DateTime.now().toString(),
                status: 1,
                sync: 'N',
                namaJenis: jenislistlocal
                    .where((e) => e.id == int.parse(jenisvalue!))
                    .first
                    .namaJenis
                    .toString())
            .toMapForDb());

    if (query != null) {
      print(query);
      print('id user------------>');
      print(id_user);
      await fetchProduklocal(id_toko);
      await Get.find<kasirController>().fetchProduklocal(id_toko);
      await Get.find<dashboardController>().loadproduktotal();
      await clear();
      Get.back(closeOverlays: true);
      Get.showSnackbar(toast()
          .bottom_snackbar_success('Sukses', 'Produk berhasil ditambah'));
    } else {
      Get.back(closeOverlays: true);
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

  initProdukToLocal(id_toko) async {
    //login -> sync -> init

    List<DataProduk> produk_local = await fetchProduk();
    List<DataJenis> produk_local_jenis = await fetchjenis();

    print('-------------------init Produk local---------------------');

    //Get.dialog(showloading(), barrierDismissible: false);
    await Future.forEach(produk_local, (e) async {
      await DBHelper().INSERT(
          'produk_local',
          DataProduk(
                  id: e.id,
                  idKategori: e.idKategori,
                  idToko: e.idToko,
                  idUser: e.idUser,
                  idJenis: e.idJenis,
                  idJenisStock: e.idJenisStock,
                  namaProduk: e.namaProduk,
                  deskripsi: e.deskripsi,
                  qty: e.qty,
                  harga: e.harga,
                  hargaModal: e.hargaModal,
                  diskonBarang: e.diskonBarang,
                  barcode: e.barcode,
                  image: e.image,
                  //  createdAt: DateTime.now().toString(),
                  status: e.status,
                  sync: 'Y',
                  namaJenis: e.namaJenis)
              .toMapForDb());
    });

    await Future.forEach(produk_local_jenis, (e) async {
      await DBHelper().INSERT(
          'produk_jenis_local',
          DataJenis(
                  aktif: 'Y',
                  id: e.id,
                  idToko: e.idToko,
                  sync: 'Y',
                  namaJenis: e.namaJenis)
              .toMapForDb());
    });

    // if (up != null) {
    //  print(up.toString());
    print('init success---------------------------------------------------->');
    await fetchProduklocal(id_toko);
    await fetchjenislocal(id_toko);
    // Get.back(closeOverlays: true);
    //Get.showSnackbar(toast()
    //  .bottom_snackbar_success('Sukses', 'Produk berhasil ditambah'));
    // } else {
    //   // Get.back(closeOverlays: true);
    //   Get.showSnackbar(
    //       toast().bottom_snackbar_error('error', 'gagal tambah data local'));
    // }

    // if (add == 1) {
    //
    // } else {
    //   Get.back(closeOverlays: true);
    //   Get.showSnackbar(
    //       toast().bottom_snackbar_error('error', 'gagal tambah data local'));
    // }
  }

  syncProduk(id_toko) async {
    print('-----------------SYNC PRODUK LOCAL TO HOST-------------------');

    //Get.dialog(showloading(), barrierDismissible: false);
    var checkconn = await check_conn.check();
    if (checkconn == true) {
      List<DataProduk> produk = await fetchProduksync(id_toko);
      //  produklistlocal.refresh();
      print('start up DB SYNC PRODUK--------------------------------------->');
      var query = produk.where((x) => x.sync == 'N').toList();
      if (query.isEmpty) {
        print(query.toString() +
            '----------------------------------------------->');
        print(' all data sync -------------------------------->');
        // Get.showSnackbar(
        //     toast().bottom_snackbar_success('Sukses', 'semua produk sync'));
      } else {
        await Future.forEach(query, (e) async {
          await REST.produkLocalToDb(
            token: token,
            image: e.image,
            id: e.id,
            barcode: e.barcode,
            harga: e.harga,
            diskon_barang: e.diskonBarang,
            deskripsi: e.deskripsi,
            harga_modal: e.hargaModal,
            id_jenis: e.idJenis,
            id_jenis_stock: e.idJenisStock,
            id_kategori: e.idKategori,
            id_toko: e.idToko,
            id_user: e.idUser,
            nama_produk: e.namaProduk,
            qty: e.qty,
            status: e.status,

            //  updated_at: e.updatedAt,
            //    image: e.image
          );
          print("PRODUK UP ------>    " +
              e.namaProduk +
              "------------------------------------------>");

          await DBHelper()
              .UPDATE(table: 'produk_local', data: synclocal('Y'), id: e.id);

          //
          // produklistlocal.refresh();
          // var q = produklistlocal.value.where((z) => z.id == e.id).toList();
          // q.forEach((lll) {
          //   print('updated : sync = ' +
          //       lll.namaProduk +
          //       ' : ' +
          //       lll.sync! +
          //       '-------------------------------------------->');
          // });

          //seperate update method needed
        });

        // Get.showSnackbar(
        //     toast().bottom_snackbar_success('Sukses', 'Produk  up DB'));
      }

      //Get.back(closeOverlays: true);

      // return [];
    } else {
      Get.back(closeOverlays: true);
      Get.showSnackbar(
          toast().bottom_snackbar_error('Error', 'Periksa Koneksi Internet'));
    }
  }

  syncProdukJenis(id_toko) async {
    print(
        '-----------------SYNC PRODUK JENIS LOCAL TO HOST-------------------');

    //Get.dialog(showloading(), barrierDismissible: false);
    var checkconn = await check_conn.check();
    if (checkconn == true) {
      List<DataJenis> produkjenis = await fetchjenissync(id_toko);
      //jenislistlocal.refresh();
      print(
          'start up DB SYNC PRODUK JENIS--------------------------------------->');
      var query = produkjenis.where((x) => x.sync == 'N').toList();
      if (query.isEmpty) {
        print(query.toString() +
            '----------------------------------------------->');
        print(' all data sync -------------------------------->');
      } else {
        await Future.forEach(query, (e) async {
          await REST.syncProdukJenis(
              token: token,
              id: e.id.toString(),
              aktif: e.aktif,
              idtoko: e.idToko.toString(),
              namajenis: e.namaJenis);
          print("PRODUK JENIS UP ------>    " +
              e.namaJenis! +
              "------------------------------------------>");

          await DBHelper().UPDATE(
              table: 'produk_jenis_local', data: synclocal('Y'), id: e.id);
        });

        // Get.showSnackbar(
        //     toast().bottom_snackbar_success('Sukses', 'Produk  up DB'));
      }

      //Get.back(closeOverlays: true);

      // return [];
    } else {
      Get.back(closeOverlays: true);
      Get.showSnackbar(
          toast().bottom_snackbar_error('Error', 'Periksa Koneksi Internet'));
    }
  }

  syncProdukv2() async {
    print('-----------------   syncProdukv2  ------------------');

    //Get.dialog(showloading(), barrierDismissible: false);
    var checkconn = await check_conn.check();
    if (checkconn == true) {
      print('-------------------fetch Produk local---------------------');
      // succ.value = false;
      List<Map<String, Object?>> fetchproduk = await DBHelper().FETCH(
          'SELECT * FROM produk_local WHERE id_toko = $id_toko ORDER BY ID DESC');
      List<DataProduk> produk = fetchproduk.isNotEmpty
          ? fetchproduk.map((e) => DataProduk.fromJson(e)).toList()
          : [];
      produklistlocal.value = produk;
      print(produk);
      print('start up DB SYNC--------------------------------------->');
      var query =
          await produklistlocal.value.where((x) => x.sync == 'N').toList();
      print('check query----------->');
      print(query);
      if (query.isEmpty) {
        print(query.toString() +
            '----------------------------------------------->');
        print(' all data sync -------------------------------->');
        return true;
        // Get.showSnackbar(
        //     toast().bottom_snackbar_success('Sukses', 'semua produk sync'));
      } else {
        await Future.forEach(query, (e) async {
          await REST.produkLocalToDb(
            token: token,
            id: e.id,
            barcode: e.barcode,
            harga: e.harga,
            diskon_barang: e.diskonBarang,
            //created_at: e.createdAt,
            //deleted_at: null,
            deskripsi: e.deskripsi,
            harga_modal: e.hargaModal,
            id_jenis: e.idJenis,
            id_jenis_stock: e.idJenisStock,
            id_kategori: e.idKategori,
            id_toko: e.idToko,
            id_user: e.idUser,
            nama_produk: e.namaProduk,
            qty: e.qty,
            status: e.status,

            //  updated_at: e.updatedAt,
            //    image: e.image
          );
          print("DB local UP " +
              e.namaProduk +
              "------------------------------------------>");

          await DBHelper()
              .UPDATE(table: 'produk_local', data: synclocal('Y'), id: e.id);

          //
          // produklistlocal.refresh();
          // var q = produklistlocal.value.where((z) => z.id == e.id).toList();
          // q.forEach((lll) {
          //   print('updated : sync = ' +
          //       lll.namaProduk +
          //       ' : ' +
          //       lll.sync! +
          //       '-------------------------------------------->');
          // });

          //seperate update method needed
        });

        // Get.showSnackbar(
        //
        //     toast().bottom_snackbar_success('Sukses', 'Produk  up DB'));
        return true;
      }

      //Get.back(closeOverlays: true);

      // return [];
    } else {
      return false;
      // Get.back(closeOverlays: true);
      // Get.showSnackbar(
      //     toast().bottom_snackbar_error('Error', 'Periksa Koneksi Internet'));
    }
  }

  Map<String, dynamic> synclocal(data) {
    var map = <String, dynamic>{};

    map['sync'] = data;

    return map;
  }

  ProdukTambahlocalv2() async {
    print('-------------------tambah Produk local---------------------');

    Get.dialog(const showloading(), barrierDismissible: false);
    var db = DatabaseHelper.instance;

    var add = await db.addProdukv2(DataProduk(
      //id: 69,
      idKategori: 1,
      idToko: int.parse(id_toko),
      idUser: id_user,
      idJenis: int.parse(jenisvalue!),
      idJenisStock: int.parse(jenisstokval!),
      namaProduk: nama_produk.value.text,
      deskripsi: desc.value.text,
      qty: jenisstokval == '1' ? int.parse(qty.value.text) : 0,
      harga: int.parse(jumlahharga.value.toString()),
      hargaModal: int.parse(jumlahhargamodal.value.toString()),
      diskonBarang: int.parse(jumlahdiskon.value.toInt().toString()),
      barcode: barcode.value.text.toString(),
    ));
    print(add);
    await fetchProduklocalv2();
    Get.back(closeOverlays: true);
    // if (add == 1) {
    //
    // } else {
    //   Get.back(closeOverlays: true);
    //   Get.showSnackbar(
    //       toast().bottom_snackbar_error('error', 'gagal tambah data local'));
    // }
  }

  deleteproduk(String id) async {
    Get.dialog(const showloading(), barrierDismissible: false);
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

  deleteproduklocal(int id) async {
    print('delete produk local---------------------------------------->');
    Get.dialog(const showloading(), barrierDismissible: false);
    var select = produklistlocal.where((x) => x.id == id).first;
    var delete = await DBHelper().UPDATE(
      id: select.id,
      table: 'produk_local',
      data: DataProduk(
              id: select.id,
              status: 3,
              idKategori: select.idKategori,
              idJenisStock: select.idJenisStock,
              idToko: select.idToko,
              idJenis: select.idJenis,
              idUser: select.idUser,
              qty: select.qty,
              deskripsi: select.deskripsi,
              diskonBarang: select.diskonBarang,
              harga: select.harga,
              hargaModal: select.hargaModal,
              namaProduk: select.namaProduk,
              barcode: select.barcode,
              image: select.image,
              sync: 'N')
          .toMapForDb(),
    );

    // var query = await DBHelper().DELETE('produk_local', id);
    if (delete == 1) {
      await fetchProduklocal(id_toko);
      await Get.find<kasirController>().fetchProduklocal(id_toko);
      await Get.find<dashboardController>().loadproduktotal();
      Get.back(closeOverlays: true);
      Get.showSnackbar(
          toast().bottom_snackbar_success('Sukses', 'Produk berhasil dihapus'));
      print('deleted ' + id.toString());
    } else {
      Get.back(closeOverlays: true);
      Get.showSnackbar(
          toast().bottom_snackbar_error('Error', 'gagal menghapus produk'));
    }
  }

  clearjenis() {
    nama_jenis.value.clear();
  }

  jenisTambahlocal() async {
    print('-------------------tambah jenis local---------------------');

    Get.dialog(const showloading(), barrierDismissible: false);

    var query = await DBHelper().INSERT(
        'produk_jenis_local',
        DataJenis(
                aktif: 'Y',
                sync: 'N',
                idToko: id_toko,
                namaJenis: nama_jenis.value.text)
            .toMapForDb());

    if (query != null) {
      print(query);
      print('id user------------>');
      print(id_user);
      jenisvalue = query.toString();
      await fetchjenislocal(id_toko);

      // await fetchProduklocal(id_toko);
      //  jenislistlocal.refresh();
      await Get.find<kasirController>().fetchjenislocal(id_toko);
      await clearjenis();
      Get.back();
      Get.back();
      Get.showSnackbar(toast()
          .bottom_snackbar_success('Sukses', 'jenis produk berhasil ditambah'));
    } else {
      Get.back(closeOverlays: true);
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

  jenisTambah() async {
    print('-------------------tambah jenis---------------------');

    Get.dialog(const showloading(), barrierDismissible: false);
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

    Get.dialog(const showloading(), barrierDismissible: false);
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

  deletejenislocal(int id) async {
    print('delete produk local---------------------------------------->');
    Get.dialog(const showloading(), barrierDismissible: false);
    var select = jenislistlocal.where((x) => x.id == id).first;
    var delete = await DBHelper().UPDATE(
      id: select.id,
      table: 'produk_jenis_local',
      data: DataJenis(
              aktif: 'N',
              sync: 'N',
              namaJenis: select.namaJenis,
              idToko: select.idToko,
              id: select.id)
          .toMapForDb(),
    );

    // var query = await DBHelper().DELETE('produk_local', id);
    if (delete == 1) {
      await fetchjenislocal(id_toko);
      await Get.find<kasirController>().fetchjenislocal(id_toko);
      Get.back(closeOverlays: true);
      Get.showSnackbar(
          toast().bottom_snackbar_success('Sukses', 'Berhasil dihapus'));
      print('deleted ' + id.toString());
    } else {
      Get.back(closeOverlays: true);
      Get.showSnackbar(
          toast().bottom_snackbar_error('Error', 'gagal menghapus produk'));
    }
  }

  deletejenis(String id) async {
    Get.dialog(
      const showloading(),
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

    Get.dialog(const showloading(), barrierDismissible: false);
    var checkconn = await check_conn.check();
    if (checkconn == true) {
      var qty =
          await REST.produkqtytambah(token, id, id_toko, qtyadd.value.text);
      if (qty != null) {
        print(qty);
        var sum = stock + int.parse(qtyadd.value.text);
        qty = sum.toString();
        qtyadd.value.clear();

        await DBHelper()
            .UPDATE(table: 'produk_local', data: synclocal('N'), id: id);

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

  Map<String, dynamic> qtylocal(data) {
    var map = <String, dynamic>{};

    map['qty'] = data;
    map['sync'] = 'N';

    return map;
  }

  //TODO : background task WORKMANAGER sync produk

  editqtylocal(int id) async {
    print('-------------------tambah qty local---------------------');

    Get.dialog(const showloading(), barrierDismissible: false);

    await fetchProduklocal(id_toko);
    var query = produklistlocal.where((e) => e.id == id).first;
    print(query.namaProduk);
    var sum = query.qty! + int.parse(qtyadd.value.text);

    var updateqty = await DBHelper().UPDATE(
      table: 'produk_local',
      data: qtylocal(sum),
      id: id,
    );
    print(updateqty);

    if (updateqty == 1) {
      print('----------------- QTY local----------------->');
      await fetchProduklocal(id_toko);
      await Get.find<kasirController>().fetchProduklocal(id_toko);
      Get.back(closeOverlays: true);
      Get.showSnackbar(toast()
          .bottom_snackbar_success('Berhasil', 'Stock berhasil ditambah'));
    } else {
      Get.back(closeOverlays: true);
      Get.showSnackbar(
          toast().bottom_snackbar_error('Error', 'Stock gagal ditambah'));
    }
  }

  addqty(produkController controller, DataProduk arg) {
    Get.dialog(AlertDialog(
      title: header(
          title: 'Tambah Stock',
          icon: Icons.add,
          icon_color: color_template().primary,
          base_color: color_template().primary),
      contentPadding: const EdgeInsets.all(10),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(12.0),
        ),
      ),
      content: Builder(
        builder: (context) {
          return SingleChildScrollView(
            child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                width: context.width_query / 2.6,
                height: context.height_query / 2.6,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    const Text('Masukan jumlah yang akan di tambah'),
                    const SizedBox(
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
                          editqtylocal(arg.id!);
                        },
                        child: Text(
                          'Tambah Stock',
                          style: font().primary_white,
                        ),
                        width: context.width_query,
                        height: context.height_query / 11),
                    const SizedBox(
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
      contentPadding: const EdgeInsets.all(10),
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
