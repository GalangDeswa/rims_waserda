import 'package:data_table_2/data_table_2.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:rims_waserda/Modules/Widgets/card_custom.dart';
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
    return Card_custom(
      border: false,
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
                        icon: FontAwesomeIcons.userGear,
                        icon_funtion: Icons.refresh,
                        function: () async {
                          Get.dialog(showloading(), barrierDismissible: false);
                          await controller.userdata();
                          Get.back();
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
                        'Tambah user'.toUpperCase(),
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
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceAround,
            //   children: [
            //     Expanded(
            //       child: Container(
            //         margin: EdgeInsets.symmetric(horizontal: 3),
            //         //width: 200,
            //         child: TextFormField(
            //           //controller: email,
            //           onChanged: ((String pass) {}),
            //           decoration: InputDecoration(
            //             icon: Icon(Icons.add_box),
            //             labelText: "cari user",
            //             labelStyle: TextStyle(
            //               color: Colors.black87,
            //             ),
            //             border: UnderlineInputBorder(
            //                 borderRadius: BorderRadius.circular(10)),
            //             focusedBorder: OutlineInputBorder(
            //                 borderRadius: BorderRadius.circular(10)),
            //           ),
            //           textAlign: TextAlign.center,
            //           validator: (value) {
            //             if (value!.isEmpty) {
            //               return 'Please enter email';
            //             }
            //             return null;
            //           },
            //         ),
            //       ),
            //     ),
            //     icon_button_custom(
            //         onPressed: () {
            //           // controller.getprodukall();
            //         },
            //         icon: Icons.search,
            //         container_color: color_template().primary),
            //   ],
            // ),
            Expanded(
              child: Obx(() {
                var source = userTable(controller.listUser.value, context).obs;
                return Container(
                    // height: context.height_query * 0.46,
                    margin: EdgeInsets.only(top: 10),
                    // width: double.infinity,
                    child: controller.listUser.value.isEmpty
                        ? Container(
                            width: 100, height: 100, child: showloading())
                        : PaginatedDataTable2(
                            horizontalMargin: 10,
                            //minWidth: 1000,
                            //minWidth: 10,
                            //fit: FlexFit.loose,
                            renderEmptyRowsInTheEnd: false,
                            wrapInCard: false,
                            columnSpacing: 0,
                            headingRowColor: MaterialStateColor.resolveWith(
                                (states) =>
                                    color_template().primary.withOpacity(0.2)),
                            source: source.value,
                            empty: Center(
                              child: Text(
                                "Data Kosong",
                                style: font().header_black,
                              ),
                            ),
                            columns: <DataColumn>[
                              DataColumn(
                                label: Text(
                                  'Nama',
                                  style: font().reguler,
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'Email',
                                  style: font().reguler,
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'No.HP',
                                  style: font().reguler,
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'Role',
                                  style: font().reguler,
                                ),
                              ),
                              DataColumn(
                                label: Center(
                                  child: Text(
                                    'Aksi',
                                    style: font().reguler,
                                  ),
                                ),
                              ),
                            ],
                          ));
              }),
            ),
            // Obx(() {
            //   return Container(
            //     margin: EdgeInsets.only(left: context.width_query / 1.9),
            //     child: Row(
            //       mainAxisAlignment: MainAxisAlignment.spaceAround,
            //       children: [
            //         Text('Data perbaris :'),
            //         Text(controller.perpage.value.toString()),
            //         controller.currentpage > 1
            //             ? IconButton(
            //                 onPressed: () {
            //                   controller.back();
            //                 },
            //                 icon: Icon(FontAwesomeIcons.angleLeft, size: 20))
            //             : IconButton(
            //                 onPressed: null,
            //                 icon: Icon(
            //                   FontAwesomeIcons.angleLeft,
            //                   size: 20,
            //                   color: Colors.grey,
            //                 )),
            //         Text(controller.currentpage.value.toString() +
            //             ' - ' +
            //             controller.totalpage.value.toString()),
            //         controller.currentpage < controller.totalpage.value
            //             ? IconButton(
            //                 onPressed: () {
            //                   controller.next();
            //                 },
            //                 icon: Icon(
            //                   FontAwesomeIcons.angleRight,
            //                   size: 20,
            //                 ))
            //             : IconButton(
            //                 onPressed: null,
            //                 icon: Icon(
            //                   FontAwesomeIcons.angleRight,
            //                   color: Colors.grey,
            //                   size: 20,
            //                 ))
            //       ],
            //     ),
            //   );
            // })
          ],
        ),
      ),
    );
  }
}

