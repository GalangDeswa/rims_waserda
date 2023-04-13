import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rims_waserda/Modules/pelanggan/data%20pelanggan/view_tambah_pelanggan_form.dart';

import '../../../Templates/setting.dart';
import '../../Widgets/stack bg.dart';
import 'controller_data_pelanggan.dart';

class tambah_pelanggan extends GetView<pelangganController> {
  const tambah_pelanggan({Key? key}) : super(key: key);

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
          child: SingleChildScrollView(
            child: tambah_pelanggan_form(),
          ),
        ),
      ),
    );
  }
}
