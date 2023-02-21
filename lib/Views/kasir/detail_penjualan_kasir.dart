import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';



import '../../Controllers/Templates/setting.dart';

import '../../Controllers/kasir controller/kasir_controller.dart';
import '../Widgets/buttons.dart';
import '../Widgets/popup.dart';


class detail_penjualan_kasir extends GetView<kasirController> {
  const detail_penjualan_kasir({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        // color: Colors.blue,
        width: context.width_query * 0.25,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              color: color_template().primary.withOpacity(0.2),
              height: context.height_query * 0.63,
              margin: EdgeInsets.only(bottom: 5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    color: color_template().primary,
                    child: Center(
                      child: Text(
                        'Detail Penjualan',
                        style: font().header,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      //color: Colors.red,
                      padding: EdgeInsets.symmetric(horizontal: 6),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('sales person :', style: font().reguler),
                              Text('Galang', style: font().reguler),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Total item :', style: font().reguler),
                              Obx(() {
                                return Text(
                                    controller.listbarang_baru.length
                                        .toString(),
                                    style: font().reguler);
                              }),
                            ],
                          ),
                          Obx(() {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Total harga :', style: font().reguler),
                                Text(controller.totalharga().toString(),
                                    style: font().reguler),
                              ],
                            );
                          }),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('total diskon :', style: font().reguler),
                              Text('0', style: font().reguler),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('total pajak :', style: font().reguler),
                              Text('0', style: font().reguler),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Obx(() {
                    return Container(
                      width: double.infinity,
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                      color: color_template().primary,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            'Total tagihan :',
                            style: font().header,
                          ),
                          Text(
                            controller.totalharga().toString(),
                            style: font().header,
                          ),
                        ],
                      ),
                    );
                  }),
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                button_solid_custom(
                    onPressed: () {
                      popscreen().popbayar(context, controller);
                    },
                    child: Text(
                      'Bayar',
                      style: font().header,
                    ),
                    width: double.infinity,
                    height: 50),
                SizedBox(
                  height: 8,
                ),
                button_border_custom(
                    onPressed: () {
                      Get.snackbar(
                        "Lmao XD",
                        "Xd",
                        icon: Icon(Icons.dangerous, color: Colors.white),
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: color_template().tritadery,
                      );
                    },
                    child: Text(
                      'Tunda',
                      style: TextStyle(fontSize: 20, color: Colors.black),
                    ),
                    width: double.infinity,
                    height: 50)
              ],
            )
          ],
        ),
      ),
    );
  }
}
