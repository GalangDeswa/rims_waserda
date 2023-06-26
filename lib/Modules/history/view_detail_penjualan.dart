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
      width: context.width_query / 1.8,
      height: context.height_query,
      child: Card_custom(
        border: false,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: const EdgeInsets.symmetric(vertical: 5),
                padding: const EdgeInsets.all(3),
                decoration: BoxDecoration(
                    borderRadius: border_radius().header_border,
                    border: Border.all(color: color_template().primary)),
                width: context.width_query,
                child: Center(
                  child: Text(
                    'Detail penjualan',
                    style: font().header_blue,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 3),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                        child: Text(
                      'Kasir :',
                      style: font().reguler,
                    )),
                    Text(
                      controller.data.namaUser,
                      style: font().reguler,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 3),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                        child: Text(
                      'Tanggal transaksi :',
                      style: font().reguler,
                    )),
                    Text(
                      controller.dateFormatdisplay
                          .format(DateTime.parse(controller.data.tglPenjualan)),
                      style: font().reguler,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 3),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                        child: Text(
                      'Nomor meja :',
                      style: font().reguler,
                    )),
                    Text(
                      controller.data.meja.toString(),
                      style: font().reguler,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 3),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                        child: Text(
                      'Total item :',
                      style: font().reguler,
                    )),
                    Text(
                      controller.data.totalItem.toString(),
                      style: font().reguler,
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 5),
                padding: const EdgeInsets.all(3),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: border_radius().header_border,
                    border: Border.all(color: color_template().primary)),
                width: context.width_query,
                child: Center(
                  child: Text(
                    'Item',
                    style: font().header_blue,
                  ),
                ),
              ),
              Container(
                width: context.width_query,
                height: context.height_query / 3.5,
                child: Obx(() {
                  return DataTable2(
                      columns: <DataColumn>[
                        DataColumn(
                          label: Text(
                            'Produk',
                            style: font().reguler,
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'Qty',
                            style: font().reguler,
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'Harga',
                            style: font().reguler,
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'Diskon',
                            style: font().reguler,
                          ),
                        ),
                      ],
                      rows: List.generate(
                          controller.isilocal.length,
                          (index) => DataRow(cells: <DataCell>[
                                DataCell(Text(
                                  controller.isilocal[index].namaBrg!,
                                  style: font().reguler,
                                  overflow: TextOverflow.ellipsis,
                                )),
                                DataCell(Text(
                                    controller.isilocal[index].qty.toString())),
                                DataCell(Text(
                                  'Rp.' +
                                      controller.nominal.format(double.parse(
                                          controller.isilocal[index].hargaBrg
                                              .toString())),
                                  style: font().reguler,
                                  overflow: TextOverflow.ellipsis,
                                )),
                                DataCell(Text(
                                  'Rp.' +
                                      controller.nominal.format(double.parse(
                                          controller.isilocal[index].diskonBrg
                                              .toString())),
                                  style: font().reguler,
                                  overflow: TextOverflow.ellipsis,
                                )),
                              ])));
                }),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 5),
                padding: const EdgeInsets.all(3),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: border_radius().header_border,
                    border: Border.all(color: color_template().primary)),
                width: context.width_query,
                child: Center(
                  child: Text(
                    'Pembayaran',
                    style: font().header_blue,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 3),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Expanded(
                        child: Text(
                      'Subtotal :',
                    )),
                    Text(
                      'Rp.' +
                          controller.nominal.format(controller.data.subTotal),
                      style: font().reguler,
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 3),
                child: Row(
                  children: [
                    const Expanded(
                        child: Text(
                      'Diskon total :',
                    )),
                    Text(
                      'Rp.' +
                          controller.nominal
                              .format(controller.data.diskonTotal),
                      style: font().reguler,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 3),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                        child: Text(
                      'Total :',
                      style: font().reguler,
                    )),
                    Text(
                      'Rp.' + controller.nominal.format(controller.data.total),
                      style: font().reguler,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 3),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                        child: Text(
                      'Bayar :',
                      style: font().reguler,
                    )),
                    Text(
                      'Rp.' + controller.nominal.format(controller.data.bayar),
                      style: font().reguler,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 3),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                        child: Text(
                      'Metode Bayar :',
                      style: font().reguler,
                    )),
                    Text(
                      controller.data.metodeBayar == 1
                          ? 'Tunai'
                          : controller.data.metodeBayar == 2
                              ? 'Non tunai'
                              : controller.data.metodeBayar == 3
                                  ? 'Hutang'
                                  : '-',
                      style: font().reguler,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 3),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                        child: Text(
                      'Kembali :',
                      style: font().reguler,
                    )),
                    Text(
                      'Rp.' +
                          controller.nominal.format(controller.data.kembalian),
                      style: font().reguler,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 3),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                        child: Text(
                      'Status :',
                      style: font().reguler,
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
                      style: font().reguler,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
