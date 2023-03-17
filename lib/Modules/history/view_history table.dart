import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

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
            header(title: 'Daftar Riwayat', icon: Icons.history),
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
                        labelText: "cari history",
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
                      controller.gethistory(controller.id_kas.value.text);
                    },
                    icon: Icons.search,
                    container_color: color_template().primary),
              ],
            ),
            Container(
              //color: Colors.red,
              height: context.height_query / 1.6,
              margin: EdgeInsets.only(top: 15),
              width: double.infinity,
              child: SingleChildScrollView(
                child: Obx(() {
                  return DataTable(
                      columns: const <DataColumn>[
                        DataColumn(
                          label: Expanded(
                            child: Text(
                              'tanggal',
                              style: TextStyle(fontStyle: FontStyle.italic),
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Expanded(
                            child: Text(
                              'nomor transasksi',
                              style: TextStyle(fontStyle: FontStyle.italic),
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Expanded(
                            child: Text(
                              'id kasir',
                              style: TextStyle(fontStyle: FontStyle.italic),
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Expanded(
                            child: Text(
                              'Produk',
                              style: TextStyle(fontStyle: FontStyle.italic),
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Expanded(
                            child: Text(
                              'QTY',
                              style: TextStyle(fontStyle: FontStyle.italic),
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Expanded(
                            child: Center(
                              child: Text(
                                'Total',
                                style: TextStyle(fontStyle: FontStyle.italic),
                              ),
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Expanded(
                            child: Center(
                              child: Text(
                                'Aksi',
                                style: TextStyle(fontStyle: FontStyle.italic),
                              ),
                            ),
                          ),
                        ),
                      ],
                      rows: List.generate(controller.history_list.length,
                          (index) {
                        return DataRow(cells: [
                          DataCell(Container(
                              child: Text(controller.history_list[index].tgl))),
                          DataCell(Container(
                              child: Text(controller
                                  .history_list[index].nomorTransaksi))),
                          DataCell(Container(
                              child: Text(
                                  controller.history_list[index].idKasir))),
                          DataCell(Container(
                              child: Text(
                                  controller.history_list[index].namaProduk))),
                          DataCell(Container(
                              child: Text(controller.history_list[index].qty))),
                          DataCell(Container(
                              child:
                                  Text(controller.history_list[index].total))),
                          DataCell(Row(
                            children: [
                              IconButton(
                                  onPressed: () {
                                    // print('qweqweqwe');
                                    // Get.toNamed('/detail_produk');
                                  },
                                  icon: Icon(
                                    Icons.ballot,
                                    size: 18,
                                  )),
                              IconButton(
                                  onPressed: () {
                                    Get.toNamed('/detail_produk');
                                  },
                                  icon: Icon(
                                    Icons.edit,
                                    size: 18,
                                  )),
                              IconButton(
                                  onPressed: () {},
                                  icon: Icon(Icons.delete, size: 18))
                            ],
                          ))
                        ]);
                      }));
                }),
              ),
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
