import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:rims_waserda/Modules/Widgets/card_custom.dart';
import 'package:rims_waserda/Modules/user/data%20user/controller_data_user.dart';

import '../../../Templates/setting.dart';
import '../../Widgets/buttons.dart';
import '../../Widgets/header.dart';

class tambah_user_form extends GetView<datauserController> {
  const tambah_user_form({Key? key}) : super(key: key);

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
              title: 'Tambah User'.toUpperCase(),
              icon: FontAwesomeIcons.person,
              iscenter: false,
            ),
            SizedBox(
              height: 25,
            ),
            Obx(() {
              return Form(
                  key: controller.formKey.value,
                  child: IntrinsicHeight(
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
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
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
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
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
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
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
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
                          ),
                        ),
                        Container(
                            margin: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
                            child: VerticalDivider(
                              color: color_template().primary,
                              thickness: 1,
                            )),
                        Expanded(
                            child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.only(bottom: 10),
                              //  width: context.width_query / 3.3,
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
                                  labelText: "Password",
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
                                controller: controller.konfirmasipassword.value,
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
                                  labelText: "Konfirmasi password",
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
                            Obx(() {
                              return DropdownButtonFormField2(
                                isExpanded: true,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                ),
                                hint: Text('Role'),
                                validator: (value) {
                                  if (value == null) {
                                    return 'Pilih role user';
                                  }
                                  return null;
                                },
                                dropdownStyleData: DropdownStyleData(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.white)),
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
                          ],
                        )),
                      ],
                    ),
                  ));
            }),
            SizedBox(
              height: 25,
            ),
            button_solid_custom(
                onPressed: () {
                  if (controller.formKey.value.currentState!.validate()) {
                    controller.tambahuser();
                  }
                },
                child: Text(
                  'tambah user'.toUpperCase(),
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
