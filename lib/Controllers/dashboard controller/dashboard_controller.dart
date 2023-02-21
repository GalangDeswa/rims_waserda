import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:meta/meta.dart';

class dashboardController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    print('dashboard controller ------------------------------------------->');
    print(toko_user.toString());
  }

  var toko_user = GetStorage().read('toko_user');
  //var toko = Get.arguments as Map;
}
