import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:rims_waserda/Modules/Widgets/card_custom.dart';
import 'package:rims_waserda/Modules/user/edit%20user/controller_edit_user.dart';

import '../../Widgets/buttons.dart';
import '../../Widgets/header.dart';

class edit_user_form extends GetView<edituserController> {
  const edit_user_form({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card_custom(
      border: false,
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            header(
              title: 'edit User'.toUpperCase(),
              icon: FontAwesomeIcons.person,
              iscenter: false,
            ),
            SizedBox(
              height: 25,
            ),
            Obx(() {
              return Form(
                  key: controller.formKeyedituser.value,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        margin: EdgeInsets.only(bottom: 10),
                        // width: context.width_query / 2.2,
                        // height: 100,
                        child: TextFormField(
                          controller: controller.nama.value,
                          onChanged: ((String pass) {}),
                          decoration: InputDecoration(
                            labelText: "Nama user",
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
                              return 'Masukan nama user';
                            }
                            return null;
                          },
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 10),
                        //  width: context.width_query / 3.3,
                        child: TextFormField(
                          controller: controller.email.value,
                          onChanged: ((String pass) {}),
                          decoration: InputDecoration(
                            labelText: "Email",
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
                              return 'Masukan email';
                            }
                            return null;
                          },
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 10),
                        //  width: context.width_query / 3.3,
                        child: TextFormField(
                          controller: controller.hp.value,
                          onChanged: ((String pass) {}),
                          decoration: InputDecoration(
                            labelText: "No.HP",
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
                              return 'Masukan nomor HP';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ));
            }),
            SizedBox(
              height: 25,
            ),
            button_solid_custom(
                onPressed: () {
                  if (controller.formKeyedituser.value.currentState!
                      .validate()) {
                    controller.edituser();
                  }
                },
                child: Text(
                  'edit user'.toUpperCase(),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                width: double.infinity,
                height: 60)
          ],
        ),
      ),
    );
  }
}
