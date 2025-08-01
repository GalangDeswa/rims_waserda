import 'package:flutter/material.dart';

import '../../Templates/setting.dart';

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
        width: context.width_query / 5,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: color_template().primary,
            borderRadius: border_radius().header_border,
            boxShadow: [shadow().reguler]),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(5),
              margin: EdgeInsets.only(right: 10),
              decoration: BoxDecoration(
                borderRadius: border_radius().header_border,
                color: Colors.white,
              ),
              child: Icon(
                icon,
                size: context.height_query / 15,
                color: color_template().primary,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: font().header_datacard,
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  subtile,
                  style: font().primary_white_datacard,
                )
              ],
            )
          ],
        ));
  }
}
