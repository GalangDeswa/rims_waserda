import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:rims_waserda/Modules/Widgets/card_custom.dart';

import '../../../Templates/setting.dart';
import '../../Widgets/buttons.dart';
import '../../Widgets/header.dart';
import '../../Widgets/loading.dart';
import 'controller_hutang.dart';

class hutang_table extends GetView<hutangController> {
  const hutang_table({Key? key}) : super(key: key);

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
                //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: header(
                      iscenter: false,
                      title: 'Riwayat hutang',
                      icon: FontAwesomeIcons.moneyBill,
                      icon_funtion: Icons.refresh,
                      function: () async {
                        Get.dialog(Container(
                          width: 300,
                          height: 150,
                          child: showloading(),
                        ));
                        await controller.fetchDataHutang();

                        Get.back();
                      },
                    ),
                  ),
                  // button_solid_custom(
                  //     onPressed: () {
                  //       Get.toNamed('/tambah_hutang');
                  //
                  //       // Get.dialog(SingleChildScrollView(
                  //       //   child: AlertDialog(
                  //       //       elevation: 0,
                  //       //       backgroundColor: Colors.transparent,
                  //       //       content: Center(
                  //       //         child: Container(
                  //       //             width: context.width_query / 1.3,
                  //       //             child: tambah_produk_form()),
                  //       //       )),
                  //       // ));
                  //     },
                  //     child: Text(
                  //       'Tambah hutang',
                  //       style: font().header,
                  //     ),
                  //     width: context.width_query * 0.2,
                  //     height: 65)
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
                          //controller.fetchDataBeban();
                        }),
                        decoration: InputDecoration(
                          icon: Icon(Icons.add_box),
                          labelText: "Cari hutang",
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
                      //controller.fetchDataBeban();
                    },
                    icon: Icons.search,
                    container_color: color_template().primary),
              ],
            ),
            Expanded(
              child: Obx(() {
                return Container(
                  // height: context.height_query / 2.5,
                  margin: EdgeInsets.only(top: 12),
                  // width: double.infinity,
                  child: controller.list_hutangv2.value.isEmpty
                      ? Container(width: 100, height: 100, child: showloading())
                      :
                      //untuk paginated table yg pakek data source harus buat var lg di dalam obx
                      //dan di class source nya di buat konstruktor untuk di lembar var data dari kontroller

                      DataTable2(
                          horizontalMargin: 10,
                          columnSpacing: 5,
                          headingRowColor: MaterialStateColor.resolveWith(
                              (states) =>
                                  color_template().primary.withOpacity(0.2)),
                          columns: <DataColumn>[
                            DataColumn(
                              label: Text(
                                'Tanggal hutang',
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                'Nama Pelanggan',
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                'Hutang',
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                'status',
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                'Aksi',
                              ),
                            ),
                          ],
                          rows: List.generate(
                              controller.list_hutangv2.length,
                              (index) => DataRow(cells: [
                                    DataCell(Text(controller
                                        .list_hutangv2[index].tglHutang
                                        .toString())),
                                    DataCell(Text(controller
                                        .list_hutangv2[index].namaPelanggan)),
                                    DataCell(Text('Rp.' +
                                        controller.nominal.format(int.parse(
                                            controller
                                                .list_hutangv2[index].hutang
                                                .toString())))),
                                    DataCell(controller
                                                .list_hutangv2[index].status ==
                                            1
                                        ? Container(
                                            padding: EdgeInsets.all(6),
                                            decoration: BoxDecoration(
                                                color: Colors.green,
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            child: Text(
                                              'Lunas',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                            ))
                                        : Container(
                                            padding: EdgeInsets.all(6),
                                            decoration: BoxDecoration(
                                                color: Colors.orange,
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            child: Text(
                                              'Hutang',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                            ))),
                                    DataCell(Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        IconButton(
                                            onPressed: () {
                                              Get.dialog(AlertDialog(
                                                content: Container(
                                                  width:
                                                      context.width_query / 1.5,
                                                  height:
                                                      context.height_query / 2,
                                                  child: Column(
                                                    children: [
                                                      Container(
                                                        width: context
                                                                .width_query /
                                                            1.5,
                                                        height: context
                                                                .height_query /
                                                            2,
                                                        child: DataTable2(
                                                            columns: <
                                                                DataColumn>[
                                                              DataColumn(
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
                                                                controller
                                                                    .list_hutangv2[
                                                                        index]
                                                                    .riwayatHutang
                                                                    .length,
                                                                (i) => DataRow(
                                                                        cells: [
                                                                          DataCell(Text(controller
                                                                              .list_hutangv2[index]
                                                                              .riwayatHutang[i]
                                                                              .tglHutang
                                                                              .toString())),
                                                                          DataCell(Text(controller
                                                                              .list_hutangv2[index]
                                                                              .riwayatHutang[i]
                                                                              .bayar
                                                                              .toString())),
                                                                          DataCell(controller.list_hutangv2[index].riwayatHutang[i].tglBayar == null
                                                                              ? Text('-')
                                                                              : Text(controller.list_hutangv2[index].riwayatHutang[i].tglBayar.toString())),
                                                                          DataCell(Text(controller
                                                                              .list_hutangv2[index]
                                                                              .riwayatHutang[i]
                                                                              .sisa
                                                                              .toString())),
                                                                          DataCell(controller.list_hutangv2[index].riwayatHutang[i].tglLunas == null
                                                                              ? Text('-')
                                                                              : Text(controller.list_hutangv2[index].riwayatHutang[i].tglLunas.toString())),
                                                                        ]))),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ));
                                            },
                                            icon: Icon(
                                              Icons.list,
                                              size: 18,
                                              color: color_template().secondary,
                                            )),
                                        IconButton(
                                            onPressed: () {
                                              controller.bayarhutangpop(
                                                  controller
                                                      .list_hutangv2[index].id
                                                      .toString(),
                                                  controller
                                                      .list_hutangv2[index]
                                                      .hutang
                                                      .toString());
                                            },
                                            icon: Icon(
                                              FontAwesomeIcons.dollarSign,
                                              size: 18,
                                              color: color_template().secondary,
                                            )),
                                        // IconButton(
                                        //     onPressed: () {
                                        //       // popscreen().deletepelanggan(
                                        //       //     controller,
                                        //       //     controller
                                        //       //         .list_pelanggan[index]);
                                        //     },
                                        //     icon: Icon(
                                        //       Icons.delete,
                                        //       size: 18,
                                        //       color: color_template().tritadery,
                                        //     ))
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
