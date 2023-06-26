import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';

import '../../../db_helper.dart';
import 'model_hutang_detail.dart';

class hutang_detailController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchDataHutangDetaillocal(id_toko, data.id);
  }

  DateFormat dateFormatdisplay = DateFormat("dd-MM-yyyy");
  var data = Get.arguments;
  var id_user = GetStorage().read('id_user');
  var token = GetStorage().read('token');
  var id_toko = GetStorage().read('id_toko');
  final nominal = NumberFormat("#,##0");
  var list_hutang_detaillocal = <DataHutangDetail>[].obs;

  Map<String, dynamic> synclocal(data) {
    var map = <String, dynamic>{};

    map['sync'] = data;

    return map;
  }

  fetchDataHutangDetaillocal(id_toko, id_hutang) async {
    print('-------------------fetch hutang detail local---------------------');
    //  succ.value = false;
    List<Map<String, Object?>> query = await DBHelper().FETCH(
        'SELECT * FROM hutang_detail_local WHERE id_toko = $id_toko AND aktif = "Y" AND id_hutang =$id_hutang  ORDER BY ID DESC');
    List<DataHutangDetail> hutang = query.isNotEmpty
        ? query.map((e) => DataHutangDetail.fromJson(e)).toList()
        : [];
    list_hutang_detaillocal.value = hutang;
    // print('fect produk local --->' + produk.toList().toString());
    //  succ.value = true;
    print(hutang);
    return hutang;
  }
}
