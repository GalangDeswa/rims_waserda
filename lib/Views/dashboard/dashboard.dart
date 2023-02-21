import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_storage/get_storage.dart';


import '../../Controllers/Templates/setting.dart';


import '../../Controllers/dashboard controller/dashboard_controller.dart';
import 'dashboard_app.dart';
import 'dashboard_app_card.dart';
import 'dashboard_data.dart';


class dashboard extends GetView<dashboardController> {
  const dashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      // minimum: EdgeInsets.all(5),
      child: Scaffold(
        backgroundColor: color_template().primary.withOpacity(0.2),
        body: Center(
            child: Row(
          children: [
            Expanded(
                child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 5),
                  child: Card(
                    child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: color_template().primary,
                      ),
                      width: context.width_query,
                      height: 100,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Selamat datang',
                                style: font().header,
                              ),
                              // Text(
                              //   controller.toko_user['nama'],
                              //   style: font().header,
                              // ),
                              // Text(
                              //   controller.toko_user['alamat'],
                              //   style: font().reguler_white,
                              // ),

                            ],
                          ),
                          GestureDetector(
                            onTap: () {
                              Get.dialog(Center(
                                child: Container(
                                  child: Column(
                                    children: [
                                      Text('logout?'),
                                      Row(
                                        children: [
                                          ElevatedButton(
                                            child: Text('tidak'),
                                            onPressed: () {
                                              Get.back();
                                            },
                                          ),
                                          ElevatedButton(
                                            child: Text('ya'),
                                            onPressed: () {
                                              GetStorage().erase();
                                            },
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ));
                              //print(GetStorage().read('token'));
                            },
                            child: CircleAvatar(
                              child: Icon(
                                Icons.person,
                                size: 50,
                              ),
                              maxRadius: 30,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                /*Container(
                    margin: EdgeInsets.only(top: 5),
                    child: Card(
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: color_template().primary,
                            gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  color_template().primary_v2,
                                  color_template().primary_v3
                                ])),
                        width: context.width_query,
                        height: 100,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Selamat datang',
                                  style: font().header,
                                ),
                                Text(
                                  'Nama toko',
                                  style: font().header,
                                ),
                              ],
                            ),
                            CircleAvatar(
                              child: Icon(
                                Icons.person,
                                size: 50,
                              ),
                              maxRadius: 30,
                            )
                          ],
                        ),
                      ),
                    ),

                  ),*/
                dashboard_data()
              ],
            )),
            dashboard_app()
          ],
        )),
      ),
    );
  }
}
