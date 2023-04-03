import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rims_waserda/Modules/produk/data%20produk/model_produk.dart';

import '../../../Templates/setting.dart';
import '../../Widgets/buttons.dart';
import '../../Widgets/header.dart';
import '../../Widgets/popup.dart';
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
                        iscenter: false,
                        title: 'List produk',
                        icon: Icons.add_box,
                        icon_funtion: Icons.refresh,
                        function: () {
                          controller.onInit();

                          print('-----snack------');
                        },
                      ),
                    ),
                  ),
                  button_solid_custom(
                      onPressed: () {
                        Get.toNamed('/tambah_produk');

                        // Get.dialog(SingleChildScrollView(
                        //   child: AlertDialog(
                        //       elevation: 0,
                        //       backgroundColor: Colors.transparent,
                        //       content: Center(
                        //         child: Container(
                        //             width: context.width_query / 1.3,
                        //             child: tambah_produk_form()),
                        //       )),
                        // ));
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
                Obx(() {
                  return Expanded(
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 3),
                      //width: 200,
                      child: TextFormField(
                        controller: controller.search.value,
                        onChanged: ((String pass) {
                          controller.fetchProduk();
                        }),
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
                  );
                }),
                icon_button_custom(
                    onPressed: () {
                      controller.fetchProduk();
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
                              'Nama Produk',
                              style: TextStyle(fontStyle: FontStyle.italic),
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Expanded(
                            child: Text(
                              'Jenis produk',
                              style: TextStyle(fontStyle: FontStyle.italic),
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Expanded(
                            child: Text(
                              'Desc',
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
                            child: Text(
                              'Harga',
                              style: TextStyle(fontStyle: FontStyle.italic),
                            ),
                          ),
                        ),
                        // DataColumn(
                        //   label: Expanded(
                        //     child: Text(
                        //       'img',
                        //       style: TextStyle(fontStyle: FontStyle.italic),
                        //     ),
                        //   ),
                        // ),
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
                          List.generate(controller.produklist.length, (index) {
                        return DataRow(cells: [
                          DataCell(Container(
                              child: Text(
                                  controller.produklist[index].namaProduk))),
                          DataCell(Container(
                              child: Text(
                                  controller.produklist[index].namaJenis))),

                          DataCell(Container(
                              child: Text(
                                  controller.produklist[index].deskripsi))),
                          DataCell(Container(
                              child: Text(controller.produklist[index].qty))),
                          DataCell(Container(
                              child: Text(controller.produklist[index].harga))),
                          // DataCell(Container(
                          //     child: Text(controller.produklist[index].image))),
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
                                    Get.toNamed('/detail_produk',
                                        arguments:
                                            controller.produklist[index]);
                                  },
                                  icon: Icon(
                                    Icons.edit,
                                    size: 18,
                                  )),
                              IconButton(
                                  onPressed: () {
                                    popscreen().deleteproduk(
                                        context,
                                        controller,
                                        controller.produklist[index]);
                                  },
                                  icon: Icon(Icons.delete, size: 18))
                            ],
                          ))
                        ]);
                      }));
                  ;
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

class produkTable extends DataTableSource {
  // Generate some made-up data
  var con = Get.put(produkController());
  late final List<DataProduk> _data = con.produklist.value;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => _data.length;

  @override
  int get selectedRowCount => 0;

  @override
  DataRow getRow(int index) {
    return DataRow(cells: [
      DataCell(Text(_data[index].namaProduk)),
      DataCell(Text(_data[index].namaJenis)),
      DataCell(Text(_data[index].deskripsi)),
      DataCell(Text(_data[index].qty)),
      DataCell(Text(_data[index].harga)),
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
                Get.toNamed('/detail_produk', arguments: con.produklist[index]);
              },
              icon: Icon(
                Icons.edit,
                size: 18,
              )),
          IconButton(
              onPressed: () {
                // popscreen().deleteproduk(
                //     context,
                //     con,
                //     con.produklist[index]);
              },
              icon: Icon(Icons.delete, size: 18))
        ],
      )),
    ]);
  }
}
