import 'package:flutter/material.dart';

import 'package:rims_waserda/Controllers/Templates/setting.dart';

class dasboard_app_card extends StatelessWidget {
  const dasboard_app_card(
      {Key? key,
      required this.function,
      required this.color,
      required this.icon,
      this.icon_size,
      required this.label})
      : super(key: key);

  final Function() function;
  final Color color;
  final IconData icon;
  final String label;
  final double? icon_size;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: function,
          splashColor: color_template().select,
          highlightColor: Colors.orange,
          borderRadius: BorderRadius.circular(10),
          child: Ink(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: color_template().primary,
            ),
            child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: color.withOpacity(0.0),
                    borderRadius: BorderRadius.circular(10)),
                child: Icon(
                  icon,
                  size: icon_size == null ? 80 : icon_size,
                  color: Colors.white,
                )),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          label,
          style: font().header_black,
        )
      ],
    );
  }
}
