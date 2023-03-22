import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rims_waserda/Modules/beban/view_beban.dart';
import 'package:rims_waserda/Modules/user/data%20user/view_data_user_base.dart';

import '../dashboard/view_dashboard_base.dart';
import '../history/view_history_base.dart';
import '../kasir/view_kasir_base.dart';
import '../produk/data produk/view_produk_base.dart';

class base_menuController extends GetxController {
  List<Widget> views = const [
    dashboard(),
    kasir(),
    produk(),
    beban(),
    data_user(),
    history(),
  ];
  var selectedIndex = 0.obs;
  var extended = false.obs;
}
