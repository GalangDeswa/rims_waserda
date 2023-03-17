import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:rims_waserda/Modules/Widgets/popup.dart';

import '../../Templates/setting.dart';
import '../kasir/controller_kasir.dart';

class KeyPad extends GetView<kasirController> {
  double buttonSize = 60.0;
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
      margin: EdgeInsets.only(left: 30, right: 30),
      child: Column(
        children: [
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              buttonWidget('1'),
              buttonWidget('2'),
              buttonWidget('3'),
            ],
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              buttonWidget('4'),
              buttonWidget('5'),
              buttonWidget('6'),
            ],
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              buttonWidget('7'),
              buttonWidget('8'),
              buttonWidget('9'),
            ],
          ),
          SizedBox(height: 20),
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
                      size: 30,
                      color: Colors.white,
                    )),
              ),
              buttonWidget('0'),
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

  buttonWidget(String buttonText) {
    return Container(
      height: buttonSize,
      width: buttonSize,
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(primary: color_template().secondary),
        onPressed: () {
          keypadController.text = keypadController.text + buttonText;
          onChange(controller.currencyFormatter
              .format(int.parse(keypadController.text)));
          //controller.change();
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
