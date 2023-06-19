import 'package:data_table_2/data_table_2.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
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
                    const DataColumn(
                      label: Text(
                        'Tanggal hutang',
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Jumlah bayar',
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Tanggal bayar',
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Sisa',
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Tanggal lunas',
                      ),
                    ),
                  ],
                  rows: List.generate(
                      controller.list_hutang_detaillocal.length,
                      (i) => DataRow(cells: [
                            DataCell(Text(controller
                                .list_hutang_detaillocal[i].tglHutang
                                .toString())),
                            DataCell(Text(controller
                                .list_hutang_detaillocal[i].bayar
                                .toString())),
                            DataCell(controller
                                        .list_hutang_detaillocal[i].tglBayar ==
                                    null
                                ? Text('-')
                                : Text(controller
                                    .list_hutang_detaillocal[i].tglBayar
                                    .toString())),
                            DataCell(Text(controller
                                .list_hutang_detaillocal[i].sisa
                                .toString())),
                            DataCell(controller
                                        .list_hutang_detaillocal[i].tglLunas ==
                                    null
                                ? Text('-')
                                : Text(controller
                                    .list_hutang_detaillocal[i].tglLunas
                                    .toString())),
                          ])));
            }),
          )
        ],
      ),
    );
  }
}
