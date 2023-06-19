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
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Card_custom(
          border: false,
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                header(
                  title: 'Edit User',
                  icon: FontAwesomeIcons.person,
                ),
                SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Obx(() {
                      return Form(
                          key: controller.formKeyedituser.value,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              TextFormField(
                                //initialValue: controller.data.nama,
                                controller: controller.nama.value,
                                onChanged: ((String pass) {}),
                                decoration: InputDecoration(
                                  icon: Icon(Icons.add_card),
                                  labelText: 'Nama',
                                  labelStyle: TextStyle(
                                    color: Colors.black87,
                                  ),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                ),
                                textAlign: TextAlign.center,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Masukan nama user';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              TextFormField(
                                controller: controller.email.value,
                                onChanged: ((String pass) {}),
                                decoration: InputDecoration(
                                  icon: Icon(Icons.person),
                                  labelText: "Email",
                                  labelStyle: TextStyle(
                                    color: Colors.black87,
                                  ),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                ),
                                textAlign: TextAlign.center,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Masukan email user';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              TextFormField(
                                controller: controller.hp.value,
                                onChanged: ((String pass) {}),
                                decoration: InputDecoration(
                                  icon: Icon(Icons.pin_drop),
                                  labelText: "Nomor HP",
                                  labelStyle: TextStyle(
                                    color: Colors.black87,
                                  ),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                ),
                                textAlign: TextAlign.center,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Masukan nomor hp user';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              button_solid_custom(
                                  onPressed: () {
                                    print('edit user-----------------------');
                                    if (controller
                                        .formKeyedituser.value.currentState!
                                        .validate()) {
                                      controller.edituser();
                                    }
                                  },
                                  child: Text(
                                    'Edit User',
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
    );
  }
}
