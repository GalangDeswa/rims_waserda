import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:rims_waserda/Models/produkv2.dart';

import '../../Controllers/Templates/setting.dart';
import '../../Controllers/kasir controller/kasir_controller.dart';
import '../../Models/produk.dart';

import '../../Models/testmodel.dart';
import '../Widgets/buttons.dart';
import 'package:dropdown_search/dropdown_search.dart';

class list_kasir extends GetView<kasirController> {
  const list_kasir({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Card(
          //color: Colors.red,
          elevation: elevation().def_elevation,
          shape: RoundedRectangleBorder(
            borderRadius: border_radius().def_border,
            side: BorderSide(color: color_template().primary, width: 3.5),
          ),
          // margin: EdgeInsets.only(left: 5, top: 10, bottom: 10, right: 10),
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                icon_button_custom(
                    onPressed: () {
                      controller.scankasir();
                    },
                    icon: Icons.qr_code_scanner,
                    container_color: color_template().primary),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Container(
                      //color: Colors.red,
                      //width: context.width_query * 0.60,
                      //pakai string bisa di cari tp tidak bisa lengkap?
                      child: DropdownSearch<ProdukElement>(
                    asyncItems: (qwe) => controller.getprodukall(),
                    //asyncItems: (qwe) => api.getproduct(),
                    //  compareFn: (i, s) => i.isEqual(s),
                    popupProps: PopupProps.menu(
                      showSelectedItems: false,
                      showSearchBox: true,
                      itemBuilder: customPopupItemBuilderExample2,
                      // favoriteItemProps: FavoriteItemProps(
                      //   showFavoriteItems: true,
                      //   favoriteItems: (us) {
                      //     return us
                      //         .where((e) => e.namaProduk.contains("mie"))
                      //         .toList();
                      //   },
                      // ),
                    ),

                    dropdownDecoratorProps: DropDownDecoratorProps(
                      dropdownSearchDecoration: InputDecoration(
                        labelText: "scan barcode/cari nama produk",
                      ),
                    ),

                    //items: controller.productlist.map((e) => e.name).toList(),

                    onChanged: (value) {
                      controller.isikeranjang(value!.kodeProduk.toString());
                      controller.getkeranjang();
                      controller.totalkeranjang();
                      controller.totalqty();
                      controller.i++;
                      print(controller.keranjang_list);
                    },
                    //items: controller.produk_list,
                    itemAsString: (ProdukElement u) {
                      return u.kodeProduk.toString() + "   " + u.namaProduk!;
                    },
                  )),
                ),
                // icon_button_custom(
                //     onPressed: () {
                //       Get.toNamed('/tambah_user');
                //     },
                //     icon: Icons.person_add,
                //     container_color: color_template().primary),

                /* Container(
                  width: context.width_query * 0.04,
                  child: TextField(
                    decoration: InputDecoration(hintText: 'Tambah user'),
                  ),
                )*/
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: Row(
            children: [
              Obx(() {
                return Expanded(
                  child: Container(
                    margin: EdgeInsets.only(left: 5),
                    //color: Colors.blue,
                    height: 35,
                    width: context.width_query * 0.60,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: controller.num.value,
                        itemBuilder: (BuildContext context, int index) {
                          var indexx = index + 1;
                          return Container(
                            margin: EdgeInsets.symmetric(horizontal: 3),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  indexx.toString(),
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                                Icon(
                                  Icons.shopping_cart,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                            height: 35,
                            width: 55,
                            decoration: BoxDecoration(
                                color: color_template().primary,
                                borderRadius: BorderRadius.circular(5)),
                          );
                        }),
                  ),
                );
              }),
              icon_button_circle_custom(
                  onPressed: () {
                    controller.addlist();
                  },
                  icon: Icons.add,
                  container_color: color_template().primary)
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
                  return controller.keranjang_list.isNotEmpty
                      ? Container(
                          width: context.width_query,
                          // height: context.height_query * 0.70,
                          //: color_template().primary.withOpacity(0.2),
                          //color: Colors.red,
                          child: SingleChildScrollView(
                              child: ProductTilev2(controller.keranjang_list)))
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

  Future<List<UserModel>> getData() async {
    var response = await Dio().get(
      "https://5d85ccfb1e61af001471bf60.mockapi.io/user",
    );

    final data = response.data;
    if (data != null) {
      return UserModel.fromJsonList(data);
    }

    return [];
  }
}

/*
DropdownSearch<String>(
popupProps: PopupProps.menu(
showSearchBox: true,
showSelectedItems: false,
),
dropdownDecoratorProps: DropDownDecoratorProps(
dropdownSearchDecoration: InputDecoration(
labelText: "scan barcode/cari nama produk",
),
),
items: controller.productlist.map((e) => e.name).toList(),
onChanged: (value) {
controller.listbaru.add(value);
print(value);
print(controller.listbaru);
},
)*/
