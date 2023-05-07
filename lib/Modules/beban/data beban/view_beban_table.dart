import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:rims_waserda/Modules/Widgets/card_custom.dart';
import 'package:rims_waserda/Modules/Widgets/loading.dart';
import 'package:rims_waserda/Modules/beban/data%20beban/model_data_beban.dart';

import '../../../Templates/setting.dart';
import '../../Widgets/buttons.dart';
import '../../Widgets/header.dart';
import '../../Widgets/popup.dart';
import 'controller_beban.dart';

class beban_table extends GetView<bebanController> {
  const beban_table({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card_custom(
      border: false,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 50),
                      child: header(
                        iscenter: false,
                        title: 'Data Beban',
                        icon: FontAwesomeIcons.dollarSign,
                        icon_funtion: Icons.refresh,
                        function: () async {
                          Get.dialog(Container(
                            width: 300,
                            height: 150,
                            child: showloading(),
                          ));
                          await controller.fetchDataBeban();
                          await controller.fetchJenisBeban();
                          Get.back();
                        },
                      ),
                    ),
                  ),
                  button_solid_custom(
                      onPressed: () {
                        Get.toNamed('/tambah_beban');

                        // Get.dialog(SingleChildScrollView(
                        //   child: AlertDialog(
                        //       elevation: 0,
                        //       backgroundColor: Colors.transparent,
                        //       content: Center(
                        //         child: Container(
                        //             width: context.width_query / 1.3,
                        //             child: tambah_produk_form()),
                        //       )),
                        // ));
                      },
                      child: Text(
                        'Tambah beban',
                        style: font().header,
                      ),
                      width: context.width_query * 0.2,
                      height: 65)
                ],
              ),
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
                        controller: controller.search.value,
                        onChanged: ((String pass) {
                          controller.fetchDataBeban();
                        }),
                        decoration: InputDecoration(
                          icon: Icon(Icons.add_box),
                          labelText: "cari beban",
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
                icon_button_custom(
                    onPressed: () {
                      controller.fetchDataBeban();
                    },
                    icon: Icons.search,
                    container_color: color_template().primary),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    //width: 200,
                    child: TextFormField(
                      controller: controller.searchhariini.value,
                      onChanged: ((String pass) {
                        controller.fetchDataBebanHariIni();
                      }),
                      decoration: InputDecoration(
                        icon: Icon(Icons.edit_calendar_outlined),
                        labelText: "cari beban hari ini",
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
                    onPressed: () {
                      controller.fetchDataBebanHariIni();
                    },
                    icon: Icons.search,
                    container_color: color_template().primary),
              ],
            ),
            Expanded(
              child: Obx(() {
                onSortColum(int columnIndex, bool ascending) {
                  if (columnIndex == 0) {
                    if (ascending) {
                      controller.databebanlist
                          .sort((a, b) => a.tgl.compareTo(b.tgl));
                    } else {
                      controller.databebanlist
                          .sort((a, b) => b.tgl.compareTo(a.tgl));
                    }
                  } else if (columnIndex == 1) {
                    if (ascending) {
                      controller.databebanlist
                          .sort((a, b) => a.nama.compareTo(b.nama));
                    } else {
                      controller.databebanlist
                          .sort((a, b) => b.nama.compareTo(a.nama));
                    }
                  } else if (columnIndex == 2) {
                    if (ascending) {
                      controller.databebanlist
                          .sort((a, b) => b.jumlah.compareTo(a.jumlah));
                    } else {
                      controller.databebanlist
                          .sort((a, b) => a.jumlah.compareTo(b.jumlah));
                    }
                  } else if (columnIndex == 3) {
                    if (ascending) {
                      controller.databebanlist.sort(
                          (a, b) => b.namaKtrBeban.compareTo(a.namaKtrBeban));
                    } else {
                      controller.databebanlist.sort(
                          (a, b) => a.namaKtrBeban.compareTo(b.namaKtrBeban));
                    }
                  }
                }

                return Container(
                  // height: context.height_query / 2.5,
                  margin: EdgeInsets.only(top: 12),
                  // width: double.infinity,
                  child: controller.databebanlist.value.isEmpty
                      ? Container(width: 100, height: 100, child: showloading())
                      :
                      //untuk paginated table yg pakek data source harus buat var lg di dalam obx
                      //dan di class source nya di buat konstruktor untuk di lembar var data dari kontroller

                      DataTable2(
                          sortAscending: controller.sort.value,
                          sortColumnIndex: controller.ColIndex.value,
                          fixedTopRows: 1,
                          horizontalMargin: 10,
                          columnSpacing: 5,
                          headingRowColor: MaterialStateColor.resolveWith(
                              (states) =>
                                  color_template().primary.withOpacity(0.2)),
                          columns: <DataColumn>[
                            DataColumn(
                              label: Text(
                                'Tanggal',
                              ),
                              onSort: (int columnIndex, bool ascending) {
                                controller.sort.value = !controller.sort.value;
                                controller.ColIndex.value = columnIndex;
                                onSortColum(columnIndex, ascending);
                              },
                            ),
                            DataColumn(
                              label: Text(
                                'Nama Beban',
                              ),
                              onSort: (int columnIndex, bool ascending) {
                                controller.sort.value = !controller.sort.value;
                                controller.ColIndex.value = columnIndex;
                                onSortColum(columnIndex, ascending);
                              },
                            ),
                            DataColumn(
                              label: Text(
                                'jumlah',
                              ),
                              onSort: (int columnIndex, bool ascending) {
                                controller.sort.value = !controller.sort.value;
                                controller.ColIndex.value = columnIndex;
                                onSortColum(columnIndex, ascending);
                              },
                            ),
                            DataColumn(
                              label: Text(
                                'Kategori',
                              ),
                              onSort: (int columnIndex, bool ascending) {
                                controller.sort.value = !controller.sort.value;
                                controller.ColIndex.value = columnIndex;
                                onSortColum(columnIndex, ascending);
                              },
                            ),
                            DataColumn(
                              label: Text(
                                'Aksi',
                              ),
                            ),
                          ],
                          rows: List.generate(
                              controller.databebanlist.length,
                              (index) => DataRow(cells: [
                                    DataCell(Text(
                                        controller.databebanlist[index].tgl)),
                                    DataCell(Text(
                                        controller.databebanlist[index].nama)),
                                    DataCell(Text('Rp. ' +
                                        controller.nominal.format(double.parse(
                                            controller.databebanlist[index]
                                                .jumlah)))),
                                    DataCell(Text(controller
                                        .databebanlist[index].namaKtrBeban)),
                                    DataCell(Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        IconButton(
                                            onPressed: () {
                                              Get.toNamed('/edit_beban',
                                                  arguments: controller
                                                      .databebanlist[index]);
                                            },
                                            icon: Icon(
                                              Icons.edit,
                                              size: 18,
                                              color: color_template().secondary,
                                            )),
                                        IconButton(
                                            onPressed: () {
                                              popscreen().deletebebanv2(
                                                  controller,
                                                  controller
                                                      .databebanlist[index]);
                                            },
                                            icon: Icon(
                                              Icons.delete,
                                              size: 18,
                                              color: color_template().tritadery,
                                            ))
                                      ],
                                    )),
                                  ])),
                          empty: Center(
                            child: Text(
                              "Data Kosong",
                              style: font().header_black,
                            ),
                          )),
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

class bebanTable extends DataTableSource {
  final List<DataBeban> data;

  bebanTable(this.data);

  var con = Get.find<bebanController>();

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => data.length;

  @override
  int get selectedRowCount => 0;

  @override
  DataRow getRow(int index) {
    return DataRow(cells: [
      DataCell(Center(child: Text(data[index].nama))),
      DataCell(Center(child: Text(data[index].keterangan))),
      DataCell(Center(child: Text(data[index].tgl))),
      DataCell(Center(
          child: Text(
              'Rp. ' + con.nominal.format(double.parse(data[index].jumlah))))),
      DataCell(Center(child: Text(data[index].namaKtrBeban))),
      DataCell(Center(
        child: Row(
          children: [
            Expanded(
              child: IconButton(
                  onPressed: () {
                    Get.toNamed('/edit_beban', arguments: data[index]);
                  },
                  icon: Icon(
                    Icons.edit,
                    size: 18,
                    color: color_template().secondary,
                  )),
            ),
            Expanded(
              child: IconButton(
                  onPressed: () {
                    popscreen().deletebebanv2(con, data[index]);
                  },
                  icon: Icon(
                    Icons.delete,
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
