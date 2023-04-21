import 'package:data_table_2/data_table_2.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rims_waserda/Modules/kasir/model_keranjang_cache.dart';
import 'package:rims_waserda/Modules/produk/data%20produk/model_produk.dart';
import 'package:rims_waserda/Templates/setting.dart';

import '../Widgets/buttons.dart';
import 'controller_kasir.dart';

class list_kasir extends GetView<kasirController> {
  const list_kasir({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Obx(() {
          return Padding(
            padding: const EdgeInsets.only(bottom: 15),
            child: Card(
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
                          child: DropdownSearch<DataProduk>(
                        //asyncItems: (qwe) => controller.fetchProduk(),
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
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                          ),
                        ),

                        items: controller.produkcache.value,

                        onChanged: (value) {
                          controller.tambahKeranjangcache(value!.id);
                          // controller.isikeranjang(value!.kodeProduk.toString());
                          // controller.getkeranjang();
                          //  controller.totalkeranjang();
                          // controller.totalqty();
                          // controller.i++;
                          // print(controller.keranjang_list);
                        },
                        //items: controller.produk_list,
                        itemAsString: (DataProduk u) {
                          return u.namaProduk.toString() + "  Rp. " + u.harga;
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
          );
        }),
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
                  return controller.cache.value.isNotEmpty
                      ? Container(
                          width: context.width_query,
                          padding: EdgeInsets.all(15),
                          // height: context.height_query * 0.70,
                          //: color_template().primary.withOpacity(0.2),
                          //color: Colors.red,
                          child: ProductTilev2(controller.cache.value))
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
    DataProduk item,
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
          leading: Text(item.namaJenis.toString())),
    );
  }
}

class ProductTilev2 extends GetView<kasirController> {
  const ProductTilev2(this.list);

  final List<DataKeranjangCache> list;

