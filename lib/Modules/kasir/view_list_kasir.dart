import 'package:data_table_2/data_table_2.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:rims_waserda/Modules/Widgets/card_custom.dart';
import 'package:rims_waserda/Modules/kasir/model_keranjang_cache.dart';
import 'package:rims_waserda/Modules/produk/data%20produk/model_produk.dart';
import 'package:rims_waserda/Templates/setting.dart';

import 'controller_kasir.dart';

class list_kasir extends GetView<kasirController> {
  const list_kasir({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 5),
          child: Card_custom(
            border: false,
            // margin: EdgeInsets.only(left: 5, top: 10, bottom: 10, right: 10),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Obx(() {
                // final scanWindow = Rect.fromCenter(
                //   center: MediaQuery.of(context).size.center(Offset.zero),
                //   width: 350,
                //   height: 350,
                // );
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    // Transform.rotate(
                    //   angle: -math.pi / 2.0,
                    //   child: Container(
                    //     color: Colors.red,
                    //     width: 50,
                    //     height: 50,
                    //     child: MobileScanner(
                    //       // scanWindow: Rect.fromCenter(
                    //       //   center:
                    //       //       MediaQuery.of(context).size.center(Offset.zero),
                    //       //   width: 500,
                    //       //   height: 500,
                    //       // ),
                    //       controller: MobileScannerController(
                    //         detectionSpeed: DetectionSpeed.normal,
                    //         torchEnabled: true,
                    //         detectionTimeoutMs: 1000,
                    //         facing: CameraFacing.front,
                    //       ),
                    //       // scanWindow: scanWindow,
                    //       onDetect: (capture) async {
                    //         print(
                    //             '-------------------------start----print scan-------------------------------------->');
                    //         var bar = capture.barcodes
                    //             .map((e) => e.rawValue.toString())
                    //             .first;
                    //         print(bar);
                    //
                    //         //var bar = '258';
                    //
                    //         var query = controller.produklistlocal
                    //             .where((e) => e.barcode
                    //                 .toString()
                    //                 .contains(bar.toString()))
                    //             .first;
                    //
                    //         if (query == null) {
                    //           await AudioPlayer()
                    //               .play(AssetSource('audio/max.mp3'));
                    //         }
                    //
                    //         final existingIndex = controller.cache.value
                    //             .indexWhere((item) => item.id == query.id);
                    //
                    //         if (existingIndex == -1) {
                    //           await AudioPlayer()
                    //               .play(AssetSource('audio/scan.wav'));
                    //           controller.cache.add(
                    //             DataKeranjangCache(
                    //                 id: query.id,
                    //                 idToko: query.idToko.toString(),
                    //                 idUser: query.idUser.toString(),
                    //                 idJenis: query.idJenis.toString(),
                    //                 idJenisStock: query.idJenisStock,
                    //                 namaJenis: query.namaJenis,
                    //                 idKategori: query.idKategori.toString(),
                    //                 namaProduk: query.namaProduk,
                    //                 deskripsi: query.deskripsi,
                    //                 qty: 1,
                    //                 harga: query.harga,
                    //                 diskonBarang: query.diskonBarang,
                    //                 image: query.image,
                    //                 status: query.status.toString(),
                    //                 updated: query.updated.toString(),
                    //                 createdAt: query.createdAt.toString(),
                    //                 updatedAt: query.updatedAt.toString()),
                    //           );
                    //         } else {
                    //           var pp = controller.produklistlocal
                    //               .where((e) =>
                    //                   e.id ==
                    //                   controller.cache[existingIndex].id)
                    //               .first;
                    //           if (int.parse(pp.qty) <=
                    //                   controller.cache[existingIndex].qty &&
                    //               controller
                    //                       .cache[existingIndex].idJenisStock ==
                    //                   1) {
                    //             await AudioPlayer()
                    //                 .play(AssetSource('audio/max.mp3'));
                    //             print('maxxxx-------------------------');
                    //             Get.showSnackbar(toast().bottom_snackbar_error(
                    //                 "Error",
                    //                 'Stock sudah habis! harap isi stock terlebih dahulu'));
                    //           } else {
                    //             await AudioPlayer()
                    //                 .play(AssetSource('audio/scan.wav'));
                    //             controller.cache[existingIndex].qty++;
                    //           }
                    //         }
                    //         controller.subtotalval();
                    //         controller.totalval();
                    //         controller.cache.refresh();
                    //
                    //         print(
                    //             '--------------------------------print scan-------------------------------------->');
                    //         // print(capture.barcodes.map((e) => e.displayValue));
                    //         print(
                    //             'stop-------------------------------------->');
                    //         // MobileScannerController().stop();
                    //         // Future.delayed(const Duration(milliseconds: 500))
                    //         //     .then((_) async {
                    //         //   print('starrt----------------------------->');
                    //         //   MobileScannerController().start();
                    //         // });
                    //
                    //         // MobileScannerController().dispose();
                    //         //MobileScannerController().start();
                    //       },
                    //     ),
                    //   ),
                    // ),
                    // icon_button_custom(
                    //     onPressed: () {
                    //       controller.scankasir();
                    //     },
                    //     icon: Icons.qr_code_scanner,
                    //     container_color: color_template().primary),
                    // SizedBox(
                    //   width: 10,
                    // ),
                    Expanded(
                      child: Container(
                          //color: Colors.red,
                          //width: context.width_query * 0.60,
                          //pakai string bisa di cari tp tidak bisa lengkap?
                          child: DropdownSearch<DataProduk>(
                        //asyncItems: (qwe) => controller.fetchProduk(),
                        //asyncItems: (qwe) => api.getproduct(),
                        //  compareFn: (i, s) => i.isEqual(s),
                        popupProps: PopupProps.menu(
                          showSelectedItems: false,
                          showSearchBox: true,
                          itemBuilder: customPopupItemBuilderExample2,
                          favoriteItemProps: FavoriteItemProps(
                            // favoriteItemsAlignment: MainAxisAlignment.start,
                            showFavoriteItems: true,
                            favoriteItems: (us) {
                              // controller.getfavorite();
                              return controller.favorite.value;
                            },
                          ),
                        ),

                        dropdownDecoratorProps: DropDownDecoratorProps(
                          dropdownSearchDecoration: InputDecoration(
                            labelText: "Cari nama produk/barcode",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                          ),
                        ),

                        items: controller.produklistlocal.value,

                        onChanged: (value) {
                          controller.tambahKeranjangcache(value!.id!);
                          // controller.isikeranjang(value!.kodeProduk.toString());
                          // controller.getkeranjang();
                          //  controller.totalkeranjang();
                          // controller.totalqty();
                          // controller.i++;
                          // print(controller.keranjang_list);
                        },
                        //items: controller.produk_list,
                        itemAsString: (DataProduk u) {
                          return u.barcode.toString() +
                              ' ' +
                              ' - ' +
                              u.namaProduk.toString() +
                              "  Rp. " +
                              u.harga.toString();
                        },
                      )),
                    ),
                    // icon_button_custom(
                    //     onPressed: () {
                    //       Get.toNamed('/tambah_user');
                    //     },
                    //     icon: Icons.person_add,
                    //     container_color: color_template().primary),

                    /* Container(
                    width: context.width_query * 0.04,
                    child: TextField(
                      decoration: InputDecoration(hintText: 'Tambah user'),
                    ),
                  )*/
                  ],
                );
              }),
            ),
          ),
        ),
        Expanded(
          child: Card(
              elevation: elevation().def_elevation,
              shape: RoundedRectangleBorder(
                borderRadius: border_radius().def_border,
                // side: BorderSide(color: color_template().primary, width: 3.5),
              ),
              // color: Colors.red,
              child: Obx(
                () {
                  return controller.cache.value.isNotEmpty
                      ? Container(
                          width: context.width_query,
                          padding: const EdgeInsets.all(15),
                          // height: context.height_query * 0.70,
                          //: color_template().primary.withOpacity(0.2),
                          //color: Colors.red,
                          child: ProductTilev2(controller.cache.value))
                      : Container(
                          width: context.width_query,
                          //height: context.height_query,
                          //margin: EdgeInsets.all(300),
                          //color: color_template().primary.withOpacity(0.2),
                          //color: Colors.red,
                          child: Icon(
                            FontAwesomeIcons.cartShopping,
                            color: color_template().primary,
                            size: 100,
                          ));
                },
              )),
        )
      ],
    );
  }

  Widget customPopupItemBuilderExample2(
    BuildContext context,
    DataProduk item,
    bool isSelected,
  ) {
    return Container(
      // color: Colors.red,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      decoration: !isSelected
          ? null
          : BoxDecoration(
              border: Border.all(color: Theme.of(context).primaryColor),
              borderRadius: BorderRadius.circular(5),
              color: Colors.white,
            ),
      child: item.qty == 0 && item.idJenisStock == 1
          ? ListTile(
              selected: isSelected,
              subtitle: Text(item.namaJenis ?? '-'),
              title: Row(
                children: [
                  Text(
                    item.namaProduk,
                    style: TextStyle(decoration: TextDecoration.lineThrough),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Text(
                    'Stock habis',
                    style: font().reguler,
                  )
                ],
              ),
              trailing: Text('Rp.' +
                  ' ' +
                  controller.nominal
                      .format(double.parse(item.harga.toString()))),
            )
          : ListTile(
              selected: isSelected,
              subtitle: Text(item.namaJenis ?? '-'),
              title: Text(item.namaProduk),
              trailing: Text('Rp.' +
                  ' ' +
                  controller.nominal
                      .format(double.parse(item.harga.toString()))),
            ),
    );
  }
}

