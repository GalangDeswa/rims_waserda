import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:rims_waserda/Modules/Widgets/card_custom.dart';
import 'package:rims_waserda/Modules/Widgets/toast.dart';
import 'package:rims_waserda/Modules/kasir/controller_kasir.dart';
import 'package:rims_waserda/Modules/kasir/view_kasir_keypad.dart';

import '../../Templates/setting.dart';
import '../Widgets/buttons.dart';

class kasir_detail extends GetView<kasirController> {
  const kasir_detail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card_custom(
      border: false,
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
                    color: Colors.white,
                    border: Border.all(color: color_template().primary)),
                child: Center(
                  child: Obx(() {
                    return Text(
                      controller.bayarprebill.value == false
                          ? 'Keranjang'.toUpperCase()
                          : 'Meja ' +
                              controller.nomormejabayarprebill.toUpperCase(),
                      style: font().header_blue,
                    );
                  }),
                ),
              ),
              Expanded(
                child: Container(
                    //color: Colors.green,
                    padding: EdgeInsets.symmetric(horizontal: 0),
                    child: Obx(() {
                      return ListView.builder(
                          itemCount: controller.cache.length,
                          itemBuilder: (BuildContext context, int index) {
                            var hargadiskon = controller.cache[index].harga! -
                                (controller.cache[index].harga! *
                                    controller.cache[index].diskonBarang! /
                                    100);
                            var persen = controller.cache[index].diskonBarang;
                            String display_diskon = persen!.toStringAsFixed(0);

                            var pp = controller.produklistlocal
                                .where((e) =>
                                    e.idLocal ==
                                    controller.cache[index].idLocal)
                                .first;
                            return Card(
                                surfaceTintColor: Colors.white,
                                elevation: elevation().def_elevation,
                                child: Container(
                                  padding: EdgeInsets.all(5),
                                  height: context.height_query / 7,
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
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Expanded(
                                                    child: Text(
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      controller.cache[index]
                                                          .namaProduk!,
                                                      style: font().reguler,
                                                    ),
                                                  ),
                                                  // IconButton(
                                                  //     onPressed: () {},
                                                  //     icon: Icon(
                                                  //       Icons.edit,
                                                  //       size: context
                                                  //               .height_query /
                                                  //           35,
                                                  //     )),
                                                  IconButton(
                                                      padding: EdgeInsets.zero,
                                                      onPressed: () {
                                                        controller
                                                            .deleteitemcache(
                                                                controller
                                                                    .cache[
                                                                        index]
                                                                    .idLocal!);
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
                                                    child: controller
                                                                .cache[index]
                                                                .diskonBarang ==
                                                            0
                                                        ? Text(
                                                            'Rp.' +
                                                                controller
                                                                    .nominal
                                                                    .format(controller
                                                                        .cache[
                                                                            index]
                                                                        .harga),
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style:
                                                                font().reguler,
                                                          )
                                                        : Row(
                                                            children: [
                                                              Text(
                                                                'Rp. ' +
                                                                    controller
                                                                        .nominal
                                                                        .format(
                                                                            hargadiskon),
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                style: font()
                                                                    .reguler,
                                                              ),
                                                              const SizedBox(
                                                                width: 10,
                                                              ),
                                                              Container(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(3),
                                                                child: Text(
                                                                  display_diskon +
                                                                      '%',
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  style: const TextStyle(
                                                                      fontSize:
                                                                          12,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      color: Colors
                                                                          .white),
                                                                ),
                                                                decoration: BoxDecoration(
                                                                    color: color_template()
                                                                        .primary_v2,
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10)),
                                                              )
                                                            ],
                                                          ),
                                                  ),
                                                  Container(
                                                    margin: EdgeInsets.only(
                                                        right: 5),
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
                                                                .idLocal!);
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
                                                  InkWell(
                                                    splashColor:
                                                        color_template().select,
                                                    onTap: () {
                                                      controller
                                                          .popeditqty(index);
                                                    },
                                                    child: Container(
                                                      width: 45,
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 5,
                                                              vertical: 5),
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          border: Border.all(
                                                              color:
                                                                  color_template()
                                                                      .primary)),
                                                      margin:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 10),
                                                      child: Center(
                                                        heightFactor: 1,
                                                        child: Text(
                                                            controller
                                                                .cache[index]
                                                                .qty
                                                                .toString(),
                                                            style:
                                                                font().reguler),
                                                      ),
                                                    ),
                                                  ),
                                                  controller.cache[index]
                                                                  .qty! >=
                                                              pp.qty! &&
                                                          controller
                                                                  .cache[index]
                                                                  .idJenisStock ==
                                                              1
                                                      ? Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                            left: 5,
                                                          ),
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
                                                              left: 5,
                                                            ),
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
                  //margin: EdgeInsets.only(top: 40),
                  height: context.height_query / 5.0,

                  width: context.width_query,
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  // decoration: BoxDecoration(
                  //     color: color_template().primary,
                  //     borderRadius: border_radius().header_border),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Obx(() {
                        return Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  'Subtotal :',
                                  style: font().reguler,
                                ),
                              ),
                              Text(
                                controller.subtotal.value == ''
                                    ? '0'
                                    : controller.cache.isEmpty
                                        ? '0'
                                        : 'Rp.' +
                                            controller.nominal.format(
                                                controller.subtotal.value),
                                style: font().reguler_bold,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        );
                      }),
                      SizedBox(
                        height: 5,
                      ),
                      Obx(() {
                        return Expanded(
                          child: Row(
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    controller.ppnSwitch.value == true
                                        ? Expanded(
                                            child: Text(
                                              "Rp." +
                                                  controller.nominal.format(
                                                      controller.ppn.value),
                                              style: font().reguler_bold,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          )
                                        : Expanded(
                                            child: Text(
                                              "-",
                                              style: font().reguler_bold,
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
                                ),
                              )
                            ],
                          ),
                        );
                      }),
                      SizedBox(
                        height: 10,
                      ),
                      Expanded(
                        child: Row(
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
                        ),
                      ),
                      // SizedBox(
                      //   height: 10,
                      // ),
                      // Expanded(
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //     children: [
                      //       Expanded(
                      //         child: Text(
                      //           'Nomor meja :',
                      //           style: font().reguler,
                      //         ),
                      //       ),
                      //       Obx(() {
                      //         return Row(
                      //           mainAxisAlignment:
                      //               MainAxisAlignment.spaceBetween,
                      //           children: [
                      //             Text(
                      //               controller.nomor_meja.value,
                      //               style: font().reguler_bold,
                      //               overflow: TextOverflow.ellipsis,
                      //             ),
                      //             Container(
                      //               margin: EdgeInsets.only(left: 10),
                      //               width: 100,
                      //               child: ElevatedButton(
                      //                   onPressed: () {
                      //                     controller.editMejaKasir(controller);
                      //                   },
                      //                   child: Text(
                      //                     'Nomor meja',
                      //                     style: TextStyle(fontSize: 12),
                      //                   )),
                      //             )
                      //           ],
                      //         );
                      //       }),
                      //     ],
                      //   ),
                      // ),
                    ],
                  ),
                );
              }),
              Obx(() {
                return Container(
                    width: context.width_query,
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
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
              Obx(() {
                return controller.bayarprebill.value == false
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: button_solid_custom(
                                onPressed: () async {
                                  controller.cache.value.isEmpty
                                      ? Get.showSnackbar(toast()
                                          .bottom_snackbar_error('Error',
                                              'Pilih item terlebih dahulu'))
                                      : Get.dialog(
                                          Stack(
                                            children: [
                                              Container(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal:
                                                          context.width_query /
                                                              10,
                                                      vertical:
                                                          context.height_query /
                                                              10),
                                                  child: kasir_keypad()),
                                              Positioned(
                                                top: context.height_query / 14,
                                                left: context.width_query / 12,
                                                child: Material(
                                                  borderRadius:
                                                      BorderRadius.circular(30),
                                                  color: color_template()
                                                      .tritadery,
                                                  child: IconButton(
                                                      onPressed: () {
                                                        Get.back();
                                                        controller.groupindex
                                                            .value = 9;
                                                        controller
                                                            .keypadController
                                                            .value
                                                            .clear();
                                                        controller
                                                            .kembalian.value
                                                            .clear();
                                                      },
                                                      icon: Icon(
                                                        FontAwesomeIcons.xmark,
                                                        color: Colors.white,
                                                      )),
                                                ),
                                              )
                                            ],
                                          ),
                                          barrierDismissible: false);

                                  controller.meja.value.text = 'Takeout';
                                  controller.nomor_meja.value = 'Takeout';

                                  print('--------------pop-------------');
                                },
                                child: Text(
                                  'Takeout'.toUpperCase(),
                                  style: font().header,
                                ),
                                width: 100,
                                height: context.height_query / 14),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: button_border_custom(
                                onPressed: () async {
                                  controller.meja.value.clear();
                                  controller.cache.value.isEmpty
                                      ? Get.showSnackbar(toast()
                                          .bottom_snackbar_error('Error',
                                              'Pilih item terlebih dahulu'))
                                      : controller.editMejaKasir(controller);

                                  print('--------------pop-------------');
                                },
                                child: Text(
                                  'open bill'.toUpperCase(),
                                  style: font().header_blue,
                                ),
                                width: 100,
                                height: context.height_query / 14),
                          ),
                        ],
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: button_border_custom(
                                onPressed: () async {
                                  // controller.cache.value.isEmpty
                                  //     ? Get.showSnackbar(toast().bottom_snackbar_error(
                                  //     'Error', 'Pilih item terlebih dahulu'))
                                  //     : Get.dialog(
                                  //     Stack(
                                  //       children: [
                                  //         Container(
                                  //             padding: EdgeInsets.symmetric(
                                  //                 horizontal:
                                  //                 context.width_query / 10,
                                  //                 vertical:
                                  //                 context.height_query / 10),
                                  //             child: kasir_keypad()),
                                  //         Positioned(
                                  //           top: context.height_query / 14,
                                  //           left: context.width_query / 12,
                                  //           child: Material(
                                  //             borderRadius:
                                  //             BorderRadius.circular(30),
                                  //             color: color_template().tritadery,
                                  //             child: IconButton(
                                  //                 onPressed: () {
                                  //                   Get.back();
                                  //                   controller.groupindex.value = 9;
                                  //                   controller
                                  //                       .keypadController.value
                                  //                       .clear();
                                  //                   controller.kembalian.value
                                  //                       .clear();
                                  //                 },
                                  //                 icon: Icon(
                                  //                   FontAwesomeIcons.xmark,
                                  //                   color: Colors.white,
                                  //                 )),
                                  //           ),
                                  //         )
                                  //       ],
                                  //     ),
                                  //     barrierDismissible: false);
                                  //
                                  // controller.meja.value.text = 'Takeout';
                                  // controller.nomor_meja.value = 'Takeout';
                                  controller.cache.clear();
                                  controller.nomormejabayarprebill.value = '';
                                  controller.subtotal.value = 0;
                                  controller.total.value = 0;
                                  controller.jumlahdiskonkasir.value = 0;
                                  controller.displaydiskon.value = 0;
                                  controller.ppn.value = 0;
                                  controller.bayarprebill.value = false;

                                  Get.back();

                                  print('--------------pop-------------');
                                },
                                child: Text(
                                  'Batal'.toUpperCase(),
                                  style: font().header_blue,
                                ),
                                width: 100,
                                height: context.height_query / 14),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: button_solid_custom(
                                onPressed: () async {
                                  controller.cache.value.isEmpty
                                      ? Get.showSnackbar(toast()
                                          .bottom_snackbar_error('Gagal',
                                              'Pilih item terlebih dahulu'))
                                      : Get.dialog(
                                          Stack(
                                            children: [
                                              Container(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal:
                                                          context.width_query /
                                                              10,
                                                      vertical:
                                                          context.height_query /
                                                              10),
                                                  child: const kasir_keypad()),
                                              Positioned(
                                                top: context.height_query / 14,
                                                left: context.width_query / 12,
                                                child: Material(
                                                  borderRadius:
                                                      BorderRadius.circular(30),
                                                  color: color_template()
                                                      .tritadery,
                                                  child: IconButton(
                                                      onPressed: () {
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
                                },
                                child: Text(
                                  'Bayar'.toUpperCase(),
                                  style: font().header,
                                ),
                                width: 100,
                                height: context.height_query / 14),
                          ),
                        ],
                      );
              })
            ],
          ),
        ),
      ),
    );
  }
}
