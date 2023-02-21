import 'package:get/get.dart';
import 'package:rims_waserda/Controllers/splash%20controller/splash_controller.dart';


class splashBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(splashController());
    //Get.lazyPut<splashController>(() => splashController());
  }
}
