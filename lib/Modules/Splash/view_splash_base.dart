import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rims_waserda/Modules/Splash/controller_splash.dart';

import '../../Templates/setting.dart';

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
                  height: 350,
                  child: Image.asset('assets/icons/logo.png'),
                ),
              ),
              Text(
                'RIMS WASERDA',
                style: TextStyle(
                    fontSize: 25,
                    color: color_template().primary_dark,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: CircularProgressIndicator(),
              ),
              SizedBox(
                height: 50,
              ),
              Text(
                'Powered by',
                style: font().header_blue,
              ),
              Container(
                width: 150,
                height: 50,
                child: Image.asset('assets/images/powered.png'),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
