import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:rims_waserda/Modules/base%20menu/controller_base_menu.dart';

import '../../Templates/setting.dart';

class base_menu extends GetView<base_menuController> {
  const base_menu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: () async {
          if (controller.selectedIndex != 0) {
            print('tidak 0');
            controller.selectedIndex(0);
            return false;
          } else {
            print('exit exit');
            final shouldPop = await showDialog<bool>(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text('Do you to go back?'),
                  actionsAlignment: MainAxisAlignment.spaceBetween,
                  actions: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: color_template().secondary),
                          onPressed: () {
                            Navigator.pop(context, false);
                          },
                          child: Center(
                            child: Text('No'),
                          ),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: color_template().secondary),
                          onPressed: () {
                            Navigator.pop(context, true);
                          },
                          child: Center(
                            child: Text('YES'),
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              },
            );
            return shouldPop!;
          }
        },
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Row(
            children: <Widget>[
              Obx(() {
                return Expanded(
                    child: controller.views
                        .elementAt(controller.selectedIndex.value));
              }),
              LayoutBuilder(
                builder: (context, constraint) {
                  return SingleChildScrollView(
                    child: ConstrainedBox(
                      constraints:
                          BoxConstraints(minHeight: constraint.maxHeight),
                      child: IntrinsicHeight(
                        child: Obx(() {
                          return NavigationRail(
                            elevation: 10,
                            useIndicator: true,
                            indicatorColor: color_template().primary,
                            selectedIconTheme:
                                IconThemeData(color: Colors.white),
                            selectedLabelTextStyle:
                                TextStyle(color: color_template().primary_dark),

                            minExtendedWidth: context.width_query * 0.2,
                            extended: controller.extended.value,
                            minWidth: context.width_query * 0.010,
                            //backgroundColor: color_template().nav,
                            leading: GestureDetector(
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
                                                Get.offAndToNamed('/login');
                                              },
                                            ),
                                            // ElevatedButton(
                                            //   child: Text('load toko'),
                                            //   onPressed: () {
                                            //     controller.loadToko();
                                            //   },
                                            // ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ));
                              },
                              child: Container(
                                width: 40,
                                height: 40,
                                margin: EdgeInsets.only(top: 10),
                                child: Icon(
                                  Icons.person,
                                  color: Colors.white,
                                ),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: color_template().primary,
                                ),
                              ),
                            ),
                            selectedIndex: controller.selectedIndex.value,
                            onDestinationSelected: controller.selectedIndex,
                            labelType: NavigationRailLabelType.all,

                            destinations: [
                              NavigationRailDestination(
                                icon: Icon(Icons.dashboard),
                                selectedIcon: Icon(Icons.dashboard),
                                label: Padding(
                                  padding: const EdgeInsets.only(top: 5),
                                  child: Text('Dashboard'),
                                ),
                              ),
                              NavigationRailDestination(
                                icon: FaIcon(FontAwesomeIcons.cashRegister),
                                selectedIcon:
                                    FaIcon(FontAwesomeIcons.cashRegister),
                                label: Padding(
                                  padding: const EdgeInsets.only(top: 5),
                                  child: Text('Penjualan'),
                                ),
                              ),
                              NavigationRailDestination(
                                icon: Icon(FontAwesomeIcons.box),
                                selectedIcon: Icon(FontAwesomeIcons.box),
                                label: Padding(
                                  padding: const EdgeInsets.only(top: 5),
                                  child: Text('Produk'),
                                ),
                              ),
                              NavigationRailDestination(
                                icon: Icon(FontAwesomeIcons.dollarSign),
                                selectedIcon: Icon(FontAwesomeIcons.dollarSign),
                                label: Padding(
                                  padding: const EdgeInsets.only(top: 5),
                                  child: Text('Beban'),
                                ),
                              ),
                              NavigationRailDestination(
                                icon: FaIcon(FontAwesomeIcons.userPlus),
                                selectedIcon: FaIcon(FontAwesomeIcons.userPlus),
                                label: Padding(
                                  padding: const EdgeInsets.only(top: 5),
                                  child: Text('User'),
                                ),
                              ),
                              NavigationRailDestination(
                                icon: Icon(FontAwesomeIcons.receipt),
                                selectedIcon: Icon(FontAwesomeIcons.receipt),
                                label: Padding(
                                  padding: const EdgeInsets.only(top: 5),
                                  child: Text('Laporan'),
                                ),
                              ),
                            ],
                          );
                        }),
                      ),
                    ),
                  );
                },
              ),
              //VerticalDivider(thickness: 1, width: 1),
              // This is the main content.
            ],
          ),
        ),
      ),
    );
  }
}
