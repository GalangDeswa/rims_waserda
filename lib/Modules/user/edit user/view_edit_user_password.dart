import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:rims_waserda/Modules/Widgets/card_custom.dart';
import 'package:rims_waserda/Modules/Widgets/stack%20bg.dart';
import 'package:rims_waserda/Modules/user/edit%20user/controller_edit_user.dart';

import '../../Widgets/buttons.dart';
import '../../Widgets/header.dart';

class edit_user_password extends GetView<edituserController> {
  const edit_user_password({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //backgroundColor: color_template().primary.withOpacity(0.2),
        body: stack_bg(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Card_custom(
            border: false,
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                children: [
                  header(
                    title: 'Edit Password',
                    icon: FontAwesomeIcons.person,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Obx(() {
                        return Form(
                            key: controller.formKey.value,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                TextFormField(
                                  //initialValue: controller.data.nama,
                                  controller: controller.password.value,
                                  onChanged: ((String pass) {}),
                                  decoration: InputDecoration(
                                    icon: Icon(Icons.add_card),
                                    labelText: 'Password',
                                    labelStyle: TextStyle(
                                      color: Colors.black87,
                                    ),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                  ),
                                  textAlign: TextAlign.center,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please enter email';
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                TextFormField(
                                  controller: controller.confirmpassword.value,
                                  onChanged: ((String pass) {}),
                                  decoration: InputDecoration(
                                    icon: Icon(Icons.person),
                                    labelText: "Konfirmasi password",
                                    labelStyle: TextStyle(
                                      color: Colors.black87,
                                    ),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                  ),
                                  textAlign: TextAlign.center,
                                  validator: (value) {
                                    if (value !=
                                        controller.password.value.text) {
                                      return 'PAssword tidak sesuai';
                                    }
                                    return null;
                                  },
                                ),
                                button_solid_custom(
                                    onPressed: () {
                                      if (controller.formKey.value.currentState!
                                          .validate()) {
                                        controller.edituserpassword();
                                      }
                                      // controller.tambahuser();
                                    },
                                    child: Text(
                                      'Edit Password',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    width: double.infinity,
                                    height: 50)
                              ],
                            ));
                      }),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    ));
  }
}
