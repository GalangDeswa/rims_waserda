import 'package:get/get.dart';
import 'package:rims_waserda/Controllers/produk%20controller/tambah_produk_controller.dart';


class tambah_produkBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(tambah_produkController());
  }
}
