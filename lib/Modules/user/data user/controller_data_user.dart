import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:rims_waserda/Modules/Widgets/toast.dart';
import 'package:rims_waserda/Services/handler.dart';

import '../../Widgets/loading.dart';
import 'model_data_user.dart';

class datauserController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    print(
        '-------------------------userdataController INIT-------------------');
    userdata();
    update();

    //userdatav2();
  }

  reload() {
    //userdata();
    print('-----------------reload------------');
    onInit();
    // listUser.refresh();
  }

  var totalpage = 0.obs;
  var totaldata = 0.obs;
  var currentpage = 0.obs;
  var nextpage;
  var count = 0.obs;

  var nextdata;
  var previouspage;
  var perpage = 0.obs;

  next() async {
    final respon = await http.post(Uri.parse(nextdata), body: {
      'token': token,
      'id_toko': id_toko,
    });
    final datav2 = json.decode(respon.body);
    var dataUser = ModelUser.fromJson(datav2);
    final data = json.decode(respon.body)['meta'];
    listUser.value = dataUser.data;
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
    var dataUser = ModelUser.fromJson(datav2);
    final data = json.decode(respon.body)['meta'];
    listUser.value = dataUser.data;

    previouspage = data['pagination']['links']['previous'];
    nextdata = data['pagination']['links']['next'];
    count.value = data['pagination']['count'];
    totaldata.value = data['pagination']['total'];
    currentpage.value = data['pagination']['current_page'];
    perpage.value = data['pagination']['per_page'];
    print(previouspage);

    //return produk_list;
  }

  var listUser = <DataUser>[].obs;
  var token = GetStorage().read('token');
  var id_toko = GetStorage().read('id_toko');

  Future<List<DataUser>> userdata() async {
    print('-------------------userdata---------------------');

    // SchedulerBinding.instance.addPostFrameCallback(
    //     (_) => Get.dialog(loading(), barrierDismissible: false));
    //call dialog tidak bisa di init tanpa coding di atas

    var checkconn = await check_conn.check();
    if (checkconn == true) {
      var user = await REST.userData(token, id_toko);
      if (user != null) {
        print('-------------------datauser---------------');
        var dataUser = ModelUser.fromJson(user);
        //listUser.value.clear();
        listUser.value = dataUser.data;

        totalpage.value = dataUser.meta.pagination.totalPages;
        totaldata.value = dataUser.meta.pagination.total;
        perpage.value = dataUser.meta.pagination.perPage;
        currentpage.value = user['meta']['pagination']['current_page'];
        count.value = dataUser.meta.pagination.count;
        if (totalpage > 1) {
          nextdata = user['meta']['pagination']['links']['next'];
        }

        print('--------------------list user---------------');
        print(listUser);

        Get.back(closeOverlays: true);

        return listUser;
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

  var password = TextEditingController().obs;
  var konfirmasipassword = TextEditingController().obs;
  var nama = TextEditingController().obs;
  var alamat = TextEditingController().obs;
  var hp = TextEditingController().obs;
  var email = TextEditingController().obs;
  var formKey = GlobalKey<FormState>().obs;

  List role = ['Pilih Role', 'Kasir', 'Admin'].obs;

  var roleval = 0.obs;

  //var token = GetStorage().read('token');
  //var id_toko = GetStorage().read('id_toko');
  var id_user = GetStorage().read('id_user');

  clear() {
    nama.value.clear();
    email.value.clear();
    password.value.clear();
    konfirmasipassword.value.clear();
    roleval.value = 0;
    hp.value.clear();
  }

  tambahuser() async {
    Get.dialog(showloading(), barrierDismissible: false);
    var checkconn = await check_conn.check();
    if (checkconn == true) {
      var user = await REST.userTambah(
          token,
          id_toko,
          id_user.toString(),
          nama.value.text,
          email.value.text,
          password.value.text,
          roleval.value.toString(),
          hp.value.text);
      if (user['success'] == true) {
        print(user);
        await userdata();
        clear();
        Get.back(closeOverlays: true, result: user);
        Get.showSnackbar(toast()
            .bottom_snackbar_success('Sukses', 'User behasil di tambah'));
      } else {
        Get.back(closeOverlays: true);
        Get.showSnackbar(
            toast().bottom_snackbar_error('Gagal', user['message']));
      }
    } else {
      Get.back(closeOverlays: true);
      Get.showSnackbar(
          toast().bottom_snackbar_error('Gagal', 'Periksa koneksi'));
    }
  }

  deleteuser(String id) async {
    Get.dialog(
      showloading(),
      barrierDismissible: false,
    );
    var checkconn = await check_conn.check();
    if (checkconn == true) {
      var user = await REST.userDelete(token, id_toko, id);
      if (user != null) {
        print(user);
        //get.back close overlay otomatis close dan back page sebelumnya?
        await userdata();
        Get.back(closeOverlays: true);

        Get.showSnackbar(
            toast().bottom_snackbar_success('Sukses', 'User behasil dihapus'));
      } else {
        Get.back(closeOverlays: true);
        Get.showSnackbar(
            toast().bottom_snackbar_error('Gagal', 'user gagal dihapus'));
      }
    } else {
      Get.back(closeOverlays: true);
      Get.showSnackbar(
          toast().bottom_snackbar_error('Gagal', 'Periksa koneksi'));
    }
  }
}
