import 'package:flutter/material.dart';
import 'package:rims_waserda/Templates/setting.dart';

class Tabs extends StatelessWidget {
  const Tabs({
    Key? key,
    this.isSelected = false,
    this.onTap,
    this.horizontalPadding = 30,
    this.leftPadding = 5,
    this.rightPadding = 5,
    required this.text,
    this.tabColor = const Color.fromARGB(255, 197, 201, 203),
  }) : super(key: key);

  final bool isSelected;
  final Function()? onTap;
  final double horizontalPadding;
  final double leftPadding;
  final double rightPadding;
  final String text;
  final tabColor;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Padding(
        padding:
            EdgeInsets.only(top: 10, left: leftPadding, right: rightPadding),
        child: InkWell(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10), topRight: Radius.circular(10)),
          onTap: onTap,
          child: Ink(
              padding: EdgeInsets.symmetric(
                  horizontal: horizontalPadding, vertical: 5),
              decoration: BoxDecoration(
                  // color: Colors.blueGrey[200],
                  color: isSelected ? Colors.white : tabColor,
                  // border: Border(
                  //     top: BorderSide(
                  //         color: Colors.black)),
                  boxShadow: isSelected
                      ? [
                          BoxShadow(
                              color: Colors.blueGrey.withOpacity(0.2),
                              blurRadius: 8,
                              offset: Offset(0, -5)),
                          BoxShadow(
                              color: Colors.blueGrey.withOpacity(0.2),
                              blurRadius: 8,
                              offset: Offset(-5, 0)),
                          BoxShadow(
                              color: Colors.blueGrey.withOpacity(0.2),
                              blurRadius: 8,
                              offset: Offset(5, 0))
                        ]
                      : [],
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10))),
              child: Text(
                text,
                style: TextStyle(
                    color: isSelected
                        ? color_template().select
                        : color_template().primary,
                    fontWeight: FontWeight.bold),
              )),
        ),
      ),
    );
  }
}
