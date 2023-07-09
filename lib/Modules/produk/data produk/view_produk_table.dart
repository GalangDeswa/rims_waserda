import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:rims_waserda/Modules/Widgets/card_custom.dart';
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
    return Card_custom(
      border: false,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 5),
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
                          //  Get.dialog(showloading(), barrierDismissible: false);
                          // print(controller.getRandString(10));
                          controller.fetchProduklocal(controller.id_toko);
                          // controller.checkidproduk();

                          // Get.back();
                          // Get.dialog(showloading(), barrierDismissible: false);
                          // await controller.fetchProduk();
                          //controller.fetchProduklocal(controller.id_toko);
                          // Workmanager().registerOneOffTask(
                          //   'sync_test',
                          //   sync,
                          //   constraints:
                          //       Constraints(networkType: NetworkType.connected),
                          // );

                          // controller.syncProdukv2();
                          // REST.produkAllv2(
                          //     controller.token, controller.id_toko);
                          //Get.back(closeOverlays: true);
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
                        'Tambah produk'.toUpperCase(),
                        style: font().header,
                      ),
                      width: context.width_query * 0.2,
                      height: 65)
                ],
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Obx(() {
                  return Expanded(
                    child: Container(
                      // color: Colors.red,
                      height: context.height_query / 15,
                      margin: const EdgeInsets.symmetric(horizontal: 3),
                      //width: 200,
                      child: TextFormField(
                        controller: controller.search.value,
                        onChanged: ((String pass) {
                          controller.searchproduklocal();
                        }),
                        decoration: InputDecoration(
                          labelText: "cari produk",
                          hintText: 'Nama produk / Barcode',
                          labelStyle: const TextStyle(
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
                      controller.searchproduklocal();
                    },
                    icon: Icons.search,
                    container_color: color_template().primary),
              ],
            ),
            Expanded(
              child: Obx(() {
                var source =
                    produkTable(controller.produklistlocal.value, context).obs;
                onSortColum(int columnIndex, bool ascending) {
                  if (columnIndex == 1) {
                    if (ascending) {
                      controller.produklistlocal
                          .sort((a, b) => a.namaProduk.compareTo(b.namaProduk));
                    } else {
                      controller.produklistlocal
                          .sort((a, b) => b.namaProduk.compareTo(a.namaProduk));
                    }
                  } else if (columnIndex == 2) {
                    if (ascending) {
                      controller.produklistlocal
                          .sort((a, b) => a.namaJenis!.compareTo(b.namaJenis!));
                    } else {
                      controller.produklistlocal
                          .sort((a, b) => b.namaJenis!.compareTo(a.namaJenis!));
                    }
                  } else if (columnIndex == 4) {
                    if (ascending) {
                      controller.produklistlocal.sort(
                          (a, b) => b.idJenisStock.compareTo(a.idJenisStock));
                    } else {
                      controller.produklistlocal.sort(
                          (a, b) => a.idJenisStock.compareTo(b.idJenisStock));
                    }
                  } else if (columnIndex == 5) {
                    if (ascending) {
                      controller.produklistlocal
                          .sort((a, b) => b.harga.compareTo(a.harga));
                    } else {
                      controller.produklistlocal
                          .sort((a, b) => a.harga.compareTo(b.harga));
                    }
                  } else if (columnIndex == 6) {
                    if (ascending) {
                      controller.produklistlocal.sort(
                          (a, b) => b.diskonBarang!.compareTo(a.diskonBarang!));
                    } else {
                      controller.produklistlocal.sort(
                          (a, b) => a.diskonBarang!.compareTo(b.diskonBarang!));
                    }
                  }
                }

                return Container(
                  //height: context.height_query * 0.46,
                  margin: const EdgeInsets.only(top: 15),
                  // width: double.infinity,

                  child: controller.succ == false
                      ? Container(
                          width: 100, height: 100, child: const showloading())
                      : PaginatedDataTable2(
                          wrapInCard: false,
                          columnSpacing: 0,
                          sortAscending: controller.sort.value,
                          sortColumnIndex: controller.ColIndex.value,
                          fixedTopRows: 1,
                          horizontalMargin: 10,
                          renderEmptyRowsInTheEnd: false,
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
                              label: Text(
                                'Barcode',
                                style: font().reguler,
                              ),
                            ),
                            DataColumn(
                              onSort: (int columnIndex, bool ascending) {
                                controller.sort.value = !controller.sort.value;
                                controller.ColIndex.value = columnIndex;
                                onSortColum(columnIndex, ascending);
                              },
                              label: Text(
                                'Nama Produk',
                                style: font().reguler,
                              ),
                            ),
                            DataColumn(
                                label: Text(
                                  'Jenis Produk',
                                  style: font().reguler,
                                ),
                                onSort: (int columnIndex, bool ascending) {
                                  controller.sort.value =
                                      !controller.sort.value;
                                  controller.ColIndex.value = columnIndex;
                                  onSortColum(columnIndex, ascending);
                                }),
                            DataColumn(
                              label: Text(
                                'Deskripsi',
                                style: font().reguler,
                              ),
                            ),
                            DataColumn(
                              onSort: (int columnIndex, bool ascending) {
                                controller.sort.value = !controller.sort.value;
                                controller.ColIndex.value = columnIndex;
                                onSortColum(columnIndex, ascending);
                              },
                              label: Text(
                                'Stock',
                                style: font().reguler,
                              ),
                            ),
                            DataColumn(
                                onSort: (int columnIndex, bool ascending) {
                                  controller.sort.value =
                                      !controller.sort.value;
                                  controller.ColIndex.value = columnIndex;
                                  onSortColum(columnIndex, ascending);
                                },
                                label: Text(
                                  'Harga',
                                  style: font().reguler,
                                )),

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
                                style: font().reguler,
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
    var hargadiskon = data[index].harga! -
        (data[index].harga! * data[index].diskonBarang! / 100);

    var persen =
        data[index].harga - data[index].diskonBarang! / data[index].harga * 100;
    String display_diskon = data[index].diskonBarang.toString();
    return DataRow(cells: [
      DataCell(Text(
        data[index].barcode ?? '-',
        style: font().reguler,
        overflow: TextOverflow.ellipsis,
      )),
      DataCell(Text(
        data[index].namaProduk,
        style: font().reguler,
        overflow: TextOverflow.ellipsis,
      )),
      DataCell(Text(
        data[index].namaJenis ?? '-',
        style: font().reguler,
        overflow: TextOverflow.ellipsis,
      )),
      DataCell(Text(
        data[index].deskripsi ?? '-',
        style: font().reguler,
        overflow: TextOverflow.ellipsis,
      )),
      DataCell(data[index].qty == 0 && data[index].idJenisStock == 2
          ? Text(
              'Non Stock',
              style: font().reguler,
              overflow: TextOverflow.ellipsis,
            )
          : Row(
              children: [
                Expanded(
                    child: Text(
                  con.nominal.format(data[index].qty),
                  style: font().reguler,
                  overflow: TextOverflow.ellipsis,
                )),
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: IconButton(
                      onPressed: () {
                        con.addqty(con, data[index]);
                      },
                      icon: Container(
                        padding: const EdgeInsets.all(3),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: color_template().primary),
                        child: const Icon(
                          Icons.add,
                          size: 18,
                          color: Colors.white,
                        ),
                      )),
                )
              ],
            )),
      DataCell(data[index].diskonBarang == 0
          ? Text(
              'Rp. ' + con.nominal.format(data[index].harga),
              style: font().reguler,
              overflow: TextOverflow.ellipsis,
            )
          : Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: Text(
                    'Rp. ' + con.nominal.format(hargadiskon),
                    style: font().reguler,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                Container(
                  padding: const EdgeInsets.all(5),
                  child: Text(
                    display_diskon + '%',
                    style: font().reguler_white,
                    overflow: TextOverflow.ellipsis,
                  ),
                  decoration: BoxDecoration(
                      color: color_template().primary_v2,
                      borderRadius: BorderRadius.circular(10)),
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
              padding: const EdgeInsets.only(right: 10),
              child: IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    Get.toNamed('/edit_produk', arguments: data[index]);
                  },
                  icon: Icon(
                    Icons.edit,
                    size: 18,
                    color: color_template().secondary,
                  )),
            ),
            IconButton(
                padding: EdgeInsets.zero,
                onPressed: () {
                  popscreen().deleteproduklocal(con, data[index]);
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
