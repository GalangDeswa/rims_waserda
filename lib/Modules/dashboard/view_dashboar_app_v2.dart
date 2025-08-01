import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:rims_waserda/Modules/Widgets/dashboard_app_card_v2.dart';
import 'package:rims_waserda/Modules/base%20menu/controller_base_menu.dart';

import '../../Templates/setting.dart';
import '../Widgets/loading.dart';

class dashboard_app_v2 extends GetView<base_menuController> {
  const dashboard_app_v2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        dashboard_app_card_v2(
            function: () {
              controller.selectedIndex(1);
            },
            color: color_template().primary,
            icon: SvgPicture.asset(
              'assets/icons/cashier.svg',
              height: context.width_query / 18,
              placeholderBuilder: (context) => showloading(),
            ),
            label: 'POS'),
        controller.role == 1
            ? dashboard_app_card_v2(
                function: () {
                  controller.selectedIndex(2);
                },
                color: color_template().primary,
                icon: SvgPicture.asset(
                  'assets/icons/money.svg',
                  height: context.width_query / 18,
                  placeholderBuilder: (context) => showloading(),
                ),
                label: 'Beban')
            : dashboard_app_card_v2(
                function: () {
                  controller.selectedIndex(2);
                },
                color: color_template().primary,
                icon: SvgPicture.asset(
                  'assets/icons/produk.svg',
                  height: context.width_query / 18,
                  placeholderBuilder: (context) => showloading(),
                ),
                label: 'Produk'),
        // dashboard_app_card_v2(
        //     function: () {
        //       controller.selectedIndex(3);
        //     },
        //     color: color_template().primary,
        //     icon: SvgPicture.asset(
        //       'assets/icons/money.svg',
        //       height: context.width_query / 25,
        //       placeholderBuilder: (context) => showloading(),
        //     ),
        //     label: 'Beban'),
        // dashboard_app_card_v2(
        //     function: () {
        //       controller.selectedIndex(4);
        //     },
        //     color: color_template().primary,
        //     icon: SvgPicture.asset(
        //       'assets/icons/adduser.svg',
        //       height: context.width_query / 25,
        //       placeholderBuilder: (context) => showloading(),
        //     ),
        //     label: 'Tambah user'),
        controller.role == 1
            ? dashboard_app_card_v2(
                function: () {
                  controller.selectedIndex(4);
                },
                color: color_template().primary,
                icon: SvgPicture.asset(
                  'assets/icons/history.svg',
                  height: context.width_query / 18,
                  placeholderBuilder: (context) => showloading(),
                ),
                label: 'Penjualan')
            : dashboard_app_card_v2(
                function: () {
                  controller.selectedIndex(6);
                },
                color: color_template().primary,
                icon: SvgPicture.asset(
                  'assets/icons/history.svg',
                  height: context.width_query / 18,
                  placeholderBuilder: (context) => showloading(),
                ),
                label: 'Penjualan'),
        controller.role == 1
            ? dashboard_app_card_v2(
                function: () {
                  controller.selectedIndex(5);
                },
                color: color_template().primary,
                icon: SvgPicture.asset(
                  'assets/icons/laporan.svg',
                  height: context.width_query / 18,
                  placeholderBuilder: (context) => showloading(),
                ),
                label: 'Laporan')
            : dashboard_app_card_v2(
                function: () {
                  controller.selectedIndex(7);
                },
                color: color_template().primary,
                icon: SvgPicture.asset(
                  'assets/icons/laporan.svg',
                  height: context.width_query / 18,
                  placeholderBuilder: (context) => showloading(),
                ),
                label: 'Laporan'),
      ],
    );
  }
}
