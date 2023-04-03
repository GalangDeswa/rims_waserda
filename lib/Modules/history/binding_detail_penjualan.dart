import 'package:get/get.dart';
import 'package:rims_waserda/Modules/history/controller_detail_penjualan.dart';

class detailpenjualanBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(detailpenjualanController());
  }
}
