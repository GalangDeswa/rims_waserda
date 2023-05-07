import 'package:get/get.dart';
import 'package:rims_waserda/Modules/pelanggan/hutang/controller_hutang.dart';

class hutangBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(hutangController());
  }
}
