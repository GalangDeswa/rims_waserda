import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:rims_waserda/Modules/Widgets/card_custom.dart';
import 'package:rims_waserda/Modules/produk/data%20produk/controller_data_produk.dart';

import '../../../Templates/setting.dart';
import '../../Widgets/buttons.dart';
import '../../Widgets/header.dart';
import '../../Widgets/stack bg.dart';

class tambah_jenis extends GetView<produkController> {
  const tambah_jenis({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      // minimum: EdgeInsets.all(5),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: color_template().base_blue,
        // appBar: appbar_custom(
        //     height: 50,
        //     child: Text(
        //       'Tambah Produk',
        //       style: font().header,
        //     )),
        body: stack_bg(
          isfullscreen: true,
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
                        title: 'Tambah Kategori Produk',
                        icon: FontAwesomeIcons.boxOpen,
                        iscenter: false,
                      ),
                      Form(
                          key: controller.formKeyjenis.value,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              TextFormField(
                                controller: controller.nama_jenis.value,
                                onChanged: ((String pass) {}),
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 0, horizontal: 10),
                                  labelText: "Nama Kategori",
                                  labelStyle: font().reguler,
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Masukan kategori produk';
                                  }
                                  return null;
                                },
                              ),
                            ],
                          )),
                      button_solid_custom(
                          onPressed: () {
                            if (controller.formKeyjenis.value.currentState!
                                .validate()) {
                              controller.jenisTambahlocal();
                            }
                          },
                          child: Text('Tambah Kategori', style: font().header),
                          width: double.infinity,
                          height: 50),
                    ],
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
