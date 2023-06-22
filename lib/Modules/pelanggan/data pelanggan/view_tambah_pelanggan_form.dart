import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:rims_waserda/Modules/Widgets/card_custom.dart';
import 'package:rims_waserda/Modules/pelanggan/data%20pelanggan/controller_data_pelanggan.dart';

import '../../../Templates/setting.dart';
import '../../Widgets/buttons.dart';
import '../../Widgets/header.dart';

class tambah_pelanggan_form extends GetView<pelangganController> {
  const tambah_pelanggan_form({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card_custom(
      border: false,
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Container(
          width: context.width_query / 1,
          //height: context.height_query / 1.3,
          child: Form(
              key: controller.formKeypelanggan.value,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  header(
                    title: 'Tambah Pelanggan'.toUpperCase(),
                    icon: FontAwesomeIcons.person,
                    iscenter: false,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    controller: controller.nama_pelanggan.value,
                    onChanged: ((String pass) {}),
                    decoration: InputDecoration(
                      labelText: "Nama pelanggan",
                      labelStyle: TextStyle(
                        color: Colors.black87,
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    textAlign: TextAlign.start,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Masukan nama pelanggan';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    controller: controller.no_hp.value,
                    onChanged: ((String pass) {}),
                    decoration: InputDecoration(
                      labelText: "Nomor HP",
                      labelStyle: TextStyle(
                        color: Colors.black87,
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    textAlign: TextAlign.start,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Masukan nomor hp';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  button_solid_custom(
                      onPressed: () {
                        if (controller.formKeypelanggan.value.currentState!
                            .validate()) {
                          controller.tambahPelangganlocal();
                        }
                      },
                      child: Text(
                        'Tambah pelanggan'.toUpperCase(),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      width: double.infinity,
                      height: 65)
                ],
              )),
        ),
      ),
    );
  }
}
