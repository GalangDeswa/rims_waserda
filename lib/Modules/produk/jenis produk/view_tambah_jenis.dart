import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:rims_waserda/Modules/produk/data%20produk/controller_data_produk.dart';

import '../../../Templates/setting.dart';
import '../../Widgets/buttons.dart';
import '../../Widgets/header.dart';
import '../../Widgets/stack bg.dart';

class tambah_jenis extends GetView<produkController> {
  const tambah_jenis({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      // minimum: EdgeInsets.all(5),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: color_template().base_blue,
        // appBar: appbar_custom(
        //     height: 50,
        //     child: Text(
        //       'Tambah Produk',
        //       style: font().header,
        //     )),
        body: stack_bg(
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(30),
                child: Card(
                  elevation: elevation().def_elevation,
                  //margin: EdgeInsets.all(30),
                  shape: RoundedRectangleBorder(
                    borderRadius: border_radius().def_border,
                    side:
                        BorderSide(color: color_template().primary, width: 3.5),
                  ),

                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Container(
                      width: context.width_query / 1,
                      height: context.height_query / 2.3,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          header(
                            title: 'Tambah Jenis Produk',
                            icon: FontAwesomeIcons.person,
                            function: () {},
                          ),
                          SizedBox(
                            height: 50,
                          ),
                          Expanded(
                            child: Form(
                                key: controller.formKeyjenis.value,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    TextFormField(
                                      controller: controller.nama_jenis.value,
                                      onChanged: ((String pass) {}),
                                      decoration: InputDecoration(
                                        icon: Icon(Icons.add_card),
                                        labelText: "Nama Jenis",
                                        labelStyle: TextStyle(
                                          color: Colors.black87,
                                        ),
                                        border: OutlineInputBorder(
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
                                    button_solid_custom(
                                        onPressed: () {
                                          controller.jenisTambah();
                                        },
                                        child: Text(
                                          'tambah jenis',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        width: double.infinity,
                                        height: 50)
                                  ],
                                )),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
