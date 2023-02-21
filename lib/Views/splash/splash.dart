import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';


import '../../Controllers/Templates/setting.dart';
import '../../Controllers/splash controller/splash_controller.dart';

class splash extends GetView<splashController> {
  const splash({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(children: [
        Positioned(
            child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/bg_login.png'),
                  colorFilter: ColorFilter.mode(
                      Colors.white.withOpacity(0.5), BlendMode.dstATop),
                  fit: BoxFit.cover)),
        )),
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  width: 450,
                  height: 450,
                  child: Lottie.asset('assets/animation/chasier.json'),
                ),
              ),
              Text(
                'RIMSWASERDA',
                style: TextStyle(
                    fontSize: 25,
                    color: color_template().primary_dark,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 25,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: CircularProgressIndicator(),
              )
            ],
          ),
        ),
      ]),
    );
  }
}
