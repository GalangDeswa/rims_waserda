import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rims_waserda/Modules/Widgets/popup.dart';
import 'package:rims_waserda/Modules/Widgets/toast.dart';

import '../../Modules/Login/view_login_carousel.dart';
import '../../Templates/setting.dart';
import '../Widgets/buttons.dart';
import '../Widgets/loading.dart';
import 'controller_login.dart';

class login_card extends GetView<loginController> {
  const login_card({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: 200,
          margin: EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
              color: color_template().primary,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.white, width: 3)),
          padding: EdgeInsets.all(5),
          child: Center(
            child: Text(
              'RIMS WASERDA',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.white),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 100),
          height: context.height_query * 0.75,
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              //color: Colors.red,
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ], borderRadius: BorderRadius.circular(30), color: Colors.white),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 30),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          bottomLeft: Radius.circular(30))),

                  //width: context.width_query * 0.5,
                  //height: context.height_query / 1.5,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Produk RIMS',
                        style: font().primary_bold,
                      ),
                      login_carousel(),
                      // Obx(() {
                      //   return DotsIndicator(
                      //     dotsCount: controller.kontensquare.length,
                      //     position: controller.current.toDouble(),
                      //     decorator: DotsDecorator(
                      //       color: color_template().secondary, // Inactive color
                      //       activeColor: color_template().select,
                      //     ),
                      //   );
                      // }),
                    ],
                  ),
                ),
              ),
              Container(
                  margin:
                      EdgeInsets.symmetric(vertical: context.height_query / 15),
                  child: VerticalDivider(
                    color: color_template().primary,
                    thickness: 2.5,
                  )),
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 30),

                  margin: EdgeInsets.symmetric(horizontal: 30),
                  //width: context.width_query * 0.5,
                  //height: context.height_query / 5,
                  child: Form(
                    key: controller.loginKey(),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          'Login',
                          style: font().primary_bold,
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
                          validator: (value) {
                            if (value!.isEmpty || value.isEmail == false) {
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
                                  borderRadius: BorderRadius.circular(10)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                            //textAlign: TextAlign.center,
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
                              width: context.width_query * 0.5,
                              height: 50,
                              onPressed: () async {
                                if (controller.loginKey.value.currentState!
                                    .validate()) {
                                  Get.dialog(Obx(() {
                                    return Center(
                                      child: Stack(
                                        children: [
                                          Center(
                                            child: Container(
                                              width: 400,
                                              height: 400,
                                              child: showloading(),
                                            ),
                                          ),
                                          Center(
                                            child: Container(
                                              width: 250,
                                              height: 250,
                                              // color: Colors.red,
                                              child: CircularProgressIndicator(
                                                strokeWidth: 15.0,
                                                backgroundColor: Colors.white,
                                                color: color_template().primary,
                                                value: controller.points.value,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  }));

                                  try {
                                    await controller.loginv2();
                                  } catch (error) {
                                    print(
                                        'error login----------------------------------------------------------------');
                                    print(error);
                                    Get.back();
                                    Get.showSnackbar(toast()
                                        .bottom_snackbar_error('Error',
                                            'Terjadi kesalahan mohon coba lagi'));
                                  }
                                }

                                //Get.toNamed('/base_menu');

                                //Get.to(() => barcode());
                              },
                              child: Text(
                                'Login',
                                style: font().primary_white,
                              )),
                        ),
                        button_border_custom(
                          onPressed: () {
                            popscreen().lupapassword();
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Lupa password ?',
                                style: font().primary,
                              ),
                            ],
                          ),
                          height: 50,
                          width: context.width_query,
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.end,
                        //   children: [
                        //     button_solid_custom(
                        //         width: context.width_query * 0.1,
                        //         height: 35,
                        //         onPressed: () {
                        //           // if (controller
                        //           //     .loginKey.value.currentState!
                        //           //     .validate()) {
                        //           //   controller.login();
                        //           // }
                        //
                        //           Get.toNamed('/base_menu');
                        //
                        //           //Get.to(() => barcode());
                        //         },
                        //         child: Text(
                        //           'Register',
                        //           style: font().primary_white,
                        //         )),
                        //     SizedBox(
                        //       width: 15,
                        //     ),
                        //     button_border_custom(
                        //       onPressed: () {},
                        //       child: Text(
                        //         'Lupa Password?',
                        //         style: TextStyle(
                        //             color: color_template().primary,
                        //             fontSize: 13),
                        //       ),
                        //       height: 35,
                        //       width: context.width_query * 0.1,
                        //     ),
                        //   ],
                        // ),

                        // RichText(
                        //     text: TextSpan(
                        //         text: 'Lupa paswword? ',
                        //         style: TextStyle(color: Colors.black),
                        //         children: <TextSpan>[
                        //       TextSpan(
                        //           text: 'Reset password',
                        //           recognizer: TapGestureRecognizer()
                        //             ..onTap = () {
                        //               Get.toNamed('/reset_password');
                        //             },
                        //           style: TextStyle(color: Colors.blue))
                        //     ]))
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          decoration: BoxDecoration(
              color: color_template().primary,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.white, width: 1)),
          padding: EdgeInsets.all(5),
          margin: EdgeInsets.symmetric(vertical: 10),
          child: Text('Powered with ❤ by RIMS',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                  color: Colors.white)),
        ),
      ],
    );
  }
}
