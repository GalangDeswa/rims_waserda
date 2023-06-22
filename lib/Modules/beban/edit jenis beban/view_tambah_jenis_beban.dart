import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:rims_waserda/Modules/Widgets/card_custom.dart';
import 'package:rims_waserda/Modules/Widgets/stack%20bg.dart';

import '../../../Templates/setting.dart';
import '../../Widgets/buttons.dart';
import '../../Widgets/header.dart';
import '../data beban/controller_beban.dart';

class tambah_jenis_beban extends GetView<bebanController> {
  const tambah_jenis_beban({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      // minimum: EdgeInsets.all(5),
      child: Scaffold(
        // backgroundColor: Colors.transparent,
        // appBar: appbar_custom(
        //     height: 50,
        //     child: Text(
        //       'Tambah Produk',
        //       style: font().header,
        //     )),
        body: stack_bg(
          isfullscreen: true,
          child: Center(
            child: Container(
              width: context.width_query / 2,
              child: Card_custom(
                border: false,
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Container(
                    width: context.width_query / 1,
                    height: context.height_query / 2.3,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        header(
                          title: 'Tambah Kategori Beban',
                          icon: FontAwesomeIcons.dollarSign,
                          iscenter: false,
                        ),
                        Form(
                            key: controller.formKeyjenisbeban.value,
                            child: TextFormField(
                              controller: controller.kategori.value,
                              onChanged: ((String pass) {}),
                              decoration: InputDecoration(
                                labelText: "Katergori",
                                labelStyle: TextStyle(
                                  color: Colors.black87,
                                ),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10)),
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Masukan kategori beban';
                                }
                                return null;
                              },
                            )),
                        button_solid_custom(
                            onPressed: () {
                              if (controller
                                  .formKeyjenisbeban.value.currentState!
                                  .validate()) {
                                controller.bebanjenisTambahlocal();
                              }
                            },
                            child: Text(
                              'Tambah Kategori',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            width: double.infinity,
                            height: 50)
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
