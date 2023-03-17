import 'package:get/get.dart';

import 'controller_reset_password.dart';

class reset_passwordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<reset_passwordController>(() => reset_passwordController());
  }
}
