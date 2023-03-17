import 'package:get/get.dart';

import 'controller_tambah_produk.dart';

class tambah_produkBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(tambah_produkController());
  }
}
