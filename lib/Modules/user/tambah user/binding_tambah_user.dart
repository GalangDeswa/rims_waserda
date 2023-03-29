import 'package:get/get.dart';
import 'package:rims_waserda/Modules/user/data%20user/controller_data_user.dart';

class tambah_userBinding extends Bindings {
  @override
  void dependencies() {
    //Get.lazyPut<tambah_userController>(() => tambah_userController());
    Get.put(datauserController());
  }
}
