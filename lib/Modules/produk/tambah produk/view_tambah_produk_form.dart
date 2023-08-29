import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:group_button/group_button.dart';
import 'package:pattern_formatter/numeric_formatter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rims_waserda/Modules/Widgets/card_custom.dart';
import 'package:rims_waserda/Modules/Widgets/toast.dart';

import '../../../Templates/setting.dart';
import '../../Widgets/buttons.dart';
import '../../Widgets/header.dart';
import '../data produk/controller_data_produk.dart';
import '../jenis produk/model_jenisproduk.dart';
import '../jenis produk/view_tambah_jenis.dart';

class tambah_produk_form extends GetView<produkController> {
  const tambah_produk_form({Key? key}) : super(key: key);

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
                title: 'Tambah Produk',
                icon: FontAwesomeIcons.boxOpen,
                iscenter: false,
              ),
              SizedBox(
                height: 25,
              ),
              Obx(() {
                return Form(
                    key: controller.formKeyproduk.value,
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
                                    controller: controller.nama_produk.value,
                                    onChanged: ((String pass) {}),
                                    decoration: InputDecoration(
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
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Masukan nama produk';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(bottom: 10),
                                  //  width: context.width_query / 3.3,
                                  child: TextFormField(
                                    controller: controller.desc.value,
                                    onChanged: ((String pass) {}),
                                    decoration: InputDecoration(
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
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Masukan deskirpsi produk';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                Expanded(
                                  child: Row(
                                    children: [
                                      controller.checkfoto == false
                                          ? Expanded(
                                              child: Container(
                                                // color: Colors.red,
                                                // width: 100,
                                                child: Row(
                                                  children: [
                                                    Expanded(
                                                      child: Container(
                                                        //color: Colors.green,
                                                        // width: 80,
                                                        child: ListTile(
                                                          title: Text(
                                                              'Foto produk'),
                                                          subtitle:
                                                              Text('opsional'),
                                                        ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Checkbox(
                                                        value: controller
                                                            .checkfoto.value,
                                                        onChanged:
                                                            (bool? value) {
                                                          controller.checkfoto
                                                              .value = value!;
                                                          if (controller
                                                                  .checkfoto
                                                                  .value ==
                                                              false) {
                                                            controller
                                                                .pikedImagePath
                                                                .value = '';
                                                            controller.image64 =
                                                                null;
                                                          }
                                                          print(controller
                                                              .checkfoto.value);
                                                          // controller.check == true;
                                                        },
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            )
                                          : Container(
                                              width: 40,
                                              child: Checkbox(
                                                value:
                                                    controller.checkfoto.value,
                                                onChanged: (bool? value) {
                                                  controller.checkfoto.value =
                                                      value!;
                                                  if (controller
                                                          .checkfoto.value ==
                                                      false) {
                                                    controller.pikedImagePath
                                                        .value = '';
                                                    controller.image64 = null;
                                                  }
                                                  print(controller
                                                      .checkfoto.value);
                                                  // controller.check == true;
                                                },
                                              ),
                                            ),
                                      controller.checkfoto.value == false
                                          ? Container()
                                          : controller.pikedImagePath.value ==
                                                  ''
                                              ? Expanded(
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: [
                                                      Container(
                                                        margin: EdgeInsets.only(
                                                            left: 10),
                                                        width: 60,
                                                        height: 60,
                                                        padding:
                                                            EdgeInsets.all(1),
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          color:
                                                              color_template()
                                                                  .primary,
                                                        ),
                                                        child: Icon(
                                                          FontAwesomeIcons
                                                              .image,
                                                          color: Colors.white,
                                                          size: 50,
                                                        ),
                                                      ),
                                                      Container(
                                                        margin: EdgeInsets.only(
                                                          left: 10,
                                                        ),
                                                        padding:
                                                            EdgeInsets.all(3),
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
                                                          icon: Icon(
                                                            Icons.add,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              : Expanded(
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Expanded(
                                                        child: Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                                  left: 20),
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
                                                      ),
                                                      Container(
                                                        margin: EdgeInsets.only(
                                                          left: 10,
                                                        ),
                                                        padding:
                                                            EdgeInsets.all(1),
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
                                                          icon: Icon(
                                                            Icons.add,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                    ],
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
                              Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      margin: EdgeInsets.only(bottom: 10),
                                      //width: context.width_query / 3.3,

                                      child: DropdownButtonFormField2(
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                        ),
                                        validator: (value) {
                                          if (value == null) {
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
                                        value: controller.jenisvalue,
                                        items: controller.jenislistlocal
                                            .map((DataJenis item) {
                                          return DropdownMenuItem(
                                            child:
                                                Text(item.namaJenis.toString()),
                                            value: item.idLocal.toString(),
                                          );
                                        }).toList(),
                                        onChanged: (val) {
                                          controller.jenisvalue =
                                              val!.toString();
                                          print(controller.jenisvalue);
                                        },
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(
                                      left: 10,
                                    ),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: color_template().primary,
                                    ),
                                    padding: EdgeInsets.all(1),
                                    child: IconButton(
                                        color: Colors.white,
                                        onPressed: () {
                                          Get.dialog(AlertDialog(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(
                                                              20.0))),
                                              contentPadding: EdgeInsets.zero,
                                              backgroundColor:
                                                  Colors.transparent,
                                              content: Builder(
                                                builder: (context) {
                                                  return Container(
                                                      padding: EdgeInsets.zero,
                                                      width:
                                                          context.width_query /
                                                              2,
                                                      height:
                                                          context.height_query /
                                                              2,
                                                      child: ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(30),
                                                          child:
                                                              tambah_jenis()));
                                                },
                                              )));
                                        },
                                        icon: Icon(Icons.add)),
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      margin: EdgeInsets.only(bottom: 10),
                                      // width: context.width_query / 3.3,
                                      //margin: EdgeInsets.only(left: 10),
                                      child: GetBuilder<produkController>(
                                          builder: (logic) {
                                        return DropdownButtonFormField2(
                                          decoration: InputDecoration(
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                            ),
                                          ),
                                          validator: (value) {
                                            if (value == null) {
                                              return 'Pilih jenis produk';
                                            }
                                            return null;
                                          },
                                          isExpanded: true,
                                          dropdownStyleData: DropdownStyleData(
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  color: Colors.white)),
                                          hint: Text('Pilih jenis produk'),
                                          value: logic.jenisstokval,
                                          items:
                                              logic.jenisstok.value.map((item) {
                                            return DropdownMenuItem(
                                              child:
                                                  Text(item['nama'].toString()),
                                              value: item['id'].toString(),
                                            );
                                          }).toList(),
                                          onChanged: (val) {
                                            logic.jenisstokval = val.toString();
                                            logic.jj.value = val.toString();
                                            print(logic.jj.value);
                                            print(logic.jenisstokval);
                                            logic.update();
                                          },
                                        );
                                      }),
                                    ),
                                  ),
                                  controller.jj.value == '2' ||
                                          controller.jj.value == ''
                                      ? Container()
                                      : Expanded(
                                          child: Container(
                                            margin: EdgeInsets.only(
                                                left: 10, bottom: 10),
                                            child: TextFormField(
                                              keyboardType:
                                                  TextInputType.number,
                                              controller: controller.qty.value,
                                              decoration: InputDecoration(
                                                labelText: "Jumlah stock",
                                                labelStyle: TextStyle(
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
                                                  return 'Masukan stock barang';
                                                } else if (value
                                                        .isNumericOnly ==
                                                    false) {
                                                  return 'Stock harus berupa angka';
                                                }
                                                return null;
                                              },
                                            ),
                                          ),
                                        ),
                                ],
                              ),
                              Expanded(
                                  child: Row(
                                children: [
                                  controller.checkbarcode == false
                                      ? Expanded(
                                          child: Container(
                                            //color: Colors.red,
                                            //width: 100,
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  child: Container(
                                                    // color: Colors.green,
                                                    // width: 80,
                                                    child: ListTile(
                                                      title: Text(
                                                        'Barcode',
                                                        style: font().reguler,
                                                      ),
                                                      subtitle: Text(
                                                        'opsional',
                                                        style: font().reguler,
                                                      ),
                                                      visualDensity:
                                                          VisualDensity.compact,
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Checkbox(
                                                    value: controller
                                                        .checkbarcode.value,
                                                    onChanged: (bool? value) {
                                                      controller.checkbarcode
                                                          .value = value!;
                                                      if (controller
                                                              .checkbarcode
                                                              .value ==
                                                          false) {
                                                        controller.barcode.value
                                                            .text = '-';
                                                      }
                                                      print(controller
                                                          .checkbarcode.value);
                                                      // controller.check == true;
                                                    },
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        )
                                      : Container(
                                          width: 40,
                                          //color: Colors.red,
                                          child: Checkbox(
                                            value:
                                                controller.checkbarcode.value,
                                            onChanged: (bool? value) {
                                              controller.checkbarcode.value =
                                                  value!;
                                              if (controller
                                                      .checkbarcode.value ==
                                                  false) {
                                                controller.barcode.value.text =
                                                    '-';
                                              }
                                              print(controller
                                                  .checkbarcode.value);
                                              // controller.check == true;
                                            },
                                          ),
                                        ),
                                  controller.checkbarcode == false
                                      ? Container()
                                      : Expanded(
                                          child: Obx(() {
                                            return Row(
                                              children: [
                                                Expanded(
                                                  child: Container(
                                                    // width: context.width_query / 2.2,
                                                    // height: 100,
                                                    child: TextFormField(
                                                      controller: controller
                                                          .barcode.value,
                                                      onChanged:
                                                          ((String pass) {}),
                                                      decoration:
                                                          InputDecoration(
                                                        labelText: "Barcode",
                                                        labelStyle: TextStyle(
                                                          color: Colors.black87,
                                                        ),
                                                        border: OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10)),
                                                        focusedBorder:
                                                            OutlineInputBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10)),
                                                      ),
                                                      textAlign:
                                                          TextAlign.center,
                                                      validator: (value) {
                                                        if (value!.isEmpty) {
                                                          return 'Masukan barcode';
                                                        }
                                                        return null;
                                                      },
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  margin:
                                                      EdgeInsets.only(left: 5),
                                                  decoration: BoxDecoration(
                                                      color: color_template()
                                                          .primary,
                                                      borderRadius:
                                                          border_radius()
                                                              .icon_border),
                                                  child: IconButton(
                                                    onPressed: () {
                                                      controller.scan();
                                                    },
                                                    icon: Icon(FontAwesomeIcons
                                                        .camera),
                                                    color: Colors.white,
                                                  ),
                                                )
                                              ],
                                            );
                                          }),
                                        ),
                                ],
                              ))
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
                                      return 'Masukan harga jual';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              Row(
                                children: [
                                  controller.check == false
                                      ? Expanded(
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: Container(
                                                  //color: Colors.green,
                                                  //  width: 80,
                                                  child: ListTile(
                                                    title: Text('Diskon'),
                                                    subtitle: Text('opsional'),
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                child: Checkbox(
                                                  value: controller.check.value,
                                                  onChanged: (bool? value) {
                                                    controller.check.value =
                                                        value!;
                                                    controller.metode_diskon
                                                        .value = 9;
                                                    print(
                                                        controller.check.value);
                                                    // controller.check == true;
                                                  },
                                                ),
                                              )
                                            ],
                                          ),
                                        )
                                      : Container(
                                          width: 40,
                                          child: Checkbox(
                                            value: controller.check.value,
                                            onChanged: (bool? value) {
                                              controller.check.value = value!;
                                              print(controller.check.value);
                                              // controller.check == true;
                                            },
                                          ),
                                        ),
                                  controller.check == false
                                      ? Container()
                                      : Expanded(
                                          child: Container(
                                            margin: EdgeInsets.only(left: 10),
                                            child: Row(
                                              children: [
                                                controller.metode_diskon == 9
                                                    ? Text(
                                                        'Pilih metode diskon')
                                                    : controller.metode_diskon ==
                                                            1
                                                        ? Expanded(
                                                            child:
                                                                TextFormField(
                                                              keyboardType:
                                                                  TextInputType
                                                                      .number,
                                                              controller: controller
                                                                  .diskon_barang
                                                                  .value,
                                                              inputFormatters: [
                                                                ThousandsFormatter()
                                                              ],
                                                              onChanged:
                                                                  ((String
                                                                      num) {
                                                                controller
                                                                    .jumlahdiskon
                                                                    .value = double.parse(num
                                                                        .toString()
                                                                    .replaceAll(
                                                                        ',',
                                                                        ''));
                                                                print(controller
                                                                    .jumlahdiskon);
                                                              }),
                                                              decoration:
                                                                  InputDecoration(
                                                                suffix:
                                                                    Text('%'),
                                                                labelText:
                                                                    "Persentase diskon",
                                                                labelStyle:
                                                                    TextStyle(
                                                                  color: Colors
                                                                      .black87,
                                                                ),
                                                                border: OutlineInputBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10)),
                                                                focusedBorder: OutlineInputBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10)),
                                                              ),
                                                              validator:
                                                                  (value) {
                                                                if (value!
                                                                    .isEmpty) {
                                                                  return 'Masukan persentase diskon';
                                                                }
                                                                return null;
                                                              },
                                                            ),
                                                          )
                                                        : Expanded(
                                                            child:
                                                                TextFormField(
                                                              keyboardType:
                                                                  TextInputType
                                                                      .number,
                                                              controller: controller
                                                                  .diskon_barang
                                                                  .value,
                                                              inputFormatters: [
                                                                ThousandsFormatter()
                                                              ],
                                                              onChanged:
                                                                  ((String
                                                                      num) {
                                                                controller
                                                                    .jumlahdiskon
                                                                    .value = double.parse(num
                                                                        .toString()
                                                                    .replaceAll(
                                                                        ',',
                                                                        ''));
                                                                print(controller
                                                                    .jumlahdiskon);
                                                              }),
                                                              decoration:
                                                                  InputDecoration(
                                                                prefixText:
                                                                    'Rp.',
                                                                labelText:
                                                                    "Potongan harga",
                                                                labelStyle:
                                                                    TextStyle(
                                                                  color: Colors
                                                                      .black87,
                                                                ),
                                                                border: OutlineInputBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10)),
                                                                focusedBorder: OutlineInputBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10)),
                                                              ),
                                                              validator:
                                                                  (value) {
                                                                if (value!
                                                                    .isEmpty) {
                                                                  return 'Masukan potongan harga';
                                                                }
                                                                return null;
                                                              },
                                                            ),
                                                          ),
                                                Container(
                                                  margin: EdgeInsets.only(
                                                      left: 15, top: 10),
                                                  child: GroupButton(
                                                    isRadio: true,
                                                    onSelected:
                                                        (string, index, bool) {
                                                      controller.metode_diskon
                                                          .value = index + 1;
                                                      print(controller
                                                          .metode_diskon.value);
                                                    },
                                                    buttons: [
                                                      "Persen",
                                                      "Nominal",
                                                    ],
                                                    options: GroupButtonOptions(
                                                      selectedShadow: const [],
                                                      selectedTextStyle:
                                                          TextStyle(
                                                              fontSize: 15,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                      selectedColor:
                                                          color_template()
                                                              .select,
                                                      unselectedShadow: const [],
                                                      unselectedColor:
                                                          Colors.white,
                                                      unselectedTextStyle:
                                                          const TextStyle(
                                                        fontSize: 12,
                                                        color: Colors.black,
                                                      ),
                                                      //selectedBorderColor: Colors.pink[900],
                                                      unselectedBorderColor:
                                                          color_template()
                                                              .select,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      spacing: 5,
                                                      runSpacing: 5,
                                                      groupingType:
                                                          GroupingType.column,
                                                      direction: Axis.vertical,
                                                      buttonHeight:
                                                          context.height_query /
                                                              20,
                                                      buttonWidth:
                                                          context.width_query /
                                                              20,
                                                      mainGroupAlignment:
                                                          MainGroupAlignment
                                                              .spaceAround,
                                                      crossGroupAlignment:
                                                          CrossGroupAlignment
                                                              .center,
                                                      groupRunAlignment:
                                                          GroupRunAlignment
                                                              .spaceBetween,
                                                      textAlign:
                                                          TextAlign.center,
                                                      textPadding:
                                                          EdgeInsets.zero,
                                                      alignment:
                                                          Alignment.center,
                                                      elevation: 3,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                ],
                              ),
                            ],
                          )),
                        ],
                      ),
                    ));
              }),
              SizedBox(
                height: 25,
              ),
              button_solid_custom(
                  onPressed: () {
                    if (controller.formKeyproduk.value.currentState!
                        .validate()) {
                      try {
                        controller.ProdukTambahlocal();
                      } catch (e) {
                        Get.back();
                        Get.showSnackbar(toast()
                            .bottom_snackbar_error('Error', e.toString()));
                      }
                    }
                  },
                  child: Text(
                    'tambah produk'.toUpperCase(),
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
