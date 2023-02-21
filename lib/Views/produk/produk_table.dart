import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:rims_waserda/Controllers/Templates/setting.dart';


import '../../Controllers/produk controller/produk_controller.dart';
import '../Widgets/buttons.dart';

class produk_table extends GetView<produkController> {
  const produk_table({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      //color: Colors.red,

      height: context.height_query,
      child: Card(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
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
                            'List produk',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 25),
                          ),
                        ],
                      ),
                      button_solid_custom(
                          onPressed: () {
                            Get.toNamed('/tambah_produk');
                          },
                          child: Text(
                            'tambah produk',
                            style: font().header,
                          ),
                          width: 150,
                          height: 50)
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Form(
                    key: controller.formKey,
                    child: Column(
                      children: [
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                        //   children: [
                        //     Container(
                        //       margin: EdgeInsets.symmetric(horizontal: 3),
                        //       width: 200,
                        //       child: TextFormField(
                        //         controller: email,
                        //         onChanged: ((String pass) {}),
                        //         decoration: InputDecoration(
                        //           icon: Icon(Icons.add_box),
                        //           labelText: "cari produk",
                        //           labelStyle: TextStyle(
                        //             color: Colors.black87,
                        //           ),
                        //           border: UnderlineInputBorder(
                        //               borderRadius:
                        //                   BorderRadius.circular(10)),
                        //           focusedBorder: OutlineInputBorder(
                        //               borderRadius:
                        //                   BorderRadius.circular(10)),
                        //         ),
                        //         textAlign: TextAlign.center,
                        //         validator: (value) {
                        //           if (value!.isEmpty) {
                        //             return 'Please enter email';
                        //           }
                        //           return null;
                        //         },
                        //       ),
                        //     ),
                        //     icon_button_custom(
                        //         onPressed: () {},
                        //         icon: Icons.add,
                        //         container_color: color_template().primary),
                        //     Container(
                        //       margin: EdgeInsets.symmetric(horizontal: 3),
                        //       width: 200,
                        //       child: TextFormField(
                        //         controller: email,
                        //         onChanged: ((String pass) {}),
                        //         decoration: InputDecoration(
                        //           icon: Icon(Icons.calendar_month),
                        //           labelText: "Tanggal",
                        //           labelStyle: TextStyle(
                        //             color: Colors.black87,
                        //           ),
                        //           border: UnderlineInputBorder(
                        //               borderRadius:
                        //                   BorderRadius.circular(10)),
                        //           focusedBorder: OutlineInputBorder(
                        //               borderRadius:
                        //                   BorderRadius.circular(10)),
                        //         ),
                        //         textAlign: TextAlign.center,
                        //         validator: (value) {
                        //           if (value!.isEmpty) {
                        //             return 'Please enter email';
                        //           }
                        //           return null;
                        //         },
                        //       ),
                        //     ),
                        //     Container(
                        //       margin: EdgeInsets.symmetric(horizontal: 3),
                        //       width: 200,
                        //       child: TextFormField(
                        //         controller: email,
                        //         onChanged: ((String pass) {}),
                        //         decoration: InputDecoration(
                        //           icon: Icon(Icons.receipt),
                        //           labelText: "no faktur",
                        //           labelStyle: TextStyle(
                        //             color: Colors.black87,
                        //           ),
                        //           border: UnderlineInputBorder(
                        //               borderRadius:
                        //                   BorderRadius.circular(10)),
                        //           focusedBorder: OutlineInputBorder(
                        //               borderRadius:
                        //                   BorderRadius.circular(10)),
                        //         ),
                        //         textAlign: TextAlign.center,
                        //         validator: (value) {
                        //           if (value!.isEmpty) {
                        //             return 'Please enter email';
                        //           }
                        //           return null;
                        //         },
                        //       ),
                        //     ),
                        //     Container(
                        //       margin: EdgeInsets.symmetric(horizontal: 3),
                        //       width: 180,
                        //       child: TextFormField(
                        //         controller: email,
                        //         onChanged: ((String pass) {}),
                        //         decoration: InputDecoration(
                        //           icon: Icon(Icons.phone),
                        //           labelText: "no suplier",
                        //           labelStyle: TextStyle(
                        //             color: Colors.black87,
                        //           ),
                        //           border: UnderlineInputBorder(
                        //               borderRadius:
                        //                   BorderRadius.circular(10)),
                        //           focusedBorder: OutlineInputBorder(
                        //               borderRadius:
                        //                   BorderRadius.circular(10)),
                        //         ),
                        //         textAlign: TextAlign.center,
                        //         validator: (value) {
                        //           if (value!.isEmpty) {
                        //             return 'Please enter email';
                        //           }
                        //           return null;
                        //         },
                        //       ),
                        //     ),
                        //   ],
                        // ),
                        Container(
                          height: context.height_query * 0.64,
                          // color: Colors.red,
                          margin: EdgeInsets.only(top: 15),
                          width: double.infinity,
                          child: SingleChildScrollView(
                            child: DataTable(
                              columns: const <DataColumn>[
                                DataColumn(
                                  label: Expanded(
                                    child: Text(
                                      'kode',
                                      style: TextStyle(
                                          fontStyle: FontStyle.italic),
                                    ),
                                  ),
                                ),
                                DataColumn(
                                  label: Expanded(
                                    child: Text(
                                      'nama produk',
                                      style: TextStyle(
                                          fontStyle: FontStyle.italic),
                                    ),
                                  ),
                                ),
                                DataColumn(
                                  label: Expanded(
                                    child: Text(
                                      'jumlah',
                                      style: TextStyle(
                                          fontStyle: FontStyle.italic),
                                    ),
                                  ),
                                ),
                                DataColumn(
                                  label: Expanded(
                                    child: Text(
                                      'harga beli',
                                      style: TextStyle(
                                          fontStyle: FontStyle.italic),
                                    ),
                                  ),
                                ),
                                DataColumn(
                                  label: Expanded(
                                    child: Text(
                                      'total',
                                      style: TextStyle(
                                          fontStyle: FontStyle.italic),
                                    ),
                                  ),
                                ),
                                DataColumn(
                                  label: Expanded(
                                    child: Center(
                                      child: Text(
                                        'Aksi',
                                        style: TextStyle(
                                            fontStyle: FontStyle.italic),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                              rows: <DataRow>[
                                DataRow(
                                  cells: <DataCell>[
                                    DataCell(Text('Sarah')),
                                    DataCell(Text('19')),
                                    DataCell(Text('Student')),
                                    DataCell(Text('Student')),
                                    DataCell(Text('Student')),
                                    DataCell(Row(
                                      children: [
                                        IconButton(
                                            onPressed: () {
                                              print('qweqweqwe');
                                              Get.toNamed('/detail_produk');
                                            },
                                            icon: Icon(
                                              Icons.ballot,
                                              size: 18,
                                            )),
                                        IconButton(
                                            onPressed: () {},
                                            icon: Icon(
                                              Icons.edit,
                                              size: 18,
                                            )),
                                        IconButton(
                                            onPressed: () {},
                                            icon: Icon(Icons.delete, size: 18))
                                      ],
                                    )),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                      ],
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