class ProductTilev2 extends GetView<kasirController> {
  const ProductTilev2(this.list);

  final List<DataKeranjangCache> list;

  @override
  Widget build(BuildContext context) {
    return DataTable2(
        fixedTopRows: 1,
        horizontalMargin: 10,
        columnSpacing: 5,
        headingRowColor: MaterialStateColor.resolveWith(
            (states) => color_template().primary.withOpacity(0.2)),
        //sortAscending: sort,
        //sortColumnIndex: 0,
        columns: [
          DataColumn(
              label: Text(
            "Nama produk",
            style: font().reguler,
          )),
          DataColumn(label: Text("harga", style: font().reguler)),
          DataColumn(label: Text("QTY", style: font().reguler)),
          DataColumn(label: Text("Aksi", style: font().reguler)),
        ],
        rows: List.generate(controller.cache.length, (index) {
          var query = controller.produklistlocal
              .where((e) => e.id == controller.cache[index].id)
              .first;
          var persen = controller.cache[index].diskonBarang;

          // var persen = (double.parse(controller.cache[index].harga) -
          //         controller.cache[index].diskonBarang!) /
          //     double.parse(controller.cache[index].harga) *
          //     100;

          var hargadiskon = controller.cache[index].harga! -
              (controller.cache[index].harga! *
                  controller.cache[index].diskonBarang! /
                  100);

          String display_diskon = persen!.toStringAsFixed(0);
          var pp = controller.produklistlocal
              .where((e) => e.id == controller.cache[index].id)
              .first;
          return DataRow(cells: [
            DataCell(
              Text(controller.cache[index].namaProduk!, style: font().reguler),
            ),
            DataCell(
              controller.cache[index].diskonBarang == 0
                  ? Text(
                      "Rp." +
                          controller.nominal.format(
                            controller.cache[index].harga,
                          ),
                      style: font().reguler)
                  : Row(
                      children: [
                        Text('Rp. ' + controller.nominal.format(hargadiskon),
                            style: font().reguler),
                        const SizedBox(
                          width: 10,
                        ),
                        Container(
                          padding: const EdgeInsets.all(6),
                          child: Text(
                            display_diskon + '%',
                            style: font().reguler_white,
                          ),
                          decoration: BoxDecoration(
                              color: color_template().primary_v2,
                              borderRadius: BorderRadius.circular(10)),
                        )
                      ],
                    ),
            ),
            DataCell(
              Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: const EdgeInsets.only(right: 15),
                    padding: const EdgeInsets.all(3),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: color_template().select),
                    child: InkWell(
                      onTap: () {
                        controller.deleteqty(
                            index, controller.cache[index].id!);
                      },
                      child: Icon(
                        Icons.remove,
                        color: Colors.white,
                        size: context.height_query / 40,
                      ),
                    ),
                  ),
                  Text(controller.cache[index].qty.toString(),
                      style: font().reguler),
                  controller.cache[index].qty >= pp.qty! &&
                          controller.cache[index].idJenisStock == 1
                      ? Container(
                          margin: const EdgeInsets.only(left: 15, right: 15),
                          padding: const EdgeInsets.all(3),
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle, color: Colors.grey),
                          child: Icon(
                            Icons.add,
                            color: Colors.white,
                            size: context.height_query / 40,
                          ),
                        )
                      : InkWell(
                          onTap: () {
                            controller.tambahqty(index);
                          },
                          child: Container(
                            margin: const EdgeInsets.only(left: 15, right: 15),
                            padding: const EdgeInsets.all(3),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: color_template().primary),
                            child: Icon(
                              Icons.add,
                              color: Colors.white,
                              size: context.height_query / 40,
                            ),
                          ),
                        )
                ],
              ),
            ),
            DataCell(Container(
              // color: Colors.cyan,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                      onPressed: () {
                        Get.toNamed('/edit_produk',
                            arguments: controller.produklistlocal[index]);
                      },
                      icon: Icon(
                        Icons.edit,
                        size: 18,
                        color: color_template().secondary,
                      )),
                  IconButton(
                      onPressed: () {
                        controller.deleteitemcache(controller.cache[index].id!);
                      },
                      icon: Icon(
                        size: context.height_query / 35,
                        Icons.delete,
                        color: color_template().tritadery,
                      )),
                ],
              ),
            ))
          ]);
        }));
  }

