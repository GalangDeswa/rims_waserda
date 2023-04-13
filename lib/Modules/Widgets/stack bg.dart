import 'package:flutter/material.dart';

class stack_bg extends StatelessWidget {
  const stack_bg({Key? key, required this.child, this.isfullscreen})
      : super(key: key);
  final Widget child;

  // final double? padding;
  final bool? isfullscreen;

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/bg_login.png'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.3), BlendMode.dstATop),
          ),
        ),
      ),
      Center(
          child: isfullscreen == true
              ? Padding(padding: EdgeInsets.all(10), child: child)
              : Padding(padding: EdgeInsets.all(30), child: child))
    ]);
  }
}
