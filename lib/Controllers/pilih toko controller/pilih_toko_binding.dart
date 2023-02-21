import 'package:get/get.dart';
import 'package:rims_waserda/Controllers/pilih%20toko%20controller/pilih_toko_controller.dart';


class pilih_tokoBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(pilih_tokoController());
  }
}
