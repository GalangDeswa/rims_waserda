import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Templates/setting.dart';
import '../../Widgets/buttons.dart';
import 'controller_detail_produk.dart';

class detail_produk_list extends GetView<detail_produkController> {
  const detail_produk_list({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        height: context.height_query,

        margin: EdgeInsets.all(10), //color: Colors.cyan,
        child: Obx(() {
          return Form(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextFormField(
                  controller: controller.nama_produk.value,
                  onChanged: ((String pass) {}),
                  decoration: InputDecoration(
                    labelText: "nama produk",
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
                TextFormField(
                  controller: controller.harga.value,
                  onChanged: ((String pass) {}),
                  decoration: InputDecoration(
                    labelText: "Harga",
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
                TextFormField(
                  controller: controller.desc.value,
                  onChanged: ((String pass) {}),
                  decoration: InputDecoration(
                    labelText: "Deskripsi",
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Container(
                        child: TextFormField(
                          controller: controller.qtyv2.value,
                          onChanged: ((String pass) {}),
                          decoration: InputDecoration(
                            labelText: "Stok",
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
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(5),
                      margin: EdgeInsets.only(left: 20),
                      decoration:
                          BoxDecoration(color: color_template().primary),
                      child: IconButton(
                        onPressed: () {
                          controller.addqty(context, controller);
                        },
                        icon: Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                ),
                button_solid_custom(
                    onPressed: () {
                      controller.editqty();
                    },
                    child: Text(
                      'Edit Produk',
                      style: font().header,
                    ),
                    width: context.width_query,
                    height: 60),
                button_border_custom(
                    onPressed: () {
                      //controller.uploadimage();
                      Get.offAndToNamed('/produk');
                    },
                    child: Text(
                      'Kembali',
                      style: font().header_blue,
                    ),
                    width: context.width_query,
                    height: 60),
              ],
            ),
          );
        }),
      ),
    );
  }
}
