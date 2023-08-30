import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rims_waserda/Modules/Widgets/card_custom.dart';
import 'package:rims_waserda/Modules/Widgets/popup.dart';
import 'package:rims_waserda/Modules/beban/edit%20jenis%20beban/model_jenis_beban.dart';

import '../../../Templates/setting.dart';
import '../../Widgets/buttons.dart';
import '../../Widgets/header.dart';
import '../../Widgets/loading.dart';
import '../data beban/controller_beban.dart';

class jenis_beban_table extends GetView<bebanController> {
  const jenis_beban_table({Key? key}) : super(key: key);

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
                        title: 'Kategori Beban',
                        icon: Icons.add_box,
                        icon_funtion: Icons.refresh,
                        function: () {
                          Get.dialog(showloading());
                          controller.fetchJenisBebanlocal(controller.id_toko);
                          Get.back();

                          print('-----snack------');
                        },
                      ),
                    ),
                  ),
                  button_solid_custom(
                      onPressed: () {
                        Get.toNamed('/tambah_jenis_beban');

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
                        'Tambah kategori beban'.toUpperCase(),
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

            Expanded(
              child: Obx(() {
                var source =
                    kategoriBebanTable(controller.jenisbebanlistlocal).obs;
                return Container(
                  // height: context.height_query * 0.46,
                  margin: const EdgeInsets.only(top: 10),
                  // width: double.infinity,
                  child: controller.succ == false
                      ? Container(
                          width: 100, height: 100, child: const showloading())
                      : PaginatedDataTable2(
                          horizontalMargin: 10,
                          //minWidth: 1000,
                          //minWidth: 10,
                          //fit: FlexFit.loose,
                          renderEmptyRowsInTheEnd: false,
                          wrapInCard: false,
                          columnSpacing: 0,
                          headingRowColor: MaterialStateColor.resolveWith(
                              (states) =>
                                  color_template().primary.withOpacity(0.2)),

                          columns: <DataColumn>[
                            DataColumn(
                              label: Text(
                                'Kategori Beban',
                                style: font().reguler,
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
                                style: font().reguler,
                              ),
                            ),
                          ],
                          source: source.value,
                          empty: Center(
                            child: Text(
                              "Data Kosong",
                              style: font().header_black,
                            ),
                          ),
                        ),
                );
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

class kategoriBebanTable extends DataTableSource {
  final List<DataJenisBeban> data;

  kategoriBebanTable(this.data);

  //var con = Get.find<editjenisbebanController>();
  //var con = Get.put(editjenisbebanController());
  var con = Get.find<bebanController>();

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => data.length;

  @override
  int get selectedRowCount => 0;

  @override
  DataRow getRow(int index) {
    return DataRow(cells: [
      DataCell(Text(
        data[index].kategori!,
        style: font().reguler,
        overflow: TextOverflow.ellipsis,
      )),
      DataCell(Container(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            IconButton(
                padding: EdgeInsets.zero,
                onPressed: () {
                  Get.toNamed('/edit_jenis_beban', arguments: data[index]);
                },
                icon: Icon(
                  Icons.edit,
                  size: 18,
                  color: color_template().secondary,
                )),
            IconButton(
                padding: EdgeInsets.zero,
                onPressed: () {
                  popscreen().deletejenisbeban(con, data[index]);
                },
                icon: Icon(
                  Icons.delete,
                  size: 18,
                  color: color_template().tritadery,
                ))
          ],
        ),
      )),
    ]);
  }
}
