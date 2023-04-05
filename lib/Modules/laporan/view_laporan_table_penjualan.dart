import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rims_waserda/Modules/laporan/Controller_laporan.dart';
import 'package:rims_waserda/Modules/laporan/view_pdf.dart';

import '../../Templates/setting.dart';
import '../Widgets/buttons.dart';
import '../Widgets/header.dart';

class laporan_table_penjualan extends GetView<laporanController> {
  const laporan_table_penjualan({Key? key}) : super(key: key);

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
            header(
              title: 'Laporan Penjualan',
              icon: Icons.history,
              iscenter: false,
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
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      //width: 200,
                      child: TextFormField(
                        onTap: () {
                          FocusScope.of(context).requestFocus(new FocusNode());
                          Get.dialog(AlertDialog(
                            content: Container(
                              width: context.width_query / 1.5,
                              height: context.height_query / 1.5,
                              child: CalendarDatePicker2WithActionButtons(
                                  config:
                                      CalendarDatePicker2WithActionButtonsConfig(
                                    weekdayLabels: [
                                      'Minggu',
                                      'Senin',
                                      'Selasa',
                                      'Rabu',
                                      'Kamis',
                                      'Jumat',
                                      'Sabtu',
                                    ],
                                    firstDayOfWeek: 1,
                                    calendarType: CalendarDatePicker2Type.range,
                                    centerAlignModePicker: true,
                                  ),
                                  value: controller.dates,
                                  onOkTapped: () {
                                    Get.back();
                                    print('tgl-----------------------------');
                                  },
                                  onValueChanged: (dates) {
                                    var list = <String>[];
                                    var start = dates.first;
                                    final end = dates.last;
                                    controller.pickdate.value.text =
                                        (controller.dateformat.format(start!) +
                                            ' - ' +
                                            controller.dateformat.format(end!));

                                    controller.date1 =
                                        controller.dateformat.format(start);
                                    controller.date2 =
                                        controller.dateformat.format(end);
                                    print(controller.date1);
                                    print(controller.date2);
                                  }),
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
                controller.pickdate.value.text.isEmpty
                    ? Container()
                    : icon_button_custom(
                        onPressed: () async {
                          //controller.askPermission();
                          // var status = await Permission.bluetooth.status;
                          // if (!status.isGranted) {
                          //   await Permission.bluetooth.request();
                          // }

                          await controller.laporanPenjualan();
                        },
                        icon: Icons.search,
                        container_color: color_template().primary),
              ],
            ),
            Obx(() {
              return Expanded(
                child: Container(

                    // height: context.height_query / 1.6,
                    margin: EdgeInsets.only(top: 10),
                    // width: double.infinity,
                    child: controller.path_penjualan.isEmpty
                        ? Center(
                            child: Text(
                            'Tidak ada data',
                            style: font().header_black,
                          ))
                        : PDFScreen(
                            path: controller.path_penjualan.value,
                            file: controller.pdffile_penjualan,
                          )),
              );
            }),
          ],
        ),
      ),
    );
  }
}
