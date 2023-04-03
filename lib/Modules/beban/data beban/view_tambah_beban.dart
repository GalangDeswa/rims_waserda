import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:pattern_formatter/numeric_formatter.dart';

import '../../../Templates/setting.dart';
import '../../Widgets/buttons.dart';
import '../../Widgets/header.dart';
import '../edit jenis beban/view_tambah_jenis_beban.dart';
import 'controller_beban.dart';

class tambah_beban extends GetView<bebanController> {
  const tambah_beban({Key? key}) : super(key: key);

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
        child: Container(
          width: context.width_query / 1,
          height: context.height_query / 1,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              header(
                title: 'Tambah beban',
                icon: FontAwesomeIcons.dollarSign,
              ),
              SizedBox(
                height: 25,
              ),
              Expanded(
                child: Form(
                    key: controller.formKeybeban.value,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        TextFormField(
                          controller: controller.nama.value,
                          onChanged: ((String pass) {}),
                          decoration: InputDecoration(
                            icon: Icon(FontAwesomeIcons.moneyBill),
                            labelText: "Nama beban",
                            labelStyle: TextStyle(
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
                              return 'Masukan nama beban';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                child: GetBuilder<bebanController>(
                                    builder: (logic) {
                                  return DropdownButtonFormField2(
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Pilih kategori beban';
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      icon: Icon(FontAwesomeIcons.dollarSign),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                    ),
                                    dropdownStyleData: DropdownStyleData(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: Colors.white)),
                                    isExpanded: true,
                                    hint: Text('Pilih Kategori'),
                                    value: logic.jenisbebanval,
                                    items:
                                        logic.jenisbebanlist.value.map((item) {
                                      return DropdownMenuItem(
                                        child: Text(item.kategori.toString()),
                                        value: item.id.toString(),
                                      );
                                    }).toList(),
                                    onChanged: (val) {
                                      logic.jenisbebanval = val!.toString();
                                      print(logic.jenisbebanval);
                                      logic.update();
                                    },
                                  );
                                }),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 30, right: 5),
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
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20.0))),
                                        contentPadding: EdgeInsets.zero,
                                        backgroundColor: Colors.transparent,
                                        content: Builder(
                                          builder: (context) {
                                            return Container(
                                                padding: EdgeInsets.zero,
                                                width: context.width_query / 2,
                                                height:
                                                    context.height_query / 2,
                                                child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
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
                        SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          controller: controller.keterangan.value,
                          onChanged: ((String pass) {}),
                          decoration: InputDecoration(
                            icon: Icon(FontAwesomeIcons.pencil),
                            labelText: "Deskripsi",
                            labelStyle: TextStyle(
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
                              return 'Masukan deskripsi beban';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          onTap: () {
                            FocusScope.of(context)
                                .requestFocus(new FocusNode());
                            showDialog(
                                context: context,
                                builder: (_) => AlertDialog(
                                      content: Container(
                                        width: context.width_query / 2,
                                        height: context.height_query / 2,
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
                                              controller.datedata = dates;
                                              controller.stringdate();
                                              Get.back();
                                            }),
                                      ),
                                    ));
                          },
                          controller: controller.tanggal.value,
                          onChanged: ((String pass) {}),
                          decoration: InputDecoration(
                            icon: Icon(FontAwesomeIcons.calendar),
                            labelText: "Tanggal",
                            labelStyle: TextStyle(
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
                              return 'Pilih tanggal beban';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 15,
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
                            icon: Icon(Icons.pin_drop),
                            labelText: "Jumlah",
                            labelStyle: TextStyle(
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
              ),
              SizedBox(
                height: 15,
              ),
              button_solid_custom(
                  onPressed: () {
                    if (controller.formKeybeban.value.currentState!
                        .validate()) {
                      controller.tambahBeban();
                    }
                  },
                  child: Text(
                    'tambah beban',
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
