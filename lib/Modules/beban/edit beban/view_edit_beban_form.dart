import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:rims_waserda/Modules/beban/data%20beban/controller_beban.dart';

import '../../../Templates/setting.dart';
import '../../Widgets/buttons.dart';
import '../../Widgets/header.dart';

class edit_beban_form extends GetView<editbebanController> {
  const edit_beban_form({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Card(
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
                    function: () {},
                  ),
                  SizedBox(
                    height: 50,
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
                                icon: Icon(Icons.add_card),
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
                                  return 'Please enter email';
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
                                  child: Container(child: Obx(() {
                                    return DropdownButton2(
                                      isExpanded: true,
                                      hint: Text('Pilih Kategori'),
                                      value: controller.jenisbebanval.value,
                                      items: controller.jenisbebanlist.value
                                          .map((item) {
                                        return DropdownMenuItem(
                                          child: Text(item.kategori.toString()),
                                          value: item.id.toString(),
                                        );
                                      }).toList(),
                                      onChanged: (val) {
                                        controller.jenisbebanval.value =
                                            val!.toString();
                                        print(controller.jenisbebanval);
                                        controller.update();
                                      },
                                    );
                                  })),
                                ),
                                IconButton(
                                    onPressed: () {
                                      Get.toNamed('/tambah_jenis_beban');
                                    },
                                    icon: Icon(Icons.add))
                              ],
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            TextFormField(
                              controller: controller.keterangan.value,
                              onChanged: ((String pass) {}),
                              decoration: InputDecoration(
                                icon: Icon(Icons.person),
                                labelText: "deskripsi",
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
                                  return 'Please enter email';
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
                                            width: 350,
                                            height: 350,
                                            child: CalendarDatePicker2(
                                                config: CalendarDatePicker2Config(
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
                                icon: Icon(Icons.pin_drop),
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
                                  return 'Please enter email';
                                }
                                return null;
                              },
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            TextFormField(
                              controller: controller.jumlah.value,
                              onChanged: ((String pass) {}),
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
                                  return 'Please enter email';
                                }
                                return null;
                              },
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            button_solid_custom(
                                onPressed: () {
                                  controller.editBeban();
                                },
                                child: Text(
                                  'edit beban',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                width: double.infinity,
                                height: 50)
                          ],
                        )),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
