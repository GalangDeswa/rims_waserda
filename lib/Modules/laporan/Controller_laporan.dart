import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rims_waserda/Modules/laporan/view_laporan_table_beban.dart';
import 'package:rims_waserda/Modules/laporan/view_laporan_table_penjualan.dart';
import 'package:rims_waserda/Modules/laporan/view_laporan_table_reversal.dart';
import 'package:rims_waserda/Modules/laporan/view_laporan_table_umum.dart';

class laporanController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  List<Widget> table = [
    laporan_table_umum(),
    laporan_table_penjualan(),
    laporan_table_beban(),
    laporan_table_reversal()
  ];

  var pickdate = TextEditingController().obs;

  var selectedIndex = 0.obs;

  var selectedTabs = false.obs;

  List<DateTime?> dates = [];

  List<DropdownMenuItem> menuItems = [
    DropdownMenuItem(
      child: Container(
        width: 100,
        height: 50,
        color: Colors.black,
      ),
      value: 1,
    ),
    DropdownMenuItem(
      child: Container(
        width: 100,
        height: 50,
        color: Colors.green,
      ),
      value: 2,
    ),
  ].obs;

  var itemval;
}
