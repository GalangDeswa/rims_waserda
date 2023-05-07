import 'package:flutter/material.dart';

import '../../Templates/setting.dart';

class dashboard_app_card_v2 extends StatelessWidget {
  const dashboard_app_card_v2(
      {Key? key,
      required this.function,
      required this.color,
      required this.label,
      required this.icon})
      : super(key: key);

  final Function() function;
  final Color color;

  final String label;
  final Widget icon;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: border_radius().icon_border,
        // side: BorderSide(color: color_template().primary, width: 3.5),
      ),
      elevation: elevation().def_elevation,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            InkWell(
              onTap: function,
              splashColor: color_template().select,
              highlightColor: Colors.orange,
              borderRadius: BorderRadius.circular(10),
              child: Ink(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  // color: color_template().primary,
                ),
                child: Container(
                    padding: EdgeInsets.all(10),
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(10)),
                    child: icon),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              label,
              style: font().reguler,
            )
          ],
        ),
      ),
    );
  }
}
