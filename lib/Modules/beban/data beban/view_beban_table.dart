import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:rims_waserda/Modules/Widgets/loading.dart';
import 'package:rims_waserda/Modules/beban/data%20beban/model_data_beban.dart';

import '../../../Templates/setting.dart';
import '../../Widgets/buttons.dart';
import '../../Widgets/header.dart';
import '../../Widgets/popup.dart';
import 'controller_beban.dart';

class beban_table extends GetView<bebanController> {
  const beban_table({Key? key}) : super(key: key);

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
                        title: 'Data Beban',
                        icon: FontAwesomeIcons.dollarSign,
                        icon_funtion: Icons.refresh,
                        function: () async {
                          Get.dialog(Container(
                            width: 300,
                            height: 150,
                            child: showloading(),
                          ));
                          await controller.fetchDataBeban();
                          await controller.fetchJenisBeban();
                          Get.back();
                        },
                      ),
                    ),
                  ),
                  button_solid_custom(
                      onPressed: () {
                        Get.toNamed('/tambah_beban');

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
                        'tambah beban',
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
                Obx(() {
                  return Expanded(
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      //width: 200,
                      child: TextFormField(
                        controller: controller.search.value,
                        onChanged: ((String pass) {
                          controller.fetchDataBeban();
                        }),
                        decoration: InputDecoration(
                          icon: Icon(Icons.add_box),
                          labelText: "cari beban",
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
                  );
                }),
                icon_button_custom(
                    onPressed: () {
                      controller.fetchDataBeban();
                    },
                    icon: Icons.search,
                    container_color: color_template().primary),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    //width: 200,
                    child: TextFormField(
                      controller: controller.searchhariini.value,
                      onChanged: ((String pass) {
                        controller.fetchDataBebanHariIni();
                      }),
                      decoration: InputDecoration(
                        icon: Icon(Icons.edit_calendar_outlined),
                        labelText: "cari beban hari ini",
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
                      controller.fetchDataBebanHariIni();
                    },
                    icon: Icons.search,
                    container_color: color_template().primary),
              ],
            ),
            Expanded(
              child: Container(
                // height: context.height_query / 2.5,
                margin: EdgeInsets.only(top: 12),
                // width: double.infinity,
                child: Obx(() {
                  //untuk paginated table yg pakek data source harus buat var lg di dalam obx
                  //dan di class source nya di buat konstruktor untuk di lembar var data dari kontroller
                  var source = bebanTable(controller.databebanlist.value).obs;
                  return PaginatedDataTable2(
                      horizontalMargin: 10,
                      //minWidth: 1000,
                      //minWidth: 10,
                      //fit: FlexFit.loose,
                      columnSpacing: 5,
                      wrapInCard: false,
                      renderEmptyRowsInTheEnd: false,
                      headingRowColor: MaterialStateColor.resolveWith(
                          (states) =>
                              color_template().primary.withOpacity(0.2)),
                      autoRowsToHeight: true,
                      showFirstLastButtons: true,
                      columns: <DataColumn>[
                        DataColumn(
                          label: Center(
                            child: Text(
                              'Nama Beban',
                              style: TextStyle(fontStyle: FontStyle.italic),
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Center(
                            child: Text(
                              'Keterangan',
                              style: TextStyle(fontStyle: FontStyle.italic),
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Center(
                            child: Text(
                              'Tanggal',
                              style: TextStyle(fontStyle: FontStyle.italic),
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Center(
                            child: Text(
                              'jumlah',
                              style: TextStyle(fontStyle: FontStyle.italic),
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Center(
                            child: Text(
                              'Kategori',
                              style: TextStyle(fontStyle: FontStyle.italic),
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Center(
                            child: Text(
                              'Aksi',
                              style: TextStyle(fontStyle: FontStyle.italic),
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
                      ));
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class bebanTable extends DataTableSource {
  final List<DataBeban> data;

  bebanTable(this.data);

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
      DataCell(Center(child: Text(data[index].nama))),
      DataCell(Center(child: Text(data[index].keterangan))),
      DataCell(Center(child: Text(data[index].tgl))),
      DataCell(Center(
          child: Text(
              'Rp. ' + con.nominal.format(double.parse(data[index].jumlah))))),
      DataCell(Center(child: Text(data[index].namaKtrBeban))),
      DataCell(Center(
        child: Row(
          children: [
            Expanded(
              child: IconButton(
                  onPressed: () {
                    Get.toNamed('/edit_beban', arguments: data[index]);
                  },
                  icon: Icon(
                    Icons.edit,
                    size: 18,
                  )),
            ),
            Expanded(
              child: IconButton(
                  onPressed: () {
                    popscreen().deletebebanv2(con, data[index]);
                  },
                  icon: Icon(Icons.delete, size: 18)),
            )
          ],
        ),
      )),
    ]);
  }
}
