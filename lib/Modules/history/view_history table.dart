import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rims_waserda/Modules/Widgets/card_custom.dart';
import 'package:rims_waserda/Modules/Widgets/loading.dart';
import 'package:rims_waserda/Modules/Widgets/popup.dart';
import 'package:rims_waserda/Modules/history/view_detail_penjualan.dart';

import '../../Templates/setting.dart';
import '../Widgets/buttons.dart';
import '../Widgets/header.dart';
import 'Controller_history.dart';
import 'model_penjualan.dart';

class history_table extends GetView<historyController> {
  const history_table({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card_custom(
      border: false,
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
            const SizedBox(
              height: 10,
            ),
            Obx(() {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 3),
                      //width: 200,
                      child: TextFormField(
                        onTap: () {
                          FocusScope.of(context).requestFocus(new FocusNode());
                          showDialog(
                              context: context,
                              builder: (_) => AlertDialog(
                                    content: Container(
                                      width: context.width_query / 2,
                                      height: context.height_query / 2,
                                      child: CalendarDatePicker2(
                                          config: CalendarDatePicker2Config(
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
                                              calendarType:
                                                  CalendarDatePicker2Type
                                                      .single),
                                          value: controller.datedata,
                                          onValueChanged: (dates) {
                                            print(dates);
                                            controller.datedata = dates;
                                            controller.stringdate();
                                            controller.searchpenjualanlocal();
                                            controller.stts.value = false;
                                            controller.valstatus = 0.toString();

                                            Get.back();
                                          }),
                                    ),
                                  ));
                        },
                        controller: controller.search.value,
                        onChanged: ((String pass) {
                          controller.searchpenjualanlocal();
                        }),
                        decoration: InputDecoration(
                          icon: const Icon(Icons.add_box),
                          labelText: "Cari tanggal penjualan",
                          labelStyle: const TextStyle(
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
                        controller.searchpenjualanlocal();
                      },
                      icon: Icons.search,
                      container_color: color_template().primary),
                  // Expanded(
                  //   child: Container(
                  //     margin: const EdgeInsets.symmetric(horizontal: 3),
                  //     //width: 200,
                  //     child: TextFormField(
                  //       //controller: controller.id_kas.value,
                  //       onChanged: ((String pass) {}),
                  //       decoration: InputDecoration(
                  //         icon: const Icon(Icons.add_box),
                  //         labelText: "Penjualan Hari Ini",
                  //         labelStyle: const TextStyle(
                  //           color: Colors.black87,
                  //         ),
                  //         border: UnderlineInputBorder(
                  //             borderRadius: BorderRadius.circular(10)),
                  //         focusedBorder: OutlineInputBorder(
                  //             borderRadius: BorderRadius.circular(10)),
                  //       ),
                  //       textAlign: TextAlign.center,
                  //       validator: (value) {
                  //         if (value!.isEmpty) {
                  //           return 'Please enter email';
                  //         }
                  //         return null;
                  //       },
                  //     ),
                  //   ),
                  // ),
                  // icon_button_custom(
                  //     onPressed: () async {
                  //       Get.dialog(const showloading());
                  //       await controller.fetchPenjualanHariIni();
                  //
                  //       Get.back();
                  //     },
                  //     icon: Icons.search,
                  //
                  //     container_color: color_template().primary),

                  //TODO : cek laporan api
                  Obx(() {
                    return controller.search.value.text.isEmpty
                        ? Container()
                        : Container(
                            width: 150,
                            margin: const EdgeInsets.only(left: 5),
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
                              hint: const Text('status'),
                              value: controller.valstatus,
                              items: controller.liststatus.value.map((item) {
                                return DropdownMenuItem(
                                    child: Text(item['nama'].toString()),
                                    value: item['id'].toString());
                              }).toList(),
                              onChanged: (val) async {
                                if (val == '0') {
                                  controller.stts.value = false;
                                  print('val === 0');
                                  print(controller.stts);
                                  await controller.searchpenjualanlocal();
                                } else {
                                  print('val === $val');
                                  controller.stts.value = true;
                                  print(controller.stts);
                                  await controller
                                      .searchpenjualanstatuslocal(val);
                                }

                                // controller.stts.value = true;
                                // controller.valstatus = val!.toString();
                                // var start = await controller.fetchPenjualan();
                                // var query = await start
                                //     .where((e) => e.status.toString() == val)
                                //     .toList();
                                // controller.penjualan_list_local.value = query;
                                // print(query);
                                // print(controller.valstatus);
                              },
                            ),
                          );
                  }),
                  Obx(() {
                    return controller.stts.value == false
                        ? Container()
                        : IconButton(
                            onPressed: () async {
                              controller.stts.value = false;
                              controller.valstatus = '0';
                              controller.search.value.clear();
                              controller.datedata.clear();
                              await controller
                                  .fetchPenjualanlocal(controller.id_toko);
                            },
                            icon: Icon(
                              Icons.cancel,
                              color: color_template().tritadery,
                            ),
                          );
                  }),
                ],
              );
            }),
            Expanded(
              child: Obx(() {
                var source = penjualanTable(
                        controller.penjualan_list_local.value, context)
                    .obs;
                onSortColum(int columnIndex, bool ascending) {
                  if (columnIndex == 0) {
                    if (ascending) {
                      controller.penjualan_list_local.sort(
                          (a, b) => a.tglPenjualan!.compareTo(b.tglPenjualan!));
                    } else {
                      controller.penjualan_list_local.sort(
                          (a, b) => b.tglPenjualan!.compareTo(a.tglPenjualan!));
                    }
                  } else if (columnIndex == 1) {
                    if (ascending) {
                      controller.penjualan_list_local
                          .sort((a, b) => a.namaUser!.compareTo(b.namaUser!));
                    } else {
                      controller.penjualan_list_local
                          .sort((a, b) => b.namaUser!.compareTo(a.namaUser!));
                    }
                  } else if (columnIndex == 2) {
                    if (ascending) {
                      controller.penjualan_list_local.sort((a, b) =>
                          b.namaPelanggan!.compareTo(a.namaPelanggan!));
                    } else {
                      controller.penjualan_list_local.sort((a, b) =>
                          a.namaPelanggan!.compareTo(b.namaPelanggan!));
                    }
                  } else if (columnIndex == 3) {
                    if (ascending) {
                      controller.penjualan_list_local
                          .sort((a, b) => b.totalItem!.compareTo(a.totalItem!));
                    } else {
                      controller.penjualan_list_local
                          .sort((a, b) => a.totalItem!.compareTo(b.totalItem!));
                    }
                  } else if (columnIndex == 4) {
                    if (ascending) {
                      controller.penjualan_list_local
                          .sort((a, b) => b.subTotal!.compareTo(a.subTotal!));
                    } else {
                      controller.penjualan_list_local
                          .sort((a, b) => a.subTotal!.compareTo(b.subTotal!));
                    }
                  } else if (columnIndex == 5) {
                    if (ascending) {
                      controller.penjualan_list_local
                          .sort((a, b) => b.total!.compareTo(a.total!));
                    } else {
                      controller.penjualan_list_local
                          .sort((a, b) => a.total!.compareTo(b.total!));
                    }
                  } else if (columnIndex == 6) {
                    if (ascending) {
                      controller.penjualan_list_local
                          .sort((a, b) => b.bayar!.compareTo(a.bayar!));
                    } else {
                      controller.penjualan_list_local
                          .sort((a, b) => a.bayar!.compareTo(b.bayar!));
                    }
                  } else if (columnIndex == 7) {
                    if (ascending) {
                      controller.penjualan_list_local
                          .sort((a, b) => b.status!.compareTo(a.status!));
                    } else {
                      controller.penjualan_list_local
                          .sort((a, b) => a.status!.compareTo(b.status!));
                    }
                  }
                }

                return Container(
                  //color: Colors.red,
                  // height: context.height_query / 1.6,
                  margin: const EdgeInsets.only(top: 10),
                  // width: double.infinity,
                  child: controller.succ == false
                      ? Container(
                          width: 100, height: 100, child: const showloading())
                      : PaginatedDataTable2(
                          sortAscending: controller.sort.value,
                          sortColumnIndex: controller.ColIndex.value,
                          horizontalMargin: 10,
                          renderEmptyRowsInTheEnd: false,
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
                              label: const Text(
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
                              label: const Text(
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
                              label: const Text(
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
                              label: const Text(
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
                              label: const Text(
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
                              label: const Text(
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
                              label: const Text(
                                'Bayar',
                                style: TextStyle(fontStyle: FontStyle.italic),
                              ),
                            ),
                            DataColumn(
                              onSort: (int columnIndex, bool ascending) {
                                controller.sort.value = !controller.sort.value;
                                controller.ColIndex.value = columnIndex;
                                onSortColum(columnIndex, ascending);
                              },
                              label: const Text(
                                'Status',
                                style: TextStyle(fontStyle: FontStyle.italic),
                              ),
                            ),
                            const DataColumn(
                              label: Text(
                                'Aksi',
                                style: TextStyle(fontStyle: FontStyle.italic),
                              ),
                            ),
                          ],
                          source: source.value,
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
            //         Text(controller.perpage.value.toString()),
            //         controller.currentpage > 1
            //             ? IconButton(
            //                 onPressed: () {
            //                   controller.back();
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
            //         Text(controller.currentpage.value.toString() +
            //             ' - ' +
            //             controller.totalpage.value.toString()),
            //         controller.currentpage < controller.totalpage.value
            //             ? IconButton(
            //                 onPressed: () {
            //                   controller.next();
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

class penjualanTable extends DataTableSource {
  final List<DataPenjualan> data;
  final BuildContext context;

  penjualanTable(this.data, this.context);

  var con = Get.find<historyController>();

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => data.length;

  @override
  int get selectedRowCount => 0;

  //TODO: chek data dashboard, chek penurangan stock pos

  @override
  DataRow getRow(int index) {
    return DataRow(cells: [
      DataCell(Text(
          con.dateFormat.format(DateTime.parse(data[index].tglPenjualan!)))),
      DataCell(Text(data[index].namaUser!)),
      DataCell(Text(data[index].namaPelanggan!)),
      DataCell(Text(data[index].totalItem.toString())),
      DataCell(Text('Rp. ' + con.nominal.format(data[index].subTotal))),
      DataCell(Text('Rp. ' + con.nominal.format(data[index].total))),
      DataCell(Text('Rp. ' + con.nominal.format(data[index].bayar))),
      DataCell(data[index].status == 1
          ? Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                  color: Colors.green, borderRadius: BorderRadius.circular(10)),
              child: const Text(
                'Selesai',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            )
          : data[index].status == 2
              ? Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(10)),
                  child: const Text('Selesai',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold)),
                )
              : data[index].status == 3
                  ? Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                          color: Colors.orange,
                          borderRadius: BorderRadius.circular(10)),
                      child: const Text('Hutang',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                    )
                  : data[index].status == 4
                      ? Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                              color: color_template().tritadery,
                              borderRadius: BorderRadius.circular(10)),
                          child: const Text('Reversal',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold)),
                        )
                      : const Text('-')),
      DataCell(Row(
        children: [
          Expanded(
            child: IconButton(
                onPressed: () {
                  Get.dialog(
                      const AlertDialog(
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
                icon: const Icon(
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
      )),
    ]);
  }
}
