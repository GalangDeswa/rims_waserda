import 'package:get/get.dart';

import 'controller_detail_produk.dart';

class detail_produkBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(detail_produkController());
  }
}
