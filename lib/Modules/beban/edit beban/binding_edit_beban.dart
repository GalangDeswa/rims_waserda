import 'package:get/get.dart';
import 'package:rims_waserda/Modules/beban/data%20beban/controller_beban.dart';

class editbebanBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(editbebanController());
  }
}
