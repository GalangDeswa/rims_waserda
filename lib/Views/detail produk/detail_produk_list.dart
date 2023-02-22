import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rims_waserda/Views/Widgets/popup.dart';


import '../../Controllers/Templates/setting.dart';
import '../../Controllers/detail produk controller/detail_produk_controller.dart';
import '../Widgets/buttons.dart';

class detail_produk_list extends GetView<detail_produkController> {
  const detail_produk_list({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      //color: Colors.cyan,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            margin: EdgeInsets.symmetric(vertical: 5),
            width: 300,
            child: TextFormField(
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
          ),
          Container(
            width: 300,
            margin: EdgeInsets.symmetric(vertical: 5),
            child: TextFormField(
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
          ),
          Container(
            width: 300,
            margin: EdgeInsets.symmetric(vertical: 5),
            child: TextFormField(
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
          ),
          Container(
            width: 300,
            margin: EdgeInsets.symmetric(vertical: 5),
            child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 230,
                  child: TextFormField(
                    controller: controller.barang_nama.value,
                    onChanged: ((String pass) {}),
                    decoration: InputDecoration(
                      labelText: "Stok",
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
                ),
                Container(
                  child: icon_button_custom(
                    onPressed: () {
                      //controller.getimagev2(ImageSource.camera);
                      popscreen().popstock(context,controller);
                    },
                    icon: Icons.add,
                    icon_color: Colors.white,
                    container_color: color_template().primary,
                    border_color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          button_solid_custom(
              onPressed: () {
               // controller.uploadimage();
              },
              child: Text(
                'Edit Produk',
                style: font().header,
              ),
              width: 300,
              height: 40),
          SizedBox(
            height: 10,
          ),
          button_border_custom(
              onPressed: () {
                //controller.uploadimage();
                Get.offAndToNamed('/produk');
              },
              child: Text(
                'Kembali',
                style: font().header_blue,
              ),
              width: 300,
              height: 40),
        ],
      ),
    );
  }
}
