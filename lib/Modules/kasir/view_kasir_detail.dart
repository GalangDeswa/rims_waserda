import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:rims_waserda/Modules/kasir/controller_kasir.dart';
import 'package:rims_waserda/Modules/kasir/view_kasir_keypad.dart';

import '../../Templates/setting.dart';
import '../Widgets/buttons.dart';

class kasir_detail extends GetView<kasirController> {
  const kasir_detail({Key? key}) : super(key: key);

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
          //color: Colors.red,
          width: context.width_query / 3.8,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 10),
                padding: EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  borderRadius: border_radius().header_border,
                  color: color_template().primary,
                ),
                child: Center(
                  child: Text(
                    'Keranjang',
                    style: font().header,
                  ),
                ),
              ),
              Expanded(
                child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 0),
                    child: Obx(() {
                      return ListView.builder(
                          itemCount: controller.cache.length,
                          itemBuilder: (BuildContext context, int index) {
                            var pp = controller.produklist
                                .where(
                                    (e) => e.id == controller.cache[index].id)
                                .first;
                            return Card(
                                elevation: elevation().def_elevation,
                                child: Container(
                                  height: context.height_query / 8,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Expanded(
                                                    child: Text(controller
                                                        .cache[index]
                                                        .namaProduk),
                                                  ),
                                                  IconButton(
                                                      onPressed: () {},
                                                      icon: Icon(
                                                        Icons.edit,
                                                        size: context
                                                                .height_query /
                                                            35,
                                                      )),
                                                  IconButton(
                                                      onPressed: () {
                                                        controller
                                                            .deleteitemcache(
                                                                controller
                                                                    .cache[
                                                                        index]
                                                                    .id);
                                                      },
                                                      icon: Icon(
                                                        size: context
                                                                .height_query /
                                                            35,
                                                        Icons.delete,
                                                        color: color_template()
                                                            .tritadery,
                                                      )),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Expanded(
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Expanded(
                                                    child: Text('Rp.' +
                                                        controller.nominal
                                                            .format(double.parse(
                                                                controller
                                                                    .cache[
                                                                        index]
                                                                    .harga))),
                                                  ),
                                                  Container(
                                                    margin: EdgeInsets.only(
                                                        right: 10),
                                                    padding: EdgeInsets.all(3),
                                                    decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        color: color_template()
                                                            .select),
                                                    child: InkWell(
                                                      onTap: () {
                                                        controller.deleteqty(
                                                            index,
                                                            controller
                                                                .cache[index]
                                                                .id);
                                                      },
                                                      child: Icon(
                                                        Icons.remove,
                                                        color: Colors.white,
                                                        size: context
                                                                .height_query /
                                                            40,
                                                      ),
                                                    ),
                                                  ),
                                                  Text(controller
                                                      .cache[index].qty
                                                      .toString()),
                                                  int.parse(pp.qty) <=
                                                              controller
                                                                  .cache[index]
                                                                  .qty &&
                                                          controller
                                                                  .cache[index]
                                                                  .idJenisStock ==
                                                              1
                                                      ? Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                                  left: 10,
                                                                  right: 10),
                                                          padding:
                                                              EdgeInsets.all(3),
                                                          decoration:
                                                              BoxDecoration(
                                                                  shape: BoxShape
                                                                      .circle,
                                                                  color: Colors
                                                                      .grey),
                                                          child: Icon(
                                                            Icons.add,
                                                            color: Colors.white,
                                                            size: context
                                                                    .height_query /
                                                                40,
                                                          ),
                                                        )
                                                      : InkWell(
                                                          onTap: () {
                                                            controller
                                                                .tambahqty(
                                                                    index);
                                                          },
                                                          child: Container(
                                                            margin:
                                                                EdgeInsets.only(
                                                                    left: 10,
                                                                    right: 10),
                                                            padding:
                                                                EdgeInsets.all(
                                                                    3),
                                                            decoration: BoxDecoration(
                                                                shape: BoxShape
                                                                    .circle,
                                                                color:
                                                                    color_template()
                                                                        .primary),
                                                            child: Icon(
                                                              Icons.add,
                                                              color:
                                                                  Colors.white,
                                                              size: context
                                                                      .height_query /
                                                                  40,
                                                            ),
                                                          ),
                                                        )
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ));
                          });
                    })),
              ),
              Obx(() {
                return Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  // decoration: BoxDecoration(
                  //     color: color_template().primary,
                  //     borderRadius: border_radius().header_border),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Subtotal :',
                            style: font().reguler,
                          ),
                          Text(
                            controller.subtotal.value == ''
                                ? '0'
                                : controller.cache.isEmpty
                                    ? '0'
                                    : 'Rp.' +
                                        controller.nominal
                                            .format(controller.subtotal.value),
                            style: font().reguler,
                          ),
                        ],
                      ),
                      // Row(
                      //   children: [
                      //     Expanded(
                      //       child: Text(
                      //         'Diskon :',
                      //         style: font().reguler,
                      //       ),
                      //     ),
                      //     Text(
                      //       controller.subtotal.value.toString(),
                      //       style: font().reguler,
                      //     ),
                      //   ],
                      // ),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              'Diskon :',
                              style: font().reguler,
                            ),
                          ),
                          Text(
                            controller.displayDiskon().toStringAsFixed(0) + '%',
                            style: font().reguler,
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }),
              Obx(() {
                return Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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

              SizedBox(
                height: 10,
              ),
              button_solid_custom(
                  onPressed: () async {
                    var x = await controller.tambahKeranjang();
                    if (x != null) {
                      Get.dialog(
                          Stack(
                            children: [
                              Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: context.width_query / 10,
                                      vertical: context.height_query / 10),
                                  child: kasir_keypad()),
                              Positioned(
                                top: context.height_query / 14,
                                left: context.width_query / 12,
                                child: Material(
                                  borderRadius: BorderRadius.circular(30),
                                  color: color_template().tritadery,
                                  child: IconButton(
                                      onPressed: () {
                                        Get.back();
                                      },
                                      icon: Icon(
                                        FontAwesomeIcons.close,
                                        color: Colors.white,
                                      )),
                                ),
                              )
                            ],
                          ),
                          barrierDismissible: false);
                    }

                    print('--------------pop-------------');
                  },
                  child: Text(
                    'Bayar',
                    style: font().header,
                  ),
                  width: double.infinity,
                  height: context.height_query / 14),

              // button_border_custom(
              //     onPressed: () {
              //       Get.snackbar(
              //         "Pesan",
              //         "Di tunda",
              //         icon: Icon(Icons.dangerous, color: Colors.white),
              //         snackPosition: SnackPosition.BOTTOM,
              //         backgroundColor: color_template().tritadery,
              //       );
              //     },
              //     child: Text(
              //       'Tunda',
              //       style: TextStyle(fontSize: 20, color: Colors.black),
              //     ),
              //     width: double.infinity,
              //     height: 50)
            ],
          ),
        ),
      ),
    );
  }
}
