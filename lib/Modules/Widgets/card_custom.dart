import 'package:flutter/material.dart';

import '../../Templates/setting.dart';

class Card_custom extends StatelessWidget {
  const Card_custom({Key? key, required this.child, this.border})
      : super(key: key);

  final Widget child;
  final bool? border;

  @override
  Widget build(BuildContext context) {
    return border == false
        ? Card(
            elevation: elevation().def_elevation,
            //margin: EdgeInsets.all(30),
            shape: RoundedRectangleBorder(
              borderRadius: border_radius().def_border,

              // side: BorderSide(color: color_template().primary, width: 3.5),
            ),
            child: child)
        : Card(
            elevation: elevation().def_elevation,
            //margin: EdgeInsets.all(30),
            shape: RoundedRectangleBorder(
              borderRadius: border_radius().def_border,
              side: BorderSide(color: color_template().primary, width: 3.5),
            ),
            child: child);
  }
}
