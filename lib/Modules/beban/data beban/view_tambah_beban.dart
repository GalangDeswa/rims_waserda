import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:pattern_formatter/numeric_formatter.dart';
import 'package:rims_waserda/Modules/Widgets/card_custom.dart';
import 'package:rims_waserda/Modules/Widgets/toast.dart';

import '../../../Templates/setting.dart';
import '../../Widgets/buttons.dart';
import '../../Widgets/header.dart';
import '../edit jenis beban/view_tambah_jenis_beban.dart';
import 'controller_beban.dart';

class tambah_beban extends GetView<bebanController> {
  const tambah_beban({Key? key}) : super(key: key);

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
              header(
                title: 'Tambah Beban',
                icon: FontAwesomeIcons.dollarSign,
                iscenter: false,
              ),
              SizedBox(
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
                                  margin: EdgeInsets.only(bottom: 10),
                                  // width: context.width_query / 2.2,
                                  // height: 100,
                                  child: TextFormField(
                                    controller: controller.nama.value,
                                    onChanged: ((String pass) {}),
                                    decoration: InputDecoration(
                                      labelText: "Nama beban",
                                      labelStyle: TextStyle(
                                        color: Colors.black87,
                                      ),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                    ),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Masukan nama produk';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(bottom: 10),
                                  //  width: context.width_query / 3.3,
                                  child: TextFormField(
                                    controller: controller.keterangan.value,
                                    onChanged: ((String pass) {}),
                                    decoration: InputDecoration(
                                      labelText: "Deskripsi",
                                      labelStyle: TextStyle(
                                        color: Colors.black87,
                                      ),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                    ),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Masukan deskirpsi beban';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        child: DropdownButtonFormField2(
                                          validator: (value) {
                                            if (value == null) {
                                              return 'Pilih kategori beban';
                                            }
                                            return null;
                                          },
                                          decoration: InputDecoration(
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                            ),
                                          ),
                                          dropdownStyleData: DropdownStyleData(
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  color: Colors.white)),
                                          isExpanded: true,
                                          hint: Text('Pilih Kategori'),
                                          value: controller.jenisbebanval,
                                          items: controller.jenisbebanlistlocal
                                              .map((item) {
                                            return DropdownMenuItem(
                                              child: Text(
                                                  item.kategori.toString()),
                                              value: item.idLocal.toString(),
                                            );
                                          }).toList(),
                                          onChanged: (val) {
                                            controller.jenisbebanval =
                                                val!.toString();
                                            print(controller.jenisbebanval);
                                          },
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin:
                                          EdgeInsets.only(left: 30, right: 5),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: color_template().primary,
                                      ),
                                      padding: EdgeInsets.all(3),
                                      child: IconButton(
                                          color: Colors.white,
                                          onPressed: () {
                                            Get.dialog(AlertDialog(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                20.0))),
                                                contentPadding: EdgeInsets.zero,
                                                backgroundColor:
                                                    Colors.transparent,
                                                content: Builder(
                                                  builder: (context) {
                                                    return Container(
                                                        padding:
                                                            EdgeInsets.zero,
                                                        width: context
                                                                .width_query /
                                                            2,
                                                        height: context
                                                                .height_query /
                                                            2,
                                                        child: ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        30),
                                                            child:
                                                                tambah_jenis_beban()));
                                                  },
                                                )));
                                          },
                                          icon: Icon(Icons.add)),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Container(
                              margin: EdgeInsets.symmetric(
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
                                margin: EdgeInsets.only(bottom: 10),
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
                                                      print(dates);
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
                                    labelText: "Tanggal",
                                    labelStyle: TextStyle(
                                      color: Colors.black87,
                                    ),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                  ),
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
                                  labelText: "Jumlah",
                                  labelStyle: TextStyle(
                                    color: Colors.black87,
                                  ),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                ),
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
                              margin: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 10),
                              child: VerticalDivider(
                                color: color_template().primary,
                                thickness: 1,
                              )),
                        ],
                      ),
                    ));
              }),
              SizedBox(
                height: 25,
              ),
              button_solid_custom(
                  onPressed: () async {
                    if (controller.formKeybeban.value.currentState!
                        .validate()) {
                      try {
                        await controller.bebanTambahlocal();
                      } catch (e) {
                        Get.back();
                        Get.showSnackbar(toast()
                            .bottom_snackbar_error('Error', e.toString()));
                      }
                    }
                  },
                  child: Text(
                    'tambah beban'.toUpperCase(),
                    style: TextStyle(
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
