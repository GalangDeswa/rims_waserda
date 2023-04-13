import 'package:get/get.dart';
import 'package:rims_waserda/Modules/pelanggan/data%20pelanggan/controller_data_pelanggan.dart';

class pelangganBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(pelangganController());
  }
}
