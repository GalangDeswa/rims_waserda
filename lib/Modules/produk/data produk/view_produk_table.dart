import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:rims_waserda/Modules/Widgets/loading.dart';
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
                        title: 'Data produk',
                        icon: FontAwesomeIcons.boxOpen,
                        icon_funtion: Icons.refresh,
                        function: () async {
                          Get.dialog(showloading(), barrierDismissible: false);

                          await controller.fetchProduk();
                          Get.back(closeOverlays: true);
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
              height: 15,
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
            Expanded(
              child: Obx(() {
                var source =
                    produkTable(controller.produklist.value, context).obs;
                return Container(
                  //height: context.height_query * 0.46,
                  margin: EdgeInsets.only(top: 15),
                  // width: double.infinity,

                  child: controller.produklist.value.isEmpty
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
                                'Nama Produk',
                                style: TextStyle(fontStyle: FontStyle.italic),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                'Jenis produk',
                                style: TextStyle(fontStyle: FontStyle.italic),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                'Desc',
                                style: TextStyle(fontStyle: FontStyle.italic),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                'Stock',
                                style: TextStyle(fontStyle: FontStyle.italic),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                'Harga',
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

class produkTable extends DataTableSource {
  final List<DataProduk> data;
  final BuildContext context;

  produkTable(this.data, this.context);

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
      DataCell(Text(data[index].namaProduk)),
      DataCell(Text(data[index].namaJenis)),
      DataCell(Text(data[index].deskripsi)),
      DataCell(Row(
        children: [
          Expanded(
              child: Text(con.nominal.format(double.parse(data[index].qty)))),
          Padding(
            padding: EdgeInsets.only(right: context.width_query / 23),
            child: IconButton(
                onPressed: () {
                  con.addqty(con, data[index]);
                },
                icon: Container(
                  padding: EdgeInsets.all(3),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: color_template().primary),
                  child: Icon(
                    Icons.add,
                    size: 18,
                    color: Colors.white,
                  ),
                )),
          )
        ],
      )),
      DataCell(
          Text('Rp. ' + con.nominal.format(double.parse(data[index].harga)))),
      DataCell(Center(
        child: Row(
          children: [
            Expanded(
              child: IconButton(
                  onPressed: () {
                    Get.toNamed('/edit_produk', arguments: data[index]);
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
                    popscreen().deleteprodukv2(con, data[index]);
                  },
                  icon: Icon(
                    Icons.delete,
                    size: 18,
                    color: color_template().tritadery,
                  )),
            )
          ],
        ),
      )),
    ]);
  }
}
