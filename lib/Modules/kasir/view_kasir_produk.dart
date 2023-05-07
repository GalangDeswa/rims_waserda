import 'package:cached_network_image/cached_network_image.dart';
import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:rims_waserda/Modules/Widgets/card_custom.dart';
import 'package:rims_waserda/Modules/kasir/controller_kasir.dart';

import '../../Templates/setting.dart';
import '../Widgets/buttons.dart';
import '../Widgets/loading.dart';

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
                              controller.fetchProduk();
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
                              controller.fetchProduk();
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
                            controller.jeniscache.value
                                .map((element) => element.namaJenis)
                                .toList(),
                        buttonValues: ['0'] +
                            controller.jeniscache.value
                                .map((element) => element.id.toString())
                                .toList(),
                        buttonTextStyle: ButtonTextStyle(
                            selectedColor: Colors.white,
                            unSelectedColor: Colors.black,
                            textStyle: TextStyle(fontSize: 16)),
                        radioButtonValue: (value) async {
                          if (value == '0') {
                            controller.produklist.value =
                                await GetStorage().read('produk');
                            //controller.nextscroll();
                          } else {
                            print(value + "<-- id jenis cache");
                            await GetStorage().read('produk');
                            controller.fetchProdukByJenis(value);
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
                  return controller.produkcache.isNotEmpty
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
                            width: 30,
                            height: 30,
                            child: showloading(),
                          ));
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
          controller: controller.scroll.value,
          scrollDirection: Axis.vertical,
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              mainAxisExtent: context.height_query / 3.2,
              maxCrossAxisExtent: context.width_query / 5.3,
              childAspectRatio: 1 / 1,
              crossAxisSpacing: 1,
              mainAxisSpacing: 2),
          itemCount: controller.produklist.length,
          itemBuilder: (BuildContext context, index) {
            var query = controller.produkcache.value
                .where((element) => element.id == controller.cache[index].id);

            final existingIndex = controller.cache.value.indexWhere(
                (item) => item.id == controller.produkcache[index].id);
            return GestureDetector(
              onTap: () {
                // controller.tambahKeranjang(
                //     controller.produkcache[index].id.toString(),
                //     0.toString(),
                //     1.toString());

                controller
                    .tambahKeranjangcache(controller.produkcache[index].id);
              },
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
                      child: CachedNetworkImage(
                          placeholder: (context, url) => Container(
                                width: 20,
                                height: 20,
                                child: showloading(),
                              ),
                          width: context.width_query,
                          height: context.height_query,
                          fit: BoxFit.cover,
                          errorWidget: (context, url, error) {
                            return Container(
                              child: Image.asset('assets/images/food.png'),
                            );
                          },
                          imageUrl: controller.produklist[index].image),
                    )),
                    Container(
                      padding: EdgeInsets.all(10),
                      width: context.width_query,
                      height: context.height_query / 10,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                              bottomLeft: Radius.circular(20),
                              bottomRight: Radius.circular(20))),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              overflow: TextOverflow.fade,
                              controller.produklist[index].namaProduk
                                  .toString(),
                              style: font().produktitle,
                            ),
                          ),
                          Expanded(
                              child: controller
                                          .produklist[index].diskonBarang ==
                                      0
                                  ? Text(
                                      'Rp. ' +
                                          controller.nominal.format(
                                              double.parse(controller
                                                  .produklist[index].harga)),
                                      style: font().produkharga,
                                    )
                                  : Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Rp. ' +
                                              controller.nominal.format(
                                                  double.parse(controller
                                                      .produklist[index]
                                                      .diskonBarang
                                                      .toString())),
                                          style: font().produkharga,
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 10),
                                          child: Text(
                                            'Rp. ' +
                                                controller.nominal.format(
                                                    double.parse(controller
                                                        .produklist[index]
                                                        .harga)),
                                            style: TextStyle(
                                                decoration:
                                                    TextDecoration.lineThrough),
                                          ),
                                        )
                                      ],
                                    ))
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
