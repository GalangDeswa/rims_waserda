import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:rims_waserda/Modules/Widgets/card_custom.dart';
import 'package:rims_waserda/Modules/pelanggan/edit%20pelanggan/controller_edit_pelanggan.dart';

import '../../../Templates/setting.dart';
import '../../Widgets/buttons.dart';
import '../../Widgets/header.dart';

class edit_pelanggan_form extends GetView<editpelangganController> {
  const edit_pelanggan_form({Key? key}) : super(key: key);

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
                    title: 'edit Pelanggan'.toUpperCase(),
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
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                      labelText: "Nama pelanggan",
                      labelStyle: font().reguler,
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
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                      labelText: "Nomor HP",
                      labelStyle: font().reguler,
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
                          controller.editpelangganlocal();
                        }
                      },
                      child: Text(
                        'edit pelanggan'.toUpperCase(),
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white),
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
