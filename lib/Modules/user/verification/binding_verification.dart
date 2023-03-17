import 'package:get/get.dart';

import 'controller_verification.dart';

class verificationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<verificationController>(() => verificationController());
  }
}
