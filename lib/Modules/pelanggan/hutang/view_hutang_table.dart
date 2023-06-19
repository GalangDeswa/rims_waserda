import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:rims_waserda/Modules/Widgets/card_custom.dart';
import 'package:rims_waserda/Modules/pelanggan/hutang/view_hutang_detail.dart';

import '../../../Templates/setting.dart';
import '../../Widgets/buttons.dart';
import '../../Widgets/header.dart';
import '../../Widgets/loading.dart';
import 'controller_hutang.dart';
import 'model_hutang.dart';

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
                        await controller
                            .fetchDataHutanglocal(controller.id_toko);

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
                          controller.searchhutanglocal();
                        }),
                        decoration: InputDecoration(
                          icon: Icon(Icons.add_box),
                          labelText: "Cari hutang",
                          hintText: 'Tanggal hutang / Nama pelanggan',
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
                      controller.searchhutanglocal();
                    },
                    icon: Icons.search,
                    container_color: color_template().primary),
              ],
            ),
            Expanded(
              child: Obx(() {
                var source =
                    hutangTable(controller.list_hutanglocal.value, context).obs;
                return Container(
                  // height: context.height_query / 2.5,
                  margin: EdgeInsets.only(top: 12),
                  // width: double.infinity,
                  child: controller.list_hutanglocal.value.isEmpty
                      ? Container(width: 100, height: 100, child: showloading())
                      :
                      //untuk paginated table yg pakek data source harus buat var lg di dalam obx
                      //dan di class source nya di buat konstruktor untuk di lembar var data dari kontroller

                      PaginatedDataTable2(
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

class hutangTable extends DataTableSource {
  final List<DataHutang> data;
  final BuildContext context;

  hutangTable(this.data, this.context);

  var con = Get.find<hutangController>();

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => data.length;

  @override
  int get selectedRowCount => 0;

  @override
  DataRow getRow(int index) {
    return DataRow(cells: [
      DataCell(Text(data[index].tglHutang.toString())),
      DataCell(Text(data[index].namaPelanggan!)),
      DataCell(data[index].hutang! <= 0
          ? Text('Rp. 0')
          : Text('Rp.' +
              con.nominal.format(int.parse(data[index].hutang.toString())))),
      DataCell(data[index].status == 1
          ? Container(
              padding: EdgeInsets.all(6),
              decoration: BoxDecoration(
                  color: Colors.green, borderRadius: BorderRadius.circular(10)),
              child: Text(
                'Lunas',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ))
          : Container(
              padding: EdgeInsets.all(6),
              decoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.circular(10)),
              child: Text(
                'Hutang',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ))),
      DataCell(Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          IconButton(
              onPressed: () {
                Get.dialog(
                    arguments: data[index],
                    AlertDialog(content: hutang_detail()));
              },
              icon: Icon(
                Icons.list,
                size: 18,
                color: color_template().secondary,
              )),
          IconButton(
              onPressed: () {
                con.bayarhutangpop(
                    data[index].id!, data[index].hutang.toString());
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
    ]);
  }
}
