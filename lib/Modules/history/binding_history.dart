import 'package:get/get.dart';

import 'Controller_history.dart';

class historyBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(historyController());
  }
}
