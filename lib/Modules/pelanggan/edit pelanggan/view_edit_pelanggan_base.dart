import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rims_waserda/Modules/pelanggan/edit%20pelanggan/controller_edit_pelanggan.dart';
import 'package:rims_waserda/Modules/pelanggan/edit%20pelanggan/view_edit_pelanggan_form.dart';

import '../../../Templates/setting.dart';
import '../../Widgets/stack bg.dart';

class edit_pelanggan extends GetView<editpelangganController> {
  const edit_pelanggan({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      // minimum: EdgeInsets.all(5),
      child: Scaffold(
        backgroundColor: color_template().primary.withOpacity(0.2),
        // appBar: appbar_custom(
        //     height: 50,
        //     child: Text(
        //       'Tambah Produk',
        //       style: font().header,
        //     )),
        body: stack_bg(
          isfullscreen: true,
          child: edit_pelanggan_form(),
        ),
      ),
    );
  }
}
