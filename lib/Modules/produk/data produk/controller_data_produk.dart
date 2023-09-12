import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
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

  var metode_diskon = 9.obs;

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
        'SELECT * FROM produk_local WHERE id_toko = $id_toko AND status = 1 AND nama_produk LIKE "%${search.value.text}%" ORDER BY ID DESC');
    List<DataProduk> produk = query.isNotEmpty
        ? query.map((e) => DataProduk.fromJson(e)).toList()
        : [];
    produklistlocal.value = produk;
    // print('fect produk local --->' + produk.toList().toString());

    return produk;
  }

  searchjenislocal() async {
    List<Map<String, Object?>> query = await DBHelper().FETCH(
        'SELECT * FROM produk_jenis_local WHERE id_toko = $id_toko AND aktif = "Y" AND nama_jenis LIKE "%${searchjenis.value.text}%" ORDER BY ID DESC');
    List<DataJenis> jenis = query.isNotEmpty
        ? query.map((e) => DataJenis.fromJson(e)).toList()
        : [];
    jenislistlocal.value = jenis;

    return jenis;
  }

  fetchProduk() async {
    print('-------------------fetchProduk---------------------');
    //succ.value = false;

    var produk = await REST.produkAllv2(token, id_toko);
    if (produk != null) {
      print('-------------------dataproduk---------------');

      var dataProduk = ModelProduk.fromJson(produk);

      produklist.value = dataProduk.data;

      print('--------------------list produk---------------');
      print(produklist);

      return produklist;
    } else {
      Get.back(closeOverlays: true);
      Get.showSnackbar(
          toast().bottom_snackbar_error('Error', 'Produk gagal ditampilkan'));
      return Future.error('fetch produk gagal');
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

  fetchProduklocalreversal(id_toko) async {
    print('-------------------fetch Produk local---------------------');
    succ.value = false;
    List<Map<String, Object?>> query = await DBHelper().FETCH(
        'SELECT * FROM produk_local WHERE id_toko = $id_toko ORDER BY ID DESC');
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
    print('-------------------fetch Jenis---------------------');

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
      Get.showSnackbar(toast()
          .bottom_snackbar_error('Error', 'Terjadi kesalahan mohon coba lagi'));
    }

    //return [];
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
    succ.value = false;
    List<Map<String, Object?>> query = await DBHelper().FETCH(
        'SELECT * FROM produK_jenis_local WHERE id_toko = $id_toko AND aktif = "Y" ORDER BY ID DESC');
    List<DataJenis> jenis = query.isNotEmpty
        ? query.map((e) => DataJenis.fromJson(e)).toList()
        : [];
    jenislistlocal.value = jenis;
    print(jenislistlocal.map((element) => element.namaJenis));
    succ.value = true;
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

  var aksi = <Widget>[
    GestureDetector(
      onTap: () {},
      child: Row(
        children: [
          Icon(Icons.edit, color: color_template().primary_dark, size: 22),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Text(
              'Edit produk',
              style: font().reguler,
            ),
          )
        ],
      ),
    )
  ].obs;

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

  checkidproduk(token) async {
    var checkconn = await check_conn.check();
    if (checkconn == true) {
      var data = await REST.checkIdProduk(token: token);
      if (data == 0) {
        await GetStorage().write('id_produk', 0);
        return 0;
      } else {
        print(
            'check produk id------------------------------------------------->');
        print(data['id']);
        await GetStorage().write('id_produk', data['id']);
        return [data['id']];
      }
    } else {
      Get.back(closeOverlays: true);
      Get.showSnackbar(
          toast().bottom_snackbar_error('Error', 'Periksa Koneksi Internet'));
    }
  }

  ProdukTambahlocal() async {
    print('-------------------tambah Produk local---------------------');

    Get.dialog(const showloading(), barrierDismissible: false);

    var query = await DBHelper().INSERT(
        'produk_local',
        DataProduk(
                idLocal: nama_produk.value.text + stringGenerator(10),
                idKategori: 1,
                idToko: int.parse(id_toko),
                idUser: id_user,
                idJenis: jenisvalue!,
                idJenisStock: int.parse(jenisstokval!),
                namaProduk: nama_produk.value.text,
                deskripsi: desc.value.text,
                qty: jenisstokval == '1' ? int.parse(qty.value.text) : 0,
                harga: int.parse(jumlahharga.value.toString()),
                hargaModal: int.parse(jumlahhargamodal.value.toString()),
                diskonBarang: metode_diskon.value == 1
                    ? int.parse(jumlahdiskon.value.toInt().toString())
                    : (jumlahdiskon.value.round() / jumlahharga.value * 100)
                        .toInt(),
                barcode: barcode.value.text.isEmpty
                    ? barcode.value.text = '-'
                    : barcode.value.text,
                image: image64 ?? null,
                //  createdAt: DateTime.now().toString(),
                status: 1,
                sync: 'N',
                namaJenis: jenislistlocal
                    .where((e) => e.idLocal == jenisvalue!)
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
  }

  checkup() async {
    List<DataProduk> produk_local = await fetchProduk();

    List<DataProduk> check_produk_local = await fetchProduksync(id_toko);
    List<DataProduk> check = produk_local
        .where((element) =>
            element.status != check_produk_local.map((e) => e.status))
        .toList();
    print(
        'check---------------------------------------------------------------');
    print(produk_local.map((e) => e.status));
    print(check_produk_local.map((e) => e.status));
    print(check.map((e) => e.namaProduk));
    // Future.forEach(produk_local, (element) {
    //   DataProduk xxx =
    //       check_produk_local.where((e) => e.status != element.status).first;
    //   print(xxx.namaProduk);
    // });

    // Future.forEach(produk_local, (e) async {
    //   xxx = produk_local.where((element) => element.status == 3).first;
    //   print(xxx);
    // });
  }

  Map<String, dynamic> datainit(
      {idLocal,
      idUser,
      barcode,
      idToko,
      idJenis,
      idKategori,
      idJenisStock,
      namaProduk,
      deskripsi,
      qty,
      harga,
      hargaModal,
      diskonBarang,
      image,
      status,
      namaJenis}) {
    var map = <String, dynamic>{};

    map['id_local'] = idLocal;
    map['id_user'] = idUser;
    map['barcode'] = barcode ?? '-';
    map['id_toko'] = idToko;
    map['id_jenis'] = idJenis;
    map['id_kategori'] = idKategori;
    map['id_jenis_stock'] = idJenisStock;
    map['nama_produk'] = namaProduk;
    map['deskripsi'] = deskripsi;
    map['qty'] = qty;
    map['harga'] = harga;
    map['harga_modal'] = hargaModal;
    map['diskon_barang'] = diskonBarang;
    map['image'] = image ?? '-';
    map['status'] = status;
    map['sync'] = 'Y';
    map['nama_jenis'] = namaJenis ?? '-';
    // map['created_at'] = createdAt;
    //map['updated_at'] = updatedAt;

    return map;
  }

  initProdukToLocal(id_toko) async {
    List<DataProduk> produk_local = await fetchProduk();
    List<DataJenis> produk_local_jenis = await fetchjenis();
    List<DataProduk> check_produk_local = await fetchProduksync(id_toko);
    List<DataJenis> check_jenis_local = await fetchjenissync(id_toko);

    await Future.forEach(produk_local_jenis, (ex) async {
      var x = check_jenis_local
          .where((element) => element.idLocal == ex.idLocal)
          .firstOrNull;
      if (x == null) {
        print('insert--------------------------------->' + ex.namaJenis!);
        await DBHelper().INSERT(
            'produk_jenis_local',
            DataJenis(
                    id: ex.id,
                    aktif: ex.aktif,
                    idLocal: ex.idLocal,
                    idToko: ex.idToko,
                    sync: 'Y',
                    namaJenis: ex.namaJenis)
                .toMapForDb());
      } else {
        print('update--------------------------------->' + ex.namaJenis!);
        DBHelper().UPDATE(
            table: 'produk_jenis_local',
            data: DataJenis(
                    aktif: ex.aktif,
                    idLocal: ex.idLocal,
                    idToko: ex.idToko,
                    sync: 'Y',
                    namaJenis: ex.namaJenis)
                .updateInit(),
            id: ex.idLocal);
      }
    });

    print('-------------------init Produk local---------------------');
    await Future.forEach(produk_local, (e) async {
      var x = check_produk_local
          .where((element) => element.idLocal == e.idLocal)
          .firstOrNull;
      if (x == null) {
        print(x);
        print('insert--------------------------------------------->' +
            e.namaProduk);
        await DBHelper().INSERT(
            'produk_local',
            DataProduk(
                    idLocal: e.idLocal,
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
      } else {
        print('update--------------------------------------------->' +
            e.namaProduk);
        await DBHelper().UPDATE(
            table: 'produk_local',
            data: DataProduk(
                    idLocal: e.idLocal,
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
                .updateInit(),
            id: e.idLocal);
      }
    });

    // if (up != null) {
    //  print(up.toString());
    print(
        'init produk success---------------------------------------------------->');
    await fetchProduklocal(id_toko);
    await fetchjenislocal(id_toko);
    //await Get.find<kasirController>().fetchProduklocal(id_toko);
    // await Get.find<kasirController>().fetchjenislocal(id_toko);
    // await Get.put(kasirController().fetchProduklocal(id_toko));
    // await Get.put(kasirController().fetchjenislocal(id_toko));
  }

  // String idGenerator() {
  //   final now = DateTime.now();
  //   var generator = now.microsecondsSinceEpoch.toString();
  //   print(generator);
  //   return generator;
  // }

  String stringGenerator(int len) {
    var random = Random.secure();
    var values = List<int>.generate(len, (i) => random.nextInt(255));

    var uniqueId = base64UrlEncode(values);
    print(uniqueId);
    return uniqueId;
  }

  var qrcode = ''.obs;
  String scaned_qr_code = '';

  Future<void> scan() async {
    try {
      scaned_qr_code = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'cancel', true, ScanMode.BARCODE);
      barcode.value.text = scaned_qr_code;
    } on PlatformException catch (e) {
      print(e);
      Get.back();
      Get.showSnackbar(toast().bottom_snackbar_error('Error', e.toString()));
    }
  }

  syncProduk(id_toko) async {
    print('-----------------SYNC PRODUK LOCAL TO HOST-------------------');

    List<DataProduk> produk = await fetchProduksync(id_toko);
    //  produklistlocal.refresh();
    print('start up DB SYNC PRODUK--------------------------------------->');
    var query = produk.where((x) => x.sync == 'N').toList();
    if (query.isEmpty) {
      print(query.toString() +
          '----------------------------------------------->');
      print(' all data sync -------------------------------->');
    } else {
      await Future.forEach(query, (e) async {
        var up = await REST.syncproduk(
          token: token,
          image: e.image,
          id: e.idLocal,
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
        );
        if (up != null) {
          print("PRODUK UP ------>    " +
              e.namaProduk +
              "------------------------------------------>");
          await DBHelper().UPDATE(
              table: 'produk_local', data: synclocal('Y'), id: e.idLocal);
        }
      });
    }
  }

  syncProdukJenis(id_toko) async {
    print(
        '-----------------SYNC PRODUK JENIS LOCAL TO HOST-------------------');

    //Get.dialog(showloading(), barrierDismissible: false);
    //var checkconn = await check_conn.check();

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
        var up = await REST.syncProdukJenis(
            token: token,
            id: e.idLocal,
            aktif: e.aktif,
            idtoko: e.idToko.toString(),
            namajenis: e.namaJenis);

        if (up != null) {
          print("PRODUK JENIS UP ------>    " +
              e.namaJenis! +
              "------------------------------------------>");
          await DBHelper().UPDATE(
              table: 'produk_jenis_local', data: synclocal('Y'), id: e.idLocal);
        }
      });

      // Get.showSnackbar(
      //     toast().bottom_snackbar_success('Sukses', 'Produk  up DB'));
    }

    //Get.back(closeOverlays: true);

    // return [];
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
          await REST.syncproduk(
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

  deleteproduklocal(String id_local) async {
    print('delete produk local---------------------------------------->');
    Get.dialog(const showloading(), barrierDismissible: false);
    var select = produklistlocal.where((x) => x.idLocal == id_local).first;
    var delete = await DBHelper().UPDATE(
      id: select.idLocal,
      table: 'produk_local',
      data: DataProduk(
              id: select.id,
              idLocal: select.idLocal,
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
      print('deleted ' + id_local.toString());
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
                idLocal: nama_jenis.value.text + stringGenerator(10),
                sync: 'N',
                idToko: id_toko,
                namaJenis: nama_jenis.value.text)
            .toMapForDb());

    if (query != null) {
      print(query);
      print('id user------------>');
      print(id_user);

      List<DataJenis> jenis = await fetchjenislocal(id_toko);
      var select = jenis.where((element) => element.id == query).first;
      jenisvalue = select.idLocal.toString();
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

  deletejenislocal(String id_local) async {
    print('delete produk local---------------------------------------->');
    Get.dialog(const showloading(), barrierDismissible: false);
    var select = jenislistlocal.where((x) => x.idLocal == id_local).first;
    var delete = await DBHelper().UPDATE(
      id: select.idLocal,
      table: 'produk_jenis_local',
      data: DataJenis(
              aktif: 'N',
              sync: 'N',
              namaJenis: select.namaJenis,
              idToko: select.idToko,
              id: select.id,
              idLocal: select.idLocal)
          .toMapForDb(),
    );

    // var query = await DBHelper().DELETE('produk_local', id);
    if (delete == 1) {
      await fetchjenislocal(id_toko);
      await Get.find<kasirController>().fetchjenislocal(id_toko);
      Get.back(closeOverlays: true);
      Get.showSnackbar(
          toast().bottom_snackbar_success('Sukses', 'Berhasil dihapus'));
      print('deleted ' + id_local.toString());
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

  editqtylocal(String id_local) async {
    print('-------------------tambah qty local---------------------');

    Get.dialog(const showloading(), barrierDismissible: false);

    await fetchProduklocal(id_toko);
    var query = produklistlocal.where((e) => e.idLocal == id_local).first;
    print(query.namaProduk);
    var sum = query.qty! + int.parse(qtyadd.value.text);

    var updateqty = await DBHelper().UPDATE(
      table: 'produk_local',
      data: qtylocal(sum),
      id: id_local,
    );
    print(updateqty);

    if (updateqty == 1) {
      print('----------------- QTY local----------------->');
      await fetchProduklocal(id_toko);
      await Get.find<kasirController>().fetchProduklocal(id_toko);
      qtyadd.value.clear();
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
                    Text(
                      'Masukan jumlah stock',
                      style: font().header_black,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                hintText: 'Stock',
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
                    const SizedBox(
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
                                editqtylocal(arg.idLocal);
                              },
                              child: Text(
                                'Tambah Stock',
                                style: font().primary_white,
                              ),
                              width: context.width_query,
                              height: context.height_query / 11),
                        ),
                      ],
                    )
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
          base_color: Colors.white),
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
