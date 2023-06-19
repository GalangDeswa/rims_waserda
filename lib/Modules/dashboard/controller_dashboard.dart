import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:rims_waserda/Modules/beban/data%20beban/model_data_beban.dart';
import 'package:rims_waserda/Modules/history/Controller_history.dart';
import 'package:rims_waserda/Modules/history/model_penjualan.dart';
import 'package:rims_waserda/Modules/pelanggan/data%20pelanggan/controller_data_pelanggan.dart';
import 'package:rims_waserda/Modules/pelanggan/data%20pelanggan/model_data_pelanggan.dart';
import 'package:rims_waserda/Modules/pelanggan/hutang/controller_hutang.dart';
import 'package:rims_waserda/Modules/pelanggan/hutang/model_hutang.dart';
import 'package:rims_waserda/Modules/produk/data%20produk/model_produk.dart';

import '../beban/data beban/controller_beban.dart';
import '../produk/data produk/controller_data_produk.dart';

class dashboardController extends GetxController {
  @override
  Future<void> onInit() async {
    // TODO: implement onInit
    super.onInit();
    print(
        '-------------------------------DASHBOARD CONTROLLER INIT--------------------------->');
    await initstorage();
    await loadproduktotal();
    await loadpelanggantotal();
    await loadpendapatantotal();
    await loadtransaksitotal();
    await loadhutangtotal();

    await loadpendapatanhariini();
    await loadbebanhariini();
    await loadtransaksihariini();

    print('konten list------------------------------------------->');
    print(kontenlists.toString());
    // print(GetStorage().read('konten_banner'));

    print(id_toko);

    //loadkonten();
    //loadkontenv2();
    //loadToko();
  }

  initstorage() async {
    nama.value = await GetStorage().read('name');
    email.value = await GetStorage().read('email');
    id_toko.value = await GetStorage().read('id_toko');
    token.value = await GetStorage().read('token');
    nama_toko.value = await GetStorage().read('nama_toko');
    alamat_toko.value = await GetStorage().read('alamat_toko');
    jenis_toko.value = await GetStorage().read('jenis_toko');
    email_toko.value = await GetStorage().read('email_toko');
    pendapatan.value = await GetStorage().read('pendapatan');
    beban.value = await GetStorage().read('beban');
    logo.value = await GetStorage().read('logo_toko');
    kontenlists.value = await GetStorage().read('konten_banner');
  }

  var nama = ''.obs;
  var email = ''.obs;
  var id_toko = ''.obs;
  var token = ''.obs;

  var nama_toko = ''.obs;
  var alamat_toko = ''.obs;
  var jenis_toko = ''.obs;
  var email_toko = ''.obs;
  var pendapatan = 0.obs;
  var beban = 0.obs;
  var logo = ''.obs;

  var listkonten = [].obs;

  // loadkonten() {
  //   //tanpa logout error
  //   //dengan di ganti jd list biasa bukan list<konten> bisa?
  //   print('---------------------load konten--------------');
  //   listkonten.value = GetStorage().read('konten');
  //   print(listkonten);
  // }

  // loadkontenv2() async {
  //   //Get.dialog(loading(), barrierDismissible: false);
  //   var checkconn = await check_conn.check();
  //   if (checkconn == true) {
  //     var toko = await REST.loadToko(token, id_toko);
  //     if (toko != null) {
  //       var dataKonten = ModelToko.fromJson(toko);
  //       dataKonten.data.forEach((element) {
  //         listkonten.value = element.konten;
  //       });
  //       print('---------------load konten v2-------------');
  //       print(listkonten);
  //     } else {
  //       //Get.back(closeOverlays: true);
  //       Get.snackbar(
  //         "Error",
  //         "Data toko gagal,toko tidak terserdia",
  //         icon: Icon(Icons.error, color: Colors.white),
  //         snackPosition: SnackPosition.BOTTOM,
  //         backgroundColor: Colors.red,
  //         borderRadius: 20,
  //         margin: EdgeInsets.all(15),
  //         colorText: Colors.white,
  //         duration: Duration(seconds: 4),
  //         isDismissible: true,
  //         dismissDirection: DismissDirection.horizontal,
  //         forwardAnimationCurve: Curves.elasticInOut,
  //         reverseAnimationCurve: Curves.easeOut,
  //       );
  //     }
  //   } else {
  //     // Get.back(closeOverlays: true);
  //     Get.snackbar(
  //       "Error",
  //       "Data toko gagal,periksa koneksi",
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

