import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rims_waserda/Modules/beban/data%20beban/controller_beban.dart';
import 'package:rims_waserda/Modules/beban/edit%20beban/view_edit_beban_form.dart';

import '../../Widgets/stack bg.dart';

class edit_beban extends GetView<editbebanController> {
  const edit_beban({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      // minimum: EdgeInsets.all(5),
      child: Scaffold(
        //backgroundColor: color_template().base_blue,

        // appBar: appbar_custom(
        //     height: 50,
        //     child: Text(
        //       'Tambah Produk',
        //       style: font().header,
        //     )),
        body: stack_bg(
          isfullscreen: true,
          child: SingleChildScrollView(
            child: edit_beban_form(),
          ),
        ),
      ),
    );
  }
}
