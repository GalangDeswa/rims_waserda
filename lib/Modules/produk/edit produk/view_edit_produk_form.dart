import 'package:cached_network_image/cached_network_image.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
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
          height: context.height_query / 1,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              header(
                title: 'Edit Produk',
                icon: FontAwesomeIcons.boxOpen,
                iscenter: false,
              ),
              SizedBox(
                height: 30,
              ),
              Expanded(
                child: Form(
                    key: controller.formKeyprodukedit.value,
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Obx(() {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                controller.pikedImagePath.value == ''
                                    ? Container(
                                        margin: EdgeInsets.only(right: 20),
                                        padding: EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
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
                                        height: 200,
                                        margin: EdgeInsets.only(right: 20),
                                        child: CachedNetworkImage(
                                          imageUrl:
                                              controller.pikedImagePath.value,
                                        ),
                                      ),
                                Container(
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

                                      controller.pickImage();
                                    },
                                    icon: Icon(
                                      Icons.add,
                                      color: Colors.white,
                                    ),
                                  ),
                                )
                              ],
                            );
                          }),
                          SizedBox(
                            height: 15,
                          ),
                          TextFormField(
                            controller: controller.nama_produk.value,
                            onChanged: ((String pass) {}),
                            decoration: InputDecoration(
                              icon: Icon(Icons.add_card),
                              labelText: "Nama produk",
                              labelStyle: TextStyle(
                                color: Colors.black87,
                              ),
                              border: OutlineInputBorder(
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
                          SizedBox(
                            height: 15,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                  child: Obx(() {
                                    return DropdownButtonFormField2(
                                      decoration: InputDecoration(
                                        icon: Icon(FontAwesomeIcons.boxOpen),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                      ),
                                      validator: (value) {
                                        if (value!.isEmpty) {
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
                                      hint: Text('Pilih jenis produk'),
                                      value: controller.jenisvalue.value,
                                      items: controller.jenislist.value
                                          .map((DataJenis item) {
                                        return DropdownMenuItem(
                                          child:
                                              Text(item.namaJenis.toString()),
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
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          TextFormField(
                            controller: controller.desc.value,
                            onChanged: ((String pass) {}),
                            decoration: InputDecoration(
                              icon: Icon(Icons.person),
                              labelText: "deskripsi",
                              labelStyle: TextStyle(
                                color: Colors.black87,
                              ),
                              border: OutlineInputBorder(
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
                          SizedBox(
                            height: 15,
                          ),
                          TextFormField(
                            controller: controller.qty.value,
                            onChanged: ((String pass) {}),
                            decoration: InputDecoration(
                              icon: Icon(Icons.pin_drop),
                              labelText: "Stock",
                              labelStyle: TextStyle(
                                color: Colors.black87,
                              ),
                              border: OutlineInputBorder(
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
                          SizedBox(
                            height: 15,
                          ),
                          TextFormField(
                            controller: controller.harga.value,
                            onChanged: ((String pass) {}),
                            decoration: InputDecoration(
                              icon: Icon(Icons.pin_drop),
                              labelText: "harga",
                              labelStyle: TextStyle(
                                color: Colors.black87,
                              ),
                              border: OutlineInputBorder(
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
                          SizedBox(
                            height: 15,
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          button_solid_custom(
                              onPressed: () {
                                controller.ProdukEdit();
                              },
                              child: Text(
                                'tambah produk',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              width: double.infinity,
                              height: 50)
                        ],
                      ),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
