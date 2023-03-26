import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rims_waserda/Modules/beban/data%20beban/controller_beban.dart';
import 'package:rims_waserda/Modules/beban/data%20beban/view_tambah_beban.dart';

import '../../../Templates/setting.dart';
import '../../Widgets/stack bg.dart';

class tambah_beban_base extends GetView<bebanController> {
  const tambah_beban_base({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      // minimum: EdgeInsets.all(5),
      child: Scaffold(
        backgroundColor: color_template().base_blue,
        // appBar: appbar_custom(
        //     height: 50,
        //     child: Text(
        //       'Tambah Produk',
        //       style: font().header,
        //     )),
        body: stack_bg(
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: tambah_beban(),
          ),
        ),
      ),
    );
  }
}
