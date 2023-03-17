import 'package:flutter/material.dart';

import '../../Templates/setting.dart';

class appbar_custom extends StatelessWidget implements PreferredSizeWidget {
  final Widget? child;
  final double height;

  appbar_custom({
    this.child,
    this.height = kToolbarHeight,
  });

  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
          boxShadow: [shadow().reguler],
          color: color_template().primary,
          borderRadius: BorderRadius.circular(10)),
      height: preferredSize.height,
      alignment: Alignment.centerLeft,
      child: child,
    );
  }
}