  var kontenlists = [].obs;

  var totalproduk = 0.obs;
  var totalpelanggan = 0.obs;
  var totalpendapatan = 0.obs;
  var totaltransaksi = 0.obs;
  var totalhutang = 0.obs;

  var pendapatanhariini = 0.obs;
  var bebanhariini = 0.obs;
  var transaksihariini = 0.obs;

  final nominal = NumberFormat("#,##0");
  DateFormat dateFormat = DateFormat("dd");

  DateFormat dateFormatdashboard = DateFormat('EEEE, d MMMM  yyyy');

  loadpendapatanhariini() async {
    print('load pendapatan hari ini------------------------------>');
    List<DataPenjualan> p =
        await historyController().fetchPenjualanlocaldashboard(id_toko);
    var filterP = p
        .map((e) => e)
        .toList()
        .where((element) =>
            element.tglPenjualan!.substring(8, 10) ==
            dateFormat.format(DateTime.now()))
        .toList();

    var sumP = filterP
        .map((e) => e.total)
        .fold(0, (previous, current) => previous + current!);

    print('sum penjualan hari ini----------------------------->');
    print(sumP);

    List<DataBeban> b = await bebanController().fetchBebanlocal(id_toko);
    var filterB = b
        .map((e) => e)
        .toList()
        .where((element) =>
            element.tgl!.substring(8, 10) == dateFormat.format(DateTime.now()))
        .toList();

    var sumB = filterB
        .map((e) => e.jumlah)
        .fold(0, (previous, current) => previous + current!);

    print('sum beban hari ini----------------------------->');
    print(sumB);

    // dateFormat.format(DateTime.parse(element!)

    return pendapatanhariini.value = sumP - sumB;
  }

  loadbebanhariini() async {
    print('load beban hari ini------------------------------>');

    List<DataBeban> b = await bebanController().fetchBebanlocal(id_toko);
    var filterB = b
        .map((e) => e)
        .toList()
        .where((element) =>
            element.tgl!.substring(8, 10) == dateFormat.format(DateTime.now()))
        .toList();

    var sumB = filterB
        .map((e) => e.jumlah)
        .fold(0, (previous, current) => previous + current!);

    // dateFormat.format(DateTime.parse(element!)

    print(sumB);

    return bebanhariini.value = sumB;
  }

  loadtransaksihariini() async {
    print('load transaksi hari ini------------------------------>');

    List<DataPenjualan> b =
        await historyController().fetchPenjualanlocaldashboard(id_toko);
    var filterB = b
        .map((e) => e)
        .toList()
        .where((element) =>
            element.tglPenjualan!.substring(8, 10) ==
            dateFormat.format(DateTime.now()))
        .toList();

    // var sumB = filterB
    //     .map((e) => e.jumlah)
    //     .fold(0, (previous, current) => previous + current!);

    // dateFormat.format(DateTime.parse(element!)

    return transaksihariini.value = filterB.length;
  }

  loadproduktotal() async {
    print('load total produk------------------------------>');
    List<DataProduk> p = await produkController().fetchProduklocal(id_toko);
    return totalproduk.value = p.length;
  }

  loadpelanggantotal() async {
    print('load total pelanggan------------------------------>');
    List<DataPelanggan> p =
        await pelangganController().fetchDataPelangganlocal(id_toko);
    return totalpelanggan.value = p.length;
  }

  loadpendapatantotal() async {
    print('load total pendapatan------------------------------>');
    List<DataPenjualan> p =
        await historyController().fetchPenjualanlocaldashboard(id_toko);

    var sumP = p
        .map((e) => e.total)
        .fold(0, (previous, current) => previous + current!);

    List<DataBeban> b = await bebanController().fetchBebanlocal(id_toko);

    var sumB = b
        .map((e) => e.jumlah)
        .fold(0, (previous, current) => previous + current!);

    var sumsum = sumP - sumB;

    return totalpendapatan.value = sumsum;
  }

  loadtransaksitotal() async {
    print('load total transaksi------------------------------>');
    List<DataPenjualan> p =
        await historyController().fetchPenjualanlocaldashboard(id_toko);
    return totaltransaksi.value = p.length;
  }

  loadhutangtotal() async {
    print('load total hutang------------------------------>');
    List<DataHutang> p = await hutangController().fetchDataHutanglocal(id_toko);
    var filter = p
        .where((e) => e.status == 2)
        .toList()
        .fold(0, (previousValue, element) => previousValue + element.hutang!);

    return totalhutang.value = filter;
  }
}
