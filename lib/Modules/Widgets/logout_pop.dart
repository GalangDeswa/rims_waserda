import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:rims_waserda/Modules/Widgets/buttons.dart';

import '../../Templates/setting.dart';
import 'header.dart';

class logout_pop extends StatelessWidget {
  const logout_pop({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      content: Padding(
        padding: EdgeInsets.all(15),
        child: Container(
          width: context.width_query / 2.3,
          height: context.height_query / 2.3,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              header(
                title: 'Logout',
                icon: Icons.logout,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  "Anda Ingin Logout?",
                  style: font().primary_dark,
                ),
              ),
              button_solid_custom(
                child: Text(
                  'Logout',
                  style: font().primary_white,
                ),
                width: context.width_query,
                height: context.height_query / 13,
                onPressed: () async {
                  await GetStorage().erase();
                  Get.offAndToNamed('/login');
                },
              ),
              button_border_custom(
                child: Text(
                  'batal',
                  style: font().primary,
                ),
                width: context.width_query,
                height: context.height_query / 13,
                onPressed: () {
                  Get.back();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
