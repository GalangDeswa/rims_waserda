import 'package:get/get.dart';

import 'controller_edit_pelanggan.dart';

class editpelangganBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(editpelangganController());
  }
}
