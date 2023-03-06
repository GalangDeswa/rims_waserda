import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rims_waserda/Views/Widgets/stack%20bg.dart';

import '../../Controllers/Templates/setting.dart';
import '../../Controllers/detail produk controller/detail_produk_controller.dart';
import '../Widgets/appbar.dart';
import '../Widgets/header.dart';
import 'detail produk_gambar.dart';
import 'detail_produk_list.dart';

class detail_Produk extends GetView<detail_produkController> {
  const detail_Produk({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: color_template().base_blue,
            // appBar: appbar_custom(
            //     height: 50,
            //     child: Text(
            //       'Detail Produk',
            //       style: font().header,
            //     )),
            body: stack_bg(
              child: Padding(
                padding: const EdgeInsets.all(30),
                child: Card(
                  elevation: elevation().def_elevation,
                  //margin: EdgeInsets.all(30),
                  shape: RoundedRectangleBorder(
                    borderRadius: border_radius().def_border,
                    side:
                        BorderSide(color: color_template().primary, width: 3.5),
                  ),

                  child: Padding(
                    padding: EdgeInsets.all(15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        detail_produk_gambar(),
                        Expanded(child: detail_produk_list())
                      ],
                    ),
                  ),
                ),
              ),
            )));
  }
}
