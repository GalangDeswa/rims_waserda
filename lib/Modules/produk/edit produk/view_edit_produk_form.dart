import 'package:cached_network_image/cached_network_image.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:pattern_formatter/numeric_formatter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rims_waserda/Modules/produk/edit%20produk/controller_edit_produk.dart';

import '../../../Templates/setting.dart';
import '../../Widgets/buttons.dart';
import '../../Widgets/header.dart';
import '../jenis produk/model_jenisproduk.dart';

class edit_produk_form extends GetView<editprodukController> {
  const edit_produk_form({Key? key}) : super(key: key);

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
        padding: const EdgeInsets.all(15),
        child: Container(
          width: context.width_query / 1,
          //height: context.height_query / 1.8,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              header(
                title: 'Edit Produk'.toUpperCase(),
                icon: FontAwesomeIcons.boxOpen,
                iscenter: false,
              ),
              SizedBox(
                height: 25,
              ),
              SingleChildScrollView(
                child: Obx(() {
                  return Form(
                      key: controller.formKeyprodukedit.value,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: context.width_query / 2.2,
                                child: TextFormField(
                                  controller: controller.nama_produk.value,
                                  onChanged: ((String pass) {}),
                                  decoration: InputDecoration(
                                    icon: Icon(FontAwesomeIcons.boxOpen),
                                    labelText: "Nama produk",
                                    labelStyle: TextStyle(
                                      color: Colors.black87,
                                    ),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                  ),
                                  textAlign: TextAlign.center,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Masukan nama produk';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              controller.data.image == ''
                                  ? Container(
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: color_template().primary,
                                      ),
                                      child: Icon(
                                        FontAwesomeIcons.image,
                                        color: Colors.white,
                                        size: 50,
                                      ),
                                    )
                                  : Container(
                                      width: 200,
                                      height: 100,
                                      child: CachedNetworkImage(
                                        imageUrl: controller.data.image,
                                      ),
                                    ),
                              Container(
                                margin: EdgeInsets.only(left: 10, right: 5),
                                padding: EdgeInsets.all(3),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: color_template().primary,
                                ),
                                child: IconButton(
                                  splashColor: Colors.orange,
                                  focusColor: Colors.orange,
                                  onPressed: () async {
                                    DeviceInfoPlugin deviceInfo =
                                        DeviceInfoPlugin();
                                    AndroidDeviceInfo androidInfo =
                                        await deviceInfo.androidInfo;
                                    if (androidInfo.version.sdkInt >= 33) {
                                      var status =
                                          await Permission.camera.status;
                                      if (!status.isGranted) {
                                        await Permission.camera.request();
                                      }
                                    } else {
                                      var status =
                                          await Permission.camera.status;
                                      if (!status.isGranted) {
                                        await Permission.camera.request();
                                      }
                                    }

                                    controller.pilihsourcefoto();
                                  },
                                  icon: Icon(
                                    Icons.add,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Container(
                                  width: context.width_query / 3.3,
                                  child: TextFormField(
                                    controller: controller.desc.value,
                                    onChanged: ((String pass) {}),
                                    decoration: InputDecoration(
                                      icon: Icon(FontAwesomeIcons.pencil),
                                      labelText: "Deskripsi",
                                      labelStyle: TextStyle(
                                        color: Colors.black87,
                                      ),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                    ),
                                    textAlign: TextAlign.center,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Masukan deskirpsi produk';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ),
                              // Container(
                              //   width: context.width_query / 3.3,
                              //   margin: EdgeInsets.only(left: 10),
                              //   child: Obx(() {
                              //     return DropdownButtonFormField2(
                              //       decoration: InputDecoration(
                              //         icon: Icon(FontAwesomeIcons.boxOpen),
                              //         border: OutlineInputBorder(
                              //           borderRadius: BorderRadius.circular(15),
                              //         ),
                              //       ),
                              //       validator: (value) {
                              //         if (value != null) {
                              //           return 'Pilih jenis produk';
                              //         }
                              //         return null;
                              //       },
                              //       isExpanded: true,
                              //       dropdownStyleData: DropdownStyleData(
                              //           decoration: BoxDecoration(
                              //               borderRadius:
                              //                   BorderRadius.circular(10),
                              //               color: Colors.white)),
                              //       hint: Text('Pilih jenis produk'),
                              //       value: controller.jenisstokval.value,
                              //       items:
                              //           controller.jenisstok.value.map((item) {
                              //         return DropdownMenuItem(
                              //           child: Text(item['nama'].toString()),
                              //           value: item['id'].toString(),
                              //         );
                              //       }).toList(),
                              //       onChanged: (val) {
                              //         controller.jenisstokval.value =
                              //             val.toString();
                              //         controller.jj.value = val.toString();
                              //         print(controller.jj.value);
                              //         print(controller.jenisstokval);
                              //         // controller.update();
                              //       },
                              //     );
                              //   }),
                              // ),
                              Container(
                                width: context.width_query / 2.55,
                                margin: EdgeInsets.only(left: 10),
                                child: Obx(() {
                                  return DropdownButtonFormField2(
                                    decoration: InputDecoration(
                                      icon: Icon(FontAwesomeIcons.boxOpen),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                    ),
                                    validator: (value) {
                                      if (value != null) {
                                        return 'Pilih kategori produk';
                                      }
                                      return null;
                                    },
                                    isExpanded: true,
                                    dropdownStyleData: DropdownStyleData(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: Colors.white)),
                                    hint: Text('Pilih kategori produk'),
                                    value: controller.jenisvalue.value,
                                    items: controller.jenislist
                                        .map((DataJenis item) {
                                      return DropdownMenuItem(
                                        child: Text(item.namaJenis.toString()),
                                        value: item.id.toString(),
                                      );
                                    }).toList(),
                                    onChanged: (val) {
                                      controller.jenisvalue.value =
                                          val!.toString();
                                      print(controller.jenisvalue);
                                    },
                                  );
                                }),
                              ),
                              // Container(
                              //   margin: EdgeInsets.only(left: 30, right: 5),
                              //   decoration: BoxDecoration(
                              //     shape: BoxShape.circle,
                              //     color: color_template().primary,
                              //   ),
                              //   padding: EdgeInsets.all(3),
                              //   child: IconButton(
                              //       color: Colors.white,
                              //       onPressed: () {
                              //         Get.dialog(AlertDialog(
                              //             shape: RoundedRectangleBorder(
                              //                 borderRadius: BorderRadius.all(
                              //                     Radius.circular(20.0))),
                              //             contentPadding: EdgeInsets.zero,
                              //             backgroundColor: Colors.transparent,
                              //             content: Builder(
                              //               builder: (context) {
                              //                 return Container(
                              //                     padding: EdgeInsets.zero,
                              //                     width:
                              //                         context.width_query / 2,
                              //                     height:
                              //                         context.height_query / 2,
                              //                     child: ClipRRect(
                              //                         borderRadius:
                              //                             BorderRadius.circular(
                              //                                 30),
                              //                         child: tambah_jenis()));
                              //               },
                              //             )));
                              //       },
                              //       icon: Icon(Icons.add)),
                              // )
                            ],
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // Obx(() {
                              //   return controller.jj.value == '2'
                              //       ? Expanded(
                              //           child: Container(
                              //             decoration: BoxDecoration(
                              //               borderRadius:
                              //                   BorderRadius.circular(10),
                              //               color: Colors.grey.shade400,
                              //             ),
                              //             child: TextFormField(
                              //               enabled: false,
                              //               keyboardType: TextInputType.number,
                              //               controller: controller.qty.value,
                              //               onChanged: ((String pass) {}),
                              //               decoration: InputDecoration(
                              //                 icon: Icon(FontAwesomeIcons
                              //                     .boxesStacked),
                              //                 labelText: "Stock",
                              //                 labelStyle: TextStyle(
                              //                   color: Colors.black87,
                              //                 ),
                              //                 border: OutlineInputBorder(
                              //                     borderRadius:
                              //                         BorderRadius.circular(
                              //                             10)),
                              //                 focusedBorder: OutlineInputBorder(
                              //                     borderRadius:
                              //                         BorderRadius.circular(
                              //                             10)),
                              //               ),
                              //               textAlign: TextAlign.center,
                              //               validator: (value) {
                              //                 if (value!.isEmpty) {
                              //                   return 'Masukan stock barang';
                              //                 }
                              //                 return null;
                              //               },
                              //             ),
                              //           ),
                              //         )
                              //       : Expanded(
                              //           child: TextFormField(
                              //             keyboardType: TextInputType.number,
                              //             controller: controller.qty.value,
                              //             onChanged: ((String pass) {}),
                              //             decoration: InputDecoration(
                              //               icon: Icon(
                              //                   FontAwesomeIcons.boxesStacked),
                              //               labelText: "Stock",
                              //               labelStyle: TextStyle(
                              //                 color: Colors.black87,
                              //               ),
                              //               border: OutlineInputBorder(
                              //                   borderRadius:
                              //                       BorderRadius.circular(10)),
                              //               focusedBorder: OutlineInputBorder(
                              //                   borderRadius:
                              //                       BorderRadius.circular(10)),
                              //             ),
                              //             textAlign: TextAlign.center,
                              //             validator: (value) {
                              //               if (value!.isEmpty) {
                              //                 return 'Masukan stock barang';
                              //               }
                              //               return null;
                              //             },
                              //           ),
                              //         );
                              // }),

                              Expanded(
                                child: TextFormField(
                                  keyboardType: TextInputType.number,
                                  controller: controller.harga.value,
                                  inputFormatters: [ThousandsFormatter()],
                                  onChanged: ((String num) {
                                    controller.jumlahharga.value = int.parse(
                                        num.toString().replaceAll(',', ''));
                                    print(controller.jumlahharga.value);
                                  }),
                                  decoration: InputDecoration(
                                    icon: Icon(FontAwesomeIcons.moneyBill),
                                    labelText: "Harga jual",
                                    labelStyle: TextStyle(
                                      color: Colors.black87,
                                    ),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                  ),
                                  textAlign: TextAlign.center,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Masukan harga jual';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Expanded(
                                child: TextFormField(
                                  keyboardType: TextInputType.number,
                                  controller: controller.diskon_barang.value,
                                  inputFormatters: [ThousandsFormatter()],
                                  onChanged: ((String num) {
                                    controller.jumlahdiskon.value =
                                        double.parse(
                                            num.toString().replaceAll(',', ''));
                                    print(controller.jumlahdiskon);
                                  }),
                                  decoration: InputDecoration(
                                    icon: Icon(FontAwesomeIcons.percent),
                                    labelText: "Harga setelah diskon",
                                    labelStyle: TextStyle(
                                      color: Colors.black87,
                                    ),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                  ),
                                  textAlign: TextAlign.center,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Masukan potongan diskon';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 25,
                          ),
                        ],
                      ));
                }),
              ),
              button_solid_custom(
                  onPressed: () {
                    controller.ProdukEdit();
                  },
                  child: Text(
                    'edit produk'.toUpperCase(),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  width: double.infinity,
                  height: 60)
            ],
          ),
        ),
      ),
    );
  }
}
