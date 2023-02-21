import 'package:flutter/material.dart';
import 'package:get/get.dart';


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
          SizedBox(
            height: 10,
          ),
          button_solid_custom(
              onPressed: () {
                controller.uploadimage();
              },
              child: Text(
                'Tambah stock',
                style: font().header,
              ),
              width: 300,
              height: 40),
          SizedBox(
            height: 10,
          ),
          button_border_custom(
              onPressed: () {
                controller.uploadimage();
              },
              child: Text(
                'Edit produk',
                style: font().header_blue,
              ),
              width: 300,
              height: 40),
        ],
      ),
    );
  }
}
