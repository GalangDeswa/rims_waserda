import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:rims_waserda/Modules/produk/tambah%20produk/view_tambah_produk_form.dart';

import '../../../Templates/setting.dart';
import '../../Widgets/stack bg.dart';
import 'controller_tambah_produk.dart';

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
