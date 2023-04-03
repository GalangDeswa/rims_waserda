import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rims_waserda/Modules/laporan/Controller_laporan.dart';

import '../../Templates/setting.dart';
import '../Widgets/buttons.dart';
import '../Widgets/header.dart';

class laporan_table_umum extends GetView<laporanController> {
  const laporan_table_umum({Key? key}) : super(key: key);

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
          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            header(title: 'Laporan Umum', icon: Icons.history),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Obx(() {
                  return Expanded(
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      //width: 200,
                      child: TextFormField(
                        onTap: () {
                          FocusScope.of(context).requestFocus(new FocusNode());
                          Get.dialog(Container(
                            padding: EdgeInsets.all(50),
                            child: Card(
                              child: CalendarDatePicker2WithActionButtons(
                                config:
                                    CalendarDatePicker2WithActionButtonsConfig(
                                  calendarType: CalendarDatePicker2Type.range,
                                  centerAlignModePicker: true,
                                ),
                                value: controller.dates,
                                onOkTapped: () {
                                  Get.back();
                                  print('tgl-----------------------------');
                                },
                                onValueChanged: (dates) => controller
                                    .pickdate.value.text = dates.toString(),
                              ),
                            ),
                          ));
                        },
                        readOnly: true,
                        controller: controller.pickdate.value,
                        onChanged: ((String pass) {
                          // controller.fetchDataBeban();
                        }),
                        decoration: InputDecoration(
                          icon: Icon(Icons.add_box),
                          labelText:
                              "Cari laporan (Tanggal awal - Tanggal akhir)",
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
                      //controller.fetchDataBeban();
                      Get.dialog(Container(
                        padding: EdgeInsets.all(50),
                        child: Card(
                          child: CalendarDatePicker2WithActionButtons(
                            config: CalendarDatePicker2WithActionButtonsConfig(
                              calendarType: CalendarDatePicker2Type.range,
                              centerAlignModePicker: true,
                            ),
                            value: controller.dates,
                            onOkTapped: () {
                              Get.back();
                              print('tgl-----------------------------');
                            },
                            onValueChanged: (dates) => controller
                                .pickdate.value.text = dates.toString(),
                          ),
                        ),
                      ));
                    },
                    icon: Icons.search,
                    container_color: color_template().primary),
              ],
            ),
            Container(
              //color: Colors.red,
              height: context.height_query / 1.6,
              margin: EdgeInsets.only(top: 15),
              width: double.infinity,
              child: SingleChildScrollView(
                  // child: Obx(() {
                  //   return DataTable(
                  //       columns: const <DataColumn>[
                  //         DataColumn(
                  //           label: Expanded(
                  //             child: Text(
                  //               'tanggal',
                  //               style: TextStyle(fontStyle: FontStyle.italic),
                  //             ),
                  //           ),
                  //         ),
                  //         DataColumn(
                  //           label: Expanded(
                  //             child: Text(
                  //               'nomor transasksi',
                  //               style: TextStyle(fontStyle: FontStyle.italic),
                  //             ),
                  //           ),
                  //         ),
                  //         DataColumn(
                  //           label: Expanded(
                  //             child: Text(
                  //               'id kasir',
                  //               style: TextStyle(fontStyle: FontStyle.italic),
                  //             ),
                  //           ),
                  //         ),
                  //         DataColumn(
                  //           label: Expanded(
                  //             child: Text(
                  //               'Produk',
                  //               style: TextStyle(fontStyle: FontStyle.italic),
                  //             ),
                  //           ),
                  //         ),
                  //         DataColumn(
                  //           label: Expanded(
                  //             child: Text(
                  //               'QTY',
                  //               style: TextStyle(fontStyle: FontStyle.italic),
                  //             ),
                  //           ),
                  //         ),
                  //         DataColumn(
                  //           label: Expanded(
                  //             child: Center(
                  //               child: Text(
                  //                 'Total',
                  //                 style: TextStyle(fontStyle: FontStyle.italic),
                  //               ),
                  //             ),
                  //           ),
                  //         ),
                  //         DataColumn(
                  //           label: Expanded(
                  //             child: Center(
                  //               child: Text(
                  //                 'Aksi',
                  //                 style: TextStyle(fontStyle: FontStyle.italic),
                  //               ),
                  //             ),
                  //           ),
                  //         ),
                  //       ],
                  //       rows: List.generate(controller.history_list.length,
                  //               (index) {
                  //             return DataRow(cells: [
                  //               DataCell(Container(
                  //                   child: Text(controller.history_list[index].tgl))),
                  //               DataCell(Container(
                  //                   child: Text(controller
                  //                       .history_list[index].nomorTransaksi))),
                  //               DataCell(Container(
                  //                   child: Text(
                  //                       controller.history_list[index].idKasir))),
                  //               DataCell(Container(
                  //                   child: Text(
                  //                       controller.history_list[index].namaProduk))),
                  //               DataCell(Container(
                  //                   child: Text(controller.history_list[index].qty))),
                  //               DataCell(Container(
                  //                   child:
                  //                   Text(controller.history_list[index].total))),
                  //               DataCell(Row(
                  //                 children: [
                  //                   IconButton(
                  //                       onPressed: () {
                  //                         // print('qweqweqwe');
                  //                         // Get.toNamed('/detail_produk');
                  //                       },
                  //                       icon: Icon(
                  //                         Icons.ballot,
                  //                         size: 18,
                  //                       )),
                  //                   IconButton(
                  //                       onPressed: () {
                  //                         Get.toNamed('/detail_produk');
                  //                       },
                  //                       icon: Icon(
                  //                         Icons.edit,
                  //                         size: 18,
                  //                       )),
                  //                   IconButton(
                  //                       onPressed: () {},
                  //                       icon: Icon(Icons.delete, size: 18))
                  //                 ],
                  //               ))
                  //             ]);
                  //           }));
                  // }),
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
