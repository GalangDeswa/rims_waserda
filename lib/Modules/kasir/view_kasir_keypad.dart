import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:group_button/group_button.dart';
import 'package:pattern_formatter/numeric_formatter.dart';
import 'package:rims_waserda/Modules/kasir/controller_kasir.dart';
import 'package:rims_waserda/Templates/setting.dart';

import '../Widgets/keypad.dart';

class kasir_keypad extends GetView<kasirController> {
  const kasir_keypad({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: elevation().def_elevation,
      //margin: EdgeInsets.all(30),
      shape: RoundedRectangleBorder(
        borderRadius: border_radius().def_border,
        side: BorderSide(color: color_template().primary, width: 3.5),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Center(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.only(right: 10),
                              height: context.height_query / 8,
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: color_template().primary),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(right: 10),
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            border_radius().header_border),
                                    child: Icon(
                                      Icons.attach_money,
                                      color: color_template().primary,
                                      size: context.height_query / 17,
                                    ),
                                  ),
                                  Text('Total Tagihan :',
                                      style: font().header_big),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: Obx(() {
                                      return Text(
                                          'Rp.' +
                                              controller.nominal.format(
                                                  double.parse(controller.total
                                                      .toString())),
                                          style: font().header_big);
                                    }),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        width: context.width_query,
                        child: GroupButton(
                          isRadio: true,
                          onSelected: (string, index, bool) {
                            controller.groupindex.value = index;
                            print(index);
                          },
                          buttons: [
                            "Cash",
                            "Debit Card",
                            "Credit Card",
                            "Cash Bon"
                          ],
                          options: GroupButtonOptions(
                            selectedShadow: const [],
                            selectedTextStyle: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                            ),
                            selectedColor: color_template().select,
                            unselectedShadow: const [],
                            unselectedColor: Colors.white,
                            unselectedTextStyle: TextStyle(
                              fontSize: 15,
                              color: Colors.black,
                            ),
                            //selectedBorderColor: Colors.pink[900],
                            unselectedBorderColor: color_template().select,
                            borderRadius: BorderRadius.circular(10),
                            spacing: 10,
                            runSpacing: 10,
                            groupingType: GroupingType.row,
                            direction: Axis.horizontal,
                            buttonHeight: context.height_query / 13,
                            buttonWidth: context.width_query / 10,
                            mainGroupAlignment: MainGroupAlignment.spaceBetween,
                            crossGroupAlignment: CrossGroupAlignment.center,
                            groupRunAlignment: GroupRunAlignment.spaceBetween,
                            textAlign: TextAlign.center,
                            textPadding: EdgeInsets.zero,
                            alignment: Alignment.center,
                            elevation: 3,
                          ),
                        ),
                      ),
                      Obx(() {
                        return controller.groupindex.value == 9
                            ? Center(
                                child: Container(
                                  child: Center(
                                    child: Text(
                                      "pilih metode bayar",
                                      style: font().header_black,
                                    ),
                                  ),
                                ),
                              )
                            : Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        padding: EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: color_template().primary),
                                        child: GestureDetector(
                                            onTap: () {
                                              controller.add_5000(controller
                                                  .keypadController.value.text);
                                              controller.balik();
                                            },
                                            child: Text(
                                              '5.000',
                                              style: font().header,
                                            )),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          controller.add_10000(controller
                                              .keypadController.value.text);
                                          controller.balik();
                                        },
                                        child: Container(
                                          padding: EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: color_template().primary),
                                          child: Text('10.000',
                                              style: font().header),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          controller.add_20000(controller
                                              .keypadController.value.text);
                                          controller.balik();
                                        },
                                        child: Container(
                                          padding: EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: color_template().primary),
                                          child: Text('20.000',
                                              style: font().header),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          controller.add_50000(controller
                                              .keypadController.value.text);
                                          controller.balik();
                                        },
                                        child: Container(
                                          padding: EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: color_template().primary),
                                          child: Text('50.000',
                                              style: font().header),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          controller.add_100000(controller
                                              .keypadController.value.text);
                                          controller.balik();
                                        },
                                        child: Container(
                                          padding: EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: color_template().primary),
                                          child: Text('100.000',
                                              style: font().header),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Expanded(
                                        child: Container(
                                          child: TextFormField(
                                            inputFormatters: [],
                                            keyboardType: TextInputType.number,
                                            controller: controller
                                                .keypadController.value,
                                            onChanged: (value) {
                                              print(value);

                                              controller.balik();
                                            },
                                            // readOnly: true,
                                            decoration: InputDecoration(
                                                prefixIcon: Icon(
                                                    Icons.attach_money_rounded),
                                                hintText: 'Jumlah bayar'),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Expanded(
                                          child: Container(
                                        child: TextFormField(
                                          controller:
                                              controller.kembalian.value,
                                          onChanged: (val) {
                                            print(
                                                'kembalian kasir--------------------' +
                                                    val);
                                          },
                                          readOnly: true,
                                          decoration: InputDecoration(
                                            prefixIcon:
                                                Icon(Icons.change_circle),
                                            hintText: 'kembalian',
                                          ),
                                        ),
                                      )),
                                    ],
                                  ),
                                ],
                              );
                      })
                    ],
                  ),
                ),
              ),
              Container(
                width: context.width_query / 3.5,
                child: KeyPad(
                  keypadController: controller.keypadController.value,
                  onChange: (String value) {
                    controller.balik();
                    print(value);
                    // controller.change();
                  },
                  onSubmit: (String pin) {},
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