// Iterable<DataRow> mapItemToDataRows(List<DataKeranjangCache> items) {
//   var pp = controller.produklistlocal
//       .where((e) => e.id == items.map((e) => e.id).first)
//       .first;
//   final List uniqueList = Set.from(items).toList();
//
//   Iterable<DataRow> dataRows = items.map((item) {
//     int idx = uniqueList.indexOf(item) + 1;
//     return DataRow(cells: [
//       DataCell(
//         Text(idx.toString()),
//       ),
//       DataCell(
//         Text(item.namaProduk),
//       ),
//       DataCell(
//         Text(
//           controller.nominal.format(item.harga.toString()),
//         ),
//       ),
//       DataCell(
//         Center(
//             // child: Expanded(
//             //   child: Row(
//             //     crossAxisAlignment:
//             //     CrossAxisAlignment.center,
//             //     mainAxisAlignment:
//             //     MainAxisAlignment
//             //         .spaceBetween,
//             //     children: [
//             //       Container(
//             //         margin: EdgeInsets.only(
//             //             right: 10),
//             //         padding: EdgeInsets.all(3),
//             //         decoration: BoxDecoration(
//             //             shape: BoxShape.circle,
//             //             color: color_template()
//             //                 .select),
//             //         child: InkWell(
//             //           onTap: () {
//             //             controller.deleteqty(
//             //                 index,
//             //                 controller
//             //                     .cache[index]
//             //                     .id);
//             //           },
//             //           child: Icon(
//             //             Icons.remove,
//             //             color: Colors.white,
//             //             size: context
//             //                 .height_query /
//             //                 40,
//             //           ),
//             //         ),
//             //       ),
//             //       Text(controller
//             //           .cache[index].qty
//             //           .toString()),
//             //       int.parse(pp.qty) <=
//             //           controller
//             //               .cache[index]
//             //               .qty &&
//             //           controller
//             //               .cache[index]
//             //               .idJenisStock ==
//             //               1
//             //           ? Container(
//             //         margin:
//             //         EdgeInsets.only(
//             //             left: 10,
//             //             right: 10),
//             //         padding:
//             //         EdgeInsets.all(3),
//             //         decoration:
//             //         BoxDecoration(
//             //             shape: BoxShape
//             //                 .circle,
//             //             color: Colors
//             //                 .grey),
//             //         child: Icon(
//             //           Icons.add,
//             //           color: Colors.white,
//             //           size: context
//             //               .height_query /
//             //               40,
//             //         ),
//             //       )
//             //           : InkWell(
//             //         onTap: () {
//             //           controller
//             //               .tambahqty(
//             //               index);
//             //         },
//             //         child: Container(
//             //           margin:
//             //           EdgeInsets.only(
//             //               left: 10,
//             //               right: 10),
//             //           padding:
//             //           EdgeInsets.all(
//             //               3),
//             //           decoration: BoxDecoration(
//             //               shape: BoxShape
//             //                   .circle,
//             //               color:
//             //               color_template()
//             //                   .primary),
//             //           child: Icon(
//             //             Icons.add,
//             //             color:
//             //             Colors.white,
//             //             size: context
//             //                 .height_query /
//             //                 40,
//             //           ),
//             //         ),
//             //       )
//             //     ],
//             //   ),
//             // )
//             ),
//       ),
//       DataCell(Row(
//         children: [
//           IconButton(
//               onPressed: () {
//                 // controller.deletekeranjang(item.kodeProduk);
//               },
//               icon: Icon(Icons.delete))
//         ],
//       )),
//     ]);
//   });
//   return dataRows;
// }
}

