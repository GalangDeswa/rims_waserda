import 'package:get/get.dart';
import 'package:rims_waserda/Modules/produk/jenis%20produk/controller_edit_jenis.dart';

class editjenisBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(editjenisController());
  }
}
