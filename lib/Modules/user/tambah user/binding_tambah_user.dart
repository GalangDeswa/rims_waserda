import 'package:get/get.dart';

import 'controller_tambah_user.dart';

class tambah_userBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<tambah_userController>(() => tambah_userController());
  }
}
