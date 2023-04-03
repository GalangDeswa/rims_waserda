import 'package:get/get.dart';
import 'package:rims_waserda/Modules/laporan/Controller_laporan.dart';

class laporanBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(laporanController());
  }
}
