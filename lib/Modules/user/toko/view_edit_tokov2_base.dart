import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rims_waserda/Modules/user/toko/controller_edit_tokov2.dart';
import 'package:rims_waserda/Modules/user/toko/view_edit_tokov2_form.dart';

import '../../../Templates/setting.dart';
import '../../Widgets/stack bg.dart';

class edit_tokov2 extends GetView<edittokov2Controller> {
  const edit_tokov2({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      // minimum: EdgeInsets.all(5),
      child: Scaffold(
        backgroundColor: color_template().base_blue,
        // appBar: appbar_custom(
        //     height: 50,
        //     child: Text(
        //       'Tambah Produk',
        //       style: font().header,
        //     )),
        body: stack_bg(
          isfullscreen: true,
          child: SingleChildScrollView(
            child: edit_tokov2_form(),
          ),
        ),
      ),
    );
  }
}
