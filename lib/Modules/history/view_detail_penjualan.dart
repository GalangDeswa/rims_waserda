import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rims_waserda/Modules/Widgets/card_custom.dart';
import 'package:rims_waserda/Modules/history/controller_detail_penjualan.dart';

import '../../Templates/setting.dart';

class detail_penjualan extends GetView<detailpenjualanController> {
  const detail_penjualan({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width_query / 2.5,
      height: context.height_query / 1,
      child: Card_custom(
        border: false,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: EdgeInsets.symmetric(vertical: 5),
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                    color: color_template().primary,
                    borderRadius: border_radius().header_border),
                width: context.width_query,
                child: Center(
                  child: Text(
                    'Detail penjualan',
                    style: font().header,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                      child: Text(
                    'Kasir :',
                  )),
                  Text(
                    controller.data.namaUser,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                      child: Text(
                    'Tanggal transaksi :',
                  )),
                  Text(
                    controller.data.tglPenjualan,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                      child: Text(
                    'Nomor meja :',
                  )),
                  Text(
                    controller.data.meja.toString(),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                      child: Text(
                    'Total item :',
                  )),
                  Text(
                    controller.data.totalItem.toString(),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 5),
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                    color: color_template().primary,
                    borderRadius: border_radius().header_border),
                width: context.width_query,
                child: Center(
                  child: Text(
                    'Item',
                    style: font().header,
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  width: context.width_query,
                  // height: context.height_query / 4,
                  child: Obx(() {
                    return DataTable2(
                        headingRowHeight: 15,
                        columns: <DataColumn>[
                          DataColumn(
                            label: Text(
                              'Produk',
                              style: TextStyle(fontStyle: FontStyle.italic),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              'Qty',
                              style: TextStyle(fontStyle: FontStyle.italic),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              'Harga',
                              style: TextStyle(fontStyle: FontStyle.italic),
                            ),
                          ),
                        ],
                        rows: List.generate(
                            controller.isi.length,
                            (index) => DataRow(cells: <DataCell>[
                                  DataCell(Text(controller.isi[index].namaBrg)),
                                  DataCell(Text(controller.isi[index].qty)),
                                  DataCell(Text('Rp.' +
                                      controller.nominal.format(double.parse(
                                          controller.isi[index].hargaBrg)))),
                                ])));
                  }),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 5),
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                    color: color_template().primary,
                    borderRadius: border_radius().header_border),
                width: context.width_query,
                child: Center(
                  child: Text(
                    'Pembayaran',
                    style: font().header,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                      child: Text(
                    'Subtotal :',
                  )),
                  Text(
                    'Rp.' +
                        controller.nominal
                            .format(double.parse(controller.data.subTotal)),
                  )
                ],
              ),
              Row(
                children: [
                  Expanded(
                      child: Text(
                    'Diskon total :',
                  )),
                  Text('Rp.' +
                      controller.nominal
                          .format(double.parse(controller.data.diskonTotal))),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                      child: Text(
                    'Total :',
                  )),
                  Text('Rp.' +
                      controller.nominal
                          .format(double.parse(controller.data.total))),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                      child: Text(
                    'Bayar :',
                  )),
                  Text('Rp.' +
                      controller.nominal
                          .format(double.parse(controller.data.bayar))),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                      child: Text(
                    'Metode Bayar :',
                  )),
                  Text(
                    controller.data.metodeBayar == 1
                        ? 'Tunai'
                        : controller.data.metodeBayar == 2
                            ? 'Non tunai'
                            : controller.data.metodeBayar == 3
                                ? 'Hutang'
                                : '-',
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                      child: Text(
                    'Kembali :',
                  )),
                  Text('Rp.' +
                      controller.nominal
                          .format(double.parse(controller.data.kembalian))),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                      child: Text(
                    'Status :',
                  )),
                  Text(
                    controller.data.status == 1
                        ? 'Selesai'
                        : controller.data.status == 2
                            ? 'Selesai'
                            : controller.data.status == 3
                                ? 'Hutang'
                                : controller.data.status == 4
                                    ? 'Reversal'
                                    : '-',
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
