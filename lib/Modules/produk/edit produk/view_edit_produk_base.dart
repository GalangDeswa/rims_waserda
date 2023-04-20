import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rims_waserda/Modules/produk/edit%20produk/controller_edit_produk.dart';
import 'package:rims_waserda/Modules/produk/edit%20produk/view_edit_produk_form.dart';

import '../../../Templates/setting.dart';
import '../../Widgets/stack bg.dart';

class edit_produk extends GetView<editprodukController> {
  const edit_produk({Key? key}) : super(key: key);

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
            child: edit_produk_form(),
          ),
        ),
      ),
    );
  }
}
