import 'package:get/get.dart';

import 'detail_produk_controller.dart';


class detail_produkBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(detail_produkController());
  }
}
