import 'package:get/get.dart';
import 'package:rims_waserda/Modules/produk/data%20produk/controller_data_produk.dart';

class produkBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(produkController());
  }
}
