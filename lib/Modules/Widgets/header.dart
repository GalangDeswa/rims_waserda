import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../Templates/setting.dart';

class header extends StatelessWidget {
  const header(
      {Key? key,
      this.base_color,
      this.title,
      this.icon,
      this.function,
      this.icon_color,
      this.icon_funtion,
      this.iscenter})
      : super(key: key);
  final Color? base_color, icon_color;
  final String? title;
  final IconData? icon, icon_funtion;
  final bool? iscenter;

  //final IconButton? button;
  final Function()? function;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: base_color == null ? color_template().primary : base_color,
            borderRadius: border_radius().header_border),
        child: iscenter == false
            ? Row(
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
                            color: icon_color == null
                                ? color_template().primary
                                : icon_color,
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
                  function == null
                      ? Container()
                      : Container(
                          decoration: BoxDecoration(
                              color: Colors.white, shape: BoxShape.circle),
                          child: IconButton(
                              color: color_template().primary,
                              onPressed: () {
                                function!();
                              },
                              icon: Icon(icon_funtion)),
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
              )
            : Row(
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
                        color: icon_color == null
                            ? color_template().primary
                            : icon_color,
                      )),
                  Text(
                    title!,
                    style: font().header_big,
                  ),
                  function == null
                      ? Container()
                      : Container(
                          decoration: BoxDecoration(
                              color: Colors.white, shape: BoxShape.circle),
                          child: IconButton(
                              color: color_template().primary,
                              onPressed: () {
                                function!();
                              },
                              icon: Icon(icon_funtion)),
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
              ));
  }
}
