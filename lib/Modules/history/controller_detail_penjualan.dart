import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../Services/handler.dart';
import '../Widgets/toast.dart';
import 'model_detail_penjualan.dart';

class detailpenjualanController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    penjualanDetail(data.id.toString());
  }

  var data = Get.arguments;
  var detail_list = <DataDetailPenjualan>[].obs;
  var id_user = GetStorage().read('id_user');
  var token = GetStorage().read('token');
  var id_toko = GetStorage().read('id_toko');
  var isi = <DetailItem>[].obs;
  var det = <String>[];

  penjualanDetail(String id) async {
    print('-------------------penjualan detail---------------------');

    var checkconn = await check_conn.check();
    if (checkconn == true) {
      var penjualan = await REST.penjualanDataDetail(token, id, id_toko);
      if (penjualan != null) {
        var dataPenjualan = ModelDetailPenjualan.fromJson(penjualan);
        detail_list.value = dataPenjualan.data;

        dataPenjualan.data.forEach((element) {
          isi.value = element.detailItem;
        });

        // detail_list.value = dataPenjualan.data.map((e) => e.detailItem).toList();
        print(detail_list.value);
        return detail_list;
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
