import 'package:get/get.dart';

import 'controller_kasir.dart';

class kasirBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(kasirController());
  }
}
