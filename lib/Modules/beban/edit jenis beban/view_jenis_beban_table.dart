import 'package:data_table_2/data_table_2.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rims_waserda/Modules/Widgets/card_custom.dart';
import 'package:rims_waserda/Modules/Widgets/popup.dart';
import 'package:rims_waserda/Modules/beban/edit%20jenis%20beban/model_jenis_beban.dart';

import '../../../Templates/setting.dart';
import '../../Widgets/buttons.dart';
import '../../Widgets/header.dart';
import '../../Widgets/loading.dart';
import '../data beban/controller_beban.dart';

class jenis_beban_table extends GetView<bebanController> {
  const jenis_beban_table({Key? key}) : super(key: key);

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
              padding: const EdgeInsets.only(top: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 50),
                      child: header(
                        iscenter: false,
                        title: 'Kategori Beban',
                        icon: Icons.add_box,
                        icon_funtion: Icons.refresh,
                        function: () {
                          Get.dialog(showloading());
                          controller.fetchJenisBebanlocal(controller.id_toko);
                          Get.back();

                          print('-----snack------');
                        },
                      ),
                    ),
                  ),
                  button_solid_custom(
                      onPressed: () {
                        Get.toNamed('/tambah_jenis_beban');

                        // Get.dialog(SingleChildScrollView(
                        //   child: AlertDialog(
                        //       elevation: 0,
                        //       backgroundColor: Colors.transparent,
                        //       content: Center(
                        //         child: Container(
                        //             width: context.width_query / 1.3,
                        //             child: tambah_produk_form()),
                        //       )),
                        // ));
                      },
                      child: Text(
                        'Tambah kategori beban'.toUpperCase(),
                        style: font().header,
                      ),
                      width: context.width_query * 0.2,
                      height: 65)
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),

            Expanded(
              child: Obx(() {
                var source =
                    kategoriBebanTable(controller.jenisbebanlistlocal, context)
                        .obs;
                return Container(
                  // height: context.height_query * 0.46,
                  margin: const EdgeInsets.only(top: 10),
                  // width: double.infinity,
                  child: controller.succ == false
                      ? Container(
                          width: 100, height: 100, child: const showloading())
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

                          columns: <DataColumn>[
                            DataColumn(
                              label: Text(
                                'Kategori Beban',
                                style: font().reguler,
                              ),
                            ),

                            // DataColumn(
                            //   label: Expanded(
                            //     child: Text(
                            //       'img',
                            //       style: TextStyle(fontStyle: FontStyle.italic),
                            //     ),
                            //   ),
                            // ),
                            DataColumn(
                              label: Center(
                                child: Text(
                                  'Aksi',
                                  style: font().reguler,
                                ),
                              ),
                            ),
                          ],
                          source: source.value,
                          empty: Center(
                            child: Text(
                              "Data Kosong",
                              style: font().header_black,
                            ),
                          ),
                        ),
                );
              }),
            ),
            // Obx(() {
            //   return Container(
            //     margin: EdgeInsets.only(left: context.width_query / 1.9),
            //     child: Row(
            //       mainAxisAlignment: MainAxisAlignment.spaceAround,
            //       children: [
            //         const Text('Data perbaris :'),
            //         Text(controller.perpagejenis.value.toString()),
            //         controller.currentpagejenis > 1
            //             ? IconButton(
            //                 onPressed: () {
            //                   controller.backjenis();
            //                 },
            //                 icon: const Icon(FontAwesomeIcons.angleLeft,
            //                     size: 20))
            //             : const IconButton(
            //                 onPressed: null,
            //                 icon: Icon(
            //                   FontAwesomeIcons.angleLeft,
            //                   size: 20,
            //                   color: Colors.grey,
            //                 )),
            //         Text(controller.currentpagejenis.value.toString() +
            //             ' - ' +
            //             controller.totalpagejenis.value.toString()),
            //         controller.currentpagejenis <
            //                 controller.totalpagejenis.value
            //             ? IconButton(
            //                 onPressed: () {
            //                   controller.nextjenis();
            //                 },
            //                 icon: const Icon(
            //                   FontAwesomeIcons.angleRight,
            //                   size: 20,
            //                 ))
            //             : const IconButton(
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

class kategoriBebanTable extends DataTableSource {
  final List<DataJenisBeban> data;
  final BuildContext context;

  kategoriBebanTable(this.data, this.context);

  //var con = Get.find<editjenisbebanController>();
  //var con = Get.put(editjenisbebanController());
  var con = Get.find<bebanController>();

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
        data[index].kategori!,
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
  static const List<MenuItem> firstItems = [edit];
  static const List<MenuItem> secondItems = [hapus];

  static const edit =
      MenuItem(text: 'Edit kategori beban', icon: Icons.edit, iconcolor: false);
  static const hapus = MenuItem(
      text: 'Hapus kategori beban', icon: Icons.delete, iconcolor: true);

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

  static void onChanged(
      BuildContext context, MenuItem item, DataJenisBeban data) {
    var con = Get.find<bebanController>();
    switch (item) {
      case MenuItems.edit:
        print('edit');
        Get.toNamed('/edit_jenis_beban', arguments: data);
        break;
      case MenuItems.hapus:
        popscreen().deletejenisbeban(con, data);
        break;
    }
  }
}
