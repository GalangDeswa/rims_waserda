import 'package:get/get.dart';

import 'historyController.dart';

class historyBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(historyController());
  }
}
