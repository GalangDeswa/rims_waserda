import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
          Container(
            margin: EdgeInsets.symmetric(vertical: 5),
            //  color: Colors.blue,
            height: double.infinity,
            child: Card(
              child: Padding(
                padding: EdgeInsets.only(top: 10),
                child: SingleChildScrollView(
                  child: Wrap(
                    alignment: WrapAlignment.spaceAround,
                    direction: Axis.horizontal,
                    runSpacing: 10,
                    spacing: 10,
                    children: [
                      Container(
                        margin: EdgeInsets.only(bottom: 10),
                        child: Text(
                          'Data Penjualan toko',
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                          // color: Colors.blue,
                          padding: EdgeInsets.all(10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                height: 300,
                                width: 200,
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    color: color_template().primary,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Container(
                                      // color: Colors.green,
                                      width: 200,
                                      height: 200,
                                      child: PieChart(
                                        PieChartData(sections: [
                                          PieChartSectionData(
                                              color: Colors.white,
                                              value: 100,
                                              showTitle: true,
                                              title: "penjualan"),
                                          PieChartSectionData(
                                              color: Colors.orange,
                                              value: 10,
                                              showTitle: true,
                                              title: "Rugi"),
                                          PieChartSectionData(
                                              color: Colors.cyan,
                                              value: 30,
                                              showTitle: true,
                                              title: "Untung"),
                                        ]),

                                        swapAnimationDuration: Duration(
                                            milliseconds: 150), // Optional
                                        swapAnimationCurve:
                                            Curves.linear, // Optional
                                      ),
                                    ),
                                    Text(
                                      'Penjualan bulan ini',
                                      style: font().header,
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                height: 300,
                                width: 200,
                                decoration: BoxDecoration(
                                    color: color_template().primary,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Container(
                                        width: 300,
                                        height: 200,
                                        //color: Colors.green,
                                        child: BarChart(BarChartData(
                                            barGroups: [
                                              BarChartGroupData(
                                                  x: 100,
                                                  barRods: [
                                                    BarChartRodData(
                                                        toY: 20,
                                                        width: 20,
                                                        borderRadius:
                                                            BorderRadius.zero,
                                                        color: Colors.white),
                                                    BarChartRodData(
                                                        toY: 30,
                                                        width: 20,
                                                        borderRadius:
                                                            BorderRadius.zero,
                                                        color: Colors.cyan),
                                                    BarChartRodData(
                                                        toY: 35,
                                                        width: 20,
                                                        borderRadius:
                                                            BorderRadius.zero,
                                                        color: Colors.white),
                                                    BarChartRodData(
                                                        toY: 36,
                                                        width: 20,
                                                        borderRadius:
                                                            BorderRadius.zero),
                                                  ])
                                            ],
                                            backgroundColor:
                                                color_template().secondary))),
                                    Text(
                                      'total keuntungan',
                                      style: font().header,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        height: 300,
                        decoration: BoxDecoration(
                            color: color_template().primary,
                            borderRadius: BorderRadius.circular(10)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                                height: 200,
                                //color: Colors.green,
                                child: BarChart(BarChartData(
                                    barGroups: [
                                      BarChartGroupData(x: 100, barRods: [
                                        BarChartRodData(
                                            toY: 10,
                                            width: 20,
                                            borderRadius: BorderRadius.zero,
                                            color: Colors.white),
                                        BarChartRodData(
                                            toY: 13,
                                            width: 20,
                                            borderRadius: BorderRadius.zero),
                                        BarChartRodData(
                                            toY: 35,
                                            width: 20,
                                            borderRadius: BorderRadius.zero,
                                            color: Colors.white),
                                        BarChartRodData(
                                            toY: 20,
                                            width: 20,
                                            borderRadius: BorderRadius.zero),
                                        BarChartRodData(
                                            toY: 25,
                                            width: 20,
                                            borderRadius: BorderRadius.zero,
                                            color: Colors.white),
                                        BarChartRodData(
                                            toY: 36,
                                            width: 20,
                                            borderRadius: BorderRadius.zero),
                                        BarChartRodData(
                                            toY: 50,
                                            width: 20,
                                            borderRadius: BorderRadius.zero,
                                            color: Colors.white),
                                      ])
                                    ],
                                    backgroundColor:
                                        color_template().secondary))),
                            Text(
                              'total keuntungan',
                              style: font().header,
                            ),
                          ],
                        ),
                      ),
                      dashboard_data_card(
                          icon: Icons.attach_money,
                          color: color_template().secondary,
                          label: 'Rp.80.000',
                          subtitle: 'Total penjualan'),
                      dashboard_data_card(
                          icon: Icons.person_add,
                          color: Colors.cyan,
                          label: '28',
                          subtitle: 'Total member'),
                      dashboard_data_card(
                          icon: Icons.person,
                          color: Colors.cyan,
                          label: '10',
                          subtitle: 'Total karyawan'),
                      dashboard_data_card(
                          icon: Icons.money_sharp,
                          color: Colors.cyan,
                          label: '7.650.000',
                          subtitle: 'Total cash'),
                      dashboard_data_card(
                          icon: Icons.account_box,
                          color: Colors.cyan,
                          label: '36.000',
                          subtitle: 'Total barang'),
                    ],
                  ),
                ),
              ),
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
