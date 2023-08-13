import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:rims_waserda/Modules/Splash/controller_splash.dart';
import 'package:rims_waserda/Templates/setting.dart';

class intro extends GetView<splashController> {
  const intro({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: IntroSlider(
          onDonePress: () {
            Get.offAndToNamed('/login');
          },
          indicatorConfig: IndicatorConfig(
              colorActiveIndicator: color_template().select,
              colorIndicator: Colors.white),
          nextButtonStyle: ButtonStyle(
              backgroundColor: MaterialStatePropertyAll<Color>(Colors.white)),
          prevButtonStyle: ButtonStyle(
              backgroundColor: MaterialStatePropertyAll<Color>(Colors.white)),
          doneButtonStyle: ButtonStyle(
              backgroundColor: MaterialStatePropertyAll<Color>(Colors.white)),
          skipButtonStyle: ButtonStyle(
              backgroundColor: MaterialStatePropertyAll<Color>(Colors.white)),
          listContentConfig: [
            ContentConfig(
              title: "RIMS WASERDA",
              styleTitle: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
              pathImage: "assets/images/intro1.png",
              description: "Aplikasi P.O.S lengkap untuk UMKM",
              styleDescription: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
              backgroundImage: "assets/images/bg_login.png",
              backgroundColor: color_template().primary,
            ),
            ContentConfig(
              styleTitle: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
              styleDescription: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
              title: "Fitur lengkap",
              pathImage: "assets/images/intro2.png",
              description: "Nikmati berbagai fitur menarik RIMS WASERDA",
              backgroundImage: "assets/images/bg_login.png",
              backgroundColor: Colors.white,
            ),
            ContentConfig(
              styleTitle: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
              styleDescription: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
              title: "Digitalisasi UMKM",
              pathImage: "assets/images/intro3.png",
              description: "Mari beralih ke UMKM digital bersama RIMS WASERDA",
              backgroundImage: "assets/images/bg_login.png",
              backgroundColor: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
