import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rims_waserda/Modules/Widgets/card_custom.dart';
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
    return Card_custom(
      border: false,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 50),
                      child: header(
                        iscenter: false,
                        title: 'Kategori Produk',
                        icon: Icons.add_box,
                        base_color: color_template().primary,
                        icon_funtion: Icons.refresh,
                        //icon_color: color_template().primary,
                        function: () async {
                          Get.dialog(const showloading(),
                              barrierDismissible: false);
                          await controller.fetchjenis();
                          Get.back();
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
                        'Tambah Kategori',
                        style: font().header,
                      ),
                      width: context.width_query * 0.2,
                      height: 65)
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 3),
                    //width: 200,
                    child: TextFormField(
                      controller: controller.searchjenis.value,
                      onChanged: ((String pass) {
                        controller.searchjenislocal();
                      }),
                      decoration: InputDecoration(
                        icon: const Icon(Icons.add_box),
                        labelText: "Cari Kategori",
                        labelStyle: const TextStyle(
                          color: Colors.black87,
                        ),
                        border: UnderlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
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
                icon_button_custom(
                    onPressed: () {
                      controller.searchjenislocal();
                    },
                    icon: Icons.search,
                    container_color: color_template().primary),
              ],
            ),
            Expanded(
              child: Obx(() {
                var source =
                    jenisprodukTable(controller.jenislistlocal.value, context)
                        .obs;
                return Container(
                    // height: context.height_query * 0.46,
                    margin: const EdgeInsets.only(top: 10),
                    // width: double.infinity,
                    child: controller.jenislistlocal.isEmpty
                        ? Container(
                            width: 100, height: 100, child: const showloading())
                        : PaginatedDataTable2(
                            horizontalMargin: 10,
                            renderEmptyRowsInTheEnd: false,
                            columnSpacing: 5,
                            headingRowColor: MaterialStateColor.resolveWith(
                                (states) =>
                                    color_template().primary.withOpacity(0.2)),
                            empty: Center(
                              child: Text(
                                "Data Kosong",
                                style: font().header_black,
                              ),
                            ),
                            columns: const <DataColumn>[
                              DataColumn(
                                label: Text(
                                  'Nama kategori',
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
                                label: Text(
                                  'Aksi',
                                ),
                              ),
                            ],
                            source: source.value));
              }),
            ),
            // Obx(() {
            //   return Container(
            //     margin: EdgeInsets.only(left: context.width_query / 1.9),
            //     child: Row(
            //       mainAxisAlignment: MainAxisAlignment.spaceAround,
            //       children: [
            //         const Text('Data perbaris :'),
            //         Text(controller.perpagejenis.value.toString()),
            //         controller.currentpagejenis > 1
            //             ? IconButton(
            //                 onPressed: () {
            //                   controller.backjenis();
            //                 },
            //                 icon: const Icon(FontAwesomeIcons.angleLeft,
            //                     size: 20))
            //             : const IconButton(
            //                 onPressed: null,
            //                 icon: Icon(
            //                   FontAwesomeIcons.angleLeft,
            //                   size: 20,
            //                   color: Colors.grey,
            //                 )),
            //         Text(controller.currentpagejenis.value.toString() +
            //             ' - ' +
            //             controller.totalpagejenis.value.toString()),
            //         controller.currentpagejenis <
            //                 controller.totalpagejenis.value
            //             ? IconButton(
            //                 onPressed: () {
            //                   controller.nextjenis();
            //                 },
            //                 icon: const Icon(
            //                   FontAwesomeIcons.angleRight,
            //                   size: 20,
            //                 ))
            //             : const IconButton(
            //                 onPressed: null,
            //                 icon: Icon(
            //                   FontAwesomeIcons.angleRight,
            //                   color: Colors.grey,
            //                   size: 20,
            //                 ))
            //       ],
            //     ),
            //   );
            // })
          ],
        ),
      ),
    );
  }
}

class jenisprodukTable extends DataTableSource {
  final List<DataJenis> data;
  final BuildContext context;

  jenisprodukTable(this.data, this.context);

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
      DataCell(Text(data[index].namaJenis!)),
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
