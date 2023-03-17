import 'package:get/get.dart';

import 'package:rims_waserda/Modules/Splash/controller_splash.dart';

class splashBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(splashController());
    //Get.lazyPut<splashController>(() => splashController());
  }
}
