import 'dart:convert';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:pattern_formatter/numeric_formatter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rims_waserda/Modules/Widgets/card_custom.dart';
import 'package:rims_waserda/Modules/Widgets/toast.dart';
import 'package:rims_waserda/Modules/produk/edit%20produk/controller_edit_produk.dart';

import '../../../Templates/setting.dart';
import '../../Widgets/buttons.dart';
import '../../Widgets/header.dart';

class edit_produk_form extends GetView<editprodukController> {
  const edit_produk_form({Key? key}) : super(key: key);

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
              const header(
                title: 'Edit Produk',
                icon: FontAwesomeIcons.pencil,
                iscenter: false,
              ),
              const SizedBox(
                height: 25,
              ),
              Obx(() {
                return Form(
                    key: controller.formKeyprodukedit.value,
                    child: IntrinsicHeight(
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(bottom: 10),
                                  // width: context.width_query / 2.2,
                                  // height: 100,
                                  child: TextFormField(
                                    controller: controller.nama_produk.value,
                                    onChanged: ((String pass) {}),
                                    decoration: InputDecoration(
                                      labelText: "Nama produk",
                                      labelStyle: const TextStyle(
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
                                        return 'Masukan nama produk';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(bottom: 10),
                                  //  width: context.width_query / 3.3,
                                  child: TextFormField(
                                    controller: controller.desc.value,
                                    onChanged: ((String pass) {}),
                                    decoration: InputDecoration(
                                      labelText: "Deskripsi",
                                      labelStyle: const TextStyle(
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
                                        return 'Masukan deskirpsi produk';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        child: CheckboxListTile(
                                          subtitle: const Text("opsional"),
                                          title: const Text("Barcode?"),

                                          checkColor: Colors.white,
                                          //  fillColor: MaterialStateProperty.resolveWith(getColor),
                                          value: controller.checkbarcode.value,
                                          onChanged: (bool? value) {
                                            controller.checkbarcode.value =
                                                value!;
                                            if (controller.checkbarcode.value ==
                                                false) {
                                              controller.barcode.value.text =
                                                  '-';
                                            }
                                            print(
                                                controller.checkbarcode.value);
                                            // controller.check == true;
                                          },
                                        ),
                                      ),
                                    ),
                                    controller.checkbarcode.value == false
                                        ? Container()
                                        : Expanded(
                                            child: Container(
                                              //margin: EdgeInsets.only(bottom: 10),
                                              // width: context.width_query / 2.2,
                                              // height: 100,
                                              child: TextFormField(
                                                controller:
                                                    controller.barcode.value,
                                                onChanged: ((String pass) {}),
                                                decoration: InputDecoration(
                                                  labelText: "Barcode",
                                                  labelStyle: const TextStyle(
                                                    color: Colors.black87,
                                                  ),
                                                  border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10)),
                                                ),
                                                validator: (value) {
                                                  if (value!.isEmpty) {
                                                    return 'Masukan barcode';
                                                  }
                                                  return null;
                                                },
                                              ),
                                            ),
                                          ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          Container(
                              margin: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 10),
                              child: VerticalDivider(
                                color: color_template().primary,
                                thickness: 1,
                              )),
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
                                        title: const Text("Foto produk?"),
                                        checkColor: Colors.white,
                                        //  fillColor: MaterialStateProperty.resolveWith(getColor),
                                        value: controller.checkfoto.value,
                                        onChanged: (bool? value) {
                                          controller.checkfoto.value = value!;
                                          if (controller.checkfoto.value ==
                                              false) {
                                            controller.data.image = null;
                                          } else {
                                            controller.data.image = '-';
                                          }
                                          print(controller.checkfoto.value);
                                          print(controller.data.image);
                                          // controller.check == true;
                                        },
                                      ),
                                    ),
                                  ),
                                  controller.checkfoto.value == false
                                      ? Container()
                                      : controller.pikedImagePath.value != ''
                                          ? Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Container(
                                                  width: 60,
                                                  height: 60,
                                                  child: Image.file(
                                                    File(controller
                                                        .pickedImageFile!.path),
                                                    width: 60,
                                                    height: 60,
                                                  ),
                                                ),
                                                Container(
                                                  margin: const EdgeInsets.only(
                                                      left: 10, right: 5),
                                                  padding:
                                                      const EdgeInsets.all(3),
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: color_template()
                                                        .primary,
                                                  ),
                                                  child: IconButton(
                                                    splashColor: Colors.orange,
                                                    focusColor: Colors.orange,
                                                    onPressed: () async {
                                                      DeviceInfoPlugin
                                                          deviceInfo =
                                                          DeviceInfoPlugin();
                                                      AndroidDeviceInfo
                                                          androidInfo =
                                                          await deviceInfo
                                                              .androidInfo;
                                                      if (androidInfo
                                                              .version.sdkInt >=
                                                          33) {
                                                        var status =
                                                            await Permission
                                                                .camera.status;
                                                        if (!status.isGranted) {
                                                          await Permission
                                                              .camera
                                                              .request();
                                                        }
                                                      } else {
                                                        var status =
                                                            await Permission
                                                                .camera.status;
                                                        if (!status.isGranted) {
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
                                          : controller.data.image != '-'
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
                                                                  .data.image)),
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
                                              : Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Container(
                                                      width: 60,
                                                      height: 60,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        color: color_template()
                                                            .primary,
                                                      ),
                                                      child: const Icon(
                                                        FontAwesomeIcons.image,
                                                        color: Colors.white,
                                                        size: 50,
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
                          Container(
                              margin: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 10),
                              child: VerticalDivider(
                                color: color_template().primary,
                                thickness: 1,
                              )),
                          Expanded(
                              child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Expanded(
                                child: TextFormField(
                                  keyboardType: TextInputType.number,
                                  controller: controller.hargamodal.value,
                                  inputFormatters: [ThousandsFormatter()],
                                  onChanged: ((String num) {
                                    controller.jumlahhargamodal.value =
                                        int.parse(
                                            num.toString().replaceAll(',', ''));
                                    print(controller.jumlahhargamodal.value);
                                  }),
                                  decoration: InputDecoration(
                                    labelText: "Harga modal",
                                    labelStyle: const TextStyle(
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
                                      return 'Masukan harga modal';
                                    }
                                    return null;
                                  },
                                ),
                              ),
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
                                    labelText: "Harga jual",
                                    labelStyle: const TextStyle(
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
                                      return 'Masukan harga jual';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              Expanded(
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        // width: 200,
                                        child: CheckboxListTile(
                                          title: const Text("Diskon produk?"),
                                          subtitle: const Text('opsional'),
                                          checkColor: Colors.white,
                                          //  fillColor: MaterialStateProperty.resolveWith(getColor),
                                          value: controller.check.value,
                                          onChanged: (bool? value) {
                                            controller.check.value = value!;
                                            if (controller.check.value ==
                                                false) {
                                              controller.diskon_barang.value
                                                  .text = '0';
                                              controller.jumlahdiskon.value = 0;
                                            }
                                            print(controller.check.value);
                                            // controller.check == true;
                                          },
                                        ),
                                      ),
                                    ),
                                    controller.check.value == false
                                        ? Container()
                                        : Expanded(
                                            child: TextFormField(
                                              keyboardType:
                                                  TextInputType.number,
                                              controller: controller
                                                  .diskon_barang.value,
                                              inputFormatters: [
                                                ThousandsFormatter()
                                              ],
                                              onChanged: ((String num) {
                                                controller.jumlahdiskon.value =
                                                    double.parse(num.toString()
                                                        .replaceAll(',', ''));
                                                print(controller.jumlahdiskon);
                                              }),
                                              decoration: InputDecoration(
                                                suffix: Text(
                                                  '%',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                labelText: "Besar diskon",
                                                labelStyle: const TextStyle(
                                                  color: Colors.black87,
                                                ),
                                                border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10)),
                                              ),
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
                              ),
                            ],
                          )),
                        ],
                      ),
                    ));
              }),
              const SizedBox(
                height: 25,
              ),
              button_solid_custom(
                  onPressed: () async {
                    if (controller.formKeyprodukedit.value.currentState!
                        .validate()) {
                      try {
                        await controller.ProdukEditlocal();
                      } catch (e) {
                        Get.back();
                        print('eerorrrr');
                        print(e);
                        Get.showSnackbar(toast()
                            .bottom_snackbar_error('Error', e.toString()));
                      }
                    }
                  },
                  child: Text(
                    'edit produk'.toUpperCase(),
                    style: const TextStyle(
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
