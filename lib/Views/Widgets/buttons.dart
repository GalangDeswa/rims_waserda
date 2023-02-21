import 'package:flutter/material.dart';

import '../../Controllers/Templates/setting.dart';

class button_solid_custom extends StatelessWidget {
  const button_solid_custom({
    Key? key,
    required this.onPressed,
    required this.child,
    required this.width,
    required this.height,
  }) : super(key: key);

  final Function() onPressed;
  final Widget child;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: onPressed,
        child: child,
        style:
            ElevatedButton.styleFrom(backgroundColor: color_template().primary),
      ),
    );
  }
}

class button_border_custom extends StatelessWidget {
  const button_border_custom(
      {Key? key,
      required this.onPressed,
      required this.child,
      required this.height,
      required this.width})
      : super(key: key);
  final Function() onPressed;
  final Widget child;
  final double height;
  final double width;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: onPressed,
        child: child,
        style: ElevatedButton.styleFrom(
            side: BorderSide(color: color_template().primary),
            backgroundColor: Colors.white),
      ),
    );
  }
}

class icon_button_custom extends StatelessWidget {
  const icon_button_custom({
    Key? key,
    required this.onPressed,
    required this.icon,
    this.icon_size,
    this.icon_color,
    this.container_color,
    this.border_color,
  }) : super(key: key);

  final Function() onPressed;

  final IconData icon;

  final double? icon_size;
  final Color? icon_color, container_color, border_color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40, height: 40,
      //padding: EdgeInsets.all(5),
      margin: EdgeInsets.all(3),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: container_color,
          border: Border.all(
              color:
                  border_color != null ? border_color! : Colors.transparent)),
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(
          icon,
          size: icon_size,
        ),
        color: icon_color != null ? icon_color! : Colors.white,
      ),
    );
  }
}

class icon_button_circle_custom extends StatelessWidget {
  const icon_button_circle_custom({
    Key? key,
    required this.onPressed,
    required this.icon,
    this.icon_size,
    this.icon_color,
    required this.container_color,
  }) : super(key: key);

  final Function() onPressed;

  final IconData icon;

  final double? icon_size;
  final Color? icon_color, container_color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40, height: 40,
      //padding: EdgeInsets.all(5),
      margin: EdgeInsets.all(3),
      decoration: BoxDecoration(shape: BoxShape.circle, color: container_color),
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(
          icon,
          size: icon_size,
        ),
        color: Colors.white,
      ),
    );
  }
}
