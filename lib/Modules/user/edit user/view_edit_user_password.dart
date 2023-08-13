import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:rims_waserda/Modules/Widgets/card_custom.dart';
import 'package:rims_waserda/Modules/Widgets/stack%20bg.dart';
import 'package:rims_waserda/Modules/user/edit%20user/controller_edit_user.dart';

import '../../../Templates/setting.dart';
import '../../Widgets/buttons.dart';
import '../../Widgets/header.dart';

class edit_user_password extends GetView<edituserController> {
  const edit_user_password({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: color_template().base_blue,
        body: stack_bg(
          isfullscreen: true,
          child: SingleChildScrollView(
              child: Card_custom(
            border: false,
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  header(
                    title: 'edit password'.toUpperCase(),
                    icon: FontAwesomeIcons.lock,
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
                                obscureText: controller.show.value,
                                controller: controller.passwordlama.value,
                                onChanged: ((String pass) {}),
                                decoration: InputDecoration(
                                  suffixIcon: IconButton(
                                    icon: controller.show == false
                                        ? Icon(Icons.visibility_off)
                                        : Icon(Icons.visibility),
                                    onPressed: () {
                                      controller.show.value =
                                          !controller.show.value;
                                      print(controller.show.value);
                                    },
                                  ),
                                  labelText: "Password lama",
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
                                    return 'Masukan password';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(bottom: 10),
                              // width: context.width_query / 2.2,
                              // height: 100,
                              child: TextFormField(
                                obscureText: controller.show.value,
                                controller: controller.password.value,
                                onChanged: ((String pass) {}),
                                decoration: InputDecoration(
                                  suffixIcon: IconButton(
                                    icon: controller.show == false
                                        ? Icon(Icons.visibility_off)
                                        : Icon(Icons.visibility),
                                    onPressed: () {
                                      controller.show.value =
                                          !controller.show.value;
                                      print(controller.show.value);
                                    },
                                  ),
                                  labelText: "Password baru",
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
                                    return 'Masukan password';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(bottom: 10),
                              //  width: context.width_query / 3.3,
                              child: TextFormField(
                                obscureText: controller.showkon.value,
                                controller: controller.confirmpassword.value,
                                onChanged: ((String pass) {}),
                                decoration: InputDecoration(
                                  suffixIcon: IconButton(
                                    icon: controller.showkon == false
                                        ? Icon(Icons.visibility_off)
                                        : Icon(Icons.visibility),
                                    onPressed: () {
                                      controller.showkon.value =
                                          !controller.showkon.value;
                                      print(controller.showkon.value);
                                    },
                                  ),
                                  labelText: "konfirmasi password baru",
                                  labelStyle: TextStyle(
                                    color: Colors.black87,
                                  ),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                ),
                                validator: (value) {
                                  if (value!.isEmpty ||
                                      value != controller.password.value.text) {
                                    return 'Password tidak sesuai';
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
                          controller.edituserpassword();
                        }
                      },
                      child: Text(
                        'edit password'.toUpperCase(),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      width: double.infinity,
                      height: 60)
                ],
              ),
            ),
          )),
        ));
  }
}
