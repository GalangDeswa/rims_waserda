import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 3),
                    //width: 200,
                    child: TextFormField(
                      controller: controller.id_kas.value,
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
              ],
            ),
            Expanded(
              child: Obx(() {
                var source =
                    penjualanTable(controller.penjualan_list.value).obs;
                return Container(
                  //color: Colors.red,
                  // height: context.height_query / 1.6,
                  margin: EdgeInsets.only(top: 10),
                  // width: double.infinity,
                  child: controller.penjualan_list.value.isEmpty
                      ? Container(width: 100, height: 100, child: showloading())
                      : PaginatedDataTable2(
                          horizontalMargin: 10,
                          //minWidth: 1000,
                          //minWidth: 10,
                          //fit: FlexFit.loose,
                          columnSpacing: 5,
                          wrapInCard: false,
                          renderEmptyRowsInTheEnd: false,
                          headingRowColor: MaterialStateColor.resolveWith(
                              (states) =>
                                  color_template().primary.withOpacity(0.2)),
                          autoRowsToHeight: true,
                          showFirstLastButtons: true,
                          empty: Center(
                            child: Text(
                              "Data Kosong",
                              style: font().header_black,
                            ),
                          ),
                          columns: const <DataColumn>[
                            DataColumn(
                              label: Text(
                                'tanggal',
                                style: TextStyle(fontStyle: FontStyle.italic),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                'Nama Kasir',
                                style: TextStyle(fontStyle: FontStyle.italic),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                'Total item',
                                style: TextStyle(fontStyle: FontStyle.italic),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                'Subtotal',
                                style: TextStyle(fontStyle: FontStyle.italic),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                'Total',
                                style: TextStyle(fontStyle: FontStyle.italic),
                              ),
                            ),
                            DataColumn(
                              label: Center(
                                child: Text(
                                  'Bayar',
                                  style: TextStyle(fontStyle: FontStyle.italic),
                                ),
                              ),
                            ),
                            DataColumn(
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
                          source: source.value,
                        ),
                );
              }),
            ),
            SizedBox(
              height: 15,
            )
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
