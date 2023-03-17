import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rims_waserda/Controllers/history%20controller/historyController.dart';
import 'package:rims_waserda/Views/Widgets/stack%20bg.dart';
import 'package:rims_waserda/Views/history/history%20table.dart';

import '../../Controllers/Templates/setting.dart';

class history extends GetView<historyController> {
  const history({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        //minimum: EdgeInsets.all(10),
        child: Scaffold(
            backgroundColor: color_template().primary.withOpacity(0.2),
            //backgroundColor: Colors.white,
            // appBar: appbar_custom(
            //     height: context.height_query / 12,
            //     child: Text(
            //       'History',
            //       style: font().header,
            //     )),
            body: stack_bg(
              child: Padding(
                padding: const EdgeInsets.all(30),
                child: history_table(),
              ),
            )));
  }
}
