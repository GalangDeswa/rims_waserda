import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:group_button/group_button.dart';
import 'package:rims_waserda/Modules/kasir/controller_kasir.dart';
import 'package:rims_waserda/Modules/pelanggan/data%20pelanggan/model_data_pelanggan.dart';
import 'package:rims_waserda/Templates/setting.dart';

import '../Widgets/buttons.dart';
import '../Widgets/card_custom.dart';
import '../Widgets/header.dart';
import '../Widgets/keypad.dart';

class kasir_keypad extends GetView<kasirController> {
  const kasir_keypad({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card_custom(
      border: false,
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
                              margin: const EdgeInsets.only(right: 10),
                              height: context.height_query / 5,
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white,
                                  border: Border.all(
                                      color: color_template().primary)),
                              child: Column(
                                children: [
                                  Expanded(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Container(
                                          margin:
                                              const EdgeInsets.only(right: 15),
                                          padding: const EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                              color: color_template().primary,
                                              borderRadius: border_radius()
                                                  .header_border),
                                          child: Icon(
                                            Icons.attach_money,
                                            color: Colors.white,
                                            size: context.height_query / 30,
                                          ),
                                        ),
                                        Text('Total Tagihan :',
                                            style: font().header_big_blue),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Expanded(
                                          child: Obx(() {
                                            return Text(
                                                'Rp.' +
                                                    controller.nominal.format(
                                                        double.parse(controller
                                                            .total
                                                            .toString())),
                                                style: font().header_big_blue);
                                          }),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.symmetric(vertical: 10),
                                    height: 0.5,
                                    color: color_template().primary,
                                    width: context.width_query,
                                  ),
                                  Expanded(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Kasir : ' + controller.nama_user,
                                          style: font().reguler_bold,
                                        ),
                                        Row(
                                          children: [
                                            Obx(() {
                                              return Text(
                                                controller.tgl_penjualan.value
                                                        .isEmpty
                                                    ? controller.dateFormatprint
                                                        .format(DateTime.now())
                                                    : controller.dateFormatprint
                                                        .format(controller
                                                            .tgl_penjualan
                                                            .first!),
                                                style: font().reguler_bold,
                                              );
                                            }),
                                            Container(
                                              margin: EdgeInsets.only(
                                                  left: 10, top: 5, bottom: 5),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  color:
                                                      color_template().primary),
                                              child: IconButton(
                                                  onPressed: () {
                                                    Get.dialog(AlertDialog(
                                                      content: Container(
                                                        width: context
                                                                .width_query /
                                                            2,
                                                        // height:
                                                        //     context.height_query / 1.5,
                                                        child:
                                                            CalendarDatePicker2WithActionButtons(
                                                                config: CalendarDatePicker2WithActionButtonsConfig(
                                                                    weekdayLabels: [
                                                                      'Minggu',
                                                                      'Senin',
                                                                      'Selasa',
                                                                      'Rabu',
                                                                      'Kamis',
                                                                      'Jumat',
                                                                      'Sabtu',
                                                                    ],
                                                                    firstDayOfWeek:
                                                                        1,
                                                                    calendarType:
                                                                        CalendarDatePicker2Type
                                                                            .single),
                                                                value: controller
                                                                    .tgl_penjualan
                                                                    .value,
                                                                onValueChanged:
                                                                    (dates) {
                                                                  print(dates);
                                                                  controller
                                                                      .tgl_penjualan
                                                                      .value = dates;

                                                                  Get.back();
                                                                }),
                                                      ),
                                                    ));
                                                  },
                                                  icon: Icon(
                                                    Icons.calendar_month,
                                                    color: Colors.white,
                                                    size: context.height_query /
                                                        45,
                                                  )),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
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
                            controller.groupindex.value = index + 1;
                            print(controller.groupindex.value);
                          },
                          buttons: [
                            "Tunai",
                            "Hutang",
                          ],
                          options: GroupButtonOptions(
                            selectedShadow: const [],
                            selectedTextStyle: const TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                            ),
                            selectedColor: color_template().select,
                            unselectedShadow: const [],
                            unselectedColor: Colors.white,
                            unselectedTextStyle: const TextStyle(
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
                            : controller.groupindex.value == 2
                                ? Row(
                                    children: [
                                      Expanded(
                                        child: DropdownSearch<DataPelanggan>(
                                          popupProps: const PopupProps.menu(
                                            //showSelectedItems: true,
                                            showSearchBox: true,
                                            itemBuilder: dropdownPelanggan,
                                          ),
                                          dropdownDecoratorProps:
                                              DropDownDecoratorProps(
                                            dropdownSearchDecoration:
                                                InputDecoration(
                                              labelText: "Cari pelanggan",
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              focusedBorder: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                            ),
                                          ),
                                          items: controller
                                              .list_pelanggan_local.value,
                                          itemAsString: (DataPelanggan u) {
                                            return u.namaPelanggan!;
                                          },
                                          onChanged: (data) {
                                            controller.id_pelanggan.value =
                                                data!.idLocal.toString();
                                            print(
                                                'id pelanggan--------------------');
                                            print(controller.id_pelanggan);
                                          },
                                        ),
                                      ),
                                      Container(
                                        margin: const EdgeInsets.only(
                                            right: 5, left: 30),
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: color_template().primary,
                                        ),
                                        padding: const EdgeInsets.all(3),
                                        child: IconButton(
                                            color: Colors.white,
                                            onPressed: () {
                                              Get.dialog(
                                                  tambahpelangganpembayaran());
                                            },
                                            icon: const Icon(Icons.add)),
                                      )
                                    ],
                                  )
                                : Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                color:
                                                    color_template().primary),
                                            child: GestureDetector(
                                                onTap: () {
                                                  controller.add_5000(controller
                                                      .keypadController
                                                      .value
                                                      .text);
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
                                              padding: const EdgeInsets.all(10),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  color:
                                                      color_template().primary),
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
                                              padding: const EdgeInsets.all(10),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  color:
                                                      color_template().primary),
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
                                              padding: const EdgeInsets.all(10),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  color:
                                                      color_template().primary),
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
                                              padding: const EdgeInsets.all(10),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  color:
                                                      color_template().primary),
                                              child: Text('100.000',
                                                  style: font().header),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 30,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Expanded(
                                            child: TextFormField(
                                              keyboardType:
                                                  TextInputType.number,
                                              controller: controller
                                                  .keypadController.value,
                                              onChanged: (value) {
                                                print(value);
                                                print('keypad chanhge');
                                                controller.balik();
                                              },
                                              // readOnly: true,
                                              decoration: const InputDecoration(
                                                  prefixText: 'Rp. ',
                                                  hintText: 'Jumlah bayar'),
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
                                                    'kembalian kasir--------->' +
                                                        val);
                                              },
                                              readOnly: true,
                                              decoration: const InputDecoration(
                                                prefixText: 'Rp.',
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
                    // controller.keypadController.value.text = value;
                    controller.bayarvalue.value =
                        int.parse(value.toString().replaceAll(',', ''));
                    controller.balik();
                    print(value + '--> mappeed string');
                    print('bayar value ===> ' +
                        controller.bayarvalue.value.toString());
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

  Widget tambahpelangganpembayaran() {
    return AlertDialog(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0))),
        contentPadding: EdgeInsets.zero,
        backgroundColor: Colors.transparent,
        content: Builder(
          builder: (context) {
            return SingleChildScrollView(
              child: Container(
                  padding: EdgeInsets.zero,
                  width: context.width_query / 2,
                  height: context.height_query / 1.7,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: Card(
                        elevation: elevation().def_elevation,
                        //margin: EdgeInsets.all(30),
                        shape: RoundedRectangleBorder(
                          borderRadius: border_radius().def_border,
                          side: BorderSide(
                              color: color_template().primary, width: 3.5),
                        ),

                        child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: Container(
                            width: context.width_query / 1,
                            //height: context.height_query / 1.3,
                            child: Form(
                                key:
                                    controller.formKeypelangganpembayaran.value,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const header(
                                      title: 'Tambah Pelanggan',
                                      icon: FontAwesomeIcons.dollarSign,
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    TextFormField(
                                      controller:
                                          controller.nama_pelanggan.value,
                                      onChanged: ((String pass) {}),
                                      decoration: InputDecoration(
                                        labelText: "Nama pelanggan",
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
                                      textAlign: TextAlign.start,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Masukan nama pelanggan';
                                        }
                                        return null;
                                      },
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    TextFormField(
                                      controller: controller.nohp.value,
                                      onChanged: ((String pass) {}),
                                      decoration: InputDecoration(
                                        labelText: "Nomor HP",
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
                                      textAlign: TextAlign.start,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Masukan nomor hp';
                                        }
                                        return null;
                                      },
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    button_solid_custom(
                                        onPressed: () {
                                          if (controller
                                              .formKeypelangganpembayaran
                                              .value
                                              .currentState!
                                              .validate()) {
                                            controller.tambahPelangganlocal();
                                          }
                                        },
                                        child: Text(
                                          'Tambah pelanggan'.toUpperCase(),
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        width: double.infinity,
                                        height: 60)
                                  ],
                                )),
                          ),
                        ),
                      ))),
            );
          },
        ));
  }
}

Widget dropdownPelanggan(
  BuildContext context,
  DataPelanggan item,
  bool isSelected,
) {
  return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      decoration: !isSelected
          ? null
          : BoxDecoration(
              border: Border.all(color: Theme.of(context).primaryColor),
              borderRadius: BorderRadius.circular(5),
              color: Colors.white,
            ),
      child: ListTile(
        selected: isSelected,
        title: Text(item.namaPelanggan!),
        subtitle: Text('Nomor hp :' + item.noHp!),
      ));
}
