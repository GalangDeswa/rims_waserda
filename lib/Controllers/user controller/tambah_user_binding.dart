import 'package:get/get.dart';

import 'tambah_user_controller.dart';

class tambah_userBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<tambah_userController>(() => tambah_userController());
  }
}
