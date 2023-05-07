import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:pattern_formatter/numeric_formatter.dart';
import 'package:rims_waserda/Modules/Widgets/loading.dart';
import 'package:rims_waserda/Modules/pelanggan/hutang/model_hutang_detail.dart';

import '../../../Services/handler.dart';
import '../../../Templates/setting.dart';
import '../../Widgets/buttons.dart';
import '../../Widgets/header.dart';
import '../../Widgets/toast.dart';
import 'model_hutang.dart';
import 'model_hutangv2.dart';

class hutangController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchDataHutang();
  }

  var search = TextEditingController().obs;

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
    var dataHutang = ModelHutang.fromJson(datav2);
    final data = json.decode(respon.body)['meta'];
    list_hutang.value = dataHutang.data;
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
    var dataHutang = ModelHutang.fromJson(datav2);
    final data = json.decode(respon.body)['meta'];
    list_hutang.value = dataHutang.data;

    previouspage = data['pagination']['links']['previous'];
    nextdata = data['pagination']['links']['next'];
    count.value = data['pagination']['count'];
    totaldata.value = data['pagination']['total'];
    currentpage.value = data['pagination']['current_page'];
    perpage.value = data['pagination']['per_page'];
    print(previouspage);

    //return produk_list;
  }

  var id_user = GetStorage().read('id_user');
  var token = GetStorage().read('token');
  var id_toko = GetStorage().read('id_toko');

  var bayarhutang = TextEditingController().obs;
  var list_hutang = <DataHutang>[].obs;
  var list_hutangv2 = <DataHutangv2>[].obs;
  var list_hutang_detail = <DataHutangDetail>[].obs;

  fetchDataHutang() async {
    print('-------------------fetch data hutang---------------------');

    var checkconn = await check_conn.check();
    if (checkconn == true) {
      var hutang = await REST.hutangAll(token: token, id_toko: id_toko);
      if (hutang['status_code'] == 200) {
        print('-------------------data beban---------------');
        var dataHutang = ModelHutangv2.fromJson(hutang);

        list_hutangv2.value = dataHutang.data;
        totalpage.value = dataHutang.meta.pagination.totalPages;
        totaldata.value = dataHutang.meta.pagination.total;
        perpage.value = dataHutang.meta.pagination.perPage;
        currentpage.value = hutang['meta']['pagination']['current_page'];
        count.value = dataHutang.meta.pagination.count;
        if (totalpage > 1) {
          nextdata = hutang['meta']['pagination']['links']['next'];
        }

        print('--------------------list data beban---------------');
        print(list_hutangv2);

        // Get.back(closeOverlays: true);

        return list_hutangv2;
      } else {
        // Get.back(closeOverlays: true);
        Get.showSnackbar(
            toast().bottom_snackbar_error('Error', 'Gagal fecth butang'));
      }
    } else {
      //Get.back(closeOverlays: true);
      Get.showSnackbar(
          toast().bottom_snackbar_error('Error', 'Periksa koneksi'));
    }
    return [];
  }

  fetchDataHutangDetail(String id) async {
    print('-------------------fetch data hutang detail---------------------');

    var checkconn = await check_conn.check();
    if (checkconn == true) {
      var hutang = await REST.hutangDetail(
          token: token, id_toko: id_toko, id_hutang: id);
      if (hutang['status_code'] == 200) {
        print('-------------------data beban---------------');
        var dataHutang = ModelHutangDetail.fromJson(hutang);

        list_hutang_detail.value = dataHutang.data;
        // totalpage.value = dataHutang.meta.pagination.totalPages;
        // totaldata.value = dataHutang.meta.pagination.total;
        // perpage.value = dataHutang.meta.pagination.perPage;
        // currentpage.value = hutang['meta']['pagination']['current_page'];
        // count.value = dataHutang.meta.pagination.count;
        // if (totalpage > 1) {
        //   nextdata = hutang['meta']['pagination']['links']['next'];
        // }

        print('--------------------list data hutang detail---------------');
        print(list_hutang_detail);

        // Get.back(closeOverlays: true);

        return list_hutang_detail;
      } else {
        // Get.back(closeOverlays: true);
        Get.showSnackbar(
            toast().bottom_snackbar_error('Error', 'Gagal fecth butang'));
      }
    } else {
      //Get.back(closeOverlays: true);
      Get.showSnackbar(
          toast().bottom_snackbar_error('Error', 'Periksa koneksi'));
    }
    return [];
  }

  bayarHutang(String id) async {
    Get.dialog(showloading(), barrierDismissible: false);
    print('-------------------fetch data hutang---------------------');

    var checkconn = await check_conn.check();
    if (checkconn == true) {
      var hutang = await REST.hutangBayar(
          token: token,
          id_toko: id_toko,
          id_hutang: id,
          bayar: jumlahbayarhutang.value.toString());
      if (hutang != null) {
        print('------------------bayar hutang---------------');

        await fetchDataHutang();

        bayarhutang.value.clear();

        Get.back(closeOverlays: true);

        Get.showSnackbar(toast()
            .bottom_snackbar_success('Berhasil', 'Hutang berhasil di bayar'));
      } else {
        Get.back(closeOverlays: true);

        Get.showSnackbar(
            toast().bottom_snackbar_error('Error', 'Gagal bayar hutang'));
      }
    } else {
      Get.back(closeOverlays: true);
      Get.showSnackbar(
          toast().bottom_snackbar_error('Error', 'Periksa koneksi'));
    }
    return [];
  }

  var jumlahbayarhutang = 0.obs;
  final nominal = NumberFormat("#,##0");

  bayarhutangpop(String arg, hutang) {
    Get.dialog(AlertDialog(
      title: header(
          title: 'Bayar hutang',
          icon: FontAwesomeIcons.dollarSign,
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
                    Text('Sisa hutang : ' +
                        'Rp.' +
                        nominal.format(int.parse(hutang))),
                    SizedBox(
                      height: 5,
                    ),
                    Text('Masukan jumlah bayar'),
                    SizedBox(
                      height: 10,
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              inputFormatters: [ThousandsFormatter()],
                              onChanged: ((String num) {
                                jumlahbayarhutang.value = int.parse(
                                    num.toString().replaceAll(',', ''));
                                print(jumlahbayarhutang.value);
                              }),
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10)),
                              ),
                              textAlign: TextAlign.center,
                              controller: bayarhutang.value,
                              style: font().header_black,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    button_solid_custom(
                        onPressed: () {
                          bayarHutang(arg);
                        },
                        child: Text(
                          'Bayar',
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
}
