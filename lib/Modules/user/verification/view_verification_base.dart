import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:lottie/lottie.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import 'controller_verification.dart';

class verification extends GetView<verificationController> {
  const verification({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final verifikasi_kode = TextEditingController();
    return Scaffold(
      appBar: AppBar(),
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
            Center(
              child: SingleChildScrollView(
                  child: Card(
                color: Colors.white,
                child: Padding(
                  padding: EdgeInsets.all(30),
                  child: Column(
                    children: [
                      Text('Masukan kode verifikasi'),
                      Container(
                        height: 200,
                        child: Lottie.asset('assets/animation/verifikasi.json',
                            animate: true, fit: BoxFit.cover, repeat: false),
                      ),
                      Padding(
                          padding: EdgeInsets.only(bottom: 20),
                          child: Text(
                              'Kode verifikasi telah di kirim ke nomor +62 123456')),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 15),
                        width: 350,
                        child: Form(
                          key: formKey,
                          child: Column(
                            children: [
                              PinCodeTextField(
                                length: 6,
                                obscureText: false,
                                animationType: AnimationType.fade,
                                pinTheme: PinTheme(
                                    shape: PinCodeFieldShape.box,
                                    borderRadius: BorderRadius.circular(5),
                                    fieldHeight: 50,
                                    fieldWidth: 40,
                                    activeFillColor: Colors.white,
                                    inactiveColor: Colors.blue),
                                animationDuration: Duration(milliseconds: 300),
                                //backgroundColor: Colors.blue.shade50,
                                controller: verifikasi_kode,
                                onCompleted: (v) {
                                  print("Completed");
                                },
                                onChanged: (value) {
                                  print(value);
                                },
                                beforeTextPaste: (text) {
                                  print("Allowing to paste $text");
                                  //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                                  //but you can show anything you want here, like your pop up saying wrong paste format or etc
                                  return true;
                                },
                                appContext: context,
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 10),
                                width: 350,
                                child: ElevatedButton(
                                    onPressed: () {
                                      if (formKey.currentState!.validate()) {
                                        print('login');
                                        Get.toNamed('/base_menu');
                                      }
                                    },
                                    child: Text('Verivikasi email')),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              RichText(
                                  text: TextSpan(
                                      text: 'Kode tidak terkirim? ',
                                      style: TextStyle(color: Colors.black),
                                      children: <TextSpan>[
                                    TextSpan(
                                        text: ' kirim ulang',
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () {
                                            Get.toNamed('/login');
                                          },
                                        style: TextStyle(color: Colors.blue))
                                  ]))
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )),
            ),
          ],
        ),
      ),
    );
  }
}
