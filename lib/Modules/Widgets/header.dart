import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../Templates/setting.dart';

class header extends StatelessWidget {
  const header(
      {Key? key, this.base_color, this.title, this.icon, this.function})
      : super(key: key);
  final Color? base_color;
  final String? title;
  final IconData? icon;

  //final IconButton? button;
  final Function()? function;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: color_template().primary,
          borderRadius: border_radius().header_border),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: FaIcon(
                    icon!,
                    size: 23,
                    color: color_template().primary,
                  )),
              SizedBox(
                width: 20,
              ),
              Text(
                title!,
                style: font().header_big,
              ),
            ],
          ),
          Container(
            decoration:
                BoxDecoration(color: Colors.white, shape: BoxShape.circle),
            child: IconButton(
                color: color_template().primary,
                onPressed: () {
                  function!();
                },
                icon: Icon(Icons.refresh)),
          )
          // button_solid_custom(
          //     onPressed: () {
          //       Get.toNamed('/tambah_produk');
          //     },
          //     child: Text(
          //       'tambah produk',
          //       style: font().header,
          //     ),
          //     width: context.width_query * 0.2,
          //     height: 55)
        ],
      ),
    );
  }
}
