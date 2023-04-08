import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controller_login.dart';

class login_carousel extends GetView<loginController> {
  const login_carousel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var login_con = Get.find<loginController>();

    return Expanded(
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(15)),
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Obx(() {
          return CarouselSlider(
            options: CarouselOptions(
              onPageChanged: (index, reason) {
                login_con.current(index);
              },
              viewportFraction: 1.0,
              height: 450,
              enlargeCenterPage: true,
              enableInfiniteScroll: true,
              autoPlay: true,
              autoPlayInterval: Duration(seconds: 6),
            ),
            items: login_con.konten
                .map((x) => ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.asset(x),
                    ))
                .toList(),
          );
        }),
      ),
    );
  }
}
