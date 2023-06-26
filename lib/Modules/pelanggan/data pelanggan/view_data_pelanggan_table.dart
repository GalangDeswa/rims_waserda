import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:rims_waserda/Modules/Widgets/card_custom.dart';
import 'package:rims_waserda/Modules/pelanggan/data%20pelanggan/controller_data_pelanggan.dart';
import 'package:rims_waserda/Modules/pelanggan/data%20pelanggan/model_data_pelanggan.dart';

import '../../../Templates/setting.dart';
import '../../Widgets/buttons.dart';
import '../../Widgets/header.dart';
import '../../Widgets/loading.dart';
import '../../Widgets/popup.dart';

class pelanggan_table extends GetView<pelangganController> {
  const pelanggan_table({Key? key}) : super(key: key);

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
                        title: 'Data Pelanggan',
                        icon: FontAwesomeIcons.peopleGroup,
                        icon_funtion: Icons.refresh,
                        function: () async {
                          Get.dialog(Container(
                            width: 300,
                            height: 150,
                            child: showloading(),
                          ));
                          await controller
                              .fetchDataPelangganlocal(controller.id_toko);
                          // await controller.statuspelanggan();
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
                        'Tambah pelanggan'.toUpperCase(),
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
                      height: context.height_query / 15,
                      child: TextFormField(
                        controller: controller.search.value,
                        onChanged: ((String pass) {
                          controller.searchpelangganlocal();
                        }),
                        decoration: InputDecoration(
                          labelText: "Cari pelanggan",
                          hintText: 'Nama pelanggan',
                          labelStyle: TextStyle(
                            color: Colors.black87,
                          ),
                          border: UnderlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                        textAlign: TextAlign.start,
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
                      controller.searchpelangganlocal();
                    },
                    icon: Icons.search,
                    container_color: color_template().primary),
              ],
            ),
            Expanded(
              child: Obx(() {
                var source = pelangganTable(
                        controller.list_pelanggan_local.value, context)
                    .obs;
                return Container(
                  // height: context.height_query / 2.5,
                  margin: EdgeInsets.only(top: 12),
                  // width: double.infinity,
                  child: controller.succ == false
                      ? Container(width: 100, height: 100, child: showloading())
                      :
                      //untuk paginated table yg pakek data source harus buat var lg di dalam obx
                      //dan di class source nya di buat konstruktor untuk di lembar var data dari kontroller

                      PaginatedDataTable2(
                          wrapInCard: false,
                          columnSpacing: 0,
                          horizontalMargin: 10,
                          renderEmptyRowsInTheEnd: false,
                          headingRowColor: MaterialStateColor.resolveWith(
                              (states) =>
                                  color_template().primary.withOpacity(0.2)),
                          columns: <DataColumn>[
                            DataColumn(
                              label: Text(
                                'Nama Pelanggan',
                                style: font().reguler,
                              ),
                            ),
                            DataColumn(
                              label: Text('Nomor Hp', style: font().reguler),
                            ),
                            DataColumn(
                              label: Text('status', style: font().reguler),
                            ),
                            DataColumn(
                              label: Text('Aksi', style: font().reguler),
                            ),
                          ],
                          source: source.value,
                          empty: Center(
                            child: Text(
                              "Data Kosong",
                              style: font().header_black,
                            ),
                          )),
                );
              }),
            ),
            // Obx(() {
            //   return Container(
            //     margin: EdgeInsets.only(left: context.width_query / 1.9),
            //     child: Row(
            //       mainAxisAlignment: MainAxisAlignment.spaceAround,
            //       children: [
            //         Text('Data perbaris :'),
            //         Text(controller.perpage.value.toString()),
            //         controller.currentpage > 1
            //             ? IconButton(
            //                 onPressed: () {
            //                   controller.back();
            //                 },
            //                 icon: Icon(FontAwesomeIcons.angleLeft, size: 20))
            //             : IconButton(
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
            //                 icon: Icon(
            //                   FontAwesomeIcons.angleRight,
            //                   size: 20,
            //                 ))
            //             : IconButton(
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

class pelangganTable extends DataTableSource {
  final List<DataPelanggan> data;
  final BuildContext context;

  pelangganTable(this.data, this.context);

  var con = Get.find<pelangganController>();

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => data.length;

  @override
  int get selectedRowCount => 0;

