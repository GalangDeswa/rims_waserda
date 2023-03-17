import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../Templates/setting.dart';
import '../base menu/controller_base_menu.dart';
import '../Widgets/dashboard_app_card.dart';

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
                padding: EdgeInsets.only(top: 55),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Wrap(
                      alignment: WrapAlignment.spaceBetween,
                      direction: Axis.horizontal,
                      runSpacing: 30,
                      spacing: 30,
                      children: [
                        dasboard_app_card(
                            function: () {
                              controller.selectedIndex(1);
                            },
                            color: color_template().primary,
                            icon: FontAwesomeIcons.cashRegister,
                            label: 'Kasir'),
                        dasboard_app_card(
                            function: () {
                              controller.selectedIndex(2);
                            },
                            color: color_template().primary,
                            icon: FontAwesomeIcons.box,
                            label: 'Produk'),
                        dasboard_app_card(
                            function: () {
                              controller.selectedIndex(3);
                            },
                            color: color_template().primary,
                            icon: FontAwesomeIcons.dollarSign,
                            label: 'Beban'),
                        dasboard_app_card(
                            function: () {
                              controller.selectedIndex(4);
                            },
                            color: color_template().primary,
                            icon: Icons.person_add,
                            label: 'Tambah user'),
                        dasboard_app_card(
                            function: () {
                              controller.selectedIndex(5);
                            },
                            color: color_template().primary,
                            icon: Icons.history,
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
