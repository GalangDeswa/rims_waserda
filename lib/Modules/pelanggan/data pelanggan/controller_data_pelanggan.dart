import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:rims_waserda/Modules/pelanggan/data%20pelanggan/view_data_pelanggan_table.dart';
import 'package:rims_waserda/Modules/pelanggan/hutang/view_hutang_table.dart';

import '../../../Services/handler.dart';
import '../../Widgets/loading.dart';
import '../../Widgets/toast.dart';
import 'model_data_pelanggan.dart';

class pelangganController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchDataPelanggan();
  }

  List<Widget> table = [
    pelanggan_table(),
    hutang_table(),
  ];

  var selectedIndex = 0.obs;

  var formKeypelanggan = GlobalKey<FormState>().obs;
  var id_user = GetStorage().read('id_user');
  var token = GetStorage().read('token');
  var id_toko = GetStorage().read('id_toko');

  var search = TextEditingController().obs;
  var nama_pelanggan = TextEditingController().obs;
  var no_hp = TextEditingController().obs;

  var totalpage = 0.obs;
  var totaldata = 0.obs;
  var currentpage = 0.obs;
  var nextpage;
  var count = 0.obs;

  var nextdata;
  var previouspage;
  var perpage = 0.obs;

  var list_pelanggan = <DataPelanggan>[].obs;

  next() async {
    final respon = await http.post(Uri.parse(nextdata), body: {
      'token': token,
      'id_toko': id_toko,
    });
    final datav2 = json.decode(respon.body);
    var dataBeban = ModelPelanggan.fromJson(datav2);
    final data = json.decode(respon.body)['meta'];
    list_pelanggan.value = dataBeban.data;
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
    });
    final datav2 = json.decode(respon.body);
    var dataBeban = ModelPelanggan.fromJson(datav2);
    final data = json.decode(respon.body)['meta'];
    list_pelanggan.value = dataBeban.data;

    previouspage = data['pagination']['links']['previous'];
    nextdata = data['pagination']['links']['next'];
    count.value = data['pagination']['count'];
    totaldata.value = data['pagination']['total'];
    currentpage.value = data['pagination']['current_page'];
    perpage.value = data['pagination']['per_page'];
    print(previouspage);

    //return produk_list;
  }

  fetchDataPelanggan() async {
    print('-------------------fetch data beban---------------------');

    var checkconn = await check_conn.check();
    if (checkconn == true) {
      var pelanggan = await REST.pelangganData(token, id_toko);
      if (pelanggan != null) {
        print('-------------------data beban---------------');
        var dataPelanggan = ModelPelanggan.fromJson(pelanggan);

        list_pelanggan.value = dataPelanggan.data;
        totalpage.value = dataPelanggan.meta.pagination.totalPages;
        totaldata.value = dataPelanggan.meta.pagination.total;
        perpage.value = dataPelanggan.meta.pagination.perPage;
        currentpage.value = pelanggan['meta']['pagination']['current_page'];
        count.value = dataPelanggan.meta.pagination.count;
        if (totalpage > 1) {
          nextdata = pelanggan['meta']['pagination']['links']['next'];
        }

        print('--------------------list data beban---------------');
        print(list_pelanggan);

        // Get.back(closeOverlays: true);

        return list_pelanggan;
      } else {
        // Get.back(closeOverlays: true);
        Get.showSnackbar(
            toast().bottom_snackbar_error('Error', 'Gagal fecthdatabeban'));
      }
    } else {
      //Get.back(closeOverlays: true);
      Get.showSnackbar(
          toast().bottom_snackbar_error('Error', 'Periksa koneksi'));
    }
    return [];
  }

  tambahPelanggan() async {
    print('-------------------tambah beban---------------------');

    Get.dialog(showloading(), barrierDismissible: false);
    var checkconn = await check_conn.check();
    if (checkconn == true) {
      var pelanggan = await REST.pelangganTambah(
          token, id_toko, nama_pelanggan.value.text, no_hp.value.text);
      if (pelanggan != null) {
        print(pelanggan);
        var ui = await fetchDataPelanggan();
        if (ui != null) {
          Get.back(closeOverlays: true);
          Get.showSnackbar(toast()
              .bottom_snackbar_success('Berhasil', 'beban Berhasil di tambah'));
        } else {
          Get.showSnackbar(
              toast().bottom_snackbar_error('Error', ' beban Gagal di tambah'));
        }
      } else {
        Get.back(closeOverlays: true);
        Get.showSnackbar(
            toast().bottom_snackbar_error('Error', ' beban Gagal di tambah'));
      }
    } else {
      Get.back(closeOverlays: true);
      Get.showSnackbar(
          toast().bottom_snackbar_error('Error', 'Periksa Koneksi Internet'));
    }
    return [];
  }

  hapusPelanggan(String id) async {
    print('-------------------tambah beban---------------------');

    Get.dialog(showloading(), barrierDismissible: false);
    var checkconn = await check_conn.check();
    if (checkconn == true) {
      var hapus = await REST.pelangganHapus(token, id_toko, id);
      if (hapus != null) {
        //print(beban);
        print('---------feacth data dari delete---------');

        await fetchDataPelanggan();
        Get.back(closeOverlays: true, result: true);
        print('-----------batas----toasrp0-------------');
        Get.showSnackbar(toast().bottom_snackbar_success(
            'Berhasil', 'Pelanggan Berhasil di hapus'));
      } else {
        Get.back(closeOverlays: true);
        Get.showSnackbar(
            toast().bottom_snackbar_error('Error', 'Pelanggan Gagal di hapus'));
      }
    } else {
      Get.back(closeOverlays: true);
      Get.showSnackbar(
          toast().bottom_snackbar_error('Error', 'Periksa Koneksi Internet'));
    }
    return [];
  }
}
