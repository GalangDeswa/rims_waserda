import 'package:get/get.dart';
import 'package:rims_waserda/Controllers/verifikasi%20controller/verification_controller.dart';


class verificationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<verificationController>(() => verificationController());
  }
}
