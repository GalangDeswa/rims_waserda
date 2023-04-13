import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:rims_waserda/Modules/Widgets/popup.dart';

import '../../../Templates/setting.dart';
import '../../Widgets/buttons.dart';
import '../../Widgets/header.dart';
import '../../Widgets/loading.dart';
import 'controller_data_user.dart';
import 'model_data_user.dart';

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
                        iscenter: false,
                        title: 'Data User',
                        icon: Icons.add_box,
                        icon_funtion: Icons.refresh,
                        function: () {
                          controller.onInit();
                        },
                      ),
                    ),
                  ),
                  button_solid_custom(
                      onPressed: () {
                        //karna beda kontroller dari kontroller untuk fect ?pertama?
                        //tidak ke refresh
                        //karna kontrollernya close ketika getdialog back?
                        Get.toNamed('/tambah_user');
                        // Get.dialog(Container(
                        //     padding: EdgeInsets.all(50),
                        //     child: tambah_user_form()));
                      },
                      child: Text(
                        'Tambah user',
                        style: font().header,
                      ),
                      width: context.width_query * 0.2,
                      height: 65)
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
            Expanded(
              child: Obx(() {
                var source = userTable(controller.listUser.value).obs;
                return Container(
                    // height: context.height_query * 0.46,
                    margin: EdgeInsets.only(top: 10),
                    // width: double.infinity,
                    child: controller.listUser.value.isEmpty
                        ? Container(
                            width: 100, height: 100, child: showloading())
                        : DataTable2(
                            horizontalMargin: 10,
                            //minWidth: 1000,
                            //minWidth: 10,
                            //fit: FlexFit.loose,
                            columnSpacing: 5,

                            headingRowColor: MaterialStateColor.resolveWith(
                                (states) =>
                                    color_template().primary.withOpacity(0.2)),
                            rows: List.generate(
                                controller.listUser.length,
                                (index) => DataRow(cells: [
                                      DataCell(Text(
                                          controller.listUser[index].nama)),
                                      DataCell(Text(
                                          controller.listUser[index].email)),
                                      DataCell(
                                          Text(controller.listUser[index].hp)),
                                      DataCell(Text(
                                          controller.listUser[index].role == '1'
                                              ? "Kasir"
                                              : controller.listUser[index]
                                                          .role ==
                                                      '2'
                                                  ? 'Admin'
                                                  : '-')),
                                      DataCell(Center(
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: IconButton(
                                                  onPressed: () {
                                                    Get.toNamed('/edit_user',
                                                        arguments: controller
                                                            .listUser[index]);
                                                  },
                                                  icon: Icon(
                                                    Icons.edit,
                                                    size: 18,
                                                    color: color_template()
                                                        .secondary,
                                                  )),
                                            ),
                                            Expanded(
                                              child: IconButton(
                                                  onPressed: () {
                                                    popscreen().deleteuser(
                                                        controller,
                                                        controller
                                                            .listUser[index]);
                                                  },
                                                  icon: Icon(
                                                    Icons.delete,
                                                    size: 18,
                                                    color: color_template()
                                                        .tritadery,
                                                  )),
                                            )
                                          ],
                                        ),
                                      )),
                                    ])),
                            empty: Center(
                              child: Text(
                                "Data Kosong",
                                style: font().header_black,
                              ),
                            ),
                            columns: const <DataColumn>[
                              DataColumn(
                                label: Text(
                                  'Nama',
                                  style: TextStyle(fontStyle: FontStyle.italic),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'Email',
                                  style: TextStyle(fontStyle: FontStyle.italic),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'No.HP',
                                  style: TextStyle(fontStyle: FontStyle.italic),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'Role',
                                  style: TextStyle(fontStyle: FontStyle.italic),
                                ),
                              ),
                              DataColumn(
                                label: Center(
                                  child: Text(
                                    'Aksi',
                                    style:
                                        TextStyle(fontStyle: FontStyle.italic),
                                  ),
                                ),
                              ),
                            ],
                          ));
              }),
            ),
            Obx(() {
              return Container(
                margin: EdgeInsets.only(left: context.width_query / 1.9),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text('Data perbaris :'),
                    Text(controller.perpage.value.toString()),
                    controller.currentpage > 1
                        ? IconButton(
                            onPressed: () {
                              controller.back();
                            },
                            icon: Icon(FontAwesomeIcons.angleLeft, size: 20))
                        : IconButton(
                            onPressed: null,
                            icon: Icon(
                              FontAwesomeIcons.angleLeft,
                              size: 20,
                              color: Colors.grey,
                            )),
                    Text(controller.currentpage.value.toString() +
                        ' - ' +
                        controller.totalpage.value.toString()),
                    controller.currentpage < controller.totalpage.value
                        ? IconButton(
                            onPressed: () {
                              controller.next();
                            },
                            icon: Icon(
                              FontAwesomeIcons.angleRight,
                              size: 20,
                            ))
                        : IconButton(
                            onPressed: null,
                            icon: Icon(
                              FontAwesomeIcons.angleRight,
                              color: Colors.grey,
                              size: 20,
                            ))
                  ],
                ),
              );
            })
          ],
        ),
      ),
    );
  }
}

class userTable extends DataTableSource {
  final List<DataUser> data;

  userTable(this.data);

  var con = Get.find<datauserController>();

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => data.length;

  @override
  int get selectedRowCount => 0;

  @override
  DataRow getRow(int index) {
    return DataRow(cells: [
      DataCell(Text(data[index].nama)),
      DataCell(Text(data[index].email)),
      DataCell(Text(data[index].hp)),
      DataCell(Text(data[index].role == '1'
          ? "Kasir"
          : data[index].role == '2'
              ? 'Admin'
              : '-')),
      DataCell(Center(
        child: Row(
          children: [
            Expanded(
              child: IconButton(
                  onPressed: () {
                    Get.toNamed('/edit_user', arguments: data[index]);
                  },
                  icon: Icon(
                    Icons.edit,
                    size: 18,
                    color: color_template().secondary,
                  )),
            ),
            Expanded(
              child: IconButton(
                  onPressed: () {
                    popscreen().deleteuser(con, data[index]);
                  },
                  icon: Icon(
                    Icons.delete,
                    size: 18,
                    color: color_template().tritadery,
                  )),
            )
          ],
        ),
      )),
    ]);
  }
}
