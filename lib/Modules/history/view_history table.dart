import 'package:data_table_2/data_table_2.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:rims_waserda/Modules/Widgets/loading.dart';
import 'package:rims_waserda/Modules/Widgets/popup.dart';
import 'package:rims_waserda/Modules/history/model_penjualan.dart';
import 'package:rims_waserda/Modules/history/view_detail_penjualan.dart';

import '../../Templates/setting.dart';
import '../Widgets/buttons.dart';
import '../Widgets/header.dart';
import 'Controller_history.dart';

class history_table extends GetView<historyController> {
  const history_table({Key? key}) : super(key: key);

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
              iscenter: false,
              title: 'Daftar Riwayat Penjualan',
              icon: Icons.history,
              icon_funtion: Icons.refresh,
              function: () {
                controller.fetchPenjualan();
              },
            ),
            SizedBox(
              height: 10,
            ),
            Obx(() {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 3),
                      //width: 200,
                      child: TextFormField(
                        controller: controller.search.value,
                        onChanged: ((String pass) {
                          controller.fetchPenjualan();
                        }),
                        decoration: InputDecoration(
                          icon: Icon(Icons.add_box),
                          labelText: "Cari tanggal penjualan",
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
                  ),
                  icon_button_custom(
                      onPressed: () async {
                        Get.dialog(showloading());
                        await controller.fetchPenjualan();

                        Get.back();
                      },
                      icon: Icons.search,
                      container_color: color_template().primary),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 3),
                      //width: 200,
                      child: TextFormField(
                        //controller: controller.id_kas.value,
                        onChanged: ((String pass) {}),
                        decoration: InputDecoration(
                          icon: Icon(Icons.add_box),
                          labelText: "Penjualan Hari Ini",
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
                  ),
                  icon_button_custom(
                      onPressed: () async {
                        Get.dialog(showloading());
                        await controller.fetchPenjualanHariIni();

                        Get.back();
                      },
                      icon: Icons.search,
                      container_color: color_template().primary),
                  Expanded(
                    child: DropdownButtonFormField2(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      isExpanded: true,
                      dropdownStyleData: DropdownStyleData(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white)),
                      hint: Text('Filter berdasar status'),
                      value: controller.valstatus,
                      items: controller.liststatus.value.map((item) {
                        return DropdownMenuItem(
                            child: Text(item['nama'].toString()),
                            value: item['id'].toString());
                      }).toList(),
                      onChanged: (val) async {
                        controller.stts.value = true;
                        controller.valstatus = val!.toString();
                        var start = await controller.fetchPenjualan();
                        var query = await start
                            .where((e) => e.status.toString() == val)
                            .toList();
                        controller.penjualan_list.value = query;
                        print(query);
                        print(controller.valstatus);
                      },
                    ),
                  ),
                  controller.stts.value == false
                      ? Container()
                      : IconButton(
                          onPressed: () {
                            controller.stts.value = true;
                            controller.valstatus = 0.toString();
                            print(
                                'stts-------------------------------------------------->');
                            print(controller.stts);
                            print(controller.valstatus);
                            controller.fetchPenjualan();
                          },
                          icon: Icon(
                            Icons.cancel,
                            color: color_template().tritadery,
                          ),
                        )
                ],
              );
            }),
            Expanded(
              child: Obx(() {
                onSortColum(int columnIndex, bool ascending) {
                  if (columnIndex == 0) {
                    if (ascending) {
                      controller.penjualan_list.sort(
                          (a, b) => a.tglPenjualan.compareTo(b.tglPenjualan));
                    } else {
                      controller.penjualan_list.sort(
                          (a, b) => b.tglPenjualan.compareTo(a.tglPenjualan));
                    }
                  } else if (columnIndex == 1) {
                    if (ascending) {
                      controller.penjualan_list
                          .sort((a, b) => a.namaUser.compareTo(b.namaUser));
                    } else {
                      controller.penjualan_list
                          .sort((a, b) => b.namaUser.compareTo(a.namaUser));
                    }
                  } else if (columnIndex == 2) {
                    if (ascending) {
                      controller.penjualan_list.sort(
                          (a, b) => b.namaPelanggan.compareTo(a.namaPelanggan));
                    } else {
                      controller.penjualan_list.sort(
                          (a, b) => a.namaPelanggan.compareTo(b.namaPelanggan));
                    }
                  } else if (columnIndex == 3) {
                    if (ascending) {
                      controller.penjualan_list
                          .sort((a, b) => b.totalItem.compareTo(a.totalItem));
                    } else {
                      controller.penjualan_list
                          .sort((a, b) => a.totalItem.compareTo(b.totalItem));
                    }
                  } else if (columnIndex == 4) {
                    if (ascending) {
                      controller.penjualan_list
                          .sort((a, b) => b.subTotal.compareTo(a.subTotal));
                    } else {
                      controller.penjualan_list
                          .sort((a, b) => a.subTotal.compareTo(b.subTotal));
                    }
                  } else if (columnIndex == 5) {
                    if (ascending) {
                      controller.penjualan_list
                          .sort((a, b) => b.total.compareTo(a.total));
                    } else {
                      controller.penjualan_list
                          .sort((a, b) => a.total.compareTo(b.total));
                    }
                  } else if (columnIndex == 6) {
                    if (ascending) {
                      controller.penjualan_list
                          .sort((a, b) => b.bayar.compareTo(a.bayar));
                    } else {
                      controller.penjualan_list
                          .sort((a, b) => a.bayar.compareTo(b.bayar));
                    }
                  } else if (columnIndex == 7) {
                    if (ascending) {
                      controller.penjualan_list
                          .sort((a, b) => b.status.compareTo(a.status));
                    } else {
                      controller.penjualan_list
                          .sort((a, b) => a.status.compareTo(b.status));
                    }
                  }
                }

                return Container(
                  //color: Colors.red,
                  // height: context.height_query / 1.6,
                  margin: EdgeInsets.only(top: 10),
                  // width: double.infinity,
                  child: controller.succ == false
                      ? Container(width: 100, height: 100, child: showloading())
                      : DataTable2(
                          sortAscending: controller.sort.value,
                          sortColumnIndex: controller.ColIndex.value,
                          horizontalMargin: 10,
                          //minWidth: 1000,
                          //minWidth: 10,
                          //fit: FlexFit.loose,
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
                          columns: <DataColumn>[
                            DataColumn(
                              onSort: (int columnIndex, bool ascending) {
                                controller.sort.value = !controller.sort.value;
                                controller.ColIndex.value = columnIndex;
                                onSortColum(columnIndex, ascending);
                              },
                              label: Text(
                                'tanggal',
                                style: TextStyle(fontStyle: FontStyle.italic),
                              ),
                            ),
                            DataColumn(
                              onSort: (int columnIndex, bool ascending) {
                                controller.sort.value = !controller.sort.value;
                                controller.ColIndex.value = columnIndex;
                                onSortColum(columnIndex, ascending);
                              },
                              label: Text(
                                'Nama kasir',
                                style: TextStyle(fontStyle: FontStyle.italic),
                              ),
                            ),
                            DataColumn(
                              onSort: (int columnIndex, bool ascending) {
                                controller.sort.value = !controller.sort.value;
                                controller.ColIndex.value = columnIndex;
                                onSortColum(columnIndex, ascending);
                              },
                              label: Text(
                                'Nama pelanggan',
                                style: TextStyle(fontStyle: FontStyle.italic),
                              ),
                            ),
                            DataColumn(
                              onSort: (int columnIndex, bool ascending) {
                                controller.sort.value = !controller.sort.value;
                                controller.ColIndex.value = columnIndex;
                                onSortColum(columnIndex, ascending);
                              },
                              label: Text(
                                'Total item',
                                style: TextStyle(fontStyle: FontStyle.italic),
                              ),
                            ),
                            DataColumn(
                              onSort: (int columnIndex, bool ascending) {
                                controller.sort.value = !controller.sort.value;
                                controller.ColIndex.value = columnIndex;
                                onSortColum(columnIndex, ascending);
                              },
                              label: Text(
                                'Subtotal',
                                style: TextStyle(fontStyle: FontStyle.italic),
                              ),
                            ),
                            DataColumn(
                              onSort: (int columnIndex, bool ascending) {
                                controller.sort.value = !controller.sort.value;
                                controller.ColIndex.value = columnIndex;
                                onSortColum(columnIndex, ascending);
                              },
                              label: Text(
                                'Total',
                                style: TextStyle(fontStyle: FontStyle.italic),
                              ),
                            ),
                            DataColumn(
                              onSort: (int columnIndex, bool ascending) {
                                controller.sort.value = !controller.sort.value;
                                controller.ColIndex.value = columnIndex;
                                onSortColum(columnIndex, ascending);
                              },
                              label: Center(
                                child: Text(
                                  'Bayar',
                                  style: TextStyle(fontStyle: FontStyle.italic),
                                ),
                              ),
                            ),
                            DataColumn(
                              onSort: (int columnIndex, bool ascending) {
                                controller.sort.value = !controller.sort.value;
                                controller.ColIndex.value = columnIndex;
                                onSortColum(columnIndex, ascending);
                              },
                              label: Center(
                                child: Text(
                                  'Status',
                                  style: TextStyle(fontStyle: FontStyle.italic),
                                ),
                              ),
                            ),
                            DataColumn(
                              label: Center(
                                child: Text(
                                  'Aksi',
                                  style: TextStyle(fontStyle: FontStyle.italic),
                                ),
                              ),
                            ),
                          ],
                          rows: List.generate(
                              controller.penjualan_list.length,
                              (index) => DataRow(cells: [
                                    DataCell(Center(
                                        child: Text(controller
                                            .penjualan_list[index]
                                            .tglPenjualan))),
                                    DataCell(Center(
                                        child: Text(controller
                                            .penjualan_list[index].namaUser))),
                                    DataCell(Center(
                                        child: Text(controller
                                            .penjualan_list[index]
                                            .namaPelanggan))),
                                    DataCell(Center(
                                        child: Text(controller
                                            .penjualan_list[index].totalItem))),
                                    DataCell(Center(
                                        child: Text('Rp. ' +
                                            controller.nominal.format(
                                                double.parse(controller
                                                    .penjualan_list[index]
                                                    .subTotal))))),
                                    DataCell(Center(
                                        child: Text('Rp. ' +
                                            controller.nominal.format(
                                                double.parse(controller
                                                    .penjualan_list[index]
                                                    .total))))),
                                    DataCell(Center(
                                        child: Text('Rp. ' +
                                            controller.nominal.format(
                                                double.parse(controller
                                                    .penjualan_list[index]
                                                    .bayar))))),
                                    DataCell(Center(
                                        child: controller.penjualan_list[index]
                                                    .status ==
                                                1
                                            ? Container(
                                                padding: EdgeInsets.all(6),
                                                decoration: BoxDecoration(
                                                    color: Colors.green,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                                child: Text(
                                                  'Selesai',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              )
                                            : controller.penjualan_list[index]
                                                        .status ==
                                                    2
                                                ? Container(
                                                    padding: EdgeInsets.all(6),
                                                    decoration: BoxDecoration(
                                                        color: Colors.green,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10)),
                                                    child: Text('Selesai',
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold)),
                                                  )
                                                : controller
                                                            .penjualan_list[
                                                                index]
                                                            .status ==
                                                        3
                                                    ? Container(
                                                        padding:
                                                            EdgeInsets.all(6),
                                                        decoration: BoxDecoration(
                                                            color:
                                                                Colors.orange,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10)),
                                                        child: Text('Hutang',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold)),
                                                      )
                                                    : controller
                                                                .penjualan_list[
                                                                    index]
                                                                .status ==
                                                            4
                                                        ? Container(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    6),
                                                            decoration: BoxDecoration(
                                                                color: color_template()
                                                                    .tritadery,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10)),
                                                            child: Text(
                                                                'Reversal',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold)),
                                                          )
                                                        : Text('-'))),
                                    DataCell(Center(
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: IconButton(
                                                onPressed: () {
                                                  Get.dialog(
                                                      AlertDialog(
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius.all(
                                                                    Radius.circular(
                                                                        20.0))),
                                                        contentPadding:
                                                            EdgeInsets.zero,
                                                        content:
                                                            detail_penjualan(),
                                                      ),
                                                      arguments: controller
                                                              .penjualan_list[
                                                          index]);
                                                  //popscreen().penjualandetail(con, data[index]);
                                                  //Get.toNamed('/detail_penjualan', arguments: data[index]);
                                                },
                                                icon: Icon(
                                                  Icons.list,
                                                  size: 18,
                                                )),
                                          ),
                                          Expanded(
                                            child: IconButton(
                                                onPressed: () {
                                                  popscreen().reversalpenjualan(
                                                      controller,
                                                      controller.penjualan_list[
                                                          index]);
                                                },
                                                icon: Icon(
                                                  Icons.cancel,
                                                  size: 18,
                                                  color: color_template()
                                                      .tritadery,
                                                )),
                                          )
                                        ],
                                      ),
                                    )),
                                  ])),
                        ),
                );
              }),
            ),
            Obx(() {
              return Container(
                margin: EdgeInsets.only(left: context.width_query / 1.9),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text('Data perbaris :'),
                    Text(controller.perpage.value.toString()),
                    controller.currentpage > 1
                        ? IconButton(
                            onPressed: () {
                              controller.back();
                            },
                            icon: Icon(FontAwesomeIcons.angleLeft, size: 20))
                        : IconButton(
                            onPressed: null,
                            icon: Icon(
                              FontAwesomeIcons.angleLeft,
                              size: 20,
                              color: Colors.grey,
                            )),
                    Text(controller.currentpage.value.toString() +
                        ' - ' +
                        controller.totalpage.value.toString()),
                    controller.currentpage < controller.totalpage.value
                        ? IconButton(
                            onPressed: () {
                              controller.next();
                            },
                            icon: Icon(
                              FontAwesomeIcons.angleRight,
                              size: 20,
                            ))
                        : IconButton(
                            onPressed: null,
                            icon: Icon(
                              FontAwesomeIcons.angleRight,
                              color: Colors.grey,
                              size: 20,
                            ))
                  ],
                ),
              );
            })
          ],
        ),
      ),
    );
  }
}

