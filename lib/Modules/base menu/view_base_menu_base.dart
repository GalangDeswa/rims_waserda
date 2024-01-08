import 'dart:convert';

import 'package:blue_thermal_printer/blue_thermal_printer.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:group_button/group_button.dart';
import 'package:rims_waserda/Modules/Widgets/buttons.dart';
import 'package:rims_waserda/Modules/Widgets/loading.dart';
import 'package:rims_waserda/Modules/Widgets/logout_pop.dart';
import 'package:rims_waserda/Modules/Widgets/toast.dart';
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
          if (controller.selectedIndex.value != 0) {
            print('tidak 0');
            controller.selectedIndex(0);
            return false;
          } else {
            print('exit exit');
            final shouldPop = await showDialog<bool>(
              context: context,
              builder: (context) {
                return AlertDialog(
                  surfaceTintColor: Colors.white,
                  title: const Text('Keluar aplikasi?'),
                  actionsAlignment: MainAxisAlignment.spaceBetween,
                  actions: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        button_border_custom(
                            onPressed: () {
                              Navigator.pop(context, false);
                            },
                            child: Text(
                              "Batal",
                              style: TextStyle(color: color_template().primary),
                            ),
                            height: 50,
                            width: 100),
                        // ElevatedButton(
                        //   style: ElevatedButton.styleFrom(
                        //       backgroundColor: color_template().secondary),
                        //   onPressed: () {
                        //     Navigator.pop(context, false);
                        //   },
                        //   child: Center(
                        //     child: Text('No'),
                        //   ),
                        // ),

                        button_solid_custom(
                            onPressed: () {
                              Navigator.pop(context, true);
                            },
                            child: Text(
                              'Keluar',
                              style: TextStyle(color: Colors.white),
                            ),
                            width: 100,
                            height: 50),
                        // ElevatedButton(
                        //   style: ElevatedButton.styleFrom(
                        //       backgroundColor: color_template().secondary),
                        //   onPressed: () {
                        //     Navigator.pop(context, true);
                        //   },
                        //   child: Center(
                        //     child: Text('YES'),
                        //   ),
                        // ),
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
          endDrawer: Obx(() {
            return Drawer(
              backgroundColor: Colors.white,
              child: ListView(
                shrinkWrap: true,
                padding: EdgeInsets.only(bottom: 10),
                children: [
                  DrawerHeader(
                      decoration: BoxDecoration(
                          color: color_template().primary,
                          image: DecorationImage(
                            image: AssetImage('assets/images/bg_login.png'),
                            fit: BoxFit.cover,
                            alignment: Alignment(1.0, -0.5),
                            colorFilter: ColorFilter.mode(
                                color_template().primary.withOpacity(1),
                                BlendMode.dstATop),
                          )),
                      child: Column(
                        children: [
                          controller.logo.value == '-'
                              ? CircleAvatar(
                                  backgroundImage: AssetImage(
                                      'assets/images/login_toko.png'),
                                  radius: 40,
                                )
                              : CircleAvatar(
                                  backgroundImage: MemoryImage(
                                    base64Decode(controller.logo.value),
                                    // fit: BoxFit.cover,
                                  ),
                                  backgroundColor: Colors.white,
                                  radius: 40,
                                ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            controller.namauser.value,
                            style: font().primary_dark,
                          ),
                          Text(
                            controller.role == 1 ? 'Kasir' : 'Admin',
                            style: TextStyle(fontSize: 13),
                          ),
                        ],
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  InkWell(
                    highlightColor: color_template().select,
                    splashColor: Colors.orangeAccent,
                    onTap: () async {
                      var p = 0.0.obs;

                      Get.dialog(Obx(() {
                        p.value = p.value + 0.2;
                        return Center(
                          child: Stack(
                            children: [
                              Center(
                                child: Container(
                                  width: 400,
                                  height: 400,
                                  child: showloading(),
                                ),
                              ),
                              Center(
                                child: Container(
                                  width: 250,
                                  height: 250,
                                  // color: Colors.red,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 15.0,
                                    backgroundColor: Colors.white,
                                    color: color_template().primary,
                                    value: controller.point_loading.value,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }));
                      p.value = p.value + 0.2;
                      print(
                          '<---------------- workmanager manual sync ---------------->');
                      try {
                        await controller.syncAll(controller.id_toko);
                        //  await Get.find<produkController>().checkup();
                      } catch (e) {
                        Get.back();
                        Get.showSnackbar(toast()
                            .bottom_snackbar_error('Error', e.toString()));
                      }

                      p.value = p.value + 0.2;
                      p.value = p.value + 0.2;
                      p.value = p.value + 0.2;
                      // p.value = 1.0;
                      if (controller.point_loading == 1.0) {
                        print(
                            'loading sync manual complete------------------>');
                      }
                    },
                    child: ListTile(
                      title: Text('Sinkronkan data'),
                      subtitle: Text(
                        '(Butuh koneksi internet)',
                        style: font().reguler,
                      ),
                      leading: Icon(Icons.sync),
                    ),
                  ),
                  InkWell(
                    highlightColor: color_template().select,
                    splashColor: Colors.orangeAccent,
                    onTap: () {
                      Get.toNamed('/edit_tokov2');
                      //controller.stringGenerator(10);
                    },
                    child: ListTile(
                      title: Text('Edit toko'),
                      leading: Icon(Icons.settings),
                    ),
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
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: context.width_query,
                    color: Colors.black,
                    height: 0.3,
                    margin: EdgeInsets.symmetric(vertical: 10),
                  ),
                  SizedBox(
                    height: 10,
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
                            //  selectedBorderColor: color_template().primary,
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
                          onSelected: (string, index, bool) async {
                            controller.layoutIndex.value = index;
                            if (controller.layoutIndex.value == 0) {
                              Get.find<kasirController>().layout.value = true;
                              await GetStorage().write('layout', true);
                            } else if (controller.layoutIndex.value == 1) {
                              Get.find<kasirController>().layout.value = false;
                              await GetStorage().write('layout', false);
                            }
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
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: context.width_query,
                    color: Colors.black,
                    height: 0.3,
                    margin: EdgeInsets.symmetric(vertical: 10),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Obx(() {
                    return ListTile(
                        leading: Icon(Icons.print),
                        title: DropdownButton<BluetoothDevice>(
                            hint: controller.listPrinter.value.isEmpty
                                ? Text(
                                    'Cari bluetooth printer',
                                    overflow: TextOverflow.ellipsis,
                                  )
                                : Text(
                                    'Pilih bluetooth printer',
                                    overflow: TextOverflow.ellipsis,
                                  ),
                            value: controller.selectedPrinter,
                            items: controller.listPrinter.value
                                .map((e) => DropdownMenuItem(
                                      child: Text(e.name!),
                                      value: e,
                                    ))
                                .toList(),
                            onChanged: (device) async {
                              controller.loading.value = 'loading';
                              if (await controller.printer.isConnected ==
                                  true) {
                                await controller.printer.disconnect();
                              }
                              controller.isConnected.value = false;
                              controller.selectedPrinter = device;
                              await controller.printer.connect(device!);
                              if (await controller.printer.isConnected ==
                                  true) {
                                controller.isConnected.value = true;
                                controller.loading.value = 'done';
                                print(
                                    'connected printer----------------------------- > ' +
                                        device.name!);
                              } else {
                                print('beelum konek--------------->');
                              }
                              print(device.name.toString());
                              // logic.update();
                            }),
                        subtitle: controller.loading.value == ''
                            ? Text('berlum terhubung')
                            : controller.loading.value == 'loading'
                                ? Container(
                                    margin: EdgeInsets.only(right: 190),
                                    width: 5,
                                    height: 20,
                                    child: CircularProgressIndicator())
                                : controller.loading.value == 'done'
                                    ? Text('Terhubung')
                                    : Text('Printer tidak ditemukan'));
                  }),
                  SizedBox(
                    height: 10,
                  ),
                  Obx(() {
                    return controller.listPrinter.value.isEmpty
                        ? Row(
                            children: [
                              Expanded(
                                child: Container(
                                  margin: EdgeInsets.symmetric(horizontal: 15),
                                  child: ElevatedButton(
                                      onPressed: () async {
                                        if (controller.printer.isConnected ==
                                            true) {
                                          await controller.printer.disconnect();
                                        }

                                        await controller.getDevice();
                                        controller.isConnected.value = false;
                                        controller.loading.value = '';
                                      },
                                      child: Text('Cari printer')),
                                ),
                              ),
                            ],
                          )
                        : Row(
                            children: [
                              Expanded(
                                child: Container(
                                  margin: EdgeInsets.symmetric(horizontal: 10),
                                  child: ElevatedButton(
                                      onPressed: () async {
                                        //print('qweqweqweqeqeqweqweqe');
                                        if ((await controller
                                            .printer.isConnected)!) {
                                          if (controller.logo.value == '-') {
                                            controller.printer.printImage(
                                                controller.pathImage.value);
                                          } else {
                                            controller.printer.printImageBytes(
                                                base64Decode(
                                                    controller.logo.value));
                                          }
                                          controller.printer.printCustom(
                                              controller.namatoko.value, 3, 1);
                                          controller.printer.printCustom(
                                              controller.alamat_toko.value,
                                              0,
                                              3);
                                          controller.printer.printCustom(
                                              '-------------------------------',
                                              1,
                                              3);
                                          controller.printer.printLeftRight(
                                              controller.dateFormat
                                                  .format(DateTime.now()),
                                              controller.namauser.value,
                                              0);
                                          controller.printer.printCustom(
                                              '-------------------------------',
                                              1,
                                              3);
                                          controller.printer.printNewLine();
                                          controller.printer.print3Column('-->',
                                              'Print struk berhasil', '<--', 0);
                                          controller.printer.printNewLine();
                                          controller.printer.printCustom(
                                              '-------------------------------',
                                              1,
                                              3);
                                          controller.printer.printNewLine();
                                          controller.printer.printCustom(
                                              '-------------------------------',
                                              1,
                                              1);
                                          controller.printer.printImage(
                                              controller.printstruklogo.value);
                                          controller.printer.printCustom(
                                              '*** Powered by RIMS ***', 0, 1);
                                          controller.printer.printCustom(
                                              'www.rims.co.id', 0, 1);
                                          controller.printer.printCustom(
                                              '-------------------------------',
                                              1,
                                              1);
                                          controller.printer.printNewLine();
                                        } else {
                                          Get.showSnackbar(toast()
                                              .bottom_snackbar_error('Error',
                                                  'Printer belum terkoneksi'));
                                        }
                                        //controller.tesPrint();
                                      },
                                      child: Text('Test printer')),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 15),
                                child: ElevatedButton(
                                    onPressed: () async {
                                      if (controller.printer.isConnected ==
                                          true) {
                                        await controller.printer.disconnect();
                                      }

                                      await controller.getDevice();
                                      controller.isConnected.value = false;
                                      controller.loading.value = '';
                                    },
                                    child: Icon(Icons.refresh)),
                              ),
                            ],
                          );
                  }),

                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: context.width_query,
                    color: Colors.black,
                    height: 0.3,
                    margin: EdgeInsets.symmetric(vertical: 10),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  InkWell(
                    highlightColor: color_template().select,
                    splashColor: Colors.orangeAccent,
                    onTap: () {
                      controller.resetpop();
                      //controller.popprinter(context);
                    },
                    child: ListTile(
                      title: Text('Reset aplikasi'),
                      leading: Icon(
                        Icons.warning_amber,
                        color: color_template().tritadery,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  // InkWell(
                  //   highlightColor: color_template().select,
                  //   splashColor: Colors.orangeAccent,
                  //   onTap: () {
                  //     controller.test();
                  //   },
                  //   child: ListTile(
                  //     title: Text('Test'),
                  //     leading: Icon(
                  //       Icons.transfer_within_a_station,
                  //       color: color_template().tritadery,
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            );
          }),
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.white,
          body: Row(
            children: <Widget>[
              Obx(() {
                return controller.role == 1
                    ? Expanded(
                        child: controller.views_kasir
                            .elementAt(controller.selectedIndex.value))
                    : Expanded(
                        child: controller.views_admin
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
                          return controller.role == 1
                              ? NavigationRail(
                                  elevation: 10,
                                  useIndicator: true,

                                  indicatorColor: color_template().primary,
                                  selectedIconTheme:
                                      IconThemeData(color: Colors.white),
                                  selectedLabelTextStyle: TextStyle(
                                      color: color_template().primary_dark),

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
                                      selectedIcon:
                                          Icon(FontAwesomeIcons.dashcube),
                                      label: Padding(
                                        padding: const EdgeInsets.only(top: 5),
                                        child: Text('Dashboard'),
                                      ),
                                    ),
                                    NavigationRailDestination(
                                      icon:
                                          FaIcon(FontAwesomeIcons.cashRegister),
                                      selectedIcon:
                                          FaIcon(FontAwesomeIcons.cartShopping),
                                      label: Padding(
                                        padding: const EdgeInsets.only(top: 5),
                                        child: Text('POS'),
                                      ),
                                    ),
                                    // NavigationRailDestination(
                                    //   icon: Icon(FontAwesomeIcons.box),
                                    //   selectedIcon: Icon(FontAwesomeIcons.box),
                                    //   label: Padding(
                                    //     padding: const EdgeInsets.only(top: 5),
                                    //     child: Text('Produk'),
                                    //   ),
                                    // ),
                                    NavigationRailDestination(
                                      icon: Icon(FontAwesomeIcons.dollarSign),
                                      selectedIcon: Icon(
                                          FontAwesomeIcons.circleDollarToSlot),
                                      label: Padding(
                                        padding: const EdgeInsets.only(top: 5),
                                        child: Text('Beban'),
                                      ),
                                    ),
                                    // NavigationRailDestination(
                                    //   icon: FaIcon(FontAwesomeIcons.userPlus),
                                    //   selectedIcon: FaIcon(FontAwesomeIcons.userPlus),
                                    //   label: Padding(
                                    //     padding: const EdgeInsets.only(top: 5),
                                    //     child: Text('User'),
                                    //   ),
                                    // ),
                                    NavigationRailDestination(
                                      icon:
                                          FaIcon(FontAwesomeIcons.peopleGroup),
                                      selectedIcon:
                                          FaIcon(FontAwesomeIcons.peopleLine),
                                      label: Padding(
                                        padding: const EdgeInsets.only(top: 5),
                                        child: Text('Pelanggan'),
                                      ),
                                    ),
                                    NavigationRailDestination(
                                      icon: Icon(FontAwesomeIcons.moneyBill),
                                      selectedIcon:
                                          Icon(FontAwesomeIcons.moneyBills),
                                      label: Padding(
                                        padding: const EdgeInsets.only(top: 5),
                                        child: Text('Penjualan'),
                                      ),
                                    ),
                                    NavigationRailDestination(
                                      icon: Icon(FontAwesomeIcons.receipt),
                                      selectedIcon:
                                          Icon(FontAwesomeIcons.chartSimple),
                                      label: Padding(
                                        padding: const EdgeInsets.only(top: 5),
                                        child: Text('Laporan'),
                                      ),
                                    ),
                                  ],
                                )
                              : NavigationRail(
                                  elevation: 10,
                                  useIndicator: true,

                                  indicatorColor: color_template().primary,
                                  selectedIconTheme:
                                      IconThemeData(color: Colors.white),
                                  selectedLabelTextStyle: TextStyle(
                                      color: color_template().primary_dark),

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
                                      selectedIcon:
                                          Icon(FontAwesomeIcons.dashcube),
                                      label: Padding(
                                        padding: const EdgeInsets.only(top: 5),
                                        child: Text('Dashboard'),
                                      ),
                                    ),
                                    NavigationRailDestination(
                                      icon:
                                          FaIcon(FontAwesomeIcons.cashRegister),
                                      selectedIcon:
                                          FaIcon(FontAwesomeIcons.cartShopping),
                                      label: Padding(
                                        padding: const EdgeInsets.only(top: 5),
                                        child: Text('POS'),
                                      ),
                                    ),
                                    NavigationRailDestination(
                                      icon: Icon(FontAwesomeIcons.box),
                                      selectedIcon:
                                          Icon(FontAwesomeIcons.boxOpen),
                                      label: Padding(
                                        padding: const EdgeInsets.only(top: 5),
                                        child: Text('Produk'),
                                      ),
                                    ),
                                    NavigationRailDestination(
                                      icon: Icon(FontAwesomeIcons.dollarSign),
                                      selectedIcon: Icon(
                                          FontAwesomeIcons.circleDollarToSlot),
                                      label: Padding(
                                        padding: const EdgeInsets.only(top: 5),
                                        child: Text('Beban'),
                                      ),
                                    ),
                                    NavigationRailDestination(
                                      icon: FaIcon(FontAwesomeIcons.userPlus),
                                      selectedIcon:
                                          FaIcon(FontAwesomeIcons.userGear),
                                      label: Padding(
                                        padding: const EdgeInsets.only(top: 5),
                                        child: Text('User'),
                                      ),
                                    ),
                                    NavigationRailDestination(
                                      icon:
                                          FaIcon(FontAwesomeIcons.peopleGroup),
                                      selectedIcon:
                                          FaIcon(FontAwesomeIcons.peopleLine),
                                      label: Padding(
                                        padding: const EdgeInsets.only(top: 5),
                                        child: Text('Pelanggan'),
                                      ),
                                    ),
                                    NavigationRailDestination(
                                      icon: Icon(FontAwesomeIcons.moneyBill),
                                      selectedIcon:
                                          Icon(FontAwesomeIcons.moneyBills),
                                      label: Padding(
                                        padding: const EdgeInsets.only(top: 5),
                                        child: Text('Penjualan'),
                                      ),
                                    ),
                                    NavigationRailDestination(
                                      icon: Icon(FontAwesomeIcons.receipt),
                                      selectedIcon:
                                          Icon(FontAwesomeIcons.chartSimple),
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
