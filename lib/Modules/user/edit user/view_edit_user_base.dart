import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rims_waserda/Modules/user/edit%20user/controller_edit_user.dart';
import 'package:rims_waserda/Modules/user/edit%20user/view_edit_user_form.dart';

import '../../../Templates/setting.dart';
import '../../Widgets/stack bg.dart';

class edit_user extends GetView<edituserController> {
  const edit_user({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      //minimum: EdgeInsets.all(10),
      child: Scaffold(
          // backgroundColor: color_template().primary.withOpacity(0.2),
          // appBar: appbar_custom(
          //     height: 50,
          //     child: Text(
          //       'Produk',
          //       style: font().header,
          //     )),
          body: stack_bg(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: edit_user_form(),
        ),
      )),
    );
  }
}
