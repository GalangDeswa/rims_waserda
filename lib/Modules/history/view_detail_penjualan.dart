import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rims_waserda/Modules/history/controller_detail_penjualan.dart';

import '../../Templates/setting.dart';
import '../Widgets/header.dart';

class detail_penjualan extends GetView<detailpenjualanController> {
  const detail_penjualan({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width_query / 2.5,
      height: context.height_query / 1,
      child: Card(
        elevation: elevation().def_elevation,
        //margin: EdgeInsets.all(30),
        shape: RoundedRectangleBorder(
          borderRadius: border_radius().def_border,
          side: BorderSide(color: color_template().primary, width: 3.5),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              header(title: 'Daftar Riwayat Penjualan', icon: Icons.history),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                      child: Text(
                    'Kasir :',
                    style: font().primary_dark,
                  )),
                  Expanded(
                      child: Text(controller.data.namaUser,
                          style: font().primary_dark)),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                      child: Text(
                    'Tanggal transaksi :',
                    style: font().primary_dark,
                  )),
                  Expanded(
                      child: Text(controller.data.tglPenjualan,
                          style: font().primary_dark)),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                      child: Text(
                    'Nomor meja :',
                    style: font().primary_dark,
                  )),
                  Expanded(
                      child: Text(controller.data.meja.toString(),
                          style: font().primary_dark)),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                      child: Text(
                    'Total item :',
                    style: font().primary_dark,
                  )),
                  Expanded(
                      child: Text(controller.data.totalItem.toString(),
                          style: font().primary_dark)),
                ],
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                padding: EdgeInsets.all(10),
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
                  height: context.height_query / 4,
                  child: Obx(() {
                    return DataTable(
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
                                  DataCell(Center(
                                      child:
                                          Text(controller.isi[index].namaBrg))),
                                  DataCell(Center(
                                      child: Text(controller.isi[index].qty))),
                                  DataCell(Center(
                                      child: Text(
                                          controller.isi[index].hargaBrg))),
                                ])));
                  }),
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
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
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                      child: Text(
                    'Subtotal :',
                    style: font().primary_dark,
                  )),
                  Expanded(
                      child: Text(controller.data.subTotal.toString(),
                          style: font().primary_dark)),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                      child: Text(
                    'Diskon total :',
                    style: font().primary_dark,
                  )),
                  Expanded(
                      child: Text(controller.data.diskonTotal.toString(),
                          style: font().primary_dark)),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                      child: Text(
                    'Total :',
                    style: font().primary_dark,
                  )),
                  Expanded(
                      child: Text(controller.data.total.toString(),
                          style: font().primary_dark)),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                      child: Text(
                    'Metode bayar :',
                    style: font().primary_dark,
                  )),
                  Expanded(
                      child: Text(controller.data.metodeBayar.toString(),
                          style: font().primary_dark)),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                      child: Text(
                    'Bayar :',
                    style: font().primary_dark,
                  )),
                  Expanded(
                      child: Text(controller.data.bayar.toString(),
                          style: font().primary_dark)),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                      child: Text(
                    'Metode Bayar :',
                    style: font().primary_dark,
                  )),
                  Expanded(
                      child: Text(
                          controller.data.metodeBayar == 1
                              ? 'Tunai'
                              : controller.data.metodeBayar == 2
                                  ? 'Non tunai'
                                  : controller.data.metodeBayar == 3
                                      ? 'Hutang'
                                      : '-',
                          style: font().primary_dark)),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                      child: Text(
                    'Kembali :',
                    style: font().primary_dark,
                  )),
                  Expanded(
                      child: Text(controller.data.kembalian.toString(),
                          style: font().primary_dark)),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                      child: Text(
                    'Status :',
                    style: font().primary_dark,
                  )),
                  Expanded(
                      child: Text(
                          controller.data.status == 1
                              ? 'Selesai'
                              : controller.data.status == 2
                                  ? 'Selesai'
                                  : controller.data.status == 3
                                      ? 'Hutang'
                                      : controller.data.status == 4
                                          ? 'Reversal'
                                          : '-',
                          style: font().primary_dark)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
