import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:group_button/group_button.dart';

import '../../../Templates/setting.dart';
import '../../Widgets/stack bg.dart';
import 'controller_beban.dart';

class beban extends GetView<bebanController> {
  const beban({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      //minimum: EdgeInsets.all(10),
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: color_template().primary.withOpacity(0.2),
          // appBar: appbar_custom(
          //     height: 50,
          //     child: Text(
          //       'Produk',
          //       style: font().header,
          //     )),
          body: stack_bg(
            child: Padding(
              padding: const EdgeInsets.all(30),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Obx(() {
                      return controller.table
                          .elementAt(controller.selectedIndex.value);
                    }),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: GroupButton(
                      options: GroupButtonOptions(
                        selectedShadow: const [],
                        selectedTextStyle: TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                        ),
                        selectedColor: color_template().select,
                        unselectedShadow: const [],
                        unselectedColor: Colors.white,
                        unselectedTextStyle: TextStyle(
                          fontSize: 12,
                          color: Colors.amber[900],
                        ),
                        //selectedBorderColor: Colors.pink[900],
                        unselectedBorderColor: color_template().select,
                        borderRadius: BorderRadius.circular(10),
                        spacing: 10,
                        runSpacing: 10,
                        groupingType: GroupingType.wrap,
                        direction: Axis.vertical,
                        buttonHeight: 60,
                        buttonWidth: 50,
                        mainGroupAlignment: MainGroupAlignment.start,
                        crossGroupAlignment: CrossGroupAlignment.start,
                        groupRunAlignment: GroupRunAlignment.start,
                        textAlign: TextAlign.center,
                        textPadding: EdgeInsets.zero,
                        alignment: Alignment.center,
                        elevation: 0,
                      ),
                      isRadio: true,
                      controller: GroupButtonController(
                          selectedIndex: controller.selectedIndex.value),
                      onSelected: (string, index, bool) {
                        controller.selectedIndex.value = index;
                        print(index);
                      },
                      buttons: [
                        "Beban",
                        "Kategori",
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
