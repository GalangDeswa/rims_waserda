import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rims_waserda/Modules/kasir/controller_kasir.dart';
import 'package:rims_waserda/Modules/kasir/view_kasir_detail.dart';
import 'package:rims_waserda/Modules/kasir/view_kasir_produk.dart';

import '../../Templates/setting.dart';
import '../Widgets/stack bg.dart';

class kasirv2 extends GetView<kasirController> {
  const kasirv2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      // minimum: EdgeInsets.all(10),
      child: Scaffold(
          backgroundColor: color_template().primary.withOpacity(0.2),
          resizeToAvoidBottomInset: false,
          // appBar: appbar_custom(
          //     height: 50,
          //     child: Row(
          //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //       children: [
          //         Text(
          //           'kasir',
          //           style: font().header,
          //         ),
          //         IconButton(
          //             onPressed: () {
          //               controller.refresh();
          //             },
          //             icon: Icon(
          //               Icons.refresh,
          //               color: Colors.white,
          //             ))
          //       ],
          //     )),
          body: RefreshIndicator(
            onRefresh: () => controller.refresh(),
            child: stack_bg(
              isfullscreen: true,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Expanded(child: kasir_produk()),
                  kasir_detail(),
                ],
              ),
            ),
          )),
    );
  }
}
