import 'package:get/get.dart';

import 'controller_toko.dart';

class pilih_tokoBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(pilih_tokoController());
  }
}
