import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rims_waserda/Modules/Widgets/loading.dart';

import 'controller_login.dart';

class login_carousel extends GetView<loginController> {
  const login_carousel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(15)),
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Obx(() {
          return CarouselSlider(
            options: CarouselOptions(
              onPageChanged: (index, reason) {
                controller.current(index);
              },
              viewportFraction: 1.0,
              height: 450,
              enlargeCenterPage: true,
              enableInfiniteScroll: true,
              autoPlay: true,
              autoPlayInterval: Duration(seconds: 6),
            ),
            items: controller.kontensquare
                .map((x) => ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: CachedNetworkImage(
                      placeholder: (context, url) => Container(
                          width: 50, height: 50, child: showloading()),
                      fit: BoxFit.cover,
                      imageUrl: x['foto'],
                    )))
                .toList(),
          );
        }),
      ),
    );
  }
}
