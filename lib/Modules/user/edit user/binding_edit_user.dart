import 'package:get/get.dart';

import 'controller_edit_user.dart';

class edituserBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(edituserController());
  }
}
