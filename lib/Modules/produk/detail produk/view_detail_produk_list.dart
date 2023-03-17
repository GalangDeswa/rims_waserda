import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Templates/setting.dart';
import '../../Widgets/buttons.dart';
import '../../Widgets/popup.dart';
import 'controller_detail_produk.dart';

class detail_produk_list extends GetView<detail_produkController> {
  const detail_produk_list({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      //color: Colors.cyan,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextFormField(
            controller: controller.barang_nama.value,
            onChanged: ((String pass) {}),
            decoration: InputDecoration(
              labelText: "nama produk",
              labelStyle: TextStyle(
                color: Colors.black87,
              ),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              focusedBorder:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
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
            controller: controller.barang_nama.value,
            onChanged: ((String pass) {}),
            decoration: InputDecoration(
              labelText: "Harga",
              labelStyle: TextStyle(
                color: Colors.black87,
              ),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              focusedBorder:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
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
            controller: controller.barang_nama.value,
            onChanged: ((String pass) {}),
            decoration: InputDecoration(
              labelText: "Tipe produk",
              labelStyle: TextStyle(
                color: Colors.black87,
              ),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              focusedBorder:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
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
                  margin: EdgeInsets.only(right: 20),
                  child: TextFormField(
                    controller: controller.barang_nama.value,
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
                child: icon_button_custom(
                  onPressed: () {
                    //controller.getimagev2(ImageSource.camera);
                    popscreen().popstock(context, controller);
                  },
                  icon: Icons.add,
                  icon_color: Colors.white,
                  container_color: color_template().primary,
                  border_color: Colors.white,
                ),
              ),
            ],
          ),
          button_solid_custom(
              onPressed: () {
                // controller.uploadimage();
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
  }
}
