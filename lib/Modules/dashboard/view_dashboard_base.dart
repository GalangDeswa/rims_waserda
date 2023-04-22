import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rims_waserda/Modules/dashboard/view_dashboar_konten.dart';
import 'package:rims_waserda/Modules/dashboard/view_dashboard_app.dart';
import 'package:rims_waserda/Modules/dashboard/view_dashboard_data.dart';

import '../../Templates/setting.dart';
import '../Widgets/stack bg.dart';
import 'controller_dashboard.dart';

class dashboard extends GetView<dashboardController> {
  const dashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      //minimum: EdgeInsets.all(10),
      child: Scaffold(
          backgroundColor: color_template().primary.withOpacity(0.2),
          body: stack_bg(
              isfullscreen: true,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                      child: Column(
                    children: [
                      Obx(() {
                        return Container(
                          height: context.height_query / 6,
                          width: context.width_query,
                          child: Card(
                            margin: EdgeInsets.only(bottom: 10),
                            // color: color_template().primary,
                            elevation: elevation().def_elevation,
                            shape: RoundedRectangleBorder(
                              borderRadius: border_radius().def_border,
                              side: BorderSide(
                                  color: color_template().primary, width: 3.5),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        controller.nama_toko.value,
                                        style: font().header_big_black,
                                      ),
                                      Text(
                                        controller.jenis_toko.value +
                                            ' - ' +
                                            controller.alamat_toko.value,
                                        style: font().reguler,
                                      ),
                                      // Text(
                                      //   GetStorage().read('alamat_toko'),
                                      //   style: font().reguler_white,
                                      // ),
                                    ],
                                  ),
                                  CircleAvatar(
                                    backgroundColor: Colors.white,
                                    child: CachedNetworkImage(
                                      imageUrl: controller.logo.value,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                      dashboard_data()
                    ],
                  )),
                  Expanded(
                    child: Column(
                      children: [dashboard_app(), dashboard_konten()],
                    ),
                  )
                ],
              ))),
    );
  }
}
