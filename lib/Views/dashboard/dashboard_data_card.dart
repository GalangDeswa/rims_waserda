import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../Controllers/Templates/setting.dart';

class dashboard_data_card extends StatelessWidget {
  const dashboard_data_card(
      {Key? key,
      required this.icon,
      required this.color,
      required this.label,
      required this.subtitle})
      : super(key: key);

  final IconData icon;
  final Color color;
  final String label, subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(5),
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 35, vertical: 10),
                      decoration: BoxDecoration(
                          color: color.withOpacity(0.6),
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(color: color),
                          boxShadow: [shadow().reguler]),
                      child: Icon(
                        icon,
                        size: 80,
                        color: color_template().primary_dark.withOpacity(0.5),
                      )),
                  Positioned.fill(
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        label,
                        style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
        Padding(
            padding: EdgeInsets.symmetric(vertical: 5),
            child: Text(
              subtitle,
              style: TextStyle(
                fontSize: 20,
              ),
            ))
      ],
    );
  }
}
