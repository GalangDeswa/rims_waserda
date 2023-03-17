import 'dart:io';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:image_picker/image_picker.dart';

import '../../../Templates/setting.dart';
import '../../Widgets/buttons.dart';
import '../../Widgets/header.dart';
import 'controller_tambah_produk.dart';

class tambah_produk_form extends GetView<tambah_produkController> {
  const tambah_produk_form({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: elevation().def_elevation,
      //margin: EdgeInsets.all(30),
      shape: RoundedRectangleBorder(
        borderRadius: border_radius().def_border,
        side: BorderSide(color: color_template().primary, width: 3.5),
      ),
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              header(
                title: "Tambah Produk",
                icon: Icons.add_box,
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                margin: EdgeInsets.only(bottom: 15),
                //color: Colors.red,
                child: Stack(
                  children: [
                    Obx(() {
                      return controller.compresimagepath == ''
                          ? Container(
                              margin: EdgeInsets.symmetric(horizontal: 10),
                              width: 150,
                              height: 150,
                              decoration: BoxDecoration(
                                  color: color_template().primary,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Icon(
                                Icons.image,
                                color: Colors.white,
                              ))
                          : Container(
                              width: 150,
                              height: 150,
                              child: Image.file(
                                File(controller.compresimagepath.value),
                                width: double.infinity,
                                height: 300,
                              ),
                            );
                    }),
                    Obx(() {
                      return Expanded(
                          child: Container(
                        width: 150,
                        height: 100,
                        child: GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    crossAxisSpacing: 16,
                                    mainAxisSpacing: 16),
                            itemCount: controller.selectedfilecount.value,
                            itemBuilder: (context, index) {
                              return Image.file(
                                File(controller.listimagepath[index]),
                                width: 150,
                                height: 150,
                                fit: BoxFit.cover,
                              );
                            }),
                      ));
                    }),
                    Positioned.fill(
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: icon_button_custom(
                          onPressed: () {
                            controller.getimagev2(ImageSource.camera);
                          },
                          icon: Icons.add_a_photo,
                          icon_color: color_template().primary,
                          container_color: Colors.white,
                          border_color: Colors.white,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Form(
                  key: controller.formKey.value,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Card(
                        margin: EdgeInsets.symmetric(vertical: 5),
                        child: Padding(
                          padding: EdgeInsets.all(20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              //Icon(Icons.category),
                              Obx(() {
                                return Expanded(
                                  child: Container(
                                    child: DropdownButton2<String>(
                                      hint: Text('jenis produk'),
                                      value: controller.defdef.value,
                                      items: controller.jenisproduk.value
                                          .map((item) {
                                        return DropdownMenuItem<String>(
                                          child: Text(item),
                                          value: item,
                                        );
                                      }).toList(),
                                      onChanged: (String? val) {
                                        controller.defdef.value = val!;
                                      },
                                    ),
                                  ),
                                );
                              }),
                            ],
                          ),
                        ),
                      ),
                      /*  Card(
                            margin: EdgeInsets.symmetric(vertical: 10),
                            child: Padding(
                              padding: EdgeInsets.all(20),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Tambah foto produk'),
                                  */ /* Obx(() {
                                    return controller.namaFile == ''
                                        ? Container(
                                            margin: EdgeInsets.symmetric(
                                                horizontal: 10),
                                            width: 100,
                                            height: 100,
                                            decoration: BoxDecoration(
                                                color: color_template().primary,
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            child: Icon(
                                              Icons.image,
                                              color: Colors.white,
                                            ))
                                        : Container(
                                            width: 200,
                                            height: 200,
                                            decoration: BoxDecoration(
                                                image: DecorationImage(
                                                  image: Image.file(
                                                    controller.imgFile!,
                                                    fit: BoxFit.cover,
                                                  ).image,
                                                ),
                                                color: color_template().primary,
                                                borderRadius:
                                                    BorderRadius.circular(3)),
                                          );
                                  }),*/ /*
                                  Obx(() {
                                    return controller.compresimagepath == ''
                                        ? Container(
                                            margin: EdgeInsets.symmetric(
                                                horizontal: 10),
                                            width: 100,
                                            height: 100,
                                            decoration: BoxDecoration(
                                                color: color_template().primary,
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            child: Icon(
                                              Icons.image,
                                              color: Colors.white,
                                            ))
                                        : Container(
                                            width: 100,
                                            height: 100,
                                            child: Image.file(
                                              File(controller
                                                  .compresimagepath.value),
                                              width: double.infinity,
                                              height: 300,
                                            ),
                                          );
                                  }),
                                  Obx(() {
                                    return Expanded(
                                        child: Container(
                                      width: 150,
                                      height: 100,
                                      child: GridView.builder(
                                          gridDelegate:
                                              SliverGridDelegateWithFixedCrossAxisCount(
                                                  crossAxisCount: 3,
                                                  crossAxisSpacing: 16,
                                                  mainAxisSpacing: 16),
                                          itemCount: controller
                                              .selectedfilecount.value,
                                          itemBuilder: (context, index) {
                                            return Image.file(
                                              File(controller
                                                  .listimagepath[index]),
                                              width: 100,
                                              height: 100,
                                              fit: BoxFit.cover,
                                            );
                                          }),
                                    ));
                                  }),
                                  Obx(() {
                                    return Text(controller.imagesize == ''
                                        ? ''
                                        : controller.imagesize.value);
                                  }),
                                  icon_button_custom(
                                      onPressed: () {
                                        controller
                                            .getimagev2(ImageSource.camera);
                                      },
                                      icon: Icons.add_a_photo,
                                      container_color: color_template().primary)
                                ],
                              ),
                            ),
                          ),*/
                      Card(
                        margin: EdgeInsets.symmetric(vertical: 5),
                        child: Padding(
                            padding: EdgeInsets.all(20),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    //Icon(Icons.category),
                                    Expanded(
                                      child: Container(
                                        child: TextFormField(
                                          controller:
                                              controller.kode_produk.value,
                                          onChanged: ((String pass) {}),
                                          decoration: InputDecoration(
                                            icon: Icon(Icons.code),
                                            labelText: "kode produk",
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
                                              return 'Please enter email';
                                            }
                                            return null;
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 25,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Expanded(
                                      child: Container(
                                        //margin: EdgeInsets.only(left: 50),
                                        // color: Colors.red,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Obx(() {
                                              return Row(
                                                children: [
                                                  Checkbox(
                                                    activeColor: Colors.blue,
                                                    //The color to use when this checkbox is checked.
                                                    checkColor: Colors.white,
                                                    value: controller
                                                        .checkbox.value,
                                                    onChanged: (bool? value) {
                                                      controller
                                                              .checkbox.value =
                                                          !controller
                                                              .checkbox.value;
                                                      print(controller
                                                          .checkbox.value);
                                                    },
                                                  ),
                                                  Text('sama dengan kode')
                                                ],
                                              );
                                            }),
                                            Obx(() {
                                              return controller
                                                          .checkbox.value ==
                                                      true
                                                  ? AbsorbPointer(
                                                      child: Expanded(
                                                        child: Container(
                                                          decoration: BoxDecoration(
                                                              color: Colors.grey
                                                                  .withOpacity(
                                                                      0.3),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10)),
                                                          //width: 300,
                                                          child: Obx(() {
                                                            return Expanded(
                                                              child:
                                                                  TextFormField(
                                                                controller:
                                                                    controller
                                                                        .barcode
                                                                        .value,
                                                                onChanged:
                                                                    ((String
                                                                        pass) {}),
                                                                decoration:
                                                                    InputDecoration(
                                                                  icon: Icon(Icons
                                                                      .qr_code),
                                                                  labelText:
                                                                      "barcode",
                                                                  labelStyle:
                                                                      TextStyle(
                                                                    color: Colors
                                                                        .black87,
                                                                  ),
                                                                  border: OutlineInputBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              10)),
                                                                  focusedBorder:
                                                                      OutlineInputBorder(
                                                                          borderRadius:
                                                                              BorderRadius.circular(10)),
                                                                ),
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                validator:
                                                                    (value) {
                                                                  if (value!
                                                                      .isEmpty) {
                                                                    return 'Please enter email';
                                                                  }
                                                                  return null;
                                                                },
                                                              ),
                                                            );
                                                          }),
                                                        ),
                                                      ),
                                                    )
                                                  : Container(
                                                      //width: 300,
                                                      child: Obx(() {
                                                        return TextFormField(
                                                          controller: controller
                                                              .barcode.value,
                                                          onChanged: ((String
                                                              pass) {}),
                                                          decoration:
                                                              InputDecoration(
                                                            icon: Icon(
                                                                Icons.qr_code),
                                                            labelText:
                                                                "barcode",
                                                            labelStyle:
                                                                TextStyle(
                                                              color: Colors
                                                                  .black87,
                                                            ),
                                                            border: OutlineInputBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10)),
                                                            focusedBorder: OutlineInputBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10)),
                                                          ),
                                                          textAlign:
                                                              TextAlign.center,
                                                          validator: (value) {
                                                            if (value!
                                                                .isEmpty) {
                                                              return 'Please enter email';
                                                            }
                                                            return null;
                                                          },
                                                        );
                                                      }),
                                                    );
                                            })
                                          ],
                                        ),
                                      ),
                                    ),
                                    icon_button_custom(
                                        onPressed: () {
                                          controller.scan();
                                        },
                                        icon: Icons.qr_code,
                                        container_color:
                                            color_template().primary),
                                  ],
                                ),
                              ],
                            )),
                      ),
                      Card(
                        margin: EdgeInsets.symmetric(vertical: 5),
                        child: Padding(
                            padding: EdgeInsets.all(20),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Container(
                                        child: TextFormField(
                                          controller:
                                              controller.nama_produk.value,
                                          onChanged: ((String pass) {}),
                                          decoration: InputDecoration(
                                            icon: Icon(Icons.add_box),
                                            labelText: "nama produk",
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
                                              return 'Please enter email';
                                            }
                                            return null;
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 25,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Obx(() {
                                        return DropdownButton(
                                          hint: Text('kategori'),
                                          value: controller.katkat.value,
                                          items: controller.kategoriv2.value
                                              .map((item) {
                                            return DropdownMenuItem(
                                              child: Text(item),
                                              value: item,
                                            );
                                          }).toList(),
                                          onChanged: (val) {
                                            controller.katkat.value =
                                                val.toString();
                                          },
                                        );
                                      }),
                                    ),
                                  ],
                                ),
                              ],
                            )),
                      ),
                      Card(
                        margin: EdgeInsets.symmetric(vertical: 5),
                        child: Padding(
                            padding: EdgeInsets.all(20),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Container(
                                        child: TextFormField(
                                          controller:
                                              controller.harga_jual.value,
                                          onChanged: ((String pass) {}),
                                          decoration: InputDecoration(
                                            icon: Icon(Icons.attach_money),
                                            labelText: "harga jual",
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
                                              return 'Please enter email';
                                            }
                                            return null;
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 25,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Container(
                                        width: 300,
                                        child: TextFormField(
                                          controller: controller.satuan.value,
                                          onChanged: ((String pass) {}),
                                          decoration: InputDecoration(
                                            icon: Icon(Icons.list),
                                            labelText: "satuan",
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
                                              return 'Please enter email';
                                            }
                                            return null;
                                          },
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        width: 300,
                                        child: TextFormField(
                                          controller: controller.stock.value,
                                          onChanged: ((String pass) {}),
                                          decoration: InputDecoration(
                                            icon: Icon(Icons.list),
                                            labelText: "Stock",
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
                                              return 'Please enter email';
                                            }
                                            return null;
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            )),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      button_solid_custom(
                          onPressed: () {
                            controller.tambahbarang();
                          },
                          child: Text(
                            'tambah produk',
                            style: font().header,
                          ),
                          width: context.width_query,
                          height: 70)
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
