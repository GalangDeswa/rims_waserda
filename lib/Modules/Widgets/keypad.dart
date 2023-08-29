import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rims_waserda/Modules/Widgets/popup.dart';
import 'package:rims_waserda/Modules/Widgets/toast.dart';

import '../../Templates/setting.dart';
import '../kasir/controller_kasir.dart';
import '../kasir/model_meja.dart';

class KeyPad extends GetView<kasirController> {
  double buttonSize = 60;
  final TextEditingController keypadController;
  final Function onChange;
  final Function onSubmit;
  final List<DataMeja>? prebill;
  final String? nomor_meja;
  final int? total_prebill;
  final int? diskon_kasir;
  final int? subtotal;
  final int? ppn;

  KeyPad(
      {required this.onChange,
      required this.onSubmit,
      required this.keypadController,
      this.prebill,
      this.nomor_meja,
      this.total_prebill,
      this.diskon_kasir,
      this.subtotal,
      this.ppn});

  @override
  Widget build(BuildContext context) {
    return Container(
      //margin: EdgeInsets.only(left: 20, right: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(height: context.height_query / 35),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              buttonWidget('1', context.height_query / 9),
              buttonWidget('2', context.height_query / 9),
              buttonWidget('3', context.height_query / 9),
            ],
          ),
          SizedBox(height: context.height_query / 35),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              buttonWidget('4', context.height_query / 9),
              buttonWidget('5', context.height_query / 9),
              buttonWidget('6', context.height_query / 9),
            ],
          ),
          SizedBox(height: context.height_query / 35),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              buttonWidget('7', context.height_query / 9),
              buttonWidget('8', context.height_query / 9),
              buttonWidget('9', context.height_query / 9),
            ],
          ),
          SizedBox(height: context.height_query / 35),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                decoration: BoxDecoration(
                    color: color_template().select, shape: BoxShape.circle),
                padding: EdgeInsets.all(10),
                child: IconButton(
                    onPressed: () {
                      if (keypadController.text.length > 0) {
                        keypadController.text = keypadController.text
                            .substring(0, keypadController.text.length - 1);
                      }
                      onChange(keypadController.text);
                    },
                    icon: Icon(
                      Icons.backspace,
                      color: Colors.white,
                      size: 30,
                    )),
              ),
              buttonWidget('0', context.height_query / 10),
              Container(
                decoration: BoxDecoration(
                    color: color_template().primary, shape: BoxShape.circle),
                padding: EdgeInsets.all(10),
                child: IconButton(
                    onPressed: () async {
                      if (prebill == null) {
                        if (controller.groupindex.value == 9) {
                          Get.showSnackbar(toast().bottom_snackbar_error(
                              'Gagal', 'Pilih metode bayar terlebih dahulu'));
                        } else {
                          if (controller.groupindex.value == 2) {
                            if (controller.id_pelanggan.value.isEmpty) {
                              Get.showSnackbar(toast().bottom_snackbar_error(
                                  'Gagal', 'Pilih pelanggan terlebih dahulu'));
                            } else {
                              popscreen().popkonfirmasi(context, controller);
                            }
                          } else {
                            if (keypadController.text.isEmpty) {
                              Get.showSnackbar(toast().bottom_snackbar_error(
                                  'Gagal',
                                  'masukan jumlah bayar terlebih dahulu'));
                            } else {
                              if (controller.bayarvalue.value <
                                      controller.total.value &&
                                  controller.groupindex.value != 2) {
                                Get.showSnackbar(toast().bottom_snackbar_error(
                                    'Gagal', "Jumlah bayaran tidak mencukupi"));
                              } else {
                                popscreen().popkonfirmasi(context, controller);
                              }
                            }
                          }
                        }
                      } else {
                        if (controller.groupindex.value == 9) {
                          Get.showSnackbar(toast().bottom_snackbar_error(
                              'Gagal', 'Pilih metode bayar terlebih dahulu'));
                        } else {
                          if (controller.groupindex.value == 2) {
                            if (controller.id_pelanggan.value.isEmpty) {
                              Get.showSnackbar(toast().bottom_snackbar_error(
                                  'Gagal', 'Pilih pelanggan terlebih dahulu'));
                            } else {
                              List<DataMeja> items =
                                  await controller.fetchmejadetail(nomor_meja);
                              popscreen().popkonfirmasiprebill(
                                  context,
                                  controller,
                                  items,
                                  nomor_meja!,
                                  total_prebill!,
                                  diskon_kasir,
                                  subtotal,
                                  ppn);
                            }
                          } else {
                            if (keypadController.text.isEmpty) {
                              Get.showSnackbar(toast().bottom_snackbar_error(
                                  'Gagal',
                                  'masukan jumlah bayar terlebih dahulu'));
                            } else {
                              if (controller.bayarvalue_prebill.value <
                                      total_prebill!.toInt() &&
                                  controller.groupindex.value != 2) {
                                Get.showSnackbar(toast().bottom_snackbar_error(
                                    'Gagal', "Jumlah bayaran tidak mencukupi"));
                              } else {
                                List<DataMeja> items = await controller
                                    .fetchmejadetail(nomor_meja);
                                popscreen().popkonfirmasiprebill(
                                    context,
                                    controller,
                                    items,
                                    nomor_meja!,
                                    total_prebill!,
                                    diskon_kasir,
                                    subtotal,
                                    ppn);
                              }
                            }
                          }
                        }
                      }
                    },
                    icon: Icon(
                      Icons.check,
                      size: 30,
                      color: Colors.white,
                    )),
              )
            ],
          ),
        ],
      ),
    );
  }

  buttonWidget(String buttonText, double size) {
    return Container(
      height: size,
      width: size,
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(primary: color_template().secondary),
        onPressed: () {
          var num = keypadController.text = keypadController.text + buttonText;
          var x = num.replaceAll(RegExp(r'[^\w\s]+'), '').replaceAllMapped(
              RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},');
          // x.replaceAllMapped(
          //     RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => "${m[1]},");

          // onChange(controller.currencyFormatter
          //     .format(int.parse(keypadController.text)));
          onChange(keypadController.text = x);
          //controller.change();
          //.replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => "${m[1]}.");
        },
        child: Center(
          child: Text(
            buttonText,
            style: TextStyle(
                fontWeight: FontWeight.bold, color: Colors.white, fontSize: 25),
          ),
        ),
      ),
    );
  }

  iconButtonWidget(IconData icon, Function function) {
    return InkWell(
      onTap: function(),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        height: buttonSize,
        width: buttonSize,
        decoration:
            BoxDecoration(color: Colors.orangeAccent, shape: BoxShape.circle),
        child: Center(
          child: Icon(
            icon,
            size: 30,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
