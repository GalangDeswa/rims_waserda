import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rims_waserda/Modules/user/tambah%20user/view_tambah_user_form.dart';

import 'controller_tambah_user.dart';

class tambah_user extends GetView<tambah_userController> {
  const tambah_user({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();

    final email = TextEditingController();
    return SafeArea(
      //minimum: EdgeInsets.all(10),
      child: Scaffold(
          // backgroundColor: color_template().primary.withOpacity(0.2),
          // appBar: appbar_custom(
          //     height: 50,
          //     child: Text(
          //       'Tambah user',
          //       style: font().header,
          //     )),
          body: tambah_user_form()),
    );
  }
}
