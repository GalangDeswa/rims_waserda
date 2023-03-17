import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../../Templates/setting.dart';
import '../../Widgets/buttons.dart';
import '../../Widgets/header.dart';
import 'controller_data_produk.dart';

class produk_table extends GetView<produkController> {
  const produk_table({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: elevation().def_elevation,
      //margin: EdgeInsets.all(30),
      shape: RoundedRectangleBorder(
        borderRadius: border_radius().def_border,
        side: BorderSide(color: color_template().primary, width: 3.5),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 50),
                      child: header(
                        title: 'List produk',
                        icon: Icons.add_box,
                      ),
                    ),
                  ),
                  button_solid_custom(
                      onPressed: () {
                        Get.toNamed('/tambah_produk');
                      },
                      child: Text(
                        'tambah produk',
                        style: font().header,
                      ),
                      width: context.width_query * 0.2,
                      height: 55)
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 3),
                    //width: 200,
                    child: TextFormField(
                      //controller: email,
                      onChanged: ((String pass) {}),
                      decoration: InputDecoration(
                        icon: Icon(Icons.add_box),
                        labelText: "cari produk",
                        labelStyle: TextStyle(
                          color: Colors.black87,
                        ),
                        border: UnderlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
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
                icon_button_custom(
                    onPressed: () {
                      controller.getprodukall();
                    },
                    icon: Icons.search,
                    container_color: color_template().primary),
              ],
            ),
            Container(
              height: context.height_query * 0.46,
              margin: EdgeInsets.only(top: 15),
              width: double.infinity,
              child: SingleChildScrollView(
                child: Obx(() {
                  return DataTable(
                      columns: const <DataColumn>[
                        DataColumn(
                          label: Expanded(
                            child: Text(
                              'kode',
                              style: TextStyle(fontStyle: FontStyle.italic),
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Expanded(
                            child: Text(
                              'nama produk',
                              style: TextStyle(fontStyle: FontStyle.italic),
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Expanded(
                            child: Text(
                              'jenis',
                              style: TextStyle(fontStyle: FontStyle.italic),
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Expanded(
                            child: Text(
                              'kategori',
                              style: TextStyle(fontStyle: FontStyle.italic),
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Expanded(
                            child: Text(
                              'Harga',
                              style: TextStyle(fontStyle: FontStyle.italic),
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Expanded(
                            child: Text(
                              'Stock',
                              style: TextStyle(fontStyle: FontStyle.italic),
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Expanded(
                            child: Center(
                              child: Text(
                                'Aksi',
                                style: TextStyle(fontStyle: FontStyle.italic),
                              ),
                            ),
                          ),
                        ),
                      ],
                      rows:
                          List.generate(controller.produk_list.length, (index) {
                        return DataRow(cells: [
                          DataCell(Container(
                              child:
                                  Text(controller.produk_list[index].barcode))),
                          DataCell(Container(
                              child: Text(
                                  controller.produk_list[index].namaProduk))),
                          DataCell(Container(
                              child: Text(
                                  controller.produk_list[index].jenisProduk))),
                          DataCell(Container(
                              child: Text(
                                  controller.produk_list[index].kategori))),
                          DataCell(Container(
                              child:
                                  Text(controller.produk_list[index].harga))),
                          DataCell(Container(
                              child:
                                  Text(controller.produk_list[index].stock))),
                          DataCell(Row(
                            children: [
                              IconButton(
                                  onPressed: () {
                                    // print('qweqweqwe');
                                    // Get.toNamed('/detail_produk');
                                  },
                                  icon: Icon(
                                    Icons.ballot,
                                    size: 18,
                                  )),
                              IconButton(
                                  onPressed: () {
                                    Get.toNamed('/detail_produk');
                                  },
                                  icon: Icon(
                                    Icons.edit,
                                    size: 18,
                                  )),
                              IconButton(
                                  onPressed: () {},
                                  icon: Icon(Icons.delete, size: 18))
                            ],
                          ))
                        ]);
                      }));
                }),
              ),
            ),
            SizedBox(
              height: 15,
            )
          ],
        ),
      ),
    );
  }
}
