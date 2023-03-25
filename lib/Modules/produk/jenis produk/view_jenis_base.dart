import 'package:flutter/material.dart';
import 'package:rims_waserda/Modules/produk/jenis%20produk/view_jenis_table.dart';

import '../../../Templates/setting.dart';
import '../../Widgets/stack bg.dart';

class jenis_produk extends StatelessWidget {
  const jenis_produk({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      //minimum: EdgeInsets.all(10),
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: color_template().primary.withOpacity(0.2),
          // appBar: appbar_custom(
          //     height: 50,
          //     child: Text(
          //       'Produk',
          //       style: font().header,
          //     )),
          body: stack_bg(
            child: Padding(
              padding: const EdgeInsets.all(30),
              child: jenis_table(),
            ),
          )),
    );
  }
}