  @override
  Widget build(BuildContext context) {
    return DataTable2(
        fixedTopRows: 1,
        horizontalMargin: 10,
        columnSpacing: 5,
        headingRowColor: MaterialStateColor.resolveWith(
            (states) => color_template().primary.withOpacity(0.2)),
        //sortAscending: sort,
        //sortColumnIndex: 0,
        columns: [
          DataColumn(label: Text("Nama produk")),
          DataColumn(label: Text("harga")),
          DataColumn(
              label: Text(
            "QTY",
          )),
          DataColumn(label: Text("Aksi")),
        ],
        rows: List.generate(controller.cache.length, (index) {
          var pp = controller.produklist
              .where((e) => e.id == controller.cache[index].id)
              .first;
          return DataRow(cells: [
            DataCell(
              Text(controller.cache[index].namaProduk),
            ),
            DataCell(
              Text("Rp." +
                  controller.nominal
                      .format(double.parse(controller.cache[index].harga))),
            ),
            DataCell(
              Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: EdgeInsets.only(right: 15),
                    padding: EdgeInsets.all(3),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: color_template().select),
                    child: InkWell(
                      onTap: () {
                        controller.deleteqty(index, controller.cache[index].id);
                      },
                      child: Icon(
                        Icons.remove,
                        color: Colors.white,
                        size: context.height_query / 40,
                      ),
                    ),
                  ),
                  Text(controller.cache[index].qty.toString()),
                  int.parse(pp.qty) <= controller.cache[index].qty &&
                          controller.cache[index].idJenisStock == 1
                      ? Container(
                          margin: EdgeInsets.only(left: 15, right: 15),
                          padding: EdgeInsets.all(3),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: Colors.grey),
                          child: Icon(
                            Icons.add,
                            color: Colors.white,
                            size: context.height_query / 40,
                          ),
                        )
                      : InkWell(
                          onTap: () {
                            controller.tambahqty(index);
                          },
                          child: Container(
                            margin: EdgeInsets.only(left: 15, right: 15),
                            padding: EdgeInsets.all(3),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: color_template().primary),
                            child: Icon(
                              Icons.add,
                              color: Colors.white,
                              size: context.height_query / 40,
                            ),
                          ),
                        )
                ],
              ),
            ),
            DataCell(Container(
              // color: Colors.cyan,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                      onPressed: () {
                        Get.toNamed('/edit_produk',
                            arguments: controller.produklist[index]);
                      },
                      icon: Icon(
                        Icons.edit,
                        size: 18,
                        color: color_template().secondary,
                      )),
                  IconButton(
                      onPressed: () {
                        controller.deleteitemcache(controller.cache[index].id);
                      },
                      icon: Icon(
                        size: context.height_query / 35,
                        Icons.delete,
                        color: color_template().tritadery,
                      )),
                ],
              ),
            ))
          ]);
        }));
  }

  Iterable<DataRow> mapItemToDataRows(List<DataKeranjangCache> items) {
    var pp = controller.produklist
        .where((e) => e.id == items.map((e) => e.id).first)
        .first;
    final List uniqueList = Set.from(items).toList();

    Iterable<DataRow> dataRows = items.map((item) {
      int idx = uniqueList.indexOf(item) + 1;
      return DataRow(cells: [
        DataCell(
          Text(idx.toString()),
        ),
        DataCell(
          Text(item.namaProduk),
        ),
        DataCell(
          Text(
            item.harga.toString(),
          ),
        ),
        DataCell(
          Center(
              // child: Expanded(
              //   child: Row(
              //     crossAxisAlignment:
              //     CrossAxisAlignment.center,
              //     mainAxisAlignment:
              //     MainAxisAlignment
              //         .spaceBetween,
              //     children: [
              //       Container(
              //         margin: EdgeInsets.only(
              //             right: 10),
              //         padding: EdgeInsets.all(3),
              //         decoration: BoxDecoration(
              //             shape: BoxShape.circle,
              //             color: color_template()
              //                 .select),
              //         child: InkWell(
              //           onTap: () {
              //             controller.deleteqty(
              //                 index,
              //                 controller
              //                     .cache[index]
              //                     .id);
              //           },
              //           child: Icon(
              //             Icons.remove,
              //             color: Colors.white,
              //             size: context
              //                 .height_query /
              //                 40,
              //           ),
              //         ),
              //       ),
              //       Text(controller
              //           .cache[index].qty
              //           .toString()),
              //       int.parse(pp.qty) <=
              //           controller
              //               .cache[index]
              //               .qty &&
              //           controller
              //               .cache[index]
              //               .idJenisStock ==
              //               1
              //           ? Container(
              //         margin:
              //         EdgeInsets.only(
              //             left: 10,
              //             right: 10),
              //         padding:
              //         EdgeInsets.all(3),
              //         decoration:
              //         BoxDecoration(
              //             shape: BoxShape
              //                 .circle,
              //             color: Colors
              //                 .grey),
              //         child: Icon(
              //           Icons.add,
              //           color: Colors.white,
              //           size: context
              //               .height_query /
              //               40,
              //         ),
              //       )
              //           : InkWell(
              //         onTap: () {
              //           controller
              //               .tambahqty(
              //               index);
              //         },
              //         child: Container(
              //           margin:
              //           EdgeInsets.only(
              //               left: 10,
              //               right: 10),
              //           padding:
              //           EdgeInsets.all(
              //               3),
              //           decoration: BoxDecoration(
              //               shape: BoxShape
              //                   .circle,
              //               color:
              //               color_template()
              //                   .primary),
              //           child: Icon(
              //             Icons.add,
              //             color:
              //             Colors.white,
              //             size: context
              //                 .height_query /
              //                 40,
              //           ),
              //         ),
              //       )
              //     ],
              //   ),
              // )
              ),
        ),
        DataCell(Row(
          children: [
            IconButton(
                onPressed: () {
                  // controller.deletekeranjang(item.kodeProduk);
                },
                icon: Icon(Icons.delete))
          ],
        )),
      ]);
    });
    return dataRows;
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
