import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:rims_waserda/Modules/Widgets/loading.dart';
import 'package:rims_waserda/Modules/produk/data%20produk/model_produk.dart';

import '../../../Templates/setting.dart';
import '../../Widgets/buttons.dart';
import '../../Widgets/header.dart';
import '../../Widgets/popup.dart';
import 'controller_data_produk.dart';

class produk_table extends GetView<produkController> {
  const produk_table({Key? key}) : super(key: key);

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
                        title: 'Data produk',
                        icon: FontAwesomeIcons.boxOpen,
                        icon_funtion: Icons.refresh,
                        function: () async {
                          Get.dialog(showloading(), barrierDismissible: false);
                          await controller.fetchProduk();
                          Get.back(closeOverlays: true);
                        },
                      ),
                    ),
                  ),
                  button_solid_custom(
                      onPressed: () {
                        Get.toNamed('/tambah_produk');

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
                        'Tambah produk',
                        style: font().header,
                      ),
                      width: context.width_query * 0.2,
                      height: 65)
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Obx(() {
                  return Expanded(
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 3),
                      //width: 200,
                      child: TextFormField(
                        controller: controller.search.value,
                        onChanged: ((String pass) {
                          controller.fetchProduk();
                        }),
                        decoration: InputDecoration(
                          icon: Icon(Icons.add_box),
                          labelText: "cari produk",
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
                      controller.fetchProduk();
                    },
                    icon: Icons.search,
                    container_color: color_template().primary),
              ],
            ),
            Expanded(
              child: Obx(() {
                var source =
                    produkTable(controller.produklist.value, context).obs;
                return Container(
                  //height: context.height_query * 0.46,
                  margin: EdgeInsets.only(top: 15),
                  // width: double.infinity,

                  child: controller.succ == false
                      ? Container(width: 100, height: 100, child: showloading())
                      : DataTable2(
                          fixedTopRows: 1,
                          horizontalMargin: 10,
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
                          columns: const <DataColumn>[
                            DataColumn(
                              label: Text('Nama Produk'),
                            ),
                            DataColumn(
                              label: Text(
                                'Jenis Produk',
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                'Deskripsi',
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                'Stock',
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                'Harga',
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                'Harga Diskon',
                              ),
                            ),

                            // DataColumn(
                            //   label: Expanded(
                            //     child: Text(
                            //       'img',
                            //       style: TextStyle(fontStyle: FontStyle.italic),
                            //     ),
                            //   ),
                            // ),
                            DataColumn(
                              label: Text(
                                'Aksi',
                              ),
                            ),
                          ],
                          rows: List.generate(
                            controller.produklist.length,
                            (index) {
                              var persen = (double.parse(
                                          controller.produklist[index].harga) -
                                      controller
                                          .produklist[index].diskonBarang) /
                                  double.parse(
                                      controller.produklist[index].harga) *
                                  100;
                              String display_diskon = persen.toStringAsFixed(0);
                              return DataRow(cells: [
                                DataCell(Text(
                                    controller.produklist[index].namaProduk)),
                                DataCell(Text(
                                    controller.produklist[index].namaJenis)),
                                DataCell(Text(
                                    controller.produklist[index].deskripsi)),
                                controller.produklist[index].idJenisStock == 1
                                    ? DataCell(Row(
                                        children: [
                                          Expanded(
                                              child: Text(controller.nominal
                                                  .format(double.parse(
                                                      controller
                                                          .produklist[index]
                                                          .qty)))),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                right:
                                                    context.width_query / 23),
                                            child: IconButton(
                                                onPressed: () {
                                                  controller.addqty(
                                                      controller,
                                                      controller
                                                          .produklist[index]);
                                                },
                                                icon: Container(
                                                  padding: EdgeInsets.all(3),
                                                  decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: color_template()
                                                          .primary),
                                                  child: Icon(
                                                    Icons.add,
                                                    size: 18,
                                                    color: Colors.white,
                                                  ),
                                                )),
                                          )
                                        ],
                                      ))
                                    : DataCell(Text('Non stock')),
                                DataCell(Text('Rp. ' +
                                    controller.nominal.format(double.parse(
                                        controller.produklist[index].harga)))),
                                controller.produklist[index].diskonBarang == 0
                                    ? DataCell(Text('-'))
                                    : DataCell(Row(
                                        children: [
                                          Text('Rp. ' +
                                              controller.nominal.format(
                                                  double.parse(controller
                                                      .produklist[index]
                                                      .diskonBarang
                                                      .toString()))),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Container(
                                            padding: EdgeInsets.all(6),
                                            child: Text(
                                              display_diskon + '%',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black),
                                            ),
                                            decoration: BoxDecoration(
                                                color:
                                                    color_template().primary_v2,
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                          )
                                        ],
                                      )),
                                DataCell(Container(
                                  // color: Colors.cyan,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 10),
                                        child: IconButton(
                                            onPressed: () {
                                              Get.toNamed('/edit_produk',
                                                  arguments: controller
                                                      .produklist[index]);
                                            },
                                            icon: Icon(
                                              Icons.edit,
                                              size: 18,
                                              color: color_template().secondary,
                                            )),
                                      ),
                                      IconButton(
                                          onPressed: () {
                                            popscreen().deleteprodukv2(
                                                controller,
                                                controller.produklist[index]);
                                          },
                                          icon: Icon(
                                            Icons.delete,
                                            size: 18,
                                            color: color_template().tritadery,
                                          ))
                                    ],
                                  ),
                                )),
                              ]);
                            },
                          ),
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

