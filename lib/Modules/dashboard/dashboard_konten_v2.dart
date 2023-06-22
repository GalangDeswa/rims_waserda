import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:rims_waserda/Modules/dashboard/controller_dashboard.dart';

import '../../Templates/setting.dart';
import '../Widgets/loading.dart';

class dashboard_konten_v2 extends GetView<dashboardController> {
  const dashboard_konten_v2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [shadow().reguler],
        color: Colors.white,
        borderRadius: border_radius().def_border,
      ),
      margin: EdgeInsets.only(top: 10),
      // height: context.height_query / 19.5,
      width: context.width_query,
      child: Obx(() {
        return CarouselSlider(
          options: CarouselOptions(
            onPageChanged: (index, reason) {
              //controller.listkonten.value.length;
            },
            viewportFraction: 1,
            aspectRatio: 16 / 9,
            // height: context.height_query,
            enlargeCenterPage: true,
            enableInfiniteScroll: true,
            autoPlay: true,
            autoPlayInterval: Duration(seconds: 7),
          ),
          //TODO : chek fetch history berdasar role user
          // TODO : chek proses sync pas di relese mode
          // TODO : chek app lagi untuk relese

          items: controller.kontenlists.value
              .map((x) => ClipRRect(
                    borderRadius: border_radius().def_border,
                    child: CachedNetworkImage(
                        placeholder: (context, url) => Container(
                            width: 50, height: 50, child: showloading()),
                        errorWidget: (context, url, error) => Container(
                            width: 100,
                            height: 100,
                            child: Icon(
                              FontAwesomeIcons.warning,
                              color: color_template().tritadery,
                            )),
                        fit: BoxFit.fill,
                        imageUrl: x['foto']),
                  ))
              .toList(),
        );
      }),
    );
  }
}
