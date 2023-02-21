import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../Controllers/Templates/setting.dart';
import '../../Controllers/login controller/login_controller.dart';
import '../Widgets/buttons.dart';
import 'login_carousel.dart';

class login_card extends GetView<loginController> {
  const login_card({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 200,
          margin: EdgeInsets.symmetric(vertical: 20),
          decoration: BoxDecoration(
              color: color_template().primary,
              borderRadius: BorderRadius.circular(5)),
          padding: EdgeInsets.all(5),
          child: Center(
            child: Text(
              'RIMSWASERDA',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  color: Colors.white),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 100),
          height: 400,
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ], borderRadius: BorderRadius.circular(30), color: Colors.white),
          child: Stack(
            children: [
              Positioned.fill(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    width: 400,
                    decoration: BoxDecoration(
                        color: color_template().primary,
                        borderRadius: BorderRadius.circular(30)),
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: 350,
                        child: Column(
                          children: [
                            Text(
                              'Promo RIMS',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: Colors.white),
                            ),
                            login_carousel(),
                            Obx(() {
                              return DotsIndicator(
                                dotsCount: controller.iklan.length,
                                position: controller.current.toDouble(),
                                decorator: DotsDecorator(
                                  color: Colors.black87, // Inactive color
                                  activeColor: color_template().select,
                                ),
                              );
                            }),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 15),
                        width: 350,
                        child: Form(
                          key: controller.loginKey(),
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(bottom: 20),
                                child: Text(
                                  'Login',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                              ),
                              SizedBox(
                                height: 10,
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
                                  border: UnderlineInputBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                ),
                                textAlign: TextAlign.center,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Masukan Email';
                                  }
                                  return null;
                                },
                              ),
                              Obx(() {
                                return TextFormField(
                                  obscureText: controller.showpass.value,
                                  controller: controller.pass.value,
                                  onChanged: ((String pass) {}),
                                  decoration: InputDecoration(
                                    suffixIcon: IconButton(
                                      icon: controller.showpass == false
                                          ? Icon(Icons.visibility_off)
                                          : Icon(Icons.visibility),
                                      onPressed: () {
                                        controller.showpass.value =
                                            !controller.showpass.value;
                                        print(controller.showpass.value);
                                      },
                                    ),
                                    icon: Icon(Icons.lock),
                                    labelText: "password",
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
                                      return 'Masukan Password';
                                    }
                                    return null;
                                  },
                                );
                              }),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 15),
                                child: button_solid_custom(
                                    width: 350,
                                    height: 35,
                                    onPressed: () {
                                      // if (controller
                                      //     .loginKey.value.currentState!
                                      //     .validate()) {
                                      //   controller.login();
                                      // }

                                      Get.toNamed('/base_menu');

                                      //Get.to(() => barcode());
                                    },
                                    child: Text(
                                      'Login',
                                      style: font().primary_white,
                                    )),
                              ),
                              button_border_custom(
                                  onPressed: () {},
                                  child: Text(
                                    'Login dengan google',
                                    style: font().primary,
                                  ),
                                  height: 35,
                                  width: 350),
                              SizedBox(
                                height: 15,
                              ),
                              RichText(
                                  text: TextSpan(
                                      text: 'Lupa paswword? ',
                                      style: TextStyle(color: Colors.black),
                                      children: <TextSpan>[
                                    TextSpan(
                                        text: 'Reset password',
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () {
                                            Get.toNamed('/reset_password');
                                          },
                                        style: TextStyle(color: Colors.blue))
                                  ]))
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: 20),
          child: Text('Powered with ❤ by RIMS',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: Colors.black)),
        ),
      ],
    );
  }
}
