import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:group_button/group_button.dart';
import 'package:rims_waserda/Modules/Widgets/logout_pop.dart';
import 'package:rims_waserda/Modules/base%20menu/controller_base_menu.dart';
import 'package:rims_waserda/Modules/kasir/controller_kasir.dart';

import '../../Templates/setting.dart';

class base_menu extends GetView<base_menuController> {
  base_menu({Key? key}) : super(key: key);
  var key = GlobalKey<ScaffoldState>();

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
          drawerEnableOpenDragGesture: false,
          endDrawer: Drawer(
            child: ListView(
              shrinkWrap: true,
              padding: EdgeInsets.only(bottom: 10),
              children: [
                DrawerHeader(
                    child: Column(
                  children: [
                    Container(
                      width: 70,
                      height: 70,
                      margin: EdgeInsets.only(top: 10),
                      child: Icon(
                        Icons.person,
                        color: Colors.white,
                        size: 50,
                      ),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: color_template().primary,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      GetStorage().read('name'),
                      style: font().primary_dark,
                    ),
                    Text(
                      GetStorage().read('nama_toko'),
                      style: font().primary_dark,
                    ),
                  ],
                )),
                ListTile(
                  title: Text('Setting'),
                  leading: Icon(Icons.settings),
                ),
                InkWell(
                  highlightColor: color_template().select,
                  splashColor: Colors.orangeAccent,
                  onTap: () {
                    Get.dialog(logout_pop());
                  },
                  child: ListTile(
                    title: Text('Logout'),
                    leading: Icon(Icons.logout),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    children: [
                      Expanded(child: Text('Tampilan Kasir')),
                      GroupButton(
                        options: GroupButtonOptions(
                          selectedTextStyle: TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                          selectedColor: color_template().select,
                          selectedShadow: [shadow().reguler],
                          unselectedShadow: const [],
                          unselectedColor: Colors.white,
                          unselectedTextStyle: TextStyle(
                            fontSize: 12,
                            color: Colors.black,
                          ),
                          selectedBorderColor: color_template().primary,
                          // unselectedBorderColor: color_template().select,
                          borderRadius: BorderRadius.circular(12),
                          spacing: 15,
                          runSpacing: 10,
                          groupingType: GroupingType.wrap,
                          direction: Axis.horizontal,
                          buttonHeight: context.height_query / 15,
                          buttonWidth: context.width_query / 15,
                          mainGroupAlignment: MainGroupAlignment.start,
                          crossGroupAlignment: CrossGroupAlignment.start,
                          groupRunAlignment: GroupRunAlignment.start,
                          textAlign: TextAlign.center,
                          textPadding: EdgeInsets.all(5),
                          alignment: Alignment.center,
                          elevation: 3,
                        ),
                        isRadio: true,
                        controller: GroupButtonController(
                            selectedIndex: controller.getlayout()),
                        onSelected: (string, index, bool) {
                          controller.layoutIndex.value = index;
                          controller.layoutIndex.value == 0
                              ? Get.find<kasirController>().layout.value = true
                              : controller.layoutIndex.value == 1
                                  ? Get.find<kasirController>().layout.value =
                                      false
                                  : null;
                          print(index);
                          print(Get.find<kasirController>().layout.value);
                        },
                        buttons: [
                          "Cafe",
                          "Waserda",
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          resizeToAvoidBottomInset: false,
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
                            leading: Builder(
                              builder: (context) {
                                return GestureDetector(
                                  onTap: () {
                                    Scaffold.of(context).openEndDrawer();
                                    //controller.openDrawer();
                                  },
                                  child: Column(
                                    children: [
                                      Container(
                                        width: 50,
                                        height: 50,
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
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        GetStorage().read('name'),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                            selectedIndex: controller.selectedIndex.value,
                            onDestinationSelected: (value) {
                              controller.selectedIndex.value = value;

                              print(value);
                            },
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
                                icon: FaIcon(FontAwesomeIcons.peopleGroup),
                                selectedIcon:
                                    FaIcon(FontAwesomeIcons.peopleGroup),
                                label: Padding(
                                  padding: const EdgeInsets.only(top: 5),
                                  child: Text('Pelanggan'),
                                ),
                              ),
                              NavigationRailDestination(
                                icon: Icon(FontAwesomeIcons.history),
                                selectedIcon: Icon(FontAwesomeIcons.history),
                                label: Padding(
                                  padding: const EdgeInsets.only(top: 5),
                                  child: Text('History'),
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
