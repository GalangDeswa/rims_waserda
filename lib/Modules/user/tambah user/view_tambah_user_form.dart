import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:rims_waserda/Modules/user/tambah%20user/controller_tambah_user.dart';

import '../../../Templates/setting.dart';
import '../../Widgets/buttons.dart';
import '../../Widgets/header.dart';
import '../../Widgets/stack bg.dart';

class tambah_user_form extends GetView<tambah_userController> {
  const tambah_user_form({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return stack_bg(
        child: Center(
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Card(
          elevation: elevation().def_elevation,
          //margin: EdgeInsets.all(30),
          shape: RoundedRectangleBorder(
            borderRadius: border_radius().def_border,
            side: BorderSide(color: color_template().primary, width: 3.5),
          ),

          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                header(
                  title: 'Tambah User',
                  icon: FontAwesomeIcons.person,
                ),
                SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Form(
                        key: controller.formKey.value,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            TextFormField(
                              controller: controller.nama.value,
                              onChanged: ((String pass) {}),
                              decoration: InputDecoration(
                                icon: Icon(Icons.add_card),
                                labelText: "Nama",
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
                                  return 'Please enter email';
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
                                  return 'Please enter email';
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
                                  return 'Please enter email';
                                }
                                return null;
                              },
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            TextFormField(
                              controller: controller.password.value,
                              onChanged: ((String pass) {}),
                              decoration: InputDecoration(
                                icon: Icon(Icons.pin_drop),
                                labelText: "password",
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
                                  return 'Please enter email';
                                }
                                return null;
                              },
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Obx(() {
                              return DropdownButton2(
                                isExpanded: true,
                                hint: Text('Role'),
                                value: controller.roleval.value == null
                                    ? null
                                    : controller.role[controller.roleval.value],
                                items: controller.role.map((item) {
                                  return DropdownMenuItem(
                                    child: Text(item),
                                    value: item,
                                  );
                                }).toList(),
                                onChanged: (val) {
                                  controller.roleval.value =
                                      controller.role.indexOf(val);
                                  print(controller.roleval.value);
                                },
                              );
                            }),
                            SizedBox(
                              height: 30,
                            ),
                            button_solid_custom(
                                onPressed: () {
                                  controller.tambahuser();
                                },
                                child: Text(
                                  'tambah user',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                width: double.infinity,
                                height: 50)
                          ],
                        )),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
