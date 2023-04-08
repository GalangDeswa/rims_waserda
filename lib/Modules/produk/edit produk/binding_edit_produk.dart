import 'package:get/get.dart';
import 'package:rims_waserda/Modules/produk/edit%20produk/controller_edit_produk.dart';

class editprodukBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(editprodukController());
  }
}
