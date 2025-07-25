import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:rims_waserda/Modules/Widgets/card_custom.dart';
import 'package:rims_waserda/Modules/Widgets/loading.dart';
import 'package:rims_waserda/Modules/Widgets/popup.dart';
import 'package:rims_waserda/Modules/history/view_detail_penjualan.dart';
import 'package:rims_waserda/Modules/pelanggan/hutang/model_hutang_detail.dart';

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
              title: 'Riwayat Penjualan',
              icon: FontAwesomeIcons.moneyBills,
              icon_funtion: Icons.refresh,
              function: () async {
                Get.dialog(showloading());
                await controller.fetchPenjualanlocal(
                    id_toko: controller.id_toko,
                    id_user: controller.id_user,
                    role: controller.role);
                // await controller.initPenjualanToLocal(controller.id_toko);
                Get.back();
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
                      height: context.height_query / 15,
                      child: TextFormField(
                        onTap: () {
                          FocusScope.of(context).requestFocus(new FocusNode());
                          showDialog(
                              context: context,
                              builder: (_) => AlertDialog(
                                    content: Container(
                                      width: context.width_query / 2,
                                      //  height: context.height_query / 2,
                                      child:
                                          CalendarDatePicker2WithActionButtons(
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
                                                      calendarType:
                                                          CalendarDatePicker2Type
                                                              .range),
                                              value: controller.datedata,
                                              onValueChanged: (dates) {
                                                print(dates);
                                                controller.datedata = dates;
                                                controller.stringdate();
                                                controller
                                                    .searchpenjualanlocal();
                                                controller.stts.value = false;
                                                controller.valstatus =
                                                    0.toString();

                                                Get.back();
                                              }),
                                    ),
                                  ));
                        },
                        controller: controller.search.value,
                        onChanged: ((String pass) async {
                          await controller.searchpenjualanlocal();
                        }),
                        decoration: InputDecoration(
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
                              await controller.fetchPenjualanlocal(
                                  id_toko: controller.id_toko,
                                  id_user: controller.id_user,
                                  role: controller.role);
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
                          wrapInCard: false,
                          columnSpacing: 0,
                          sortAscending: controller.sort.value,
                          sortColumnIndex: controller.ColIndex.value,
                          horizontalMargin: 10,
                          renderEmptyRowsInTheEnd: false,
                          //minWidth: 1000,
                          //minWidth: 10,
                          //fit: FlexFit.loose,

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
                                'kasir',
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
                                'pelanggan',
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
                              label: Center(
                                child: Text(
                                  'Aksi',
                                  style: TextStyle(fontStyle: FontStyle.italic),
                                ),
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

  @override
  DataRow getRow(int index) {
    var dtl = <DataHutangDetail>[].obs;
    dtl.value = con.list_hutang_detaillocal
        .where((e) => e.idHutang == data[index].idHutang)
        .toList();
    return DataRow(cells: [
      DataCell(Text(
        con.dateFormat.format(DateTime.parse(data[index].tglPenjualan!)),
        style: font().reguler,
        overflow: TextOverflow.ellipsis,
      )),
      DataCell(Text(
        data[index].namaUser!,
        style: font().reguler,
        overflow: TextOverflow.ellipsis,
      )),
      DataCell(Text(
        data[index].namaPelanggan!,
        style: font().reguler,
        overflow: TextOverflow.ellipsis,
      )),
      DataCell(Text(
        data[index].totalItem.toString(),
        style: font().reguler,
        overflow: TextOverflow.ellipsis,
      )),
      DataCell(Text(
        'Rp. ' + con.nominal.format(data[index].subTotal),
        style: font().reguler,
        overflow: TextOverflow.ellipsis,
      )),
      DataCell(Text(
        'Rp. ' + con.nominal.format(data[index].total),
        style: font().reguler,
        overflow: TextOverflow.ellipsis,
      )),
      DataCell(Text(
        'Rp. ' + con.nominal.format(data[index].bayar),
        style: font().reguler,
        overflow: TextOverflow.ellipsis,
      )),
      DataCell(dtl.isNotEmpty && data[index].status == 3
          // data[index].status != 1 &&
          // data[index].status != 4
          ? Container(
              padding: EdgeInsets.all(6),
              decoration: BoxDecoration(
                  color: Colors.teal, borderRadius: BorderRadius.circular(10)),
              child: Text(
                'Sudah bayar sebagian',
                style: font().reguler_white,
                overflow: TextOverflow.ellipsis,
              ))
          : data[index].status == 1
              ? Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(10)),
                  child: Text(
                    'Selesai',
                    style: font().reguler_white,
                    overflow: TextOverflow.ellipsis,
                  ),
                )
              : data[index].status == 2
                  ? Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                          color: Colors.orange,
                          borderRadius: BorderRadius.circular(10)),
                      child: Text(
                        'Hutang',
                        style: font().reguler_white,
                        overflow: TextOverflow.ellipsis,
                      ),
                    )
                  : data[index].status == 3
                      ? Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                              color: Colors.orange,
                              borderRadius: BorderRadius.circular(10)),
                          child: Text(
                            'Tunda',
                            style: font().reguler_white,
                            overflow: TextOverflow.ellipsis,
                          ),
                        )
                      : data[index].status == 4
                          ? Container(
                              padding: const EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                  color: color_template().tritadery,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Text(
                                'Reversal',
                                style: font().reguler_white,
                                overflow: TextOverflow.ellipsis,
                              ),
                            )
                          : Text(
                              '-',
                              style: font().reguler,
                              overflow: TextOverflow.ellipsis,
                            )),
      DataCell(Container(
        child: Center(
          child: data[index].status == 4
              ? DropdownButton2(
                  customButton: const Icon(
                    Icons.list,
                  ),
                  items: [
                    ...MenuItems.firstItems.map(
                      (item) => DropdownMenuItem<MenuItem>(
                        value: item,
                        child: MenuItems.buildItem(item),
                      ),
                    ),
                  ],
                  onChanged: (value) {
                    MenuItems.onChanged(
                        context, value! as MenuItem, data[index]);
                  },
                  dropdownStyleData: DropdownStyleData(
                    width: 160,
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                    ),
                    offset: const Offset(0, 8),
                  ),
                )
              : DropdownButton2(
                  customButton: const Icon(
                    Icons.list,
                  ),
                  items: [
                    ...MenuItems.firstItems.map(
                      (item) => DropdownMenuItem<MenuItem>(
                        value: item,
                        child: MenuItems.buildItem(item),
                      ),
                    ),
                    const DropdownMenuItem<Divider>(
                        enabled: false, child: Divider()),
                    ...MenuItems.secondItems.map(
                      (item) => DropdownMenuItem<MenuItem>(
                        value: item,
                        child: MenuItems.buildItem(item),
                      ),
                    ),
                  ],
                  onChanged: (value) {
                    MenuItems.onChanged(
                        context, value! as MenuItem, data[index]);
                  },
                  dropdownStyleData: DropdownStyleData(
                    width: 160,
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                    ),
                    offset: const Offset(0, 8),
                  ),
                  menuItemStyleData: MenuItemStyleData(
                    customHeights: [
                      ...List<double>.filled(MenuItems.firstItems.length, 48),
                      8,
                      ...List<double>.filled(MenuItems.secondItems.length, 48),
                    ],
                    padding: const EdgeInsets.only(left: 16, right: 16),
                  ),
                ),
        ),
      )),
    ]);
  }
}

