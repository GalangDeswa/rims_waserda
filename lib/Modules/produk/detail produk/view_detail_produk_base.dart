import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rims_waserda/Modules/Widgets/header.dart';

import '../../../Templates/setting.dart';
import '../../Widgets/stack bg.dart';
import 'controller_detail_produk.dart';
import 'view_detail produk_gambar.dart';
import 'view_detail_produk_list.dart';

class detail_Produk extends GetView<detail_produkController> {
  const detail_Produk({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: color_template().base_blue,
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
                    child: Column(
                      children: [
                        header(
                          title: 'Edit produk',
                          icon: Icons.add,
                        ),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              detail_produk_gambar(),
                              Expanded(child: detail_produk_list())
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )));
  }
}
