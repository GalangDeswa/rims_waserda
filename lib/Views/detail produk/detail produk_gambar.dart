import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:image_picker/image_picker.dart';

import '../../Controllers/Templates/setting.dart';

import '../../Controllers/detail produk controller/detail_produk_controller.dart';
import '../Widgets/buttons.dart';

class detail_produk_gambar extends GetView<detail_produkController> {
  const detail_produk_gambar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            width: 300,
            height: 300,
            decoration: BoxDecoration(
                color: color_template().primary,
                borderRadius: BorderRadius.circular(10)),
            child: Icon(
              Icons.image,
              color: Colors.white,
              size: 50,
            )),
        SizedBox(
          height: 10,
        ),
        Container(
          width: 300,
          //  color: Colors.blue,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //Icon(Icons.category),
              Container(
                child: DropdownButton(
                  hint: Text('Pilih variasi'),
                  value: controller.val_ongkir,
                  items: controller.ongkir.map((item) {
                    return DropdownMenuItem(
                      child: Text(item),
                      value: item,
                    );
                  }).toList(),
                  onChanged: (val) {
                    print('lol');
                  },
                ),
              ),
              icon_button_custom(
                onPressed: () {
                  controller.getimagev2(ImageSource.camera);
                },
                icon: Icons.add_a_photo,
                icon_color: color_template().primary,
                container_color: Colors.white,
                border_color: Colors.white,
              ),
            ],
          ),
        ),
        Expanded(
          child: Container(
              width: 300,
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              decoration: BoxDecoration(
                  color: color_template().primary,
                  borderRadius: BorderRadius.circular(10)),
              child: Icon(
                Icons.qr_code,
                color: Colors.white,
                size: 50,
              )),
        ),
      ],
    );
  }
}
