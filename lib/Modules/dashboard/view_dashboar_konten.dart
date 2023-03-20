import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rims_waserda/Modules/Widgets/loading.dart';
import 'package:rims_waserda/Modules/dashboard/controller_dashboard.dart';

import '../../Templates/setting.dart';

class dashboard_konten extends GetView<dashboardController> {
  const dashboard_konten({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
              boxShadow: [shadow().reguler],
              color: Colors.white,
              borderRadius: border_radius().def_border,
              border: Border.all(color: color_template().primary, width: 3.5)),
          margin: EdgeInsets.only(left: 15),
          height: context.height_query / 3,
          width: context.width_query,
          child: Card(
            elevation: 0,
            child: Padding(
              padding: EdgeInsets.all(15),
              child: Obx(() {
                return CarouselSlider(
                  options: CarouselOptions(
                    onPageChanged: (index, reason) {
                      //controller.listkonten.value.length;
                    },
                    viewportFraction: 1.0,
                    height: 450,
                    enlargeCenterPage: true,
                    enableInfiniteScroll: true,
                    autoPlay: true,
                    autoPlayInterval: Duration(seconds: 6),
                  ),
                  items: controller.listkonten.value
                      .map((x) => ClipRRect(
                            child: Container(
                              // margin: EdgeInsets.only(top: 20),
                              child: CachedNetworkImage(
                                  errorWidget: (context, url, error) =>
                                      Container(
                                          width: 100,
                                          height: 120,
                                          child: loading()),
                                  fit: BoxFit.cover,
                                  imageUrl: x.photo),
                            ),
                          ))
                      .toList(),
                );
              }),
            ),
          ),
        ),
        Positioned.fill(
          child: Align(
            alignment: Alignment.topLeft,
            child: Container(
              margin: EdgeInsets.only(top: 0, bottom: 10, left: 10),
              padding: EdgeInsets.all(10),
              width: 100,
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 3,
                      blurRadius: 5,
                      offset: Offset(3, 3), // changes position of shadow
                    ),
                  ],
                  color: color_template().primary,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10),
                      bottomRight: Radius.circular(10))),
              child: Text(
                'Promo RIMS',
                style: font().header,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
