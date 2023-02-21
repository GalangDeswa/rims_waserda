import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';


import '../../Controllers/Templates/setting.dart';
import '../../Controllers/pilih toko controller/pilih_toko_controller.dart';
import '../Widgets/appbar.dart';

class pilih_toko extends GetView<pilih_tokoController> {
  const pilih_toko({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: appbar_custom(
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Pilih Toko',
                style: font().header,
              ),
              IconButton(
                  onPressed: () {
                    controller.refresh();
                  },
                  icon: Icon(
                    Icons.refresh,
                    color: Colors.white,
                  ))
            ],
          )),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 400,
              width: 450,
              child: ListView.builder(
                  itemCount: controller.toko.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        print(controller.toko[index]['_id']);
                        GetStorage().write('toko_user', controller.toko[index]);

                        Get.toNamed('/base_menu',
                            arguments: controller.toko[index]);
                      },
                      child: Card(
                        margin: EdgeInsets.symmetric(vertical: 10),
                        child: Container(
                          margin: EdgeInsets.symmetric(vertical: 10),
                          child: ListTile(
                            title: Text(controller.toko[index]['nama']),
                            subtitle: Text(controller.toko[index]['alamat']),
                            leading: Icon(Icons.home),
                          ),
                        ),
                      ),
                    );
                  }),
            )
          ],
        ),
      ),
    ));
  }
}
