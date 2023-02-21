import 'package:get/get.dart';
import 'package:meta/meta.dart';

class tambah_stockController extends GetxController {
  var lol = 0.obs;
  void tambah() {
    lol++;
    print(lol);
  }
}
