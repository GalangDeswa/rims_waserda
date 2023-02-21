import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:rims_waserda/Controllers/Templates/setting.dart';

import '../../Controllers/base menu controller/base_menu_controller.dart';
import 'dashboard_app_card.dart';


class dashboard_app extends GetView<base_menuController> {
  const dashboard_app({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Stack(
        children: [
          Container(
            margin: EdgeInsets.all(5),
            //  color: Colors.green,
            height: context.height_query,
            width: context.width_query,
            child: Card(
              child: Padding(
                padding: EdgeInsets.only(top: 50),
                child: SingleChildScrollView(
                  child: Wrap(
                    alignment: WrapAlignment.spaceAround,
                    direction: Axis.horizontal,
                    runSpacing: 20,
                    spacing: 20,
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
                            controller.selectedIndex(3);
                          },
                          color: color_template().primary,
                          icon: Icons.add_box,
                          label: 'Tambah stock'),
                      dasboard_app_card(
                          function: () {
                            controller.selectedIndex(3);
                          },
                          color: color_template().primary,
                          icon: Icons.person_add,
                          label: 'Tambah user'),
                      dasboard_app_card(
                          function: () {
                            controller.selectedIndex(1);
                          },
                          color: color_template().primary,
                          icon: FontAwesomeIcons.cashRegister,
                          label: 'Kasir'),
                      dasboard_app_card(
                          function: () {
                            controller.selectedIndex(3);
                          },
                          color: color_template().primary,
                          icon: Icons.add_box,
                          label: 'Tambah stock'),
                      dasboard_app_card(
                          function: () {
                            controller.selectedIndex(3);
                          },
                          color: color_template().primary,
                          icon: Icons.person_add,
                          label: 'Tambah user'),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned.fill(
            child: Align(
              alignment: Alignment.topLeft,
              child: Container(
                margin: EdgeInsets.only(top: 10, bottom: 10),
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