class produkTable extends DataTableSource {
  final List<DataProduk> data;
  final BuildContext context;

  produkTable(this.data, this.context);

  var con = Get.find<produkController>();

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => data.length;

  @override
  int get selectedRowCount => 0;

  @override
  DataRow getRow(int index) {
    return DataRow(cells: [
      DataCell(Text(data[index].namaProduk)),
      DataCell(Text(data[index].namaJenis)),
      DataCell(Text(data[index].deskripsi)),
      DataCell(Row(
        children: [
          Expanded(
              child: Text(con.nominal.format(double.parse(data[index].qty)))),
          Padding(
            padding: EdgeInsets.only(right: context.width_query / 23),
            child: IconButton(
                onPressed: () {
                  con.addqty(con, data[index]);
                },
                icon: Container(
                  padding: EdgeInsets.all(3),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: color_template().primary),
                  child: Icon(
                    Icons.add,
                    size: 18,
                    color: Colors.white,
                  ),
                )),
          )
        ],
      )),
      DataCell(
          Text('Rp. ' + con.nominal.format(double.parse(data[index].harga)))),
      DataCell(Center(
        child: Row(
          children: [
            Expanded(
              child: IconButton(
                  onPressed: () {
                    Get.toNamed('/edit_produk', arguments: data[index]);
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
                    popscreen().deleteprodukv2(con, data[index]);
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

// class ExampleSource extends AdvancedDataTableSource<DataProduk> {
//   final List<DataProduk> data;
//   var con = Get.find<produkController>();
//
//   ExampleSource(this.data);
//
//   @override
//   DataRow? getRow(int index) {
//     final currentRowData = data[index];
//     return DataRow(cells: [
//       DataCell(
//         Text(currentRowData.namaProduk.toString()),
//       ),
//       DataCell(
//         Text(currentRowData.harga),
//       ),
//     ]);
//   }
//
//   @override
//   int get selectedRowCount => 0;
//
//   @override
//   Future<RemoteDataSourceDetails<DataProduk>> getNextPage(
//       NextPageRequest pageRequest) async {
//     //the remote data source has to support the pagaing and sorting
//
//     final requestUri = Uri.https(
//       'http://localhost/rimspos-standar/api-pos/produk/data/allproduk',
//       queryParameter as String,
//     );
//
//     final response = await http.get(requestUri);
//     if (response.statusCode == 200) {
//       final data = jsonDecode(response.body);
//       return RemoteDataSourceDetails(
//         data['data'],
//         (data['data'] as List<dynamic>)
//             .map((json) => DataProduk.fromJson(json))
//             .toList(),
//       );
//     } else {
//       throw Exception('Unable to query remote server');
//     }
//   }
// }
