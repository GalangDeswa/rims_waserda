import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../Templates/setting.dart';
import '../../Widgets/buttons.dart';
import '../jenis produk/model_jenisproduk.dart';
import 'controller_detail_produk.dart';

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
              Expanded(
                child: Container(
                  child: Obx(() {
                    return DropdownButton2(
                      isExpanded: true,
                      hint: Text('Pilih jenis produk'),
                      value: controller.jenisvalue.value,
                      items: controller.jenislist.value.map((DataJenis item) {
                        return DropdownMenuItem(
                          child: Text(item.namaJenis.toString()),
                          value: item.id.toString(),
                        );
                      }).toList(),
                      onChanged: (val) {
                        controller.jenisvalue.value = val!.toString();
                        print(controller.jenisvalue);
                        controller.update();
                      },
                    );
                  }),
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
