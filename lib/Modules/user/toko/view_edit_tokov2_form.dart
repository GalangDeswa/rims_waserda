import 'dart:convert';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rims_waserda/Modules/user/toko/controller_edit_tokov2.dart';
import 'package:rims_waserda/Templates/setting.dart';

import '../../Widgets/buttons.dart';
import '../../Widgets/card_custom.dart';
import '../../Widgets/header.dart';

class edit_tokov2_form extends GetView<edittokov2Controller> {
  const edit_tokov2_form({super.key});

  @override
  Widget build(BuildContext context) {
    return Card_custom(
      border: false,
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Container(
          width: context.width_query / 1,
          //height: context.height_query / 1.5,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              header(
                title: 'Edit toko',
                icon: FontAwesomeIcons.dollarSign,
                iscenter: false,
              ),
              SizedBox(
                height: 25,
              ),
              Obx(() {
                return Form(
                    key: controller.formKeytoko.value,
                    child: IntrinsicHeight(
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(bottom: 10),
                                  // width: context.width_query / 2.2,
                                  // height: 100,
                                  child: TextFormField(
                                    controller: controller.nama_toko.value,
                                    onChanged: ((String pass) {}),
                                    decoration: InputDecoration(
                                      labelText: "Nama toko",
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
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Masukan nama toko';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(bottom: 10),
                                  //  width: context.width_query / 3.3,
                                  child: TextFormField(
                                    controller: controller.jenis_usaha.value,
                                    onChanged: ((String pass) {}),
                                    decoration: InputDecoration(
                                      labelText: "Jenis usaha",
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
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Masukan jenis usaha';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(bottom: 10),
                                  // width: context.width_query / 2.2,
                                  // height: 100,
                                  child: TextFormField(
                                    controller: controller.alamat.value,
                                    onChanged: ((String pass) {}),
                                    decoration: InputDecoration(
                                      labelText: "Alamat toko",
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
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Masukan alamat';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                              margin: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 10),
                              child: VerticalDivider(
                                color: color_template().primary,
                                thickness: 1,
                              )),
                          Expanded(
                              child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                margin: EdgeInsets.only(bottom: 10),
                                //  width: context.width_query / 3.3,
                                child: TextFormField(
                                  controller: controller.email.value,
                                  onChanged: ((String pass) {}),
                                  decoration: InputDecoration(
                                    labelText: "Email",
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
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Masukan email';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(bottom: 10),
                                //  width: context.width_query / 3.3,
                                child: TextFormField(
                                  keyboardType: TextInputType.number,
                                  controller: controller.no_hp.value,
                                  onChanged: ((String pass) {}),
                                  decoration: InputDecoration(
                                    labelText: "Nomor hp",
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
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Masukan nomor hp';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ],
                          )),
                          Container(
                              margin: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 10),
                              child: VerticalDivider(
                                color: color_template().primary,
                                thickness: 1,
                              )),
                          Expanded(
                              child: Column(
                            children: [
                              Expanded(
                                  child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Container(
                                          //width: 200,
                                          child: CheckboxListTile(
                                            subtitle: const Text("opsional"),
                                            title: const Text("Logo toko?"),
                                            checkColor: Colors.white,
                                            value: controller.checkfoto.value,
                                            onChanged: (bool? value) {
                                              controller.checkfoto.value =
                                                  value!;
                                              if (controller.checkfoto.value ==
                                                  false) {
                                                controller.Logo.value = '-';
                                              } else {
                                                controller.Logo.value = '-';
                                              }
                                              print(controller.checkfoto.value);
                                              print(controller.Logo.value);
                                              // controller.check == true;
                                            },
                                          ),
                                        ),
                                      ),
                                      controller.checkfoto.value == false
                                          ? Container()
                                          : controller.pikedImagePath.value !=
                                                  ''
                                              ? Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Container(
                                                      width: 60,
                                                      height: 60,
                                                      child: Image.file(
                                                        File(controller
                                                            .pickedImageFile!
                                                            .path),
                                                        width: 60,
                                                        height: 60,
                                                      ),
                                                    ),
                                                    Container(
                                                      margin:
                                                          const EdgeInsets.only(
                                                              left: 10,
                                                              right: 5),
                                                      padding:
                                                          const EdgeInsets.all(
                                                              3),
                                                      decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        color: color_template()
                                                            .primary,
                                                      ),
                                                      child: IconButton(
                                                        splashColor:
                                                            Colors.orange,
                                                        focusColor:
                                                            Colors.orange,
                                                        onPressed: () async {
                                                          DeviceInfoPlugin
                                                              deviceInfo =
                                                              DeviceInfoPlugin();
                                                          AndroidDeviceInfo
                                                              androidInfo =
                                                              await deviceInfo
                                                                  .androidInfo;
                                                          if (androidInfo
                                                                  .version
                                                                  .sdkInt >=
                                                              33) {
                                                            var status =
                                                                await Permission
                                                                    .camera
                                                                    .status;
                                                            if (!status
                                                                .isGranted) {
                                                              await Permission
                                                                  .camera
                                                                  .request();
                                                            }
                                                          } else {
                                                            var status =
                                                                await Permission
                                                                    .camera
                                                                    .status;
                                                            if (!status
                                                                .isGranted) {
                                                              await Permission
                                                                  .camera
                                                                  .request();
                                                            }
                                                          }

                                                          controller
                                                              .pilihsourcefoto();
                                                        },
                                                        icon: const Icon(
                                                          Icons.add,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                )
                                              : controller.Logo != '-'
                                                  ? Row(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        Container(
                                                          width: 60,
                                                          height: 60,
                                                          child: Image.memory(
                                                              base64Decode(
                                                                  controller
                                                                      .Logo
                                                                      .value)),
                                                        ),
                                                        Container(
                                                          margin:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 10,
                                                                  right: 5),
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(3),
                                                          decoration:
                                                              BoxDecoration(
                                                            shape:
                                                                BoxShape.circle,
                                                            color:
                                                                color_template()
                                                                    .primary,
                                                          ),
                                                          child: IconButton(
                                                            splashColor:
                                                                Colors.orange,
                                                            focusColor:
                                                                Colors.orange,
                                                            onPressed:
                                                                () async {
                                                              DeviceInfoPlugin
                                                                  deviceInfo =
                                                                  DeviceInfoPlugin();
                                                              AndroidDeviceInfo
                                                                  androidInfo =
                                                                  await deviceInfo
                                                                      .androidInfo;
                                                              if (androidInfo
                                                                      .version
                                                                      .sdkInt >=
                                                                  33) {
                                                                var status =
                                                                    await Permission
                                                                        .camera
                                                                        .status;
                                                                if (!status
                                                                    .isGranted) {
                                                                  await Permission
                                                                      .camera
                                                                      .request();
                                                                }
                                                              } else {
                                                                var status =
                                                                    await Permission
                                                                        .camera
                                                                        .status;
                                                                if (!status
                                                                    .isGranted) {
                                                                  await Permission
                                                                      .camera
                                                                      .request();
                                                                }
                                                              }

                                                              controller
                                                                  .pilihsourcefoto();
                                                            },
                                                            icon: const Icon(
                                                              Icons.add,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    )
                                                  : Row(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        Container(
                                                          width: 60,
                                                          height: 60,
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                            color:
                                                                color_template()
                                                                    .primary,
                                                          ),
                                                          child: const Icon(
                                                            FontAwesomeIcons
                                                                .image,
                                                            color: Colors.white,
                                                            size: 50,
                                                          ),
                                                        ),
                                                        Container(
                                                          margin:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 10,
                                                                  right: 5),
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(3),
                                                          decoration:
                                                              BoxDecoration(
                                                            shape:
                                                                BoxShape.circle,
                                                            color:
                                                                color_template()
                                                                    .primary,
                                                          ),
                                                          child: IconButton(
                                                            splashColor:
                                                                Colors.orange,
                                                            focusColor:
                                                                Colors.orange,
                                                            onPressed:
                                                                () async {
                                                              DeviceInfoPlugin
                                                                  deviceInfo =
                                                                  DeviceInfoPlugin();
                                                              AndroidDeviceInfo
                                                                  androidInfo =
                                                                  await deviceInfo
                                                                      .androidInfo;
                                                              if (androidInfo
                                                                      .version
                                                                      .sdkInt >=
                                                                  33) {
                                                                var status =
                                                                    await Permission
                                                                        .camera
                                                                        .status;
                                                                if (!status
                                                                    .isGranted) {
                                                                  await Permission
                                                                      .camera
                                                                      .request();
                                                                }
                                                              } else {
                                                                var status =
                                                                    await Permission
                                                                        .camera
                                                                        .status;
                                                                if (!status
                                                                    .isGranted) {
                                                                  await Permission
                                                                      .camera
                                                                      .request();
                                                                }
                                                              }

                                                              controller
                                                                  .pilihsourcefoto();
                                                            },
                                                            icon: const Icon(
                                                              Icons.add,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                    ],
                                  ),
                                  // Row(
                                  //   children: [
                                  //     Expanded(
                                  //       child: Container(
                                  //         margin: EdgeInsets.only(bottom: 10),
                                  //         //width: context.width_query / 3.3,
                                  //
                                  //         child: Obx(() {
                                  //           return DropdownButtonFormField2(
                                  //             decoration: InputDecoration(
                                  //               icon:
                                  //                   Icon(FontAwesomeIcons.boxOpen),
                                  //               border: OutlineInputBorder(
                                  //                 borderRadius:
                                  //                     BorderRadius.circular(15),
                                  //               ),
                                  //             ),
                                  //             // validator: (value) {
                                  //             //   if (value != null) {
                                  //             //     return 'Pilih kategori produk';
                                  //             //   }
                                  //             //   return null;
                                  //             // },
                                  //             isExpanded: true,
                                  //             dropdownStyleData: DropdownStyleData(
                                  //                 decoration: BoxDecoration(
                                  //                     borderRadius:
                                  //                         BorderRadius.circular(10),
                                  //                     color: Colors.white)),
                                  //             hint: Text('Pilih kategori produk'),
                                  //             value: controller.jenisvalue.value,
                                  //             items: controller.jenislist
                                  //                 .map((DataJenis item) {
                                  //               return DropdownMenuItem(
                                  //                 child: Text(
                                  //                     item.namaJenis.toString()),
                                  //                 value: item.id.toString(),
                                  //               );
                                  //             }).toList(),
                                  //             onChanged: (val) {
                                  //               controller.jenisvalue.value =
                                  //                   val!.toString();
                                  //               print(controller.jenisvalue);
                                  //             },
                                  //           );
                                  //         }),
                                  //       ),
                                  //     ),
                                  //   ],
                                  // ),
                                  // Row(
                                  //   children: [
                                  //     Expanded(
                                  //       child: Container(
                                  //         margin: EdgeInsets.only(bottom: 10),
                                  //         // width: context.width_query / 3.3,
                                  //         //margin: EdgeInsets.only(left: 10),
                                  //         child: Obx(() {
                                  //           return DropdownButtonFormField2(
                                  //             decoration: InputDecoration(
                                  //               icon:
                                  //                   Icon(FontAwesomeIcons.boxOpen),
                                  //               border: OutlineInputBorder(
                                  //                 borderRadius:
                                  //                     BorderRadius.circular(15),
                                  //               ),
                                  //             ),
                                  //             validator: (value) {
                                  //               if (value == null) {
                                  //                 return 'Pilih jenis produk';
                                  //               }
                                  //               return null;
                                  //             },
                                  //             isExpanded: true,
                                  //             dropdownStyleData: DropdownStyleData(
                                  //                 decoration: BoxDecoration(
                                  //                     borderRadius:
                                  //                         BorderRadius.circular(10),
                                  //                     color: Colors.white)),
                                  //             hint: Text('Pilih jenis produk'),
                                  //             value: controller.jenisstokval.value,
                                  //             items: controller.jenisstok.value
                                  //                 .map((item) {
                                  //               return DropdownMenuItem(
                                  //                 child:
                                  //                     Text(item['nama'].toString()),
                                  //                 value: item['id'].toString(),
                                  //               );
                                  //             }).toList(),
                                  //             onChanged: (val) {
                                  //               controller.jenisstokval.value =
                                  //                   val.toString();
                                  //               controller.jj.value =
                                  //                   val.toString();
                                  //               print(controller.jj.value);
                                  //               print(controller.jenisstokval);
                                  //             },
                                  //           );
                                  //         }),
                                  //       ),
                                  //     ),
                                  //     // controller.jj.value == '2' ||
                                  //     //         controller.jj.value == ''
                                  //     //     ? Container()
                                  //     //     : Expanded(
                                  //     //         child: Container(
                                  //     //           margin: EdgeInsets.only(
                                  //     //               left: 10, bottom: 10),
                                  //     //           child: TextFormField(
                                  //     //             keyboardType:
                                  //     //                 TextInputType.number,
                                  //     //             controller: controller.qty.value,
                                  //     //             decoration: InputDecoration(
                                  //     //               labelText: "Jumlah stock",
                                  //     //               labelStyle: TextStyle(
                                  //     //                 color: Colors.black87,
                                  //     //               ),
                                  //     //               border: OutlineInputBorder(
                                  //     //                   borderRadius:
                                  //     //                       BorderRadius.circular(
                                  //     //                           10)),
                                  //     //               focusedBorder:
                                  //     //                   OutlineInputBorder(
                                  //     //                       borderRadius:
                                  //     //                           BorderRadius
                                  //     //                               .circular(10)),
                                  //     //             ),
                                  //     //
                                  //     //             validator: (value) {
                                  //     //               if (value!.isEmpty) {
                                  //     //                 return 'Masukan stock barang';
                                  //     //               } else if (value
                                  //     //                       .isNumericOnly ==
                                  //     //                   false) {
                                  //     //                 return 'Stock harus berupa angka';
                                  //     //               }
                                  //     //               return null;
                                  //     //             },
                                  //     //           ),
                                  //     //         ),
                                  //     //       ),
                                  //   ],
                                  // ),
                                ],
                              )),
                            ],
                          ))
                        ],
                      ),
                    ));
              }),
              SizedBox(
                height: 25,
              ),
              button_solid_custom(
                  onPressed: () async {
                    if (controller.formKeytoko.value.currentState!.validate()) {
                      // try {
                      await controller.editToko();
                      // } catch (e) {
                      //   Get.back();
                      //   Get.showSnackbar(toast()
                      //       .bottom_snackbar_error('Error', e.toString()));
                      // }
                    }
                  },
                  child: Text(
                    'edit toko'.toUpperCase(),
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
