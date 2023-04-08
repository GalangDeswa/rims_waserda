import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rims_waserda/Modules/Widgets/popup.dart';
import 'package:rims_waserda/Modules/produk/data%20produk/controller_data_produk.dart';
import 'package:rims_waserda/Modules/produk/jenis%20produk/model_jenisproduk.dart';

import '../../../Templates/setting.dart';
import '../../Widgets/buttons.dart';
import '../../Widgets/header.dart';
import '../../Widgets/loading.dart';

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
            Expanded(
              child: Obx(() {
                var source = jenisprodukTable(controller.jenislist.value).obs;
                return Container(
                  // height: context.height_query * 0.46,
                  margin: EdgeInsets.only(top: 10),
                  // width: double.infinity,
                  child: controller.jenislist.value.isEmpty
                      ? Container(width: 100, height: 100, child: showloading())
                      : PaginatedDataTable2(
                          horizontalMargin: 10,
                          //minWidth: 1000,
                          //minWidth: 10,
                          //fit: FlexFit.loose,
                          columnSpacing: 5,
                          wrapInCard: false,
                          renderEmptyRowsInTheEnd: false,
                          headingRowColor: MaterialStateColor.resolveWith(
                              (states) =>
                                  color_template().primary.withOpacity(0.2)),
                          autoRowsToHeight: true,
                          showFirstLastButtons: true,
                          empty: Center(
                            child: Text(
                              "Data Kosong",
                              style: font().header_black,
                            ),
                          ),
                          columns: const <DataColumn>[
                            DataColumn(
                              label: Text(
                                'Nama Jenis',
                                style: TextStyle(fontStyle: FontStyle.italic),
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
                              label: Center(
                                child: Text(
                                  'Aksi',
                                  style: TextStyle(fontStyle: FontStyle.italic),
                                ),
                              ),
                            ),
                          ],
                          source: source.value,
                        ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}

class jenisprodukTable extends DataTableSource {
  final List<DataJenis> data;

  jenisprodukTable(this.data);

  var con = Get.find<produkController>();

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => data.length;

  @override
  int get selectedRowCount => 0;

  @override
  DataRow getRow(int index) {
    return DataRow(cells: [
      DataCell(Text(data[index].namaJenis)),
      DataCell(Row(
        children: [
          Expanded(
            child: IconButton(
                onPressed: () {
                  Get.toNamed('/edit_jenis', arguments: data[index]);
                },
                icon: Icon(
                  Icons.edit,
                  size: 18,
                  color: color_template().secondary,
                )),
          ),
          Expanded(
            child: IconButton(
                onPressed: () {
                  popscreen().deletejenis(con, data[index]);
                },
                icon: Icon(
                  Icons.delete,
                  size: 18,
                  color: color_template().tritadery,
                )),
          )
        ],
      )),
    ]);
  }
}
