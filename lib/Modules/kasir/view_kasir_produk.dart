import 'dart:convert';

import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:rims_waserda/Modules/Widgets/card_custom.dart';
import 'package:rims_waserda/Modules/kasir/controller_kasir.dart';

import '../../Templates/setting.dart';
import '../Widgets/buttons.dart';

class kasir_produk extends GetView<kasirController> {
  const kasir_produk({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Card_custom(
                border: false,
                child: Padding(
                  padding: const EdgeInsets.all(3),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(right: 10, left: 10),
                          //color: Colors.red,
                          //width: context.width_query * 0.60,
                          //pakai string bisa di cari tp tidak bisa lengkap?
                          child: TextFormField(
                            controller: controller.search.value,
                            onChanged: ((String pass) {
                              controller.searchproduklocal();
                            }),
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(10),
                              labelText: "Cari produk",
                              border: InputBorder.none,
                              labelStyle: TextStyle(
                                color: Colors.black87,
                              ),
                            ),
                            textAlign: TextAlign.center,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter email';
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 5),
                        child: icon_button_custom(
                            onPressed: () {
                              controller.searchproduklocal();
                            },
                            icon: Icons.search,
                            container_color: color_template().primary),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              width: context.width_query / 10,
              child: Card_custom(
                border: false,
                //color: Colors.red,

                // margin: EdgeInsets.only(left: 5, top: 10, bottom: 10, right: 10),
                child: Padding(
                  padding: const EdgeInsets.all(3),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(right: 10, left: 10),
                          //color: Colors.red,
                          //width: context.width_query * 0.60,
                          //pakai string bisa di cari tp tidak bisa lengkap?
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            controller: controller.meja.value,
                            onChanged: ((String pass) {
                              controller.fetchProduk();
                            }),
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(10),
                              labelText: 'Meja',
                              border: InputBorder.none,
                              labelStyle: TextStyle(
                                color: Colors.black87,
                              ),
                            ),
                            textAlign: TextAlign.center,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter email';
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 6),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Obx(() {
                return Expanded(
                  child: Container(
                      height: context.height_query / 15,
                      // width: context.width_query * 0.60,
                      child: CustomRadioButton(
                        //enableButtonWrap: true,
                        autoWidth: true,
                        wrapAlignment: WrapAlignment.start,
                        elevation: 1,
                        absoluteZeroSpacing: false,
                        unSelectedColor: Theme.of(context).canvasColor,
                        buttonLables: ['semua'] +
                            controller.jenislistlocal
                                .map((element) => element.namaJenis!)
                                .toList(),
                        buttonValues: ['0'] +
                            controller.jenislistlocal.value
                                .map((element) => element.id.toString())
                                .toList(),
                        buttonTextStyle: ButtonTextStyle(
                            selectedColor: Colors.white,
                            unSelectedColor: Colors.black,
                            textStyle: TextStyle(fontSize: 16)),
                        radioButtonValue: (value) async {
                          if (value == '0') {
                            await controller
                                .fetchProduklocal(controller.id_toko);
                          } else {
                            await controller.fetchProduklocalbyjenis(
                                controller.id_toko, value);
                            print(value);
                            // print('lengt------------------------------------>');
                            // print(x.length);
                          }
                        },
                        enableShape: true,
                        padding: 100,
                        selectedBorderColor: Colors.transparent,
                        unSelectedBorderColor: Colors.transparent,
                        selectedColor: color_template().select,
                        defaultSelected: '0',
                      )),
                );
              }),
            ],
          ),
        ),
        Expanded(
          child: Card_custom(
              border: false,

              // color: Colors.red,
              child: Obx(
                () {
                  return controller.succ.value != false &&
                          controller.produklistlocal.isNotEmpty
                      ? Container(
                          width: context.width_query,
                          // height: context.height_query * 0.70,
                          //: color_template().primary.withOpacity(0.2),
                          //color: Colors.red,
                          child: ProductTilev2())
                      : Container(
                          width: context.width_query,
                          //height: context.height_query,
                          //margin: EdgeInsets.all(300),
                          //color: color_template().primary.withOpacity(0.2),
                          //color: Colors.red,
                          child: Container(
                              child: Icon(
                            FontAwesomeIcons.cartShopping,
                            color: color_template().primary,
                            size: 100,
                          )));
                },
              )),
        )
      ],
    );
  }
}

