import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:rims_waserda/Modules/Widgets/card_custom.dart';
import 'package:rims_waserda/Modules/Widgets/toast.dart';
import 'package:rims_waserda/Modules/kasir/view_kasir_keypad.dart';

import '../../Templates/setting.dart';
import '../Widgets/buttons.dart';
import 'controller_kasir.dart';

class detail_penjualan_kasir extends GetView<kasirController> {
  const detail_penjualan_kasir({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card_custom(
      border: false,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Container(
          width: context.width_query / 4,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 15),
                decoration: BoxDecoration(
                    borderRadius: border_radius().header_border,
                    color: Colors.white,
                    border: Border.all(color: color_template().primary)),
                child: Center(
                  child: Text(
                    'Detail Penjualan',
                    style: font().header_blue,
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  //color: Colors.red,
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('sales person :', style: font().reguler),
                          Text(controller.kasir, style: font().reguler),
                        ],
                      ),
                      Obx(() {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Total item :', style: font().reguler),
                            Text(
                                //controller.testlist.length.toString()
                                controller.cache
                                    .map((e) => e.qty)
                                    .fold(
                                        0,
                                        (previous, current) =>
                                            previous + current!)
                                    .toString(),
                                style: font().reguler_bold),
                          ],
                        );
                      }),
                      Obx(() {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Subtotal :', style: font().reguler),
                            Text(
                              controller.subtotal.value == ''
                                  ? '0'
                                  : controller.cache.isEmpty
                                      ? '0'
                                      : 'Rp.' +
                                          controller.nominal.format(
                                              controller.subtotal.value),
                              style: font().reguler_bold,
                            ),
                          ],
                        );
                      }),
                      Obx(() {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                'PPN :',
                                style: font().reguler,
                              ),
                            ),
                            Expanded(
                                child: Row(
                              children: [
                                controller.ppnSwitch.value == true
                                    ? Expanded(
                                        child: Text(
                                          "Rp." +
                                              controller.nominal
                                                  .format(controller.ppn.value),
                                          style: font().reguler_bold,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      )
                                    : Expanded(
                                        child: Text(
                                          "-",
                                          style: font().reguler,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                Transform.scale(
                                  scale: 0.65,
                                  child: Switch(
                                      activeColor: color_template().primary,
                                      value: controller.ppnSwitch.value,
                                      onChanged: (x) {
                                        controller.ppnSwitch.value = x;
                                        print(controller.ppnSwitch);
                                        print(controller.ppn);
                                        controller.totalval();
                                      }),
                                ),
                              ],
                            )),
                          ],
                        );
                      }),
                      Obx(() {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                                child: Text('Diskon :', style: font().reguler)),
                            Expanded(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  controller.metode_diskon == 1
                                      ? Text(
                                          controller.displaydiskon
                                                  .toStringAsFixed(0) +
                                              '%',
                                          style: font().reguler_bold,
                                          overflow: TextOverflow.ellipsis,
                                        )
                                      : Text(
                                          'Rp. ' +
                                              controller.nominal.format(
                                                  controller
                                                      .displaydiskon.value),
                                          style: font().reguler_bold,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                  controller.displaydiskon.value == 0
                                      ? InkWell(
                                          splashColor: color_template().select,
                                          onTap: () {
                                            controller
                                                .editDiskonKasir(controller);
                                          },
                                          child: Container(
                                            padding: EdgeInsets.all(3),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                color: color_template().select,
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.black
                                                        .withOpacity(0.2),
                                                    spreadRadius: 1,
                                                    blurRadius: 2,
                                                    offset: Offset(0,
                                                        2), // changes position of shadow
                                                  ),
                                                ]),
                                            child: Text(
                                              'Diskon',
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white),
                                            ),
                                          ),
                                        )
                                      : InkWell(
                                          splashColor: color_template().select,
                                          onTap: () {
                                            controller
                                                .editDiskonKasir(controller);
                                          },
                                          child: Container(
                                            padding: EdgeInsets.all(3),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                color: color_template().primary,
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.black
                                                        .withOpacity(0.2),
                                                    spreadRadius: 1,
                                                    blurRadius: 2,
                                                    offset: Offset(0,
                                                        2), // changes position of shadow
                                                  ),
                                                ]),
                                            child: Text(
                                              'Diskon',
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white),
                                            ),
                                          ),
                                        )
                                ],
                              ),
                            )
                          ],
                        );
                      }),
                    ],
                  ),
                ),
              ),
              Obx(() {
                return Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: border_radius().header_border,
                        border: Border.all(color: color_template().primary)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total :',
                          style: font().header_black,
                        ),
                        Text(
                          controller.total.value == 0
                              ? 0.toString()
                              : controller.cache.isEmpty
                                  ? '0'
                                  : 'Rp.' +
                                      controller.nominal
                                          .format(controller.total.value),
                          style: font().header_black,
                        ),
                      ],
                    ));
              }),
              const SizedBox(
                height: 10,
              ),
              button_solid_custom(
                  onPressed: () async {
                    controller.cache.value.isEmpty
                        ? Get.showSnackbar(toast().bottom_snackbar_error(
                            'Gagal', 'Pilih item terlebih dahulu'))
                        : Get.dialog(
                            Stack(
                              children: [
                                Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: context.width_query / 10,
                                        vertical: context.height_query / 10),
                                    child: const kasir_keypad()),
                                Positioned(
                                  top: context.height_query / 14,
                                  left: context.width_query / 12,
                                  child: Material(
                                    borderRadius: BorderRadius.circular(30),
                                    color: color_template().tritadery,
                                    child: IconButton(
                                        onPressed: () {
                                          //TODO : chek kalkulasi harga di crud penjualan

                                          // controller.deletekeranjanglocal(
                                          //     'keranjang_local');
                                          Get.back();
                                        },
                                        icon: const Icon(
                                          FontAwesomeIcons.close,
                                          color: Colors.white,
                                        )),
                                  ),
                                )
                              ],
                            ),
                            barrierDismissible: false);

                    print('--------------pop-------------');
                  },
                  child: Text(
                    'Bayar'.toUpperCase(),
                    style: font().header,
                  ),
                  width: double.infinity,
                  height: context.height_query / 14),
            ],
          ),
        ),
      ),
    );
  }
}
