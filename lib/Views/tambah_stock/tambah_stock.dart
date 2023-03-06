import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:rims_waserda/Views/Widgets/header.dart';
import 'package:rims_waserda/Views/Widgets/stack%20bg.dart';
import 'package:rims_waserda/Views/tambah_stock/tambah_stock_table.dart';

import '../../Controllers/Templates/setting.dart';
import '../../Controllers/stock controller/tambah_stock.dart';
import '../Widgets/appbar.dart';
import '../Widgets/buttons.dart';
import '../Widgets/popup.dart';

class tambah_stock extends GetView<tambah_stockController> {
  const tambah_stock({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();

    final email = TextEditingController();
    return SafeArea(
      // minimum: EdgeInsets.all(10),
      child: Scaffold(
        backgroundColor: color_template().primary.withOpacity(0.2),
        // appBar: appbar_custom(
        //     height: 50,
        //     child: Text(
        //       'Tambah stock',
        //       style: font().header,
        //     )),
        body: stack_bg(
            child: Center(
          //color: Colors.red,

          //height: context.height_query,
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: Card(
              elevation: elevation().def_elevation,
              //margin: EdgeInsets.all(30),
              shape: RoundedRectangleBorder(
                borderRadius: border_radius().def_border,
                side: BorderSide(color: color_template().primary, width: 3.5),
              ),
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    header(
                      title: 'Tambah stok',
                      icon: Icons.add_box,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Form(
                        key: formKey,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Expanded(
                                  child: Container(
                                    margin: EdgeInsets.symmetric(horizontal: 3),
                                    //width: 200,
                                    child: TextFormField(
                                      controller: email,
                                      onChanged: ((String pass) {}),
                                      decoration: InputDecoration(
                                        icon: Icon(Icons.add_box),
                                        labelText: "cari produk",
                                        labelStyle: TextStyle(
                                          color: Colors.black87,
                                        ),
                                        border: UnderlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10)),
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
                                    onPressed: () {},
                                    icon: Icons.add,
                                    container_color: color_template().primary),
                                Expanded(
                                  child: Container(
                                    margin: EdgeInsets.symmetric(horizontal: 3),
                                    // width: 200,
                                    child: TextFormField(
                                      controller: email,
                                      onChanged: ((String pass) {}),
                                      decoration: InputDecoration(
                                        icon: Icon(Icons.calendar_month),
                                        labelText: "Tanggal",
                                        labelStyle: TextStyle(
                                          color: Colors.black87,
                                        ),
                                        border: UnderlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10)),
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
                                Expanded(
                                  child: Container(
                                    margin: EdgeInsets.symmetric(horizontal: 3),
                                    //width: 200,
                                    child: TextFormField(
                                      controller: email,
                                      onChanged: ((String pass) {}),
                                      decoration: InputDecoration(
                                        icon: Icon(Icons.receipt),
                                        labelText: "no faktur",
                                        labelStyle: TextStyle(
                                          color: Colors.black87,
                                        ),
                                        border: UnderlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10)),
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
                                Expanded(
                                  child: Container(
                                    margin: EdgeInsets.symmetric(horizontal: 3),
                                    child: TextFormField(
                                      controller: email,
                                      onChanged: ((String pass) {}),
                                      decoration: InputDecoration(
                                        icon: Icon(Icons.phone),
                                        labelText: "no suplier",
                                        labelStyle: TextStyle(
                                          color: Colors.black87,
                                        ),
                                        border: UnderlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10)),
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
                                      popscreen()
                                          .popsuplier(context, controller);
                                    },
                                    icon: Icons.add,
                                    container_color: color_template().primary),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                          ],
                        )),
                    SingleChildScrollView(child: tambah_stock_table()),
                    button_solid_custom(
                        onPressed: () {},
                        child: Text('tambah stock'),
                        width: context.width_query,
                        height: 50)
                  ],
                ),
              ),
            ),
          ),
        )),
      ),
    );
  }
}
