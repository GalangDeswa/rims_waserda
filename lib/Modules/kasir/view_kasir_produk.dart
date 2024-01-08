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
                            onChanged: ((String pass) async {
                              await controller
                                  .searchproduklocal(controller.id_toko);
                            }),
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 0, horizontal: 10),
                              labelText: "Cari produk",
                              hintText: 'nama produk',
                              border: InputBorder.none,
                              labelStyle: TextStyle(
                                color: Colors.black87,
                              ),
                            ),
                            textAlign: TextAlign.start,
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
                            onPressed: () async {
                              await controller
                                  .fetchProduklocal(controller.id_toko);
                              await controller.fetchmeja();
                            },
                            icon: Icons.refresh,
                            container_color: color_template().primary),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Obx(() {
              return controller.bayarprebill.value == false
                  ? Stack(
                      children: [
                        Container(
                          width: context.width_query / 11,
                          child: Card_custom(
                            border: false,
                            child: Padding(
                                padding: const EdgeInsets.all(3),
                                child: IconButton(
                                  onPressed: () {
                                    controller.listMejaKasir(controller);
                                  },
                                  icon: Icon(Icons.receipt_long),
                                )),
                          ),
                        ),
                        Obx(() {
                          return controller.cachemeja.isEmpty
                              ? Container()
                              : Container(
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: color_template().select),
                                  padding: EdgeInsets.all(10),
                                  child: Text(
                                    controller.cachemeja.length.toString(),
                                    style: font().reguler_white_bold,
                                  ),
                                );
                        }),
                      ],
                    )
                  : Container();
            })
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
                                .map((element) => element.idLocal.toString())
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
      padding: EdgeInsets.all(10),
      height: context.height_query,
      child: GridView.builder(
          //controller: controller.scroll.value,
          scrollDirection: Axis.vertical,
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              mainAxisExtent: context.height_query / 3.0,
              maxCrossAxisExtent: context.width_query / 5.0,
              childAspectRatio: 1 / 1,
              crossAxisSpacing: 3,
              mainAxisSpacing: 3),
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
                          controller.produklistlocal[index].idLocal!);
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
                                  height: context.height_query / 9,
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
                                                  Text(
                                                    'Rp. ' +
                                                        controller.nominal
                                                            .format(
                                                                hargadiskon),
                                                    style: font().produkharga,
                                                  ),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  Container(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        vertical: 3,
                                                        horizontal: 5),
                                                    child: Text(
                                                      display_diskon + '%',
                                                      style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.white,
                                                          fontSize: 12),
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
                          controller.produklistlocal[index].idLocal!);
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
                                              fit: BoxFit.cover,
                                            ),
                                          ))),
                            Container(
                              padding: EdgeInsets.all(10),
                              width: context.width_query,
                              height: context.height_query / 9,
                              decoration: BoxDecoration(

                                  // color: Colors.red,
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
                                                        .produklistlocal[index]
                                                        .harga),
                                            style: font().produkharga,
                                          )
                                        : Row(
                                            children: [
                                              Text(
                                                'Rp. ' +
                                                    controller.nominal
                                                        .format(hargadiskon),
                                                style: font().produkharga,
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 3,
                                                        horizontal: 5),
                                                child: Text(
                                                  display_diskon + '%',
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white,
                                                      fontSize: 12),
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