class ProductTilev2 extends GetView<kasirController> {
  const ProductTilev2();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      height: context.height_query,
      child: GridView.builder(
          //controller: controller.scroll.value,
          scrollDirection: Axis.vertical,
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              mainAxisExtent: context.height_query / 3.2,
              maxCrossAxisExtent: context.width_query / 5.3,
              childAspectRatio: 1 / 1,
              crossAxisSpacing: 3,
              mainAxisSpacing: 2),
          itemCount: controller.produklistlocal.length,
          itemBuilder: (BuildContext context, index) {
            var hargadiskon = controller.produklistlocal[index].harga! -
                (controller.produklistlocal[index].harga! *
                    controller.produklistlocal[index].diskonBarang! /
                    100);
            var persen = controller.produklistlocal[index].diskonBarang;
            String display_diskon = persen!.toStringAsFixed(0);

            var query = controller.produklistlocal.value
                .where((element) => element.id == controller.cache[index].id);

            final existingIndex = controller.cache.value.indexWhere(
                (item) => item.id == controller.produklistlocal[index].id);

            return controller.produklistlocal[index].qty == 0 &&
                    controller.produklistlocal[index].idJenisStock == 1
                ? GestureDetector(
                    onTap: () {
                      // controller.tambahKeranjang(
                      //     controller.produklistlocal[index].id.toString(),
                      //     0.toString(),
                      //     1.toString());

                      controller.tambahKeranjangcache(
                          controller.produklistlocal[index].id!);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Stack(
                        children: [
                          Card_custom(
                            border: false,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(20),
                                            topLeft: Radius.circular(20)),
                                        child: controller.produklistlocal[index]
                                                        .image ==
                                                    null ||
                                                controller
                                                        .produklistlocal[index]
                                                        .image ==
                                                    '' ||
                                                controller
                                                        .produklistlocal[index]
                                                        .image ==
                                                    '-'
                                            ? Image.asset(
                                                'assets/images/food.png',
                                                fit: BoxFit.contain,
                                              )
                                            : Container(
                                                width: context.width_query,
                                                child: Image.memory(
                                                  base64Decode(controller
                                                      .produklistlocal[index]
                                                      .image!),
                                                  fit: BoxFit.cover,
                                                ),
                                              ))),
                                Container(
                                  padding: EdgeInsets.all(10),
                                  width: context.width_query,
                                  height: context.height_query / 8.5,
                                  decoration: BoxDecoration(
                                      //  color: Colors.red,
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(0),
                                          topRight: Radius.circular(0),
                                          bottomLeft: Radius.circular(20),
                                          bottomRight: Radius.circular(20))),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          overflow: TextOverflow.ellipsis,
                                          controller
                                              .produklistlocal[index].namaProduk
                                              .toString(),
                                          style: font().produktitle,
                                        ),
                                      ),
                                      Expanded(
                                        child: controller.produklistlocal[index]
                                                    .diskonBarang ==
                                                0
                                            ? Text(
                                                'Rp. ' +
                                                    controller.nominal.format(
                                                        controller
                                                            .produklistlocal[
                                                                index]
                                                            .harga),
                                                style: font().produkharga,
                                              )
                                            : Row(
                                                children: [
                                                  Text('Rp. ' +
                                                      controller.nominal
                                                          .format(hargadiskon)),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  Container(
                                                    padding:
                                                        const EdgeInsets.all(6),
                                                    child: Text(
                                                      display_diskon + '%',
                                                      style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.white),
                                                    ),
                                                    decoration: BoxDecoration(
                                                        color: color_template()
                                                            .primary_v2,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10)),
                                                  )
                                                ],
                                              ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: color_template()
                                    .primary_dark
                                    .withOpacity(0.5),
                                borderRadius: border_radius().def_border),
                            child: Center(
                                child: Text(
                              'Stock habis',
                              style: font().header,
                            )),
                          ),
                        ],
                      ),
                    ),
                  )
                : GestureDetector(
                    onTap: () {
                      // controller.tambahKeranjang(
                      //     controller.produklistlocal[index].id.toString(),
                      //     0.toString(),
                      //     1.toString());

                      controller.tambahKeranjangcache(
                          controller.produklistlocal[index].id!);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Card_custom(
                        border: false,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                                child: ClipRRect(
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(20),
                                        topLeft: Radius.circular(20)),
                                    child: controller.produklistlocal[index]
                                                    .image ==
                                                null ||
                                            controller.produklistlocal[index]
                                                    .image ==
                                                '' ||
                                            controller.produklistlocal[index]
                                                    .image ==
                                                '-'
                                        ? Image.asset(
                                            'assets/images/food.png',
                                            fit: BoxFit.cover,
                                          )
                                        : Container(
                                            width: context.width_query,
                                            child: Image.memory(
                                              base64Decode(controller
                                                  .produklistlocal[index]
                                                  .image!),
                                              fit: BoxFit.contain,
                                            ),
                                          ))),
                            Container(
                              padding: EdgeInsets.all(10),
                              width: context.width_query,
                              height: context.height_query / 8.5,
                              decoration: BoxDecoration(
                                  //  color: Colors.red,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(0),
                                      topRight: Radius.circular(0),
                                      bottomLeft: Radius.circular(20),
                                      bottomRight: Radius.circular(20))),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Text(
                                      overflow: TextOverflow.fade,
                                      controller
                                          .produklistlocal[index].namaProduk
                                          .toString(),
                                      style: font().produktitle,
                                    ),
                                  ),
                                  Expanded(
                                    child: controller.produklistlocal[index]
                                                .diskonBarang ==
                                            0
                                        ? Text(
                                            'Rp. ' +
                                                controller.nominal.format(
                                                    controller
                                                        .produklistlocal[index]
                                                        .harga),
                                            style: font().produkharga,
                                          )
                                        : Row(
                                            children: [
                                              Text('Rp. ' +
                                                  controller.nominal
                                                      .format(hargadiskon)),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Container(
                                                padding:
                                                    const EdgeInsets.all(6),
                                                child: Text(
                                                  display_diskon + '%',
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white),
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
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
          }),
    );
  }
}
