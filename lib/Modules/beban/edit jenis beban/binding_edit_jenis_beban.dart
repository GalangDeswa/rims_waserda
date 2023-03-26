import 'package:get/get.dart';

import '../data beban/controller_beban.dart';

class editjenisbebanBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(editjenisbebanController());
  }
}
