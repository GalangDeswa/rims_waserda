import 'package:flutter/material.dart';

import '../../Controllers/Templates/setting.dart';

class datacard extends StatelessWidget {
  const datacard(
      {Key? key,
      this.icon,
      this.color,
      required this.title,
      required this.subtile})
      : super(key: key);

  final IconData? icon;
  final Color? color;
  final String title;
  final String subtile;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: color_template().primary,
            borderRadius: border_radius().header_border,
            boxShadow: [shadow().reguler]),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(3),
              margin: EdgeInsets.only(right: 10),
              decoration: BoxDecoration(
                borderRadius: border_radius().header_border,
                color: Colors.white,
              ),
              child: Icon(
                icon,
                size: 50,
                color: color_template().primary,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: font().header_big,
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  subtile,
                  style: font().primary_white,
                )
              ],
            )
          ],
        ));
  }
}
