import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rims_waserda/Modules/Widgets/stack%20bg.dart';
import 'package:rims_waserda/Modules/user/data%20user/controller_data_user.dart';
import 'package:rims_waserda/Modules/user/tambah%20user/view_tambah_user_form.dart';

import '../../../Templates/setting.dart';

class tambah_user extends GetView<datauserController> {
  const tambah_user({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      //minimum: EdgeInsets.all(10),
      child: Scaffold(
          backgroundColor: color_template().base_blue,
          // backgroundColor: color_template().primary.withOpacity(0.2),
          // appBar: appbar_custom(
          //     height: 50,
          //     child: Text(
          //       'Tambah user',
          //       style: font().header,
          //     )),
          body: stack_bg(
              isfullscreen: true,
              child: SingleChildScrollView(child: tambah_user_form()))),
    );
  }
}
