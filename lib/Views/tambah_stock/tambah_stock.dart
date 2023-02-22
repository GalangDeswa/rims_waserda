import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
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
      minimum: EdgeInsets.all(10),
      child: Scaffold(
        backgroundColor: color_template().primary.withOpacity(0.2),
        appBar: appbar_custom(
            height: 50,
            child: Text(
              'Tambah stock',
              style: font().header,
            )),
        body: Center(
          //color: Colors.red,

          //height: context.height_query,
          child: Card(margin: EdgeInsets.all(10),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 5),
                      child: Row(
                        children: [
                          Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  color: color_template().primary,
                                  borderRadius: BorderRadius.circular(10)),
                              child: FaIcon(
                                FontAwesomeIcons.boxesPacking,
                                size: 20,
                                color: Colors.white,
                              )),
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            'Tambah stock',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 25),
                          )
                        ],
                      ),
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
                            tambah_stock_table(),
                            SizedBox(
                              height: 15,
                            ),
                            button_solid_custom(
                                onPressed: () {},
                                child: Text('tambah stock'),
                                width: 900,
                                height: 50)
                          ],
                        ))
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
