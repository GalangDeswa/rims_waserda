import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../Controllers/Templates/setting.dart';

class header extends StatelessWidget {
  const header({Key? key, this.base_color, this.title, this.icon})
      : super(key: key);
  final Color? base_color;
  final String? title;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      color: Colors.white,
      child: Row(
        children: [
          Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: color_template().primary,
                  borderRadius: BorderRadius.circular(10)),
              child: FaIcon(
                icon,
                size: 20,
                color: Colors.white,
              )),
          SizedBox(
            width: 20,
          ),
          Text(
            title!,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
          )
        ],
      ),
    );
  }
}
