import 'package:flutter/material.dart';
import 'package:get/get.dart';


import '../../Controllers/Templates/setting.dart';
import '../../Controllers/detail produk controller/detail_produk_controller.dart';
import '../Widgets/appbar.dart';
import '../Widgets/header.dart';
import 'detail produk_gambar.dart';
import 'detail_produk_list.dart';

class detail_Produk extends GetView<detail_produkController> {
  const detail_Produk({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: color_template().base_blue,
      appBar: appbar_custom(
          height: 50,
          child: Text(
            'Detail Produk',
            style: font().header,
          )),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              header(
                title: 'Detail produk',
                icon: Icons.add,
              ),
              Card(
                margin: EdgeInsets.symmetric(horizontal: 100),
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  child: Form(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [detail_produk_gambar(), detail_produk_list()],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    ));
  }
}
