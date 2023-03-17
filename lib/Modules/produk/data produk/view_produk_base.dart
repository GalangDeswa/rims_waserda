import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:rims_waserda/Modules/produk/data%20produk/view_produk_table.dart';

import '../../../Templates/setting.dart';
import '../../Widgets/stack bg.dart';
import 'controller_data_produk.dart';

class produk extends GetView<produkController> {
  const produk({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      //minimum: EdgeInsets.all(10),
      child: Scaffold(
          backgroundColor: color_template().primary.withOpacity(0.2),
          // appBar: appbar_custom(
          //     height: 50,
          //     child: Text(
          //       'Produk',
          //       style: font().header,
          //     )),
          body: stack_bg(
            child: Padding(
              padding: const EdgeInsets.all(30),
              child: produk_table(),
            ),
          )),
    );
  }
}
