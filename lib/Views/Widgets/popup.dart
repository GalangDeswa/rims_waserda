import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:rims_waserda/Controllers/detail%20produk%20controller/detail_produk_controller.dart';
import 'package:rims_waserda/Views/detail%20produk/detail%20produk.dart';
import 'package:rims_waserda/Views/tambah_stock/tambah_stock.dart';


import '../../Controllers/Templates/setting.dart';
import '../../Controllers/kasir controller/kasir_controller.dart';
import '../../Controllers/stock controller/tambah_stock.dart';
import 'buttons.dart';
import 'keypad.dart';
import 'package:group_button/group_button.dart';

class popscreen {
  void popkonfirmasi(BuildContext context, kasirController controller) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.warning,
              color: Colors.orange,
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              'Konfirmasi pembayaran',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 21,
                  color: Colors.black),
            ),
          ],
        ),
        //backgroundColor: Colors.red,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(12.0),
          ),
        ),
        content: Builder(
          builder: (context) {
            return Container(
              //  color: Colors.blue,
              height: context.height_query * 0.7,
              width: context.height_query * 0.6,
              // color: Colors.red,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                    color: color_template().primary,
                    child: Center(
                      child: Text(
                        'Detail Penjualan',
                        style: font().header,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('sales person :', style: font().reguler),
                      Text('Galang', style: font().reguler),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Total item :', style: font().reguler),
                      Text('3', style: font().reguler),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Total harga :', style: font().reguler),
                      Text('20000', style: font().reguler),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('sales person :', style: font().reguler),
                      Text('Galang', style: font().reguler),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('total diskon :', style: font().reguler),
                      Text('0', style: font().reguler),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('total pajak :', style: font().reguler),
                      Text('0', style: font().reguler),
                    ],
                  ),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                    color: color_template().primary,
                    child: Text(
                      'Total tagihan',
                      style: font().header,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      button_border_custom(
                          onPressed: () {
                            Get.back;
                          },
                          child: Text(
                            'Batal',
                            style: TextStyle(color: Colors.black),
                          ),
                          width: 100,
                          height: 50),
                      button_solid_custom(
                          onPressed: () {
                            popscreen().popberhasil(context);
                          },
                          child: Text('Bayar'),
                          width: 100,
                          height: 50),
                    ],
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  void popbayar(BuildContext context, kasirController controller) {
    List ongkir = [
      'Hutang',
      'Tidak dibayar',
      'Cicil',
    ];
    String? val_ongkir;

    DateTime? dateTime;
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(12.0),
          ),
        ),
        content: Builder(
          builder: (context) {
            return Center(
              child: SingleChildScrollView(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 250,
                                height: 50,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: color_template().primary),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Icon(
                                      Icons.attach_money,
                                      color: Colors.white,
                                    ),
                                    Text('total tagihan :',
                                        style: font().header),
                                    Obx(() {
                                      return Text(
                                        'Rp.' +
                                            controller.totalharga().toString(),
                                        style: font().header,
                                      );
                                    }),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Container(
                                width: 250,
                                height: 50,
                                //color: Colors.red,
                                padding: EdgeInsets.all(10),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    GroupButton(
                                      isRadio: true,
                                      //onSelected: (index, isSelected) => print('$index button is selected'),
                                      buttons: [
                                        "Cash",
                                        "Transfer",
                                        "Utang",
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: color_template().primary),
                                child: GestureDetector(
                                    onTap: () {
                                      controller.keypadController.value.text =
                                          '10000';
                                    },
                                    child: Text(
                                      '10.000',
                                      style: font().header,
                                    )),
                              ),
                              Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: color_template().primary),
                                child: Text('20.000', style: font().header),
                              ),
                              Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: color_template().primary),
                                child: Text('50.000', style: font().header),
                              ),
                              Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: color_template().primary),
                                child: Text('100.000', style: font().header),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Expanded(
                                child: Container(
                                  child: TextField(
                                    readOnly: true,
                                    onTap: () {
                                      showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime(2000),
                                        lastDate: DateTime(2099),
                                      );
                                    },
                                    decoration: InputDecoration(
                                        prefixIcon: Icon(Icons.edit_calendar),
                                        hintText: dateTime == null
                                            ? DateTime.now().toString()
                                            : dateTime.toString()),
                                  ),
                                ),
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Expanded(
                                child: Container(
                                  child: TextFormField(
                                    controller:
                                        controller.keypadController.value,
                                    onChanged: (value) {
                                      print(value);
                                    },
                                    readOnly: true,
                                    decoration: InputDecoration(
                                        prefixIcon:
                                            Icon(Icons.attach_money_rounded),
                                        hintText: 'Jumlah bayar'),
                                  ),
                                ),
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Expanded(
                                child: Container(
                                  child: TextField(
                                    readOnly: true,
                                    decoration: InputDecoration(
                                        prefixIcon: Icon(Icons.change_circle),
                                        hintText: '5000'),
                                  ),
                                ),
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Expanded(
                                child: Container(
                                  child: DropdownButton(
                                    hint: Text('Keterangan'),
                                    value: val_ongkir,
                                    items: ongkir.map((item) {
                                      return DropdownMenuItem(
                                        child: Text(item),
                                        value: item,
                                      );
                                    }).toList(),
                                    onChanged: (val) {
                                      print('lol');
                                    },
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    KeyPad(
                      keypadController: controller.keypadController.value,
                      onChange: (String pin) {
                        print(pin);
                      },
                      onSubmit: (String pin) {},
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void popedit(BuildContext context, kasirController controller) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(12.0),
          ),
        ),
        content: Builder(
          builder: (context) {
            return Container(
              color: Colors.red,
              height: 100,
              width: context.width_query * 0.65,
              child: Center(
                child: SingleChildScrollView(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Table(
                              columnWidths: {
                                0: FlexColumnWidth(5),
                                1: FlexColumnWidth(2),
                                2: FlexColumnWidth(3),
                                3: FlexColumnWidth(3),
                              },
                              children: [
                                TableRow(children: [
                                  Column(children: [
                                    Text(
                                      'nama produk',
                                      style: font().table_header,
                                    ),
                                  ]),
                                  Column(children: [
                                    Text(
                                      'harga',
                                      style: font().table_header,
                                    ),
                                  ]),
                                  Column(children: [
                                    Text(
                                      'qty',
                                      style: font().table_header,
                                    ),
                                  ]),
                                  Column(children: [
                                    Text(
                                      'diskon',
                                      style: font().table_header,
                                    ),
                                  ]),
                                ]),
                                TableRow(children: [
                                  Column(children: [
                                    Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Text(
                                        'milo 2 in 1 saset 300 ml',
                                        style: font().reguler,
                                      ),
                                    )
                                  ]),
                                  Column(children: [
                                    Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Text(
                                        '5000',
                                        style: font().reguler,
                                      ),
                                    )
                                  ]),
                                  Column(children: [
                                    Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Container(
                                            child: Icon(
                                              Icons.remove,
                                              size: 18,
                                            ),
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: color_template().select),
                                          ),
                                          Text(
                                            '2',
                                            style: font().reguler,
                                          ),
                                          Container(
                                            child: Icon(
                                              Icons.add,
                                              size: 18,
                                            ),
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: color_template().select),
                                          ),
                                        ],
                                      ),
                                    )
                                  ]),
                                  Column(children: [
                                    Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            '0',
                                            style: font().reguler,
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Container(
                                            width: 35,
                                            height: 20,
                                            color: color_template().primary,
                                            child: Text('Rp'),
                                          ),
                                          Container(
                                            width: 35,
                                            height: 20,
                                            color: color_template().select,
                                            child: Text('%'),
                                          ),
                                        ],
                                      ),
                                    )
                                  ]),
                                ]),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                button_border_custom(
                                    onPressed: () {},
                                    child: Text(
                                      'batal',
                                      style: TextStyle(color: Colors.black),
                                    ),
                                    height: 30,
                                    width: 100),
                                SizedBox(
                                  width: 10,
                                ),
                                button_solid_custom(
                                    onPressed: () {
                                      controller.tambahkasir();
                                    },
                                    child: Text('Simpan'),
                                    height: 30,
                                    width: 100),
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void popsuplier(BuildContext context, tambah_stockController controller) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(12.0),
          ),
        ),
        content: Builder(
          builder: (context) {
            return Center(
              child: SingleChildScrollView(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Icon(Icons.attach_money),
                                  Text(
                                    'Tambah suplier',
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Expanded(
                                child: Container(
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                        prefixIcon: Icon(Icons.edit_calendar),
                                        hintText: 'nama suplier'),
                                  ),
                                ),
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Expanded(
                                child: Container(
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                        prefixIcon: Icon(Icons.edit_calendar),
                                        hintText: 'nomor hp'),
                                  ),
                                ),
                              )
                            ],
                          ),
                          Container(
                            height: 230,
                            //  color: Colors.red,
                            margin: EdgeInsets.only(top: 15),
                            width: double.infinity,
                            child: SingleChildScrollView(
                              child: DataTable(
                                columns: const <DataColumn>[
                                  DataColumn(
                                    label: Expanded(
                                      child: Text(
                                        'no',
                                        style: TextStyle(
                                            fontStyle: FontStyle.italic),
                                      ),
                                    ),
                                  ),
                                  DataColumn(
                                    label: Expanded(
                                      child: Text(
                                        'suplier',
                                        style: TextStyle(
                                            fontStyle: FontStyle.italic),
                                      ),
                                    ),
                                  ),
                                  DataColumn(
                                    label: Expanded(
                                      child: Text(
                                        'no hp',
                                        style: TextStyle(
                                            fontStyle: FontStyle.italic),
                                      ),
                                    ),
                                  ),
                                  DataColumn(
                                    label: Expanded(child: Icon(Icons.edit)),
                                  ),
                                ],
                                rows: const <DataRow>[
                                  DataRow(
                                    cells: <DataCell>[
                                      DataCell(Text('1')),
                                      DataCell(Text('Nusa indah')),
                                      DataCell(Text('09832832')),
                                      DataCell(Icon(Icons.edit)),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              button_border_custom(
                                  onPressed: () {},
                                  child: Text(
                                    'batal',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  height: 40,
                                  width: 220),
                              SizedBox(
                                width: 15,
                              ),
                              button_solid_custom(
                                  onPressed: () {
                                    controller.tambah();
                                  },
                                  child: Text('Simpan'),
                                  height: 40,
                                  width: 220),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void popberhasil(BuildContext context) {
    showDialog(
      useSafeArea: true,
      context: context,
      builder: (_) => AlertDialog(
        //backgroundColor: Colors.green,
        insetPadding: EdgeInsets.symmetric(vertical: 100, horizontal: 200),
        contentPadding: EdgeInsets.zero,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(12.0),
          ),
        ),
        content: Builder(
          builder: (context) {
            return Center(
              child: Container(
                height: context.height_query * 0.3,
                width: context.width_query * 0.3,
                //  color: Colors.red,
                child: Column(
                  children: [
                    Icon(
                      Icons.check,
                      color: Colors.green,
                      size: 50,
                    ),
                    Text(
                      'berhasil',
                      style:
                          TextStyle(fontSize: 70, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void popstock(BuildContext context, detail_produkController controller) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(12.0),
          ),
        ),
        content: Builder(
          builder: (context) {
            return Container(width: context.width_query,height: context.height_query,child: tambah_stock());
          },
        ),
      ),
    );
  }
}
