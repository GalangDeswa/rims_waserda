import 'package:get/get.dart';
import 'package:rims_waserda/Modules/user/data%20user/controller_data_user.dart';

class NameBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(datauserController());
  }
}
