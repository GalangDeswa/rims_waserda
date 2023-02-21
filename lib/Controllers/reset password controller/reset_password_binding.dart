import 'package:get/get.dart';
import 'package:rims_waserda/Controllers/reset%20password%20controller/reset_password_controller.dart';


class reset_passwordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<reset_passwordController>(() => reset_passwordController());
  }
}
