import 'package:get/get.dart';

import 'controller_pembelian.dart';

class pembelianBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(pembelianController());
  }
}
