import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rims_waserda/Modules/pelanggan/hutang/controller_hutang_detail.dart';
import 'package:rims_waserda/Templates/setting.dart';

class hutang_detail extends GetView<hutang_detailController> {
  const hutang_detail({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width_query / 1.5,
      height: context.height_query / 2,
      child: Column(
        children: [
          Container(
            width: context.width_query / 1.5,
            height: context.height_query / 2,
            child: Obx(() {
              return DataTable2(
                  columns: <DataColumn>[
                    DataColumn(
                      label: Text(
                        'Tanggal hutang',
                        style: font().reguler,
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Jumlah bayar',
                        style: font().reguler,
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Tanggal bayar',
                        style: font().reguler,
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Sisa',
                        style: font().reguler,
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Tanggal lunas',
                        style: font().reguler,
                      ),
                    ),
                  ],
                  rows: List.generate(
                      controller.list_hutang_detaillocal.length,
                      (i) => DataRow(cells: [
                            DataCell(Text(
                              controller.dateFormatdisplay.format(
                                  DateTime.parse(controller
                                      .list_hutang_detaillocal[i].tglHutang!)),
                              style: font().reguler,
                            )),
                            DataCell(Text(
                              controller.list_hutang_detaillocal[i].bayar
                                  .toString(),
                              style: font().reguler,
                            )),
                            DataCell(controller
                                        .list_hutang_detaillocal[i].tglBayar ==
                                    null
                                ? Text(
                                    '-',
                                    style: font().reguler,
                                  )
                                : Text(
                                    controller.dateFormatdisplay.format(
                                        DateTime.parse(controller
                                            .list_hutang_detaillocal[i]
                                            .tglBayar!)),
                                    style: font().reguler,
                                  )),
                            DataCell(Text(
                              controller.list_hutang_detaillocal[i].sisa
                                  .toString(),
                              style: font().reguler,
                            )),
                            DataCell(controller
                                        .list_hutang_detaillocal[i].tglLunas ==
                                    null
                                ? Text(
                                    '-',
                                    style: font().reguler,
                                  )
                                : Text(
                                    controller.dateFormatdisplay.format(
                                        DateTime.parse(controller
                                            .list_hutang_detaillocal[i]
                                            .tglLunas!)),
                                    style: font().reguler,
                                  )),
                          ])));
            }),
          )
        ],
      ),
    );
  }
}
