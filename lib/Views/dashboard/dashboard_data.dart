import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:rims_waserda/Views/Widgets/dashboard%20data%20card.dart';
import 'package:rims_waserda/Views/Widgets/header.dart';

import 'package:syncfusion_flutter_charts/charts.dart';

import '../../Controllers/Templates/setting.dart';
import '../../Controllers/dashboard controller/dashboard_controller.dart';
import 'dashboard.dart';
import 'dashboard_data_card.dart';
import 'package:fl_chart/fl_chart.dart';

class dashboard_data extends GetView<dashboardController> {
  const dashboard_data({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Stack(
        children: [
          Card(
            margin: EdgeInsets.only(top: 10),
            elevation: elevation().def_elevation,
            shape: RoundedRectangleBorder(
              borderRadius: border_radius().def_border,
              side: BorderSide(color: color_template().primary, width: 3.5),
            ),
            child: Padding(
              padding: EdgeInsets.all(15),
              child: SingleChildScrollView(
                  child: Container(
                      margin: EdgeInsets.only(top: 30),
                      height: context.height_query,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              datacard(
                                title: "Rp.120.000",
                                subtile: "Total penjualan",
                                icon: Icons.money,
                              ),
                              datacard(
                                title: "150",
                                subtile: "Total barang",
                                icon: Icons.money,
                              ),
                            ],
                          ),
                        ],
                      ))),
            ),
          ),
          Positioned.fill(
            child: Align(
              alignment: Alignment.topLeft,
              child: Container(
                margin: EdgeInsets.only(top: 10, bottom: 10),
                padding: EdgeInsets.all(10),
                width: 100,
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 3,
                        blurRadius: 5,
                        offset: Offset(3, 3), // changes position of shadow
                      ),
                    ],
                    color: color_template().primary,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(10),
                        bottomRight: Radius.circular(10))),
                child: Text(
                  'Data',
                  style: font().header,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
