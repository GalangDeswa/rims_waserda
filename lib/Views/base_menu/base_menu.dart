import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:rims_waserda/Controllers/base%20menu%20controller/base_menu_controller.dart';

import '../../Controllers/Templates/setting.dart';

class base_menu extends StatefulWidget {
  const base_menu({Key? key}) : super(key: key);

  @override
  State<base_menu> createState() => _base_menuState();
}

class _base_menuState extends State<base_menu> {
  @override
  Widget build(BuildContext context) {
    var base_con = Get.find<base_menuController>();

    return SafeArea(
      child: WillPopScope(
        onWillPop: () async {
          if (base_con.selectedIndex != 0) {
            print('tidak 0');
            base_con.selectedIndex(0);
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
                              primary: color_template().secondary),
                          onPressed: () {
                            Navigator.pop(context, false);
                          },
                          child: Center(
                            child: Text('No'),
                          ),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: color_template().secondary),
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
          //backgroundColor: color_template().nav,
          body: Row(
            children: <Widget>[
              Obx(() {
                return Expanded(
                    child:
                        base_con.views.elementAt(base_con.selectedIndex.value));
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
                            minWidth: 3,
                            backgroundColor: color_template().nav,
                            leading: Container(
                              width: 40,
                              height: 40,
                              child: Icon(
                                Icons.person,
                                color: Colors.white,
                              ),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: color_template().primary,
                              ),
                            ),
                            selectedIndex: base_con.selectedIndex.value,
                            onDestinationSelected: base_con.selectedIndex,
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
                                  child: Text('Kasir'),
                                ),
                              ),
                              NavigationRailDestination(
                                icon: FaIcon(FontAwesomeIcons.userPlus),
                                selectedIcon: FaIcon(FontAwesomeIcons.userPlus),
                                label: Padding(
                                  padding: const EdgeInsets.only(top: 5),
                                  child: Text('+ User'),
                                ),
                              ),
                              NavigationRailDestination(
                                icon: Icon(Icons.add_box),
                                selectedIcon: Icon(Icons.add_box),
                                label: Padding(
                                  padding: const EdgeInsets.only(top: 5),
                                  child: Text('+ Stock'),
                                ),
                              ),
                              NavigationRailDestination(
                                icon: Icon(Icons.add_box),
                                selectedIcon: Icon(Icons.add_box),
                                label: Padding(
                                  padding: const EdgeInsets.only(top: 5),
                                  child: Text('Produk'),
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