  @override
  DataRow getRow(int index) {
    return DataRow(cells: [
      DataCell(Text(
        data[index].namaPelanggan!,
        style: font().reguler,
        overflow: TextOverflow.ellipsis,
      )),
      DataCell(Text(
        data[index].noHp!,
        style: font().reguler,
        overflow: TextOverflow.ellipsis,
      )),
      DataCell(
        con.statuspelanggan(
          data[index].id,
        ),
      ),
      DataCell(Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // IconButton(
          //     onPressed: () {
          //       Get.dialog(AlertDialog(
          //         content: Container(
          //           width:
          //               context.width_query / 2,
          //           height:
          //               context.height_query / 2,
          //           child: Column(
          //             children: [
          //               Container(
          //                 width: context
          //                         .width_query /
          //                     2,
          //                 height: context
          //                         .height_query /
          //                     2,
          //                 child: DataTable2(
          //                     columns: <
          //                         DataColumn>[
          //                       DataColumn(
          //                         label: Center(
          //                           child: Text(
          //                             'total item',
          //                             style: TextStyle(
          //                                 fontStyle:
          //                                     FontStyle.italic),
          //                           ),
          //                         ),
          //                       ),
          //                       DataColumn(
          //                         label: Center(
          //                           child: Text(
          //                             'bayar',
          //                             style: TextStyle(
          //                                 fontStyle:
          //                                     FontStyle.italic),
          //                           ),
          //                         ),
          //                       ),
          //                       DataColumn(
          //                         label: Center(
          //                           child: Text(
          //                             'Tanggal transaksi',
          //                             style: TextStyle(
          //                                 fontStyle:
          //                                     FontStyle.italic),
          //                           ),
          //                         ),
          //                       ),
          //                       DataColumn(
          //                         label: Center(
          //                           child: Text(
          //                             'status',
          //                             style: TextStyle(
          //                                 fontStyle:
          //                                     FontStyle.italic),
          //                           ),
          //                         ),
          //                       ),
          //                     ],
          //                     rows: List.generate(
          //                         controller
          //                             .list_pelanggan_local[
          //                                 index]
          //                             .riwayatPembelian
          //                             .length,
          //                         (i) => DataRow(
          //                                 cells: [
          //                                   DataCell(
          //                                       Center(child: Text(controller.list_pelanggan_local[index].riwayatPembelian[i].total.toString()))),
          //                                   DataCell(
          //                                       Center(child: Text(controller.list_pelanggan_local[index].riwayatPembelian[i].bayar.toString()))),
          //                                   DataCell(
          //                                       Center(child: Text(controller.list_pelanggan_local[index].riwayatPembelian[i].tglPenjualan.toString()))),
          //                                   DataCell(Center(
          //                                       child: controller.list_pelanggan_local[index].riwayatPembelian[i].status == 1
          //                                           ? Container(
          //                                               padding: EdgeInsets.all(6),
          //                                               decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.circular(10)),
          //                                               child: Text(
          //                                                 'Lunas',
          //                                                 style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          //                                               ))
          //                                           : controller.list_pelanggan_local[index].riwayatPembelian[i].status == 2
          //                                               ? Container(
          //                                                   padding: EdgeInsets.all(6),
          //                                                   decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.circular(10)),
          //                                                   child: Text(
          //                                                     'Lunas',
          //                                                     style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          //                                                   ))
          //                                               : Container(
          //                                                   padding: EdgeInsets.all(6),
          //                                                   decoration: BoxDecoration(color: Colors.orange, borderRadius: BorderRadius.circular(10)),
          //                                                   child: Text(
          //                                                     'Hutang',
          //                                                     style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          //                                                   ))))
          //                                 ]))),
          //               )
          //             ],
          //           ),
          //         ),
          //       ));
          //     },
          //     icon: Icon(
          //       Icons.list,
          //       size: 18,
          //       color: color_template().secondary,
          //     )),
          IconButton(
              onPressed: () {
                Get.toNamed('/edit_pelanggan', arguments: data[index]);
              },
              icon: Icon(
                Icons.edit,
                size: 18,
                color: color_template().secondary,
              )),
          con.statuspelangganhapus(data[index].id) == true
              ? Container()
              : IconButton(
                  onPressed: () {
                    popscreen().deletepelanggan(con, data[index]);
                  },
                  icon: Icon(
                    Icons.delete,
                    size: 18,
                    color: color_template().tritadery,
                  )),
        ],
      )),
    ]);
  }
}
