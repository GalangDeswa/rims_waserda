import 'package:get/get.dart';

import 'login_controller.dart';


class loginBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(loginController());
    //Get.lazyPut<loginController>(() => loginController());
  }
}
