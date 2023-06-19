import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:pattern_formatter/numeric_formatter.dart';
import 'package:rims_waserda/Modules/Widgets/card_custom.dart';
import 'package:rims_waserda/Modules/beban/data%20beban/controller_beban.dart';

import '../../../Templates/setting.dart';
import '../../Widgets/buttons.dart';
import '../../Widgets/header.dart';

class edit_beban_form extends GetView<editbebanController> {
  const edit_beban_form({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card_custom(
      border: false,
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Container(
          width: context.width_query / 1,
          //height: context.height_query / 1.5,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const header(
                title: 'Edit Beban',
                icon: FontAwesomeIcons.dollarSign,
                iscenter: false,
              ),
              const SizedBox(
                height: 25,
              ),
              Obx(() {
                return Form(
                    key: controller.formKeybeban.value,
                    child: IntrinsicHeight(
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(bottom: 10),
                                  // width: context.width_query / 2.2,
                                  // height: 100,
                                  child: TextFormField(
                                    controller: controller.nama.value,
                                    onChanged: ((String pass) {}),
                                    decoration: InputDecoration(
                                      icon:
                                          const Icon(FontAwesomeIcons.boxOpen),
                                      labelText: "Nama beban",
                                      labelStyle: const TextStyle(
                                        color: Colors.black87,
                                      ),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                    ),
                                    textAlign: TextAlign.center,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Masukan nama produk';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(bottom: 10),
                                  //  width: context.width_query / 3.3,
                                  child: TextFormField(
                                    controller: controller.keterangan.value,
                                    onChanged: ((String pass) {}),
                                    decoration: InputDecoration(
                                      icon: const Icon(FontAwesomeIcons.pencil),
                                      labelText: "Deskripsi",
                                      labelStyle: const TextStyle(
                                        color: Colors.black87,
                                      ),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                    ),
                                    textAlign: TextAlign.center,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Masukan deskirpsi beban';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                // Row(
                                //   children: [
                                //     Expanded(
                                //       child: Container(
                                //         child: Obx(() {
                                //           return DropdownButtonFormField2(
                                //             validator: (value) {
                                //               if (value == null) {
                                //                 return 'Pilih kategori beban';
                                //               }
                                //               return null;
                                //             },
                                //             decoration: InputDecoration(
                                //               icon: const Icon(
                                //                   FontAwesomeIcons.dollarSign),
                                //               border: OutlineInputBorder(
                                //                 borderRadius:
                                //                     BorderRadius.circular(15),
                                //               ),
                                //             ),
                                //             dropdownStyleData:
                                //                 DropdownStyleData(
                                //                     decoration: BoxDecoration(
                                //                         borderRadius:
                                //                             BorderRadius
                                //                                 .circular(10),
                                //                         color: Colors.white)),
                                //             isExpanded: true,
                                //             hint: const Text('Pilih Kategori'),
                                //             value:
                                //                 controller.jenisbebanval.value,
                                //             items: controller
                                //                 .jenisbebanlistlocal
                                //                 .map((item) {
                                //               return DropdownMenuItem(
                                //                 child: Text(
                                //                     item.kategori.toString()),
                                //                 value: item.id.toString(),
                                //               );
                                //             }).toList(),
                                //             onChanged: (val) {
                                //               controller.jenisbebanval.value =
                                //                   val!.toString();
                                //               print(controller.jenisbebanval);
                                //             },
                                //           );
                                //         }),
                                //       ),
                                //     ),
                                //     Container(
                                //       margin: const EdgeInsets.only(
                                //           left: 30, right: 5),
                                //       decoration: BoxDecoration(
                                //         shape: BoxShape.circle,
                                //         color: color_template().primary,
                                //       ),
                                //       padding: const EdgeInsets.all(3),
                                //       child: IconButton(
                                //           color: Colors.white,
                                //           onPressed: () {
                                //             Get.dialog(AlertDialog(
                                //                 shape:
                                //                     const RoundedRectangleBorder(
                                //                         borderRadius:
                                //                             BorderRadius.all(
                                //                                 Radius.circular(
                                //                                     20.0))),
                                //                 contentPadding: EdgeInsets.zero,
                                //                 backgroundColor:
                                //                     Colors.transparent,
                                //                 content: Builder(
                                //                   builder: (context) {
                                //                     return Container(
                                //                         padding:
                                //                             EdgeInsets.zero,
                                //                         width: context
                                //                                 .width_query /
                                //                             2,
                                //                         height: context
                                //                                 .height_query /
                                //                             2,
                                //                         child: ClipRRect(
                                //                             borderRadius:
                                //                                 BorderRadius
                                //                                     .circular(
                                //                                         30),
                                //                             child:
                                //                                 const tambah_jenis_beban()));
                                //                   },
                                //                 )));
                                //           },
                                //           icon: const Icon(Icons.add)),
                                //     )
                                //   ],
                                // ),
                              ],
                            ),
                          ),
                          Container(
                              margin: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 10),
                              child: VerticalDivider(
                                color: color_template().primary,
                                thickness: 1,
                              )),
                          Expanded(
                              child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                margin: const EdgeInsets.only(bottom: 10),
                                child: TextFormField(
                                  onTap: () {
                                    FocusScope.of(context)
                                        .requestFocus(new FocusNode());
                                    showDialog(
                                        context: context,
                                        builder: (_) => AlertDialog(
                                              content: Container(
                                                width: context.width_query / 2,
                                                height:
                                                    context.height_query / 2,
                                                child: CalendarDatePicker2(
                                                    config: CalendarDatePicker2Config(
                                                        weekdayLabels: [
                                                          'Minggu',
                                                          'Senin',
                                                          'Selasa',
                                                          'Rabu',
                                                          'Kamis',
                                                          'Jumat',
                                                          'Sabtu',
                                                        ],
                                                        firstDayOfWeek: 1,
                                                        calendarType:
                                                            CalendarDatePicker2Type
                                                                .single),
                                                    value: controller.datedata,
                                                    onValueChanged: (dates) {
                                                      controller.datedata =
                                                          dates;
                                                      controller.stringdate();
                                                      Get.back();
                                                    }),
                                              ),
                                            ));
                                  },
                                  controller: controller.tanggal.value,
                                  onChanged: ((String pass) {}),
                                  decoration: InputDecoration(
                                    icon: const Icon(FontAwesomeIcons.calendar),
                                    labelText: "Tanggal",
                                    labelStyle: const TextStyle(
                                      color: Colors.black87,
                                    ),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                  ),
                                  textAlign: TextAlign.center,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Pilih tanggal beban';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              TextFormField(
                                controller: controller.jumlah.value,
                                keyboardType: TextInputType.number,
                                inputFormatters: [ThousandsFormatter()],
                                onChanged: ((String num) {
                                  controller.jumlahbeban.value = double.parse(
                                      num.toString().replaceAll(',', ''));
                                  print(controller.jumlahbeban);
                                  print(controller.jumlahbeban.value);
                                }),
                                decoration: InputDecoration(
                                  icon: const Icon(Icons.pin_drop),
                                  labelText: "Jumlah",
                                  labelStyle: const TextStyle(
                                    color: Colors.black87,
                                  ),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                ),
                                textAlign: TextAlign.center,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Masukan jumlah beban';
                                  }
                                  return null;
                                },
                              ),
                            ],
                          )),
                          Container(
                              margin: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 10),
                              child: VerticalDivider(
                                color: color_template().primary,
                                thickness: 1,
                              )),
                        ],
                      ),
                    ));
              }),
              const SizedBox(
                height: 25,
              ),
              button_solid_custom(
                  onPressed: () {
                    if (controller.formKeybeban.value.currentState!
                        .validate()) {
                      controller.editBebanLocal();
                      //controller.jjj();
                    }
                  },
                  child: Text(
                    'edit beban'.toUpperCase(),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  width: double.infinity,
                  height: 60)
            ],
          ),
        ),
      ),
    );
  }
}
