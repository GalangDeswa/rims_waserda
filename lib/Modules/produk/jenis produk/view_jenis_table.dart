import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rims_waserda/Modules/Widgets/popup.dart';
import 'package:rims_waserda/Modules/produk/data%20produk/controller_data_produk.dart';
import 'package:rims_waserda/Modules/produk/jenis%20produk/controller_edit_jenis.dart';

import '../../../Templates/setting.dart';
import '../../Widgets/buttons.dart';
import '../../Widgets/header.dart';

class jenis_table extends GetView<produkController> {
  const jenis_table({Key? key}) : super(key: key);

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
                        title: 'List jenis',
                        icon: Icons.add_box,
                        base_color: color_template().primary,
                        icon_funtion: Icons.refresh,
                        //icon_color: color_template().primary,
                        function: () {
                          controller.onInit();

                          print('-----snack------');
                        },
                      ),
                    ),
                  ),
                  button_solid_custom(
                      onPressed: () {
                        Get.toNamed('/tambah_jenis');

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
                        'tambah jenis',
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
                        labelText: "cari jenis",
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
                      //controller.getprodukall();
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
                              'Nama Jenis',
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
                            child: Text(
                              'Aksi',
                              style: TextStyle(fontStyle: FontStyle.italic),
                            ),
                          ),
                        ),
                      ],
                      rows: List.generate(controller.jenislist.length, (index) {
                        return DataRow(cells: [
                          DataCell(Container(
                              child:
                                  Text(controller.jenislist[index].namaJenis))),

                          // DataCell(Container(
                          //     child: Text(controller.produklist[index].image))),
                          DataCell(Row(
                            children: [
                              IconButton(
                                  onPressed: () {
                                    Get.toNamed('/edit_jenis',
                                        arguments: controller.jenislist[index]);
                                  },
                                  icon: Icon(
                                    Icons.edit,
                                    size: 18,
                                  )),
                              IconButton(
                                  onPressed: () {
                                    popscreen().deletejenis(
                                        context,
                                        editjenisController(),
                                        controller.jenislist[index]);
                                  },
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
