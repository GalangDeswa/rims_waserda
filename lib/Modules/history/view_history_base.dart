import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rims_waserda/Modules/history/view_history%20table.dart';

import '../../Templates/setting.dart';
import '../Widgets/stack bg.dart';
import 'Controller_history.dart';

class history extends GetView<historyController> {
  const history({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        //minimum: EdgeInsets.all(10),
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: color_template().primary.withOpacity(0.2),
            //backgroundColor: Colors.white,
            // appBar: appbar_custom(
            //     height: context.height_query / 12,
            //     child: Text(
            //       'History',
            //       style: font().header,
            //     )),
            body: stack_bg(
              isfullscreen: true,
              child: history_table(),
            )));
  }
}
