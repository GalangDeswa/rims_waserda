import 'package:get/get.dart';

import 'controller_beban.dart';

class bebanBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(bebanController());
  }
}