class userTable extends DataTableSource {
  final List<DataUser> data;
  final BuildContext context;

  userTable(this.data, this.context);

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
      DataCell(Text(
        data[index].nama,
        style: font().reguler,
        overflow: TextOverflow.ellipsis,
      )),
      DataCell(Text(
        data[index].email,
        style: font().reguler,
        overflow: TextOverflow.ellipsis,
      )),
      DataCell(Text(
        data[index].hp,
        style: font().reguler,
        overflow: TextOverflow.ellipsis,
      )),
      DataCell(Text(
        data[index].role == '1'
            ? "Kasir"
            : data[index].role == '2'
                ? 'Admin'
                : '-',
        style: font().reguler,
        overflow: TextOverflow.ellipsis,
      )),
      DataCell(Container(
        child: Center(
          child: DropdownButton2(
            customButton: const Icon(
              Icons.list,
            ),
            items: [
              ...MenuItems.firstItems.map(
                (item) => DropdownMenuItem<MenuItem>(
                  value: item,
                  child: MenuItems.buildItem(item),
                ),
              ),
              const DropdownMenuItem<Divider>(enabled: false, child: Divider()),
              ...MenuItems.secondItems.map(
                (item) => DropdownMenuItem<MenuItem>(
                  value: item,
                  child: MenuItems.buildItem(item),
                ),
              ),
            ],
            onChanged: (value) {
              MenuItems.onChanged(context, value! as MenuItem, data[index]);
            },
            dropdownStyleData: DropdownStyleData(
              width: 160,
              padding: const EdgeInsets.symmetric(vertical: 6),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
              ),
              offset: const Offset(0, 8),
            ),
            menuItemStyleData: MenuItemStyleData(
              customHeights: [
                ...List<double>.filled(MenuItems.firstItems.length, 48),
                8,
                ...List<double>.filled(MenuItems.secondItems.length, 48),
              ],
              padding: const EdgeInsets.only(left: 16, right: 16),
            ),
          ),
        ),
      )),
    ]);
  }
}

class MenuItem {
  const MenuItem({
    required this.text,
    required this.icon,
    this.iconcolor,
  });

  final String text;
  final IconData icon;
  final bool? iconcolor;
}

abstract class MenuItems {
  static const List<MenuItem> firstItems = [edit, editpass];
  static const List<MenuItem> secondItems = [hapus];

  static const edit =
      MenuItem(text: 'Edit user', icon: Icons.edit, iconcolor: false);
  static const editpass =
      MenuItem(text: 'Edit password', icon: Icons.lock, iconcolor: false);
  static const hapus =
      MenuItem(text: 'Hapus user', icon: Icons.delete, iconcolor: true);

  static Widget buildItem(MenuItem item) {
    return Row(
      children: [
        Icon(item.icon,
            color: item.iconcolor == false
                ? color_template().primary_dark
                : color_template().tritadery,
            size: 22),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: Text(
            item.text,
            style: font().reguler,
          ),
        ),
      ],
    );
  }

  static void onChanged(BuildContext context, MenuItem item, DataUser data) {
    var con = Get.find<datauserController>();
    switch (item) {
      case MenuItems.edit:
        print('edit');
        Get.toNamed('/edit_user', arguments: data);
        break;
      case MenuItems.editpass:
        Get.toNamed('/edit_user_password', arguments: data);
        break;
      case MenuItems.hapus:
        popscreen().deleteuser(con, data);
        break;
    }
  }
}
