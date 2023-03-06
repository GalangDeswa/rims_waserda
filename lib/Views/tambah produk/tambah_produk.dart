import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:rims_waserda/Views/Widgets/stack%20bg.dart';
import 'package:rims_waserda/Views/tambah%20produk/tambah_produk_form.dart';

import '../../Controllers/Templates/setting.dart';
import '../../Controllers/produk controller/tambah_produk_controller.dart';
import '../Widgets/appbar.dart';

class tambah_produk extends GetView<tambah_produkController> {
  const tambah_produk({Key? key}) : super(key: key);

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
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: tambah_produk_form(),
          ),
        ),
      ),
    );
  }
}
