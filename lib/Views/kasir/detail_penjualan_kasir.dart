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
    return Card(
      margin: EdgeInsets.only(left: 10),
      elevation: elevation().def_elevation,
      shape: RoundedRectangleBorder(
        borderRadius: border_radius().def_border,
        side: BorderSide(color: color_template().primary, width: 3.5),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Container(
          width: context.width_query / 4,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 15),
                decoration: BoxDecoration(
                  borderRadius: border_radius().header_border,
                  color: color_template().primary,
                ),
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
                            return Text(controller.totalitem.toString(),
                                style: font().reguler);
                          }),
                        ],
                      ),
                      Obx(() {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Total harga :', style: font().reguler),
                            Text(controller.subtotal.value.toString(),
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
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                  decoration: BoxDecoration(
                      color: color_template().primary,
                      borderRadius: border_radius().header_border),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        'Total tagihan :',
                        style: font().header,
                      ),
                      Text(
                        controller.subtotal.value.toString(),
                        style: font().header,
                      ),
                    ],
                  ),
                );
              }),
              SizedBox(
                height: 8,
              ),
              button_solid_custom(
                  onPressed: () {
                    controller.tambah_chekout();
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
                      "Pesan",
                      "Di tunda",
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
          ),
        ),
      ),
    );
  }
}
