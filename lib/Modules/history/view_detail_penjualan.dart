import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rims_waserda/Modules/history/controller_detail_penjualan.dart';

import '../../Templates/setting.dart';

class detail_penjualan extends GetView<detailpenjualanController> {
  const detail_penjualan({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var subtotal = controller.data.subTotal - controller.data.diskonTotal;
    var ppn = 11 / 100 * subtotal;
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      width: context.width_query / 1.8,
      // height: context.height_query,
      child: SingleChildScrollView(
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
                      style: font().reguler_bold,
                    )),
                    Text(
                      controller.data.namaUser,
                      style: font().reguler,
                    ),
                  ],
                ),
              ),
              Container(
                width: context.width_query,
                height: 0.3,
                color: Colors.black,
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
                      style: font().reguler_bold,
                    )),
                    Text(
                      controller.dateFormatdisplay
                          .format(DateTime.parse(controller.data.tglPenjualan)),
                      style: font().reguler,
                    ),
                  ],
                ),
              ),
              Container(
                width: context.width_query,
                height: 0.3,
                color: Colors.black,
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
                      style: font().reguler_bold,
                    )),
                    Text(
                      controller.data.meja.toString(),
                      style: font().reguler,
                    ),
                  ],
                ),
              ),
              Container(
                width: context.width_query,
                height: 0.3,
                color: Colors.black,
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
                      style: font().reguler_bold,
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
                height: context.height_query / 4.5,
                child: Obx(() {
                  return DataTable2(
                      headingRowHeight: 30,
                      dataRowHeight: 30,
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
                            'Subtotal',
                            style: font().reguler,
                          ),
                        ),
                      ],
                      rows: List.generate(controller.isilocal.length, (index) {
                        var hargadiskon = controller.isilocal[index].hargaBrg! -
                            controller.isilocal[index].diskonBrg!;
                        return DataRow(cells: <DataCell>[
                          DataCell(Text(
                            controller.isilocal[index].namaBrg!,
                            style: font().reguler,
                            overflow: TextOverflow.ellipsis,
                          )),
                          DataCell(
                              Text(controller.isilocal[index].qty.toString())),
                          DataCell(controller.isilocal[index].diskonBrg == 0
                              ? Text(
                                  'Rp.' +
                                      controller.nominal.format(double.parse(
                                          controller.isilocal[index].hargaBrg
                                              .toString())),
                                  style: font().reguler,
                                  overflow: TextOverflow.ellipsis,
                                )
                              : Text(
                                  'Rp.' +
                                      controller.nominal.format(hargadiskon),
                                  style: font().reguler,
                                  overflow: TextOverflow.ellipsis,
                                )),
                          DataCell(controller.isilocal[index].diskonBrg == 0
                              ? Text(
                                  'Rp.' +
                                      controller.nominal.format(
                                          controller.isilocal[index].hargaBrg! *
                                              controller.isilocal[index].qty!),
                                  style: font().reguler,
                                  overflow: TextOverflow.ellipsis,
                                )
                              : Text(
                                  'Rp.' +
                                      controller.nominal.format(hargadiskon *
                                          controller.isilocal[index].qty!),
                                  style: font().reguler,
                                  overflow: TextOverflow.ellipsis,
                                )),
                        ]);
                      }));
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
                    Expanded(
                        child: Text(
                      'Subtotal :',
                      style: font().reguler_bold,
                    )),
                    Text(
                      'Rp.' +
                          controller.nominal.format(controller.data.subTotal),
                      style: font().reguler,
                    )
                  ],
                ),
              ),
              Container(
                width: context.width_query,
                height: 0.3,
                color: Colors.black,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 3),
                child: Row(
                  children: [
                    Expanded(
                        child:
                            Text('Diskon kasir :', style: font().reguler_bold)),
                    Text(
                      'Rp.' +
                          controller.nominal
                              .format(controller.data.diskonKasir),
                      style: font().reguler,
                    ),
                  ],
                ),
              ),
              Container(
                width: context.width_query,
                height: 0.3,
                color: Colors.black,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 3),
                child: Row(
                  children: [
                    Expanded(child: Text('PPN :', style: font().reguler_bold)),
                    Text(
                      'Rp.' + controller.nominal.format(controller.data.ppn),
                      style: font().reguler,
                    ),
                  ],
                ),
              ),
              Container(
                width: context.width_query,
                height: 0.3,
                color: Colors.black,
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
                      style: font().reguler_bold,
                    )),
                    Text(
                      'Rp.' + controller.nominal.format(controller.data.total),
                      style: font().reguler,
                    ),
                  ],
                ),
              ),
              Container(
                width: context.width_query,
                height: 0.3,
                color: Colors.black,
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
                      style: font().reguler_bold,
                    )),
                    Text(
                      'Rp.' + controller.nominal.format(controller.data.bayar),
                      style: font().reguler,
                    ),
                  ],
                ),
              ),
              Container(
                width: context.width_query,
                height: 0.3,
                color: Colors.black,
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
                      style: font().reguler_bold,
                    )),
                    Text(
                      controller.data.metodeBayar == 1
                          ? 'Tunai'
                          : controller.data.metodeBayar == 2
                              ? 'Hutang'
                              : controller.data.metodeBayar == 3
                                  ? 'Hutang'
                                  : '-',
                      style: font().reguler,
                    ),
                  ],
                ),
              ),
              Container(
                width: context.width_query,
                height: 0.3,
                color: Colors.black,
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
                      style: font().reguler_bold,
                    )),
                    Text(
                      'Rp.' +
                          controller.nominal.format(controller.data.kembalian),
                      style: font().reguler,
                    ),
                  ],
                ),
              ),
              Container(
                width: context.width_query,
                height: 0.3,
                color: Colors.black,
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
                      style: font().reguler_bold,
                    )),
                    Text(
                      controller.data.status == 1
                          ? 'Selesai'
                          : controller.data.status == 2
                              ? 'Hutang'
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
