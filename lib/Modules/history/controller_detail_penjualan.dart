import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';

import '../../Services/handler.dart';
import '../../db_helper.dart';
import '../Widgets/toast.dart';
import 'model_detail_penjualan.dart';
import 'model_detail_penjualan_v2.dart';

class detailpenjualanController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchPenjualanDetaillocal(id_toko);
    detailPenjualanById(data.id, id_toko);
  }

  var data = Get.arguments;
  var detail_list = <DataDetailPenjualan>[].obs;
  var detail_list_all = <DataPenjualanDetailV2>[].obs;
  var id_user = GetStorage().read('id_user');
  var token = GetStorage().read('token');
  var id_toko = GetStorage().read('id_toko');
  var isi = <DetailItem>[].obs;
  var isilocal = <DataPenjualanDetailV2>[].obs;
  var det = <String>[];

  final nominal = NumberFormat("#,##0");

  Map<String, dynamic> synclocal(data) {
    var map = <String, dynamic>{};

    map['sync'] = data;

    return map;
  }

  syncPenjualanDetail(id_toko) async {
    print(
        '-----------------SYNC PENJUALAN DETAIL LOCAL TO HOST-------------------');

    //Get.dialog(showloading(), barrierDismissible: false);
    var checkconn = await check_conn.check();
    if (checkconn == true) {
      List<DataPenjualanDetailV2> penjualandetail =
          await fetchPenjualanDetailsync(id_toko);
      // penjualan_list_detail_local.refresh();
      print(
          'start up DB SYNC PENJUALAN DETAIL--------------------------------------->');
      var query = penjualandetail.where((x) => x.sync == 'N').toList();
      if (query.isEmpty) {
        print(query.toString() +
            '----------------------------------------------->');
        print(' all data sync -------------------------------->');
      } else {
        await Future.forEach(query, (e) async {
          await REST.syncpenjualandetail(
              token: token,
              iduser: e.idUser,
              idtoko: id_toko.toString(),
              aktif: e.aktif,
              total: e.total,
              id: e.id,
              qty: e.qty,
              tgl: e.tgl,
              id_kategori: e.idKategori,
              id_jenis_stock: e.idJenisStock,
              harga_modal: e.hargaModal,
              diskon_brg: e.diskonBrg,
              diskon_kasir: e.diskonKasir,
              harga_brg: e.hargaBrg,
              id_penjualan: e.idPenjualan,
              id_produk: e.idProduk,
              nama_brg: e.namaBrg);
          print("PENJUALAN DETAIL UP ---->   " +
              e.idPenjualan.toString() +
              e.namaBrg! +
              "------------------------------------------>");

          await DBHelper().UPDATE(
              table: 'penjualan_detail_local', data: synclocal('Y'), id: e.id);
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

  initPenjualanDetailToLocal(id_toko) async {
    List<DataPenjualanDetailV2> penjualan_detail_local =
        await penjualanDetailALl();

    //List<DataDetailPenjualan> beban_detail_local = await fetchJenisBeban();

    print(
        '-------------------init detail penjualan local---------------------');
    //Get.dialog(showloading(), barrierDismissible: false);
    await Future.forEach(penjualan_detail_local, (e) async {
      await DBHelper().INSERT(
          'penjualan_detail_local',
          DataPenjualanDetailV2(
                  id: e.id,
                  idUser: e.idUser,
                  diskonKasir: e.diskonKasir,
                  qty: e.qty,
                  total: e.total,
                  diskonBrg: e.diskonBrg,
                  hargaBrg: e.hargaBrg,
                  hargaModal: e.hargaModal,
                  idJenisStock: e.idJenisStock,
                  idKategori: e.idKategori,
                  idPenjualan: e.idPenjualan,
                  idProduk: e.idProduk,
                  namaBrg: e.namaBrg,
                  tgl: e.tgl,
                  sync: 'Y',
                  aktif: e.aktif)
              .toMapForDb());
    });

    // await Future.forEach(beban_kategori_local, (e) async {
    //   await DBHelper().INSERT(
    //       'beban_kategori_local',
    //       DataJenisBeban(id: e.id, idToko: e.idToko, kategori: e.kategori)
    //           .toMapForDb());
    // });

    // if (up != null) {
    //  print(up.toString());
    print('init success---------------------------------------------------->');
    await fetchPenjualanDetaillocal(id_toko);
    //await fetchJenisBebanlocal(id_toko);
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

  var penjualan_list_detail_local = <DataPenjualanDetailV2>[].obs;

  // var beban_jenis_local = <DataJenisBeban>[].obs;
  fetchPenjualanDetailsync(id_toko) async {
    print(
        '-------------------fetch detail Penjualan local sync---------------------');
    //succ.value = false;
    List<Map<String, Object?>> query = await DBHelper()
        .FETCH('SELECT * FROM penjualan_detail_local ORDER BY ID DESC');
    List<DataPenjualanDetailV2> penjualan = query.isNotEmpty
        ? query.map((e) => DataPenjualanDetailV2.fromJson(e)).toList()
        : [];
    penjualan_list_detail_local.value = penjualan;
    // print('fect produk local --->' + produk.toList().toString());
    //succ.value = true;
    return penjualan;
  }

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
    // print('fect produk local --->' + produk.toList().toString());
    //succ.value = true;
    return penjualan;
  }

  detailPenjualanById(id, id_toko) async {
    print(
        '-------------------fetch detail penjulan by id local---------------------');
    //succ.value = false;
    List<Map<String, Object?>> query = await DBHelper().FETCH(
        'SELECT * FROM penjualan_detail_local WHERE id_penjualan = $id ORDER BY ID DESC');
    List<DataPenjualanDetailV2> penjualan = query.isNotEmpty
        ? query.map((e) => DataPenjualanDetailV2.fromJson(e)).toList()
        : [];
    isilocal.value = penjualan;
    // print('fect produk local --->' + produk.toList().toString());
    //succ.value = true;
    return penjualan;
  }

  // penjualanDetail(String id) async {
  //   print('-------------------penjualan detail---------------------');
  //
  //   var checkconn = await check_conn.check();
  //   if (checkconn == true) {
  //     var penjualan = await REST.penjualanDataDetail(token, id, id_toko);
  //     if (penjualan != null) {
  //       var dataPenjualan = ModelDetailPenjualan.fromJson(penjualan);
  //       detail_list.value = dataPenjualan.data;
  //
  //       dataPenjualan.data.forEach((element) {
  //         isi.value = element.detailItem!;
  //       });
  //
  //       // detail_list.value = dataPenjualan.data.map((e) => e.detailItem).toList();
  //       print(detail_list.value);
  //       return detail_list;
  //     } else {
  //       // Get.back(closeOverlays: true);
  //       Get.showSnackbar(toast()
  //           .bottom_snackbar_error('Error', 'Gagal fecthc detail penjualan'));
  //     }
  //   } else {
  //     //Get.back(closeOverlays: true);
  //     Get.showSnackbar(
  //         toast().bottom_snackbar_error('Error', 'Periksa koneksi'));
  //   }
  //   return [];
  // }

  penjualanDetailALl() async {
    print('-------------------penjualan detail---------------------');

    var checkconn = await check_conn.check();
    if (checkconn == true) {
      var penjualan = await REST.penjualanDataDetailAll(token, id_toko);
      if (penjualan != null) {
        var dataPenjualan = ModelDetailPenjualanV2.fromJson(penjualan);

        detail_list_all.value = dataPenjualan.data!;

        // detail_list.value = dataPenjualan.data.map((e) => e.detailItem).toList();
        print(detail_list_all);
        return detail_list_all;
      } else {
        // Get.back(closeOverlays: true);
        Get.showSnackbar(toast()
            .bottom_snackbar_error('Error', 'Gagal fecthc detail penjualan'));
      }
    } else {
      //Get.back(closeOverlays: true);
      Get.showSnackbar(
          toast().bottom_snackbar_error('Error', 'Periksa koneksi'));
    }
    return [];
  }
}