class MenuItem {
  const MenuItem({
    required this.text,
    required this.icon,
    this.iconcolor,
  });

  final String text;
  final IconData icon;
  final bool? iconcolor;
}

abstract class MenuItems {
  static const List<MenuItem> firstItems = [cetak, detail];
  static const List<MenuItem> secondItems = [hapus];

  static const cetak =
      MenuItem(text: 'Cetak struk', icon: Icons.receipt_long, iconcolor: false);
  static const detail = MenuItem(
      text: 'Detail penjualan', icon: Icons.table_rows, iconcolor: false);
  static const hapus =
      MenuItem(text: 'Reversal', icon: Icons.cancel, iconcolor: true);

  static Widget buildItem(MenuItem item) {
    return Row(
      children: [
        Icon(item.icon,
            color: item.iconcolor == false
                ? color_template().primary_dark
                : color_template().tritadery,
            size: 22),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: Text(
            item.text,
            style: font().reguler,
          ),
        ),
      ],
    );
  }

  static void onChanged(
      BuildContext context, MenuItem item, DataPenjualan data) {
    var con = Get.find<historyController>();
    switch (item) {
      case MenuItems.cetak:
        print('edit');
        popscreen().popprintstrukulang(context, con, data);
        break;
      case MenuItems.detail:
        Get.dialog(
            const AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0))),
              contentPadding: EdgeInsets.zero,
              content: detail_penjualan(),
            ),
            arguments: data);
        break;
      case MenuItems.hapus:
        popscreen().reversalpenjualan(con, data);
        break;
    }
  }
}
