import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:rims_waserda/Views/produk/produk_table.dart';


import '../../Controllers/Templates/setting.dart';
import '../../Controllers/produk controller/produk_controller.dart';
import '../Widgets/appbar.dart';

class produk extends GetView<produkController> {
  const produk({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();

    final email = TextEditingController();
    return SafeArea(
      minimum: EdgeInsets.all(10),
      child: Scaffold(
          backgroundColor: color_template().primary.withOpacity(0.2),
          appBar: appbar_custom(
              height: 50,
              child: Text(
                'Produk',
                style: font().header,
              )),
          body: Center(child: produk_table())),
    );
  }
}
