import 'package:get/get.dart';

import 'controller_login.dart';

class loginBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(loginController());
    //Get.lazyPut<loginController>(() => loginController());
  }
}
