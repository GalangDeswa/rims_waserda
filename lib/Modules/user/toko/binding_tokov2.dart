import 'package:get/get.dart';
import 'package:rims_waserda/Modules/user/toko/controller_edit_tokov2.dart';

class tokov2Binding extends Bindings {
  @override
  void dependencies() {
    Get.put(edittokov2Controller());
  }
}
