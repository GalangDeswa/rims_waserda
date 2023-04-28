import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:rims_waserda/Modules/Widgets/popup.dart';
import 'package:rims_waserda/Modules/pelanggan/data%20pelanggan/controller_data_pelanggan.dart';

import '../../../Templates/setting.dart';
import '../../Widgets/buttons.dart';
import '../../Widgets/header.dart';
import '../../Widgets/loading.dart';

class pelanggan_table extends GetView<pelangganController> {
  const pelanggan_table({Key? key}) : super(key: key);

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
                        title: 'Data Pelanggan',
                        icon: FontAwesomeIcons.peopleGroup,
                        icon_funtion: Icons.refresh,
                        function: () async {
                          Get.dialog(Container(
                            width: 300,
                            height: 150,
                            child: showloading(),
                          ));
                          await controller.fetchDataPelanggan();

                          Get.back();
                        },
                      ),
                    ),
                  ),
                  button_solid_custom(
                      onPressed: () {
                        Get.toNamed('/tambah_pelanggan');

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
                        'Tambah pelanggan',
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
                          //controller.fetchDataBeban();
                        }),
                        decoration: InputDecoration(
                          icon: Icon(Icons.add_box),
                          labelText: "Cari pelanggan",
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
                  child: controller.list_pelanggan.value.isEmpty
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
                                'Nama Pelanggan',
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                'Nomor Hp',
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
                              controller.list_pelanggan.length,
                              (index) => DataRow(cells: [
                                    DataCell(Text(controller
                                        .list_pelanggan[index].namaPelanggan)),
                                    DataCell(Text(
                                        controller.list_pelanggan[index].noHp)),
                                    DataCell(controller.list_pelanggan[index]
                                            .riwayatPembelian
                                            .map((e) => e.status)
                                            .contains(3)
                                        ? Container(
                                            padding: EdgeInsets.all(6),
                                            decoration: BoxDecoration(
                                                color: color_template().select,
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            child: Text(
                                              'Masih hutang',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                            ))
                                        : controller.list_pelanggan[index]
                                                .riwayatPembelian
                                                .map((e) => e.tglPenjualan)
                                                .isEmpty
                                            ? Container(
                                                padding: EdgeInsets.all(6),
                                                decoration: BoxDecoration(
                                                    color: Colors.green,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                                child: Text(
                                                  'Belum ada transaksi',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ))
                                            : Container(
                                                padding: EdgeInsets.all(6),
                                                decoration: BoxDecoration(
                                                    color: Colors.green,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                                child: Text(
                                                  'Sudah lunas',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold),
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
                                                      context.width_query / 2,
                                                  height:
                                                      context.height_query / 2,
                                                  child: Column(
                                                    children: [
                                                      Container(
                                                        width: context
                                                                .width_query /
                                                            2,
                                                        height: context
                                                                .height_query /
                                                            2,
                                                        child: DataTable2(
                                                            columns: <
                                                                DataColumn>[
                                                              DataColumn(
                                                                label: Center(
                                                                  child: Text(
                                                                    'total item',
                                                                    style: TextStyle(
                                                                        fontStyle:
                                                                            FontStyle.italic),
                                                                  ),
                                                                ),
                                                              ),
                                                              DataColumn(
                                                                label: Center(
                                                                  child: Text(
                                                                    'bayar',
                                                                    style: TextStyle(
                                                                        fontStyle:
                                                                            FontStyle.italic),
                                                                  ),
                                                                ),
                                                              ),
                                                              DataColumn(
                                                                label: Center(
                                                                  child: Text(
                                                                    'Tanggal transaksi',
                                                                    style: TextStyle(
                                                                        fontStyle:
                                                                            FontStyle.italic),
                                                                  ),
                                                                ),
                                                              ),
                                                              DataColumn(
                                                                label: Center(
                                                                  child: Text(
                                                                    'status',
                                                                    style: TextStyle(
                                                                        fontStyle:
                                                                            FontStyle.italic),
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                            rows: List.generate(
                                                                controller
                                                                    .list_pelanggan[
                                                                        index]
                                                                    .riwayatPembelian
                                                                    .length,
                                                                (i) => DataRow(
                                                                        cells: [
                                                                          DataCell(
                                                                              Center(child: Text(controller.list_pelanggan[index].riwayatPembelian[i].total))),
                                                                          DataCell(
                                                                              Center(child: Text(controller.list_pelanggan[index].riwayatPembelian[i].bayar))),
                                                                          DataCell(
                                                                              Center(child: Text(controller.list_pelanggan[index].riwayatPembelian[i].tglPenjualan.toString()))),
                                                                          DataCell(Center(
                                                                              child: controller.list_pelanggan[index].riwayatPembelian[i].status == 1
                                                                                  ? Container(
                                                                                      padding: EdgeInsets.all(6),
                                                                                      decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.circular(10)),
                                                                                      child: Text(
                                                                                        'Lunas',
                                                                                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                                                                      ))
                                                                                  : controller.list_pelanggan[index].riwayatPembelian[i].status == 2
                                                                                      ? Container(
                                                                                          padding: EdgeInsets.all(6),
                                                                                          decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.circular(10)),
                                                                                          child: Text(
                                                                                            'Lunas',
                                                                                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                                                                          ))
                                                                                      : Container(
                                                                                          padding: EdgeInsets.all(6),
                                                                                          decoration: BoxDecoration(color: Colors.orange, borderRadius: BorderRadius.circular(10)),
                                                                                          child: Text(
                                                                                            'Hutang',
                                                                                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                                                                                          ))))
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
                                              Get.toNamed('/edit_pelanggan',
                                                  arguments: controller
                                                      .list_pelanggan[index]);
                                            },
                                            icon: Icon(
                                              Icons.edit,
                                              size: 18,
                                              color: color_template().secondary,
                                            )),
                                        IconButton(
                                            onPressed: () {
                                              popscreen().deletepelanggan(
                                                  controller,
                                                  controller
                                                      .list_pelanggan[index]);
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
