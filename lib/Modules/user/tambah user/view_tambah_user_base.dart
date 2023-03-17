import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../../Templates/setting.dart';
import '../../Widgets/buttons.dart';
import '../../Widgets/header.dart';
import '../../Widgets/stack bg.dart';
import 'controller_tambah_user.dart';

class tambah_user extends GetView<tambah_userController> {
  const tambah_user({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();

    final email = TextEditingController();
    return SafeArea(
      //minimum: EdgeInsets.all(10),
      child: Scaffold(
          backgroundColor: color_template().primary.withOpacity(0.2),
          // appBar: appbar_custom(
          //     height: 50,
          //     child: Text(
          //       'Tambah user',
          //       style: font().header,
          //     )),
          body: stack_bg(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(30),
                child: Card(
                  elevation: elevation().def_elevation,
                  //margin: EdgeInsets.all(30),
                  shape: RoundedRectangleBorder(
                    borderRadius: border_radius().def_border,
                    side:
                        BorderSide(color: color_template().primary, width: 3.5),
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
                          child: Form(
                              key: formKey,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  TextFormField(
                                    controller: controller.nomor_iden.value,
                                    onChanged: ((String pass) {}),
                                    decoration: InputDecoration(
                                      icon: Icon(Icons.add_card),
                                      labelText: "Nomor identitas",
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
                                    controller: controller.nama.value,
                                    onChanged: ((String pass) {}),
                                    decoration: InputDecoration(
                                      icon: Icon(Icons.person),
                                      labelText: "Nama penlanggan",
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
                                    controller: controller.alamat.value,
                                    onChanged: ((String pass) {}),
                                    decoration: InputDecoration(
                                      icon: Icon(Icons.pin_drop),
                                      labelText: "Alamat pelanggan",
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
                                    controller: controller.hp.value,
                                    onChanged: ((String pass) {}),
                                    decoration: InputDecoration(
                                      icon: Icon(Icons.phone),
                                      labelText: "No HP",
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
                                    controller: controller.email.value,
                                    onChanged: ((String pass) {}),
                                    decoration: InputDecoration(
                                      icon: Icon(Icons.email),
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
                                    textAlign: TextAlign.center,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Please enter email';
                                      }
                                      return null;
                                    },
                                  ),
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
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          )),
    );
  }
}
