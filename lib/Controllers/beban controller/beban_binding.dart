import 'package:get/get.dart';

import 'beban_controller.dart';

class bebanBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(bebanController());
  }
}
