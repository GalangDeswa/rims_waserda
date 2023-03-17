import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:rims_waserda/Templates/setting.dart';

import '../Widgets/buttons.dart';
import 'controller_reset_password.dart';

class reset_password extends GetView<reset_passwordController> {
  const reset_password({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Reset password'),
        ),
        body: Center(
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/bg_login.png'),
                        colorFilter: new ColorFilter.mode(
                            Colors.blue.withOpacity(0.3), BlendMode.dstATop),
                        fit: BoxFit.cover)),
              ),
              reset()
            ],
          ),
        ),
      ),
    );
  }
}

class reset extends StatelessWidget {
  const reset({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final email = TextEditingController();
    return SingleChildScrollView(
      child: Center(
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 100),
          width: context.width_query * 0.5,
          height: context.height_query * 0.5,
          child: Card(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      child: Text(
                        'Reset password',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      )),
                  Text(
                    'Masukan alamat email yang terdaftar',
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 15),
                          child: Form(
                            key: formKey,
                            child: Column(
                              children: [
                                TextFormField(
                                  controller: email,
                                  onChanged: ((String pass) {}),
                                  decoration: InputDecoration(
                                    labelText: "Email",
                                    labelStyle: TextStyle(
                                      color: Colors.black87,
                                    ),
                                    border: UnderlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                  ),
                                  textAlign: TextAlign.center,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Masukan email';
                                    }
                                    return null;
                                  },
                                ),
                                Container(
                                    margin: EdgeInsets.only(top: 20),
                                    child: button_solid_custom(
                                      child: Text('Kirim kode verivikasi'),
                                      height: 30,
                                      width: 500,
                                      onPressed: () {
                                        Get.toNamed('/verification');
                                      },
                                    )),
                                SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              color: Colors.white),
        ),
      ),
    );
  }
}