class penjualanTable extends DataTableSource {
  final List<DataPenjualan> data;

  penjualanTable(this.data);

  var con = Get.find<historyController>();

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => data.length;

  @override
  int get selectedRowCount => 0;

  @override
  DataRow getRow(int index) {
    return DataRow(cells: [
      DataCell(Center(child: Text(data[index].tglPenjualan))),
      DataCell(Center(child: Text(data[index].namaUser))),
      DataCell(Center(child: Text(data[index].totalItem))),
      DataCell(Center(
          child: Text('Rp. ' +
              con.nominal.format(double.parse(data[index].subTotal))))),
      DataCell(Center(
          child: Text(
              'Rp. ' + con.nominal.format(double.parse(data[index].total))))),
      DataCell(Center(
          child: Text(
              'Rp. ' + con.nominal.format(double.parse(data[index].bayar))))),
      DataCell(Center(
          child: data[index].status == 1
              ? Container(
                  padding: EdgeInsets.all(6),
                  decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(10)),
                  child: Text(
                    'Selesai',
                    style: TextStyle(color: Colors.white),
                  ),
                )
              : data[index].status == 2
                  ? Container(
                      padding: EdgeInsets.all(6),
                      decoration: BoxDecoration(
                          color: Colors.orange,
                          borderRadius: BorderRadius.circular(10)),
                      child:
                          Text('Hutang', style: TextStyle(color: Colors.white)),
                    )
                  : data[index].status == 3
                      ? Container(
                          padding: EdgeInsets.all(6),
                          decoration: BoxDecoration(
                              color: Colors.purple,
                              borderRadius: BorderRadius.circular(10)),
                          child: Text('Bayar Nanti',
                              style: TextStyle(color: Colors.white)),
                        )
                      : data[index].status == 4
                          ? Container(
                              padding: EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                  color: color_template().tritadery,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Text('Reversal',
                                  style: TextStyle(color: Colors.white)),
                            )
                          : Text('-'))),
      DataCell(Center(
        child: Row(
          children: [
            Expanded(
              child: IconButton(
                  onPressed: () {
                    Get.dialog(
                        AlertDialog(
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0))),
                          contentPadding: EdgeInsets.zero,
                          content: detail_penjualan(),
                        ),
                        arguments: data[index]);
                    //popscreen().penjualandetail(con, data[index]);
                    //Get.toNamed('/detail_penjualan', arguments: data[index]);
                  },
                  icon: Icon(
                    Icons.list,
                    size: 18,
                  )),
            ),
            Expanded(
              child: IconButton(
                  onPressed: () {
                    popscreen().reversalpenjualan(con, data[index]);
                  },
                  icon: Icon(
                    Icons.cancel,
                    size: 18,
                    color: color_template().tritadery,
                  )),
            )
          ],
        ),
      )),
    ]);
  }
}