/*
DropdownSearch<String>(
popupProps: PopupProps.menu(
showSearchBox: true,
showSelectedItems: false,
),
dropdownDecoratorProps: DropDownDecoratorProps(
dropdownSearchDecoration: InputDecoration(
labelText: "scan barcode/cari nama produk",
),
),
items: controller.productlist.map((e) => e.name).toList(),
onChanged: (value) {
controller.listbaru.add(value);
print(value);
print(controller.listbaru);
},
)*/

// class QRViewExample extends StatefulWidget {
//   const QRViewExample({Key? key}) : super(key: key);
//
//   @override
//   State<StatefulWidget> createState() => _QRViewExampleState();
// }
//
// class _QRViewExampleState extends State<QRViewExample> {
//   Barcode? result;
//   QRViewController? controller;
//   final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
//
//   // In order to get hot reload to work we need to pause the camera if the platform
//   // is android, or resume the camera if the platform is iOS.
//   @override
//   void reassemble() {
//     super.reassemble();
//     if (Platform.isAndroid) {
//       controller!.pauseCamera();
//     }
//     controller!.resumeCamera();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: <Widget>[
//           Expanded(flex: 4, child: _buildQrView(context)),
//           Expanded(
//             flex: 1,
//             child: FittedBox(
//               fit: BoxFit.contain,
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: <Widget>[
//                   if (result != null)
//                     Text(
//                         'Barcode Type: ${describeEnum(result!.format)}   Data: ${result!.code}')
//                   else
//                     const Text('Scan a code'),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: <Widget>[
//                       Container(
//                         margin: const EdgeInsets.all(8),
//                         child: ElevatedButton(
//                             onPressed: () async {
//                               await controller?.toggleFlash();
//                               setState(() {});
//                             },
//                             child: FutureBuilder(
//                               future: controller?.getFlashStatus(),
//                               builder: (context, snapshot) {
//                                 return Text('Flash: ${snapshot.data}');
//                               },
//                             )),
//                       ),
//                       Container(
//                         margin: const EdgeInsets.all(8),
//                         child: ElevatedButton(
//                             onPressed: () async {
//                               await controller?.flipCamera();
//                               setState(() {});
//                             },
//                             child: FutureBuilder(
//                               future: controller?.getCameraInfo(),
//                               builder: (context, snapshot) {
//                                 if (snapshot.data != null) {
//                                   return Text(
//                                       'Camera facing ${describeEnum(snapshot.data!)}');
//                                 } else {
//                                   return const Text('loading');
//                                 }
//                               },
//                             )),
//                       )
//                     ],
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: <Widget>[
//                       Container(
//                         margin: const EdgeInsets.all(8),
//                         child: ElevatedButton(
//                           onPressed: () async {
//                             await controller?.pauseCamera();
//                           },
//                           child: const Text('pause',
//                               style: TextStyle(fontSize: 20)),
//                         ),
//                       ),
//                       Container(
//                         margin: const EdgeInsets.all(8),
//                         child: ElevatedButton(
//                           onPressed: () async {
//                             await controller?.resumeCamera();
//                           },
//                           child: const Text('resume',
//                               style: TextStyle(fontSize: 20)),
//                         ),
//                       )
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           )
//         ],
//       ),
//     );
//   }
//
//   Widget _buildQrView(BuildContext context) {
//     // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
//     var scanArea = (MediaQuery.of(context).size.width < 400 ||
//             MediaQuery.of(context).size.height < 400)
//         ? 150.0
//         : 300.0;
//     // To ensure the Scanner view is properly sizes after rotation
//     // we need to listen for Flutter SizeChanged notification and update controller
//     return QRView(
//       key: qrKey,
//       onQRViewCreated: _onQRViewCreated,
//       overlay: QrScannerOverlayShape(
//           borderColor: Colors.red,
//           borderRadius: 10,
//           borderLength: 30,
//           borderWidth: 10,
//           cutOutSize: scanArea),
//       onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
//     );
//   }
//
//   void _onQRViewCreated(QRViewController controller) {
//     setState(() {
//       this.controller = controller;
//     });
//     controller.scannedDataStream.listen((scanData) {
//       setState(() {
//         result = scanData;
//       });
//     });
//   }
//
//   void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
//     log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
//     if (!p) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('no Permission')),
//       );
//     }
//   }
//
//   @override
//   void dispose() {
//     controller?.dispose();
//     super.dispose();
//   }
// }
