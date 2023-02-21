import 'package:get/get.dart';

import 'kasir_controller.dart';


class kasirBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(kasirController());
  }
}
