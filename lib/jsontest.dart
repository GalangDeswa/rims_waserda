import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'jsontestController.dart';

class jsontest extends GetView<jsontestController> {
  const jsontest({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            Container(
              width: 300,
              height: 250,
              color: Colors.red,
              child: Obx(() {
                return ListView.builder(
                    padding: const EdgeInsets.all(8),
                    itemCount: controller.produk_list.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                          height: 50,
                          width: 100,
                          color: Colors.white,
                          child: Center(
                            child:
                                Text(controller.produk_list[index].namaProduk),
                          ));
                    });
              }),
            ),
            IconButton(
                onPressed: () {
                  controller.onInit();
                },
                icon: Icon(Icons.abc))
          ],
        ),
      ),
    );
  }
}
