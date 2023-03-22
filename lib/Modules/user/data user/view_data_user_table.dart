import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rims_waserda/Modules/Widgets/popup.dart';
import 'package:rims_waserda/Modules/user/edit%20user/controller_edit_user.dart';
import 'package:rims_waserda/Modules/user/edit%20user/view_edit_user_form.dart';
import 'package:rims_waserda/Modules/user/edit%20user/view_edit_user_password.dart';
import 'package:rims_waserda/Modules/user/tambah%20user/view_tambah_user_form.dart';

import '../../../Templates/setting.dart';
import '../../Widgets/buttons.dart';
import '../../Widgets/header.dart';
import 'controller_data_user.dart';

class table_user extends GetView<datauserController> {
  const table_user({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: elevation().def_elevation,
      //margin: EdgeInsets.all(30),
      shape: RoundedRectangleBorder(
        borderRadius: border_radius().def_border,
        side: BorderSide(color: color_template().primary, width: 3.5),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 50),
                      child: header(
                        title: 'Data User',
                        icon: Icons.add_box,
                        function: () {
                          controller.onInit();
                        },
                      ),
                    ),
                  ),
                  button_solid_custom(
                      onPressed: () {
                        //Get.toNamed('/tambah_user');
                        Get.dialog(Container(
                            padding: EdgeInsets.all(50),
                            child: tambah_user_form()));
                      },
                      child: Text(
                        'tambah user',
                        style: font().header,
                      ),
                      width: context.width_query * 0.2,
                      height: 55)
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 3),
                    //width: 200,
                    child: TextFormField(
                      //controller: email,
                      onChanged: ((String pass) {}),
                      decoration: InputDecoration(
                        icon: Icon(Icons.add_box),
                        labelText: "cari user",
                        labelStyle: TextStyle(
                          color: Colors.black87,
                        ),
                        border: UnderlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      textAlign: TextAlign.center,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter email';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                icon_button_custom(
                    onPressed: () {
                      // controller.getprodukall();
                    },
                    icon: Icons.search,
                    container_color: color_template().primary),
              ],
            ),
            Container(
              height: context.height_query * 0.46,
              margin: EdgeInsets.only(top: 15),
              width: double.infinity,
              child: SingleChildScrollView(
                  child: GetBuilder<datauserController>(builder: (con) {
                return DataTable(
                    columns: const <DataColumn>[
                      DataColumn(
                        label: Expanded(
                          child: Text(
                            'Nama',
                            style: TextStyle(fontStyle: FontStyle.italic),
                          ),
                        ),
                      ),
                      DataColumn(
                        label: Expanded(
                          child: Text(
                            'Email',
                            style: TextStyle(fontStyle: FontStyle.italic),
                          ),
                        ),
                      ),
                      DataColumn(
                        label: Expanded(
                          child: Text(
                            'No.HP',
                            style: TextStyle(fontStyle: FontStyle.italic),
                          ),
                        ),
                      ),
                      DataColumn(
                        label: Expanded(
                          child: Text(
                            'Role',
                            style: TextStyle(fontStyle: FontStyle.italic),
                          ),
                        ),
                      ),
                      DataColumn(
                        label: Expanded(
                          child: Center(
                            child: Text(
                              'Aksi',
                              style: TextStyle(fontStyle: FontStyle.italic),
                            ),
                          ),
                        ),
                      ),
                    ],
                    rows: List.generate(con.listUser.length, (index) {
                      return DataRow(cells: [
                        DataCell(Container(
                          child: Text(con.listUser[index].nama != null
                              ? con.listUser[index].nama
                              : '-'),
                        )),
                        DataCell(Container(
                          child: Text(con.listUser[index].email != null
                              ? con.listUser[index].email
                              : '-'),
                        )),
                        DataCell(Container(
                            child: Text(con.listUser[index].hp != null
                                ? con.listUser[index].hp
                                : '-'))),
                        DataCell(Container(
                            child: Text(con.listUser[index].role == '1'
                                ? 'Kasir'
                                : con.listUser[index].role == '2'
                                    ? 'Admin'
                                    : '-'))),
                        DataCell(Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                                onPressed: () {
                                  //Get.put(() => edituserController());
                                  //Get.find<edituserController>();
                                  Get.dialog(
                                      Container(
                                          padding: EdgeInsets.all(50),
                                          child: edit_user_form()),
                                      arguments: con.listUser[index]);

                                  // popscreen().popedituser(
                                  //     context,
                                  //     Get.put(edituserController()),
                                  //     controller.listUser[index]);
                                  // Get.toNamed('/edit_user',
                                  //     arguments: controller.listUser[index]);
                                  // popscreen().popedituserv2(
                                  //     context,
                                  //     Get.put(edituserController()),
                                  //     controller.listUser.value[index]);
                                },
                                icon: Icon(
                                  Icons.edit,
                                  size: 18,
                                )),
                            IconButton(
                                onPressed: () {
                                  Get.dialog(
                                      Container(
                                          padding: EdgeInsets.all(50),
                                          child: edit_user_password()),
                                      arguments:
                                          controller.listUser.value[index]);
                                  // popscreen().popedituserv2(
                                  //     context,
                                  //     Get.put(edituserController()),
                                  //     controller.listUser.value[index]);
                                },
                                icon: Icon(
                                  Icons.lock,
                                  size: 18,
                                )),
                            IconButton(
                                onPressed: () {
                                  popscreen().deleteuser(
                                      context,
                                      edituserController(),
                                      con.listUser.value[index]);
                                },
                                icon: Icon(Icons.delete, size: 18))
                          ],
                        )),
                      ]);
                    }));
              })),
            ),
            SizedBox(
              height: 15,
            )
          ],
        ),
      ),
    );
  }
}
