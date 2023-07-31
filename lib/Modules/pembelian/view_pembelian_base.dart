import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:group_button/group_button.dart';
import 'package:rims_waserda/Modules/pembelian/controller_pembelian.dart';

import '../../Templates/setting.dart';
import '../Widgets/stack bg.dart';

class pembelian extends GetView<pembelianController> {
  const pembelian({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      // minimum: EdgeInsets.all(5),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: color_template().primary.withOpacity(0.2),
        // appBar: appbar_custom(
        //     height: 50,
        //     child: Text(
        //       'Tambah Produk',
        //       style: font().header,
        //     )),
        body: stack_bg(
          isfullscreen: true,
          child: Stack(
            children: [
              Positioned(
                child: Align(
                  alignment: Alignment.centerRight,
                  child: GroupButton(
                    options: GroupButtonOptions(
                      selectedTextStyle: TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                      selectedColor: Colors.white,
                      selectedShadow: [shadow().reguler],
                      // unselectedShadow: const [],
                      unselectedColor: color_template().primary,
                      unselectedTextStyle: TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                      ),
                      // selectedBorderColor: color_template().primary,
                      //  unselectedBorderColor: color_template().primary,
                      borderRadius: BorderRadius.circular(12),
                      spacing: 15,
                      runSpacing: 10,
                      groupingType: GroupingType.wrap,
                      direction: Axis.vertical,
                      buttonHeight: context.height_query / 10,
                      buttonWidth: context.width_query / 13,
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
                        selectedIndex: controller.selectedIndex.value),
                    onSelected: (string, index, bool) {
                      controller.selectedIndex.value = index;
                      print(index);
                    },
                    buttons: [
                      "Pembelian",
                      "Hutang",
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: context.width_query / 16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Obx(() {
                        return controller.table
                            .elementAt(controller.selectedIndex.value);
                      }),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
