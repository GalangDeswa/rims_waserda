import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rims_waserda/Modules/Widgets/popup.dart';

import '../../Templates/setting.dart';
import '../kasir/controller_kasir.dart';

class KeyPad extends GetView<kasirController> {
  double buttonSize = 60;
  final TextEditingController keypadController;
  final Function onChange;
  final Function onSubmit;

  KeyPad({
    required this.onChange,
    required this.onSubmit,
    required this.keypadController,
  });

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
                    onPressed: () {
                      popscreen().popkonfirmasi(context, controller);
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
          var x = num;
          // onChange(controller.currencyFormatter
          //     .format(int.parse(keypadController.text)));
          onChange(x);
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
