import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../Templates/setting.dart';
import '../Widgets/dashboard_app_card.dart';
import '../Widgets/loading.dart';
import '../base menu/controller_base_menu.dart';

class dashboard_app extends GetView<base_menuController> {
  const dashboard_app({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                boxShadow: [shadow().reguler],
                color: Colors.white,
                borderRadius: border_radius().def_border,
                border:
                    Border.all(color: color_template().primary, width: 3.5)),
            margin: EdgeInsets.only(left: 15),
            height: context.height_query,
            width: context.width_query,
            child: Card(
              elevation: 0,
              child: Padding(
                padding: EdgeInsets.only(top: 20),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Wrap(
                      alignment: WrapAlignment.spaceBetween,
                      direction: Axis.horizontal,
                      runSpacing: 15,
                      spacing: 15,
                      crossAxisAlignment: WrapCrossAlignment.start,
                      children: [
                        dasboard_app_card(
                            function: () {
                              controller.selectedIndex(1);
                            },
                            color: color_template().primary,
                            icon: SvgPicture.asset(
                              'assets/icons/cashier.svg',
                              height: context.width_query / 15,
                              placeholderBuilder: (context) => showloading(),
                            ),
                            label: 'Penjualan'),
                        dasboard_app_card(
                            function: () {
                              controller.selectedIndex(2);
                            },
                            color: color_template().primary,
                            icon: SvgPicture.asset(
                              'assets/icons/produk.svg',
                              height: context.width_query / 15,
                              placeholderBuilder: (context) => showloading(),
                            ),
                            label: 'Produk'),
                        dasboard_app_card(
                            function: () {
                              controller.selectedIndex(3);
                            },
                            color: color_template().primary,
                            icon: SvgPicture.asset(
                              'assets/icons/money.svg',
                              height: context.width_query / 15,
                              placeholderBuilder: (context) => showloading(),
                            ),
                            label: 'Beban'),
                        dasboard_app_card(
                            function: () {
                              controller.selectedIndex(4);
                            },
                            color: color_template().primary,
                            icon: SvgPicture.asset(
                              'assets/icons/adduser.svg',
                              height: context.width_query / 15,
                              placeholderBuilder: (context) => showloading(),
                            ),
                            label: 'Tambah user'),
                        dasboard_app_card(
                            function: () {
                              controller.selectedIndex(5);
                            },
                            color: color_template().primary,
                            icon: SvgPicture.asset(
                              'assets/icons/history.svg',
                              height: context.width_query / 15,
                              placeholderBuilder: (context) => showloading(),
                            ),
                            label: 'History'),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned.fill(
            child: Align(
              alignment: Alignment.topLeft,
              child: Container(
                margin: EdgeInsets.only(top: 0, bottom: 10, left: 10),
                padding: EdgeInsets.all(10),
                //width: 100,
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
                  'Aplikasi',
                  style: font().header,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
