import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rims_waserda/Modules/user/data%20user/view_data_user_table.dart';

import '../../../Templates/setting.dart';
import '../../Widgets/stack bg.dart';
import 'controller_data_user.dart';

class data_user extends GetView<datauserController> {
  const data_user({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //Get.put(datauserController());
    return SafeArea(
      //minimum: EdgeInsets.all(10),
      child: Scaffold(
          backgroundColor: color_template().base_blue,
          // appBar: appbar_custom(
          //     height: 50,
          //     child: Text(
          //       'Produk',
          //       style: font().header,
          //     )),
          body: stack_bg(
            isfullscreen: true,
            child: table_user(),
          )),
    );
  }
}
