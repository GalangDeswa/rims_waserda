import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:rims_waserda/Modules/Widgets/stack%20bg.dart';
import 'package:rims_waserda/Modules/dashboard/controller_dashboard.dart';
import 'package:rims_waserda/Modules/dashboard/dashboard_konten_v2.dart';
import 'package:rims_waserda/Modules/dashboard/view_dashboar_app_v2.dart';

import '../../Templates/setting.dart';

class dashboard_v2 extends GetView<dashboardController> {
  const dashboard_v2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      //minimum: EdgeInsets.all(10),
      child: Scaffold(

          // backgroundColor: color_template().primary.withOpacity(0.2),
          resizeToAvoidBottomInset: false,
          body: stack_bg(
            isfullscreen: true,
            child: Stack(
              children: [
                Container(
                  //   margin: EdgeInsets.only(top: context.height_query / 5),
                  height: context.height_query / 4.5,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: color_template().primary,
                      image: DecorationImage(
                        image: AssetImage('assets/images/login_toko.png'),
                        fit: BoxFit.cover,
                        alignment: Alignment(1.0, -0.5),
                        colorFilter: ColorFilter.mode(
                            color_template().primary.withOpacity(0.2),
                            BlendMode.dstATop),
                      )),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  child: Container(
                    //color: Colors.cyan,
                    child: Obx(() {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Text(
                          //   'Dashboard',
                          //   style: font().header_xl,
                          // ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: ListTile(
                                  contentPadding: EdgeInsets.zero,
                                  title: Text(
                                    controller.nama_toko.value.toString(),
                                    style: font().header_big,
                                  ),
                                  subtitle: Text(
                                    controller.jenis_toko.value +
                                        ' - ' +
                                        controller.alamat_toko.value,
                                    style: font().header,
                                  ),
                                ),
                              ),
                              CircleAvatar(
                                radius: 25,
                                backgroundColor: Colors.white,
                                child:
                                    Image.asset('assets/images/login_toko.png'),
                              )
                            ],
                          ),

                          Container(
                            //  color: Colors.orange,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Card(
                                    elevation: elevation().def_elevation,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: border_radius().def_border,
                                    ),
                                    margin: EdgeInsets.only(right: 5),
                                    child: Row(
                                      children: [
                                        Container(
                                          color: Colors.green,
                                          width: 15,
                                          height: context.height_query / 7,
                                        ),
                                        Expanded(
                                          child: ListTile(
                                            leading: Container(
                                              padding: EdgeInsets.all(10),
                                              decoration: BoxDecoration(
                                                  color:
                                                      color_template().primary,
                                                  borderRadius: border_radius()
                                                      .icon_border),
                                              child: Icon(
                                                FontAwesomeIcons.dollarSign,
                                                size: 30,
                                                color: Colors.white,
                                              ),
                                            ),
                                            title: Text(
                                              'Rp. 5.250.000',
                                              style: font().header_big_black,
                                            ),
                                            subtitle: Text(
                                              'Pendapatan',
                                              style: font().header_black,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Card(
                                    elevation: elevation().def_elevation,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: border_radius().def_border,
                                    ),
                                    margin: EdgeInsets.only(right: 5, left: 5),
                                    child: Row(
                                      children: [
                                        Container(
                                          color: color_template().tritadery,
                                          width: 15,
                                          height: context.height_query / 7,
                                        ),
                                        Expanded(
                                          child: ListTile(
                                            leading: Container(
                                              padding: EdgeInsets.all(10),
                                              decoration: BoxDecoration(
                                                  color:
                                                      color_template().primary,
                                                  borderRadius: border_radius()
                                                      .icon_border),
                                              child: Icon(
                                                FontAwesomeIcons
                                                    .circleDollarToSlot,
                                                size: 30,
                                                color: Colors.white,
                                              ),
                                            ),
                                            title: Text(
                                              'Rp. 250.000',
                                              style: font().header_big_black,
                                            ),
                                            subtitle: Text(
                                              'Beban',
                                              style: font().header_black,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Card(
                                    elevation: elevation().def_elevation,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: border_radius().def_border,
                                    ),
                                    margin: EdgeInsets.only(left: 5),
                                    child: Row(
                                      children: [
                                        Container(
                                          color: color_template().primary,
                                          width: 15,
                                          height: context.height_query / 7,
                                        ),
                                        Expanded(
                                          child: ListTile(
                                            leading: Container(
                                              padding: EdgeInsets.all(10),
                                              decoration: BoxDecoration(
                                                  color:
                                                      color_template().primary,
                                                  borderRadius: border_radius()
                                                      .icon_border),
                                              child: Icon(
                                                FontAwesomeIcons.cashRegister,
                                                size: 30,
                                                color: Colors.white,
                                              ),
                                            ),
                                            title: Text(
                                              '20',
                                              style: font().header_big_black,
                                            ),
                                            subtitle: Text(
                                              'Transaksi hari ini',
                                              style: font().header_black,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Container(
                              // color: Colors.deepPurple,
                              child: Row(
                                // crossAxisAlignment: CrossAxisAlignment.stretch,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Container(
                                      margin: EdgeInsets.only(right: 10),
                                      //  color: Colors.lightBlue,
                                      child: Column(
                                        children: [
                                          ListTile(
                                            contentPadding: EdgeInsets.zero,
                                            title: Text(
                                              'Data toko',
                                              style: font().reguler,
                                            ),
                                            subtitle: Text('Detail data toko'),
                                          ),
                                          Expanded(
                                            child: Container(
                                                //height: context.height_query / 3,
                                                // color: Colors.red,
                                                child: ListView(
                                              children: [
                                                Card(
                                                  margin: EdgeInsets.only(
                                                      bottom: 10),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        border_radius()
                                                            .icon_border,
                                                    // side: BorderSide(color: color_template().primary, width: 3.5),
                                                  ),
                                                  elevation:
                                                      elevation().def_elevation,
                                                  child: ListTile(
                                                    title: Text('Rp. 150.000'),
                                                    subtitle:
                                                        Text('Total hutang'),
                                                  ),
                                                ),
                                                Card(
                                                  margin: EdgeInsets.only(
                                                      bottom: 10),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        border_radius()
                                                            .icon_border,
                                                    // side: BorderSide(color: color_template().primary, width: 3.5),
                                                  ),
                                                  elevation:
                                                      elevation().def_elevation,
                                                  child: ListTile(
                                                    title: Text('115'),
                                                    subtitle:
                                                        Text('Total produk'),
                                                  ),
                                                ),
                                                Card(
                                                  margin: EdgeInsets.only(
                                                      bottom: 10),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        border_radius()
                                                            .icon_border,
                                                    // side: BorderSide(color: color_template().primary, width: 3.5),
                                                  ),
                                                  elevation:
                                                      elevation().def_elevation,
                                                  child: ListTile(
                                                    title: Text('115'),
                                                    subtitle:
                                                        Text('Total produk'),
                                                  ),
                                                ),
                                              ],
                                            )),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      margin: EdgeInsets.only(left: 10),
                                      //color: Colors.green,
                                      child: Column(
                                        children: [
                                          ListTile(
                                            contentPadding: EdgeInsets.zero,
                                            title: Text('Aplikasi',
                                                style: font().reguler),
                                            subtitle: Text('Akses cepat'),
                                          ),
                                          Expanded(
                                            child: Container(
                                                width: context.width_query,
                                                // height: context.height_query / 3,
                                                //   color: Colors.red,
                                                child: dashboard_app_v2()),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                              //  color: Colors.orangeAccent,
                              child: dashboard_konten_v2())
                        ],
                      );
                    }),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
