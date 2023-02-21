import 'package:get/get.dart';
import 'package:meta/meta.dart';
import '../../Models/supliyer.dart';
import 'package:rims_waserda/Services/api.dart';


class suplierController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getsuplier();
  }

  var loading = true.obs;
  var suplier_list = <Supliyer>[].obs;

  var selected = ''.obs;

  void setSelected(String value) {
    selected.value = value;
  }

  void getsuplier() async {
    try {
      loading(true);
      var checkconn = await check_conn.check();
      if (checkconn == true) {
        var suplier = await api.get_suplier();
        if (suplier != null) {
          suplier_list.value = suplier;
        }
      } else {
        Get.snackbar('conn', 'tidak ada konenksi');
      }
    } finally {
      loading(false);
    }
  }
}
