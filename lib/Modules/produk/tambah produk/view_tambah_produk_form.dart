import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../../Templates/setting.dart';
import '../../Widgets/buttons.dart';
import '../../Widgets/header.dart';
import '../data produk/controller_data_produk.dart';
import '../jenis produk/model_jenisproduk.dart';

class tambah_produk_form extends GetView<produkController> {
  const tambah_produk_form({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
            child: Container(
              width: context.width_query / 1,
              height: context.height_query / 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  header(
                    title: 'Tambah Produk',
                    icon: FontAwesomeIcons.person,
                    function: () {},
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Expanded(
                    child: Form(
                        key: controller.formKeyproduk.value,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            TextFormField(
                              controller: controller.nama_produk.value,
                              onChanged: ((String pass) {}),
                              decoration: InputDecoration(
                                icon: Icon(Icons.add_card),
                                labelText: "Nama produk",
                                labelStyle: TextStyle(
                                  color: Colors.black87,
                                ),
                                border: OutlineInputBorder(
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
                            SizedBox(
                              height: 15,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    child: GetBuilder<produkController>(
                                        builder: (logic) {
                                      return DropdownButton2(
                                        isExpanded: true,
                                        hint: Text('Pilih jenis produk'),
                                        value: logic.jenisvalue,
                                        items: logic.jenislist.value
                                            .map((DataJenis item) {
                                          return DropdownMenuItem(
                                            child:
                                                Text(item.namaJenis.toString()),
                                            value: item.id.toString(),
                                          );
                                        }).toList(),
                                        onChanged: (val) {
                                          logic.jenisvalue = val!.toString();
                                          print(logic.jenisvalue);
                                          logic.update();
                                        },
                                      );
                                    }),
                                  ),
                                ),
                                IconButton(
                                    onPressed: () {
                                      Get.toNamed('/tambah_jenis');
                                    },
                                    icon: Icon(Icons.add))
                              ],
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            TextFormField(
                              controller: controller.desc.value,
                              onChanged: ((String pass) {}),
                              decoration: InputDecoration(
                                icon: Icon(Icons.person),
                                labelText: "deskripsi",
                                labelStyle: TextStyle(
                                  color: Colors.black87,
                                ),
                                border: OutlineInputBorder(
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
                            SizedBox(
                              height: 15,
                            ),
                            TextFormField(
                              controller: controller.qty.value,
                              onChanged: ((String pass) {}),
                              decoration: InputDecoration(
                                icon: Icon(Icons.pin_drop),
                                labelText: "Stock",
                                labelStyle: TextStyle(
                                  color: Colors.black87,
                                ),
                                border: OutlineInputBorder(
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
                            SizedBox(
                              height: 15,
                            ),
                            TextFormField(
                              controller: controller.harga.value,
                              onChanged: ((String pass) {}),
                              decoration: InputDecoration(
                                icon: Icon(Icons.pin_drop),
                                labelText: "harga",
                                labelStyle: TextStyle(
                                  color: Colors.black87,
                                ),
                                border: OutlineInputBorder(
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
                            SizedBox(
                              height: 15,
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            button_solid_custom(
                                onPressed: () {
                                  controller.ProdukTambah();
                                },
                                child: Text(
                                  'tambah produk',
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
    );
  }
}
