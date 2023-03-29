import 'package:cached_network_image/cached_network_image.dart';
import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rims_waserda/Modules/kasir/controller_kasir.dart';

import '../../Models/produkv2.dart';
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
              child: Card(
                //color: Colors.red,
                elevation: elevation().def_elevation,
                shape: RoundedRectangleBorder(
                  borderRadius: border_radius().def_border,
                  side: BorderSide(color: color_template().primary, width: 3.5),
                ),
                // margin: EdgeInsets.only(left: 5, top: 10, bottom: 10, right: 10),
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
                              labelText: "cari produk",
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
              child: Card(
                //color: Colors.red,
                elevation: elevation().def_elevation,
                shape: RoundedRectangleBorder(
                  borderRadius: border_radius().def_border,
                  side: BorderSide(color: color_template().primary, width: 3.5),
                ),
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
                            controller.jenislist
                                .map((element) => element.namaJenis)
                                .toList(),
                        buttonValues: ['0'] +
                            controller.jenislist
                                .map((element) => element.id.toString())
                                .toList(),
                        buttonTextStyle: ButtonTextStyle(
                            selectedColor: Colors.white,
                            unSelectedColor: Colors.black,
                            textStyle: TextStyle(fontSize: 16)),
                        radioButtonValue: (value) {
                          value == '0'
                              ? controller.fetchProduk()
                              : controller.fetchProdukByJenis(value);
                          print(value);
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
          child: Card(
              elevation: elevation().def_elevation,
              shape: RoundedRectangleBorder(
                borderRadius: border_radius().def_border,
                side: BorderSide(color: color_template().primary, width: 3.5),
              ),
              // color: Colors.red,
              child: Obx(
                () {
                  return controller.produklist.isNotEmpty
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
                          child: Icon(
                            Icons.add_shopping_cart,
                            color: color_template().primary,
                            size: 100,
                          ));
                },
              )),
        )
      ],
    );
  }
}

Widget customPopupItemBuilderExample2(
  BuildContext context,
  ProdukElement item,
  bool isSelected,
) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 8),
    decoration: !isSelected
        ? null
        : BoxDecoration(
            border: Border.all(color: Theme.of(context).primaryColor),
            borderRadius: BorderRadius.circular(5),
            color: Colors.white,
          ),
    child: ListTile(
        selected: isSelected,
        title: Text(item.namaProduk),
        subtitle: Text('Rp' + ' ' + item.harga.toString()),
        leading: Text(item.barcode.toString())),
  );
}

class ProductTilev2 extends GetView<kasirController> {
  const ProductTilev2();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      height: context.height_query,
      child: GridView.builder(
          // physics: AlwaysScrollableScrollPhysics(),
          scrollDirection: Axis.vertical,
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              mainAxisExtent: context.height_query / 3.5,
              maxCrossAxisExtent: context.width_query / 6,
              childAspectRatio: 1 / 1,
              crossAxisSpacing: 0,
              mainAxisSpacing: 0),
          itemCount: controller.produklist.length,
          itemBuilder: (BuildContext context, index) {
            return GestureDetector(
              onTap: () {
                controller.tambahKeranjang(
                    controller.produklist[index].id.toString(),
                    0.toString(),
                    1.toString());
              },
              child: Card(
                margin: EdgeInsets.all(8),
                shape: RoundedRectangleBorder(
                  borderRadius: border_radius().def_border,
                  side: BorderSide(color: color_template().primary, width: 2),
                ),
                elevation: 5,
                child: Container(
                  padding: EdgeInsets.all(10),
                  //color: Colors.orange,
                  //width: context.width_query,

                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                          child: Container(
                              decoration: BoxDecoration(
                                borderRadius: border_radius().def_border,
                              ),
                              child: CachedNetworkImage(
                                  placeholder: (context, url) => Container(
                                        width: 100,
                                        height: 100,
                                        child: showloading(),
                                      ),
                                  width: context.width_query,
                                  fit: BoxFit.cover,
                                  errorWidget: (context, url, error) {
                                    return Container(
                                      child:
                                          Image.asset('assets/images/food.png'),
                                    );
                                  },
                                  imageUrl:
                                      controller.produklist[index].image))),
                      Container(
                        width: context.width_query,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              controller.produklist[index].namaProduk,
                              style: font().header_black,
                            ),
                            Text(
                              controller.produklist[index].harga,
                              style: font().reguler,
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
