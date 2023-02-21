
import 'package:flutter/material.dart';

import 'package:get/get.dart';


import '../../Controllers/Templates/setting.dart';
import '../../Controllers/kasir controller/kasir_controller.dart';
import '../Widgets/appbar.dart';
import 'detail_penjualan_kasir.dart';
import 'list_kasir.dart';

class kasir extends GetView<kasirController> {
  const kasir({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      // minimum: EdgeInsets.all(5),
      child: Scaffold(
        backgroundColor: color_template().primary.withOpacity(0.2),
        appBar: appbar_custom(
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'kasir',
                  style: font().header,
                ),
                IconButton(
                    onPressed: () {
                      controller.refresh();
                    },
                    icon: Icon(
                      Icons.refresh,
                      color: Colors.white,
                    ))
              ],
            )),
        body: Card(
            elevation: 3,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [list_kasir(), detail_penjualan_kasir()],
            )),
      ),
    );
  }
}
