import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:rims_waserda/Templates/setting.dart';

import '../Widgets/dashboard data card.dart';
import 'controller_dashboard.dart';

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
                      height: context.height_query,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              datacard(
                                title: controller.pendapatan.toString(),
                                subtile: "Total Pendapatan",
                                icon: FontAwesomeIcons.dollarSign,
                              ),
                              datacard(
                                title: controller.beban.toString(),
                                subtile: "Total Beban",
                                icon: Icons.money_off,
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              datacard(
                                title: "Rp.120.000",
                                subtile: "Total Transaksi",
                                icon: FontAwesomeIcons.cashRegister,
                              ),
                              datacard(
                                title: "150",
                                subtile: "Total barang",
                                icon: Icons.inventory,
                              ),
                            ],
                          ),
                          // SizedBox(
                          //   height: 100,
                          // ),
                          Container(
                            height: context.height_query / 2,
                            child: ListView(
                              physics: NeverScrollableScrollPhysics(),
                              children: [
                                Card(
                                  elevation: elevation().def_elevation,
                                  child: ListTile(
                                    title: Text('150000'),
                                    subtitle: Text('total tunggakan'),
                                    leading: Container(
                                      padding: EdgeInsets.all(10),
                                      child: Icon(
                                        Icons.receipt,
                                        color: Colors.white,
                                      ),
                                      decoration: BoxDecoration(
                                          color: color_template().primary,
                                          borderRadius:
                                              border_radius().header_border),
                                    ),
                                  ),
                                ),
                                Card(
                                  elevation: elevation().def_elevation,
                                  child: ListTile(
                                    title: Text('10'),
                                    subtitle: Text('total pelanggan'),
                                    leading: Container(
                                      padding: EdgeInsets.all(10),
                                      child: Icon(
                                        Icons.people,
                                        color: Colors.white,
                                      ),
                                      decoration: BoxDecoration(
                                          color: color_template().primary,
                                          borderRadius:
                                              border_radius().header_border),
                                    ),
                                  ),
                                ),
                                Card(
                                  elevation: elevation().def_elevation,
                                  child: ListTile(
                                    title: Text('150000'),
                                    subtitle: Text('total tunggakan'),
                                    leading: Container(
                                      padding: EdgeInsets.all(10),
                                      child: Icon(
                                        Icons.receipt,
                                        color: Colors.white,
                                      ),
                                      decoration: BoxDecoration(
                                          color: color_template().primary,
                                          borderRadius:
                                              border_radius().header_border),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
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
                //width: 100,
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
