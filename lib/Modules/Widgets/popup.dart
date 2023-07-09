import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:group_button/group_button.dart';
import 'package:rims_waserda/Modules/kasir/model_kasir.dart';
import 'package:rims_waserda/Modules/pelanggan/data%20pelanggan/controller_data_pelanggan.dart';
import 'package:rims_waserda/Modules/produk/data%20produk/controller_data_produk.dart';
import 'package:rims_waserda/Modules/produk/data%20produk/model_produk.dart';
import 'package:rims_waserda/Modules/produk/jenis%20produk/model_jenisproduk.dart';
import 'package:rims_waserda/Modules/user/data%20user/controller_data_user.dart';
import 'package:rims_waserda/Modules/user/edit%20user/controller_edit_user.dart';

import '../../Templates/setting.dart';
import '../beban/data beban/controller_beban.dart';
import '../beban/data beban/model_data_beban.dart';
import '../beban/edit jenis beban/model_jenis_beban.dart';
import '../history/Controller_history.dart';
import '../history/model_penjualan.dart';
import '../kasir/controller_kasir.dart';
import '../pelanggan/data pelanggan/model_data_pelanggan.dart';
import '../produk/detail produk/controller_detail_produk.dart';
import '../produk/tambah_stock/controller_tambah_stock.dart';
import '../produk/tambah_stock/view_tambah_stock_base.dart';
import '../user/data user/model_data_user.dart';
import 'buttons.dart';
import 'header.dart';
import 'keypad.dart';

class popscreen {
  deletepelanggan(pelangganController controller, DataPelanggan arg) {
    Get.dialog(AlertDialog(
      titlePadding: EdgeInsets.all(10),
      title: header(
        title: 'Hapus Pelanggan',
        icon: Icons.warning,
        icon_color: color_template().tritadery,
      ),
      contentPadding: EdgeInsets.all(10),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(12.0),
        ),
      ),
      content: Builder(
        builder: (context) {
          return Container(
              width: context.width_query / 2.6,
              height: context.height_query / 2.6,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "Hapus " + arg.namaPelanggan! + '?',
                    style: font().header_black,
                  ),
                  button_solid_custom(
                      onPressed: () {
                        controller.hapuspelangganlocal(arg.idLocal!);
                        //controller.deleteproduk(arg.id.toString());
                      },
                      child: Text(
                        'Hapus',
                        style: font().primary_white,
                      ),
                      width: context.width_query,
                      height: context.height_query / 10),
                  button_border_custom(
                      onPressed: () {
                        Get.back();
                      },
                      child: Text(
                        'Batal',
                        style: font().primary,
                      ),
                      width: context.width_query,
                      height: context.height_query / 10)
                ],
              ));
        },
      ),
    ));
  }

  reversalpenjualan(historyController controller, DataPenjualan arg) {
    Get.dialog(AlertDialog(
      title: header(
        iscenter: true,
        title: 'Batalkan Transaksi',
        icon: Icons.warning,
        icon_color: color_template().tritadery,
      ),
      contentPadding: EdgeInsets.all(10),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(12.0),
        ),
      ),
      content: Builder(
        builder: (context) {
          return Container(
              margin: EdgeInsets.all(10),
              width: context.width_query / 2.6,
              height: context.height_query / 2.6,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "Batalkan transaksi ini?",
                    style: font().header_black,
                  ),
                  button_solid_custom(
                      onPressed: () {
                        controller.reversalPenjualanlocal(arg.idLocal!);
                      },
                      child: Text(
                        'Batalkan',
                        style: font().primary_white,
                      ),
                      width: context.width_query,
                      height: context.height_query / 10),
                  button_border_custom(
                      onPressed: () {
                        Get.back();
                      },
                      child: Text(
                        'Batal',
                        style: font().primary,
                      ),
                      width: context.width_query,
                      height: context.height_query / 10)
                ],
              ));
        },
      ),
    ));
  }

  void deletebeban(
      BuildContext context, bebanController controller, DataBeban arg) {
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: header(
              title: 'Hapus Beban',
              icon: Icons.warning,
              icon_color: color_template().tritadery,
            ),
            contentPadding: EdgeInsets.all(10),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(12.0),
              ),
            ),
            content: Builder(
              builder: (context) {
                return Container(
                    width: context.width_query / 2.6,
                    height: context.height_query / 2.6,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          "Hapus beban " + arg.nama! + '?',
                          style: font().header_black,
                        ),
                        button_solid_custom(
                            onPressed: () {
                              controller.hapusBeban(arg.id.toString());
                              //controller.deleteproduk(arg.id.toString());
                            },
                            child: Text(
                              'Hapus',
                              style: font().primary_white,
                            ),
                            width: context.width_query / 4,
                            height: context.height_query / 10),
                        button_border_custom(
                            onPressed: () {
                              Get.back();
                            },
                            child: Text(
                              'Batal',
                              style: font().primary,
                            ),
                            width: context.width_query / 4,
                            height: context.height_query / 10)
                      ],
                    ));
              },
            ),
          );
        });
  }

  deletebebanv2(bebanController controller, DataBeban arg) {
    Get.dialog(AlertDialog(
      title: header(
        title: 'Hapus Beban',
        icon: Icons.warning,
        icon_color: color_template().tritadery,
      ),
      contentPadding: EdgeInsets.all(10),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(12.0),
        ),
      ),
      content: Builder(
        builder: (context) {
          return Container(
              margin: EdgeInsets.all(10),
              width: context.width_query / 2.6,
              height: context.height_query / 2.6,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "Hapus beban " + arg.nama! + '?',
                    style: font().header_black,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  button_solid_custom(
                      onPressed: () {
                        controller.deletebebanlocal(arg.idLocal!);
                        //controller.deleteproduk(arg.id.toString());
                      },
                      child: Text(
                        'Hapus',
                        style: font().primary_white,
                      ),
                      width: context.width_query,
                      height: context.height_query / 10),
                  button_border_custom(
                      onPressed: () {
                        Get.back();
                      },
                      child: Text(
                        'Batal',
                        style: font().primary,
                      ),
                      width: context.width_query,
                      height: context.height_query / 10)
                ],
              ));
        },
      ),
    ));
  }

  void deletekeranjang(
      BuildContext context, kasirController controller, DataKeranjang arg) {
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: header(
              title: 'Hapus keranjang',
              icon: Icons.warning,
              icon_color: color_template().tritadery,
            ),
            contentPadding: EdgeInsets.all(10),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(12.0),
              ),
            ),
            content: Builder(
              builder: (context) {
                return Container(
                    width: context.width_query / 2.6,
                    height: context.height_query / 2.6,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          "Hapus " + arg.namaBrg + '?',
                          style: font().header_black,
                        ),
                        button_solid_custom(
                            onPressed: () {
                              controller.deleteKeranjang(
                                  arg.id.toString(), arg.idProduk.toString());
                            },
                            child: Text(
                              'Hapus',
                              style: font().primary_white,
                            ),
                            width: context.width_query / 4,
                            height: context.height_query / 10),
                        button_border_custom(
                            onPressed: () {
                              Get.back();
                            },
                            child: Text(
                              'Batal',
                              style: font().primary,
                            ),
                            width: context.width_query / 4,
                            height: context.height_query / 10)
                      ],
                    ));
              },
            ),
          );
        });
  }

  deletejenisbeban(bebanController controller, DataJenisBeban arg) {
    Get.dialog(AlertDialog(
      title: header(
        title: 'Hapus Kategori',
        icon: Icons.warning,
        icon_color: color_template().tritadery,
      ),
      contentPadding: EdgeInsets.all(10),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(12.0),
        ),
      ),
      content: Builder(
        builder: (context) {
          return Container(
              margin: EdgeInsets.all(10),
              width: context.width_query / 2.6,
              height: context.height_query / 2.6,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "Hapus kategori " + arg.kategori! + '?',
                    style: font().header_black,
                  ),
                  button_solid_custom(
                      onPressed: () {
                        controller.deletejenisbebanlocal(arg.idLocal!);
                      },
                      child: Text(
                        'Hapus',
                        style: font().primary_white,
                      ),
                      width: context.width_query,
                      height: context.height_query / 10),
                  button_border_custom(
                      onPressed: () {
                        Get.back();
                      },
                      child: Text(
                        'Batal',
                        style: font().primary,
                      ),
                      width: context.width_query,
                      height: context.height_query / 10)
                ],
              ));
        },
      ),
    ));
  }

  void deletejenis(produkController controller, DataJenis arg) {
    Get.dialog(AlertDialog(
      title: header(
        title: 'Hapus Data',
        icon: Icons.warning,
        icon_color: color_template().tritadery,
      ),
      contentPadding: EdgeInsets.all(10),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(12.0),
        ),
      ),
      content: Builder(
        builder: (context) {
          return Container(
              margin: EdgeInsets.all(10),
              width: context.width_query / 2.6,
              height: context.height_query / 2.6,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "Hapus data " + arg.namaJenis! + '?',
                    style: font().header_black,
                  ),
                  button_solid_custom(
                      onPressed: () {
                        controller.deletejenislocal(arg.idLocal!);
                      },
                      child: Text(
                        'Hapus',
                        style: font().primary_white,
                      ),
                      width: context.width_query,
                      height: context.height_query / 10),
                  button_border_custom(
                      onPressed: () {
                        Get.back();
                      },
                      child: Text(
                        'Batal',
                        style: font().primary,
                      ),
                      width: context.width_query,
                      height: context.height_query / 10)
                ],
              ));
        },
      ),
    ));
  }

  deleteprodukv2(produkController controller, DataProduk arg) {
    Get.dialog(AlertDialog(
      title: header(
        title: 'Hapus Data',
        icon: Icons.warning,
        icon_color: color_template().tritadery,
      ),
      contentPadding: EdgeInsets.all(10),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(12.0),
        ),
      ),
      content: Builder(
        builder: (context) {
          return Container(
              width: context.width_query / 2.6,
              height: context.height_query / 2.6,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "Hapus produk " + arg.namaProduk + '?',
                    style: font().header_black,
                  ),
                  button_solid_custom(
                      onPressed: () {
                        controller.deleteproduk(arg.id.toString());
                      },
                      child: Text(
                        'Hapus',
                        style: font().primary_white,
                      ),
                      width: context.width_query / 4,
                      height: context.height_query / 10),
                  button_border_custom(
                      onPressed: () {
                        Get.back();
                      },
                      child: Text(
                        'Batal',
                        style: font().primary,
                      ),
                      width: context.width_query / 4,
                      height: context.height_query / 10)
                ],
              ));
        },
      ),
    ));
  }

  deleteproduklocal(produkController controller, DataProduk arg) {
    Get.dialog(AlertDialog(
      title: header(
        title: 'Hapus Data',
        icon: Icons.warning,
        icon_color: color_template().tritadery,
      ),
      contentPadding: EdgeInsets.all(10),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(12.0),
        ),
      ),
      content: Builder(
        builder: (context) {
          return Container(
              margin: EdgeInsets.all(10),
              width: context.width_query / 2.6,
              height: context.height_query / 2.6,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Center(
                    child: Text(
                      "Hapus produk " + arg.namaProduk + ' ?',
                      style: font().header_black,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  button_solid_custom(
                      onPressed: () {
                        controller.deleteproduklocal(arg.idLocal);
                      },
                      child: Text(
                        'Hapus',
                        style: font().primary_white,
                      ),
                      width: context.width_query,
                      height: context.height_query / 10),
                  button_border_custom(
                      onPressed: () {
                        Get.back();
                      },
                      child: Text(
                        'Batal',
                        style: font().primary,
                      ),
                      width: context.width_query,
                      height: context.height_query / 10)
                ],
              ));
        },
      ),
    ));
  }

  lupapassword() {
    Get.dialog(AlertDialog(
      title: header(
        title: 'Lupa Password',
        icon: Icons.warning,
        icon_color: color_template().tritadery,
      ),
      contentPadding: EdgeInsets.all(10),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(12.0),
        ),
      ),
      content: Builder(
        builder: (context) {
          return Container(
              margin: EdgeInsets.all(10),
              // color: Colors.red,
              width: context.width_query / 2.6,
              height: context.height_query / 5.6,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Hubungi admin untuk mereset password anda",
                    style: font().header_black,
                  ),
                  button_solid_custom(
                      onPressed: () {
                        Get.back();
                      },
                      child: Text(
                        'Kembali',
                        style: font().primary_white,
                      ),
                      width: context.width_query,
                      height: context.height_query / 10)
                ],
              ));
        },
      ),
    ));
  }

  void deleteproduk(
      BuildContext context, produkController controller, DataProduk arg) {
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: header(
              title: 'Hapus Data',
              icon: Icons.warning,
              icon_color: color_template().tritadery,
            ),
            contentPadding: EdgeInsets.all(10),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(12.0),
              ),
            ),
            content: Builder(
              builder: (context) {
                return Container(
                    width: context.width_query / 2.6,
                    height: context.height_query / 2.6,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          "Hapus produk " + arg.namaProduk + '?',
                          style: font().header_black,
                        ),
                        button_solid_custom(
                            onPressed: () {
                              controller.deleteproduk(arg.id.toString());
                            },
                            child: Text(
                              'Hapus',
                              style: font().primary_white,
                            ),
                            width: context.width_query / 4,
                            height: context.height_query / 10),
                        button_border_custom(
                            onPressed: () {
                              Get.back();
                            },
                            child: Text(
                              'Batal',
                              style: font().primary,
                            ),
                            width: context.width_query / 4,
                            height: context.height_query / 10)
                      ],
                    ));
              },
            ),
          );
        });
  }

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
                    decoration: BoxDecoration(
                        color: color_template().primary,
                        borderRadius: BorderRadius.circular(10)),
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
                      Text(controller.namakasir, style: font().reguler),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Total item :', style: font().reguler),
                      Text(
                          controller.cache
                              .map((e) => e.qty)
                              .fold(
                                  0, (previous, current) => previous + current)
                              .toString(),
                          style: font().reguler),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Total harga :', style: font().reguler),
                      Text(
                          controller.total
                              .toStringAsFixed(0)
                              .replaceAll(RegExp(r'[^\w\s]+'), '')
                              .replaceAllMapped(
                                  RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                                  (Match m) => '${m[1]},'),
                          style: font().reguler),
                    ],
                  ),
                  controller.meja.value.text.isEmpty ||
                          controller.meja.value.text == null ||
                          controller.meja.value.text == ''
                      ? Container()
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Meja:', style: font().reguler),
                            Text(controller.meja.value.text,
                                style: font().reguler),
                          ],
                        ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Pembayaran:', style: font().reguler),
                      Text(
                          controller.keypadController.value.text.isNotEmpty
                              ? controller.keypadController.value.text
                              : '-',
                          style: font().reguler),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Kembalian :', style: font().reguler),
                      Text(
                          controller.kembalian.value.text.isNotEmpty
                              ? controller.kembalian.value.text
                              : '-',
                          style: font().reguler),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Metode bayar :', style: font().reguler),
                      Text(
                          controller.groupindex.value == 1
                              ? 'Tunai'
                              : controller.groupindex.value == 2
                                  ? 'Non tunai'
                                  : controller.groupindex.value == 3
                                      ? 'Hutang'
                                      : '-',
                          style: font().reguler),
                    ],
                  ),
                  // Container(
                  //   width: double.infinity,
                  //   padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                  //   color: color_template().primary,
                  //   child: Text(
                  //     'Kembalian',
                  //     style: font().header,
                  //   ),
                  // ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      button_border_custom(
                          onPressed: () {
                            //Navigator.of(context).pop();
                            Get.back();
                            print('back');
                          },
                          child: Text(
                            'Batal',
                            style: TextStyle(color: Colors.black),
                          ),
                          width: 100,
                          height: 50),
                      button_solid_custom(
                          onPressed: () {
                            print(
                                'bayar local------------------------------->');
                            controller.pembayaranlocal(controller.id_toko);
                          },
                          child: Text(controller.groupindex.value != 3
                              ? 'Bayar'
                              : 'Hutang'),
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
        actions: [
          button_border_custom(
              onPressed: () {
                controller.onInit();
                Navigator.of(context).pop();
              },
              child: Text(
                'Batal',
                style: font().primary,
              ),
              height: 50,
              width: 100),
        ],
        elevation: elevation().def_elevation,
        contentPadding: EdgeInsets.all(15),
        shape: const RoundedRectangleBorder(
          side: BorderSide(color: Colors.blueAccent, width: 3.5),
          borderRadius: BorderRadius.all(
            Radius.circular(12.0),
          ),
        ),
        content: Builder(
          builder: (context) {
            return Container(
              //color: Colors.red,
              width: context.width_query * 0.75,
              height: context.height_query * 0.7,

              //height: context.height_query * 0.6,
              child: Center(
                child: SingleChildScrollView(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  padding: EdgeInsets.all(10),
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
                                        size: 30,
                                      ),
                                      Text('total tagihan :',
                                          style: font().header_big),
                                      Obx(() {
                                        return Text(
                                          'Rp.' +
                                              controller.subtotal.toString(),
                                          style: font().header_big,
                                        );
                                      }),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Container(
                                  height: 50,
                                  //color: Colors.red,
                                  padding: EdgeInsets.all(10),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      GroupButton(
                                        isRadio: true,
                                        onSelected: (string, index, bool) {
                                          controller.groupindex.value = index;
                                          print(index);
                                        },
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
                              height: 50,
                            ),
                            Obx(() {
                              return controller.groupindex.value == 9
                                  ? Center(
                                      child: Container(
                                        child: Text(
                                          "pilih metode bayar",
                                          style: font().header_black,
                                        ),
                                      ),
                                    )
                                  : Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              padding: EdgeInsets.all(10),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  color:
                                                      color_template().primary),
                                              child: GestureDetector(
                                                  onTap: () {
                                                    controller.keypadController
                                                        .value.text = '10000';
                                                  },
                                                  child: Text(
                                                    '10.000',
                                                    style: font().header,
                                                  )),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                controller.keypadController
                                                    .value.text = '20000';
                                              },
                                              child: Container(
                                                padding: EdgeInsets.all(10),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    color: color_template()
                                                        .primary),
                                                child: Text('20.000',
                                                    style: font().header),
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                controller.keypadController
                                                    .value.text = '50000';
                                              },
                                              child: Container(
                                                padding: EdgeInsets.all(10),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    color: color_template()
                                                        .primary),
                                                child: Text('50.000',
                                                    style: font().header),
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                controller.keypadController
                                                    .value.text = '100000';
                                              },
                                              child: Container(
                                                padding: EdgeInsets.all(10),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    color: color_template()
                                                        .primary),
                                                child: Text('100.000',
                                                    style: font().header),
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                controller.keypadController
                                                    .value.text = '500000';
                                              },
                                              child: Container(
                                                padding: EdgeInsets.all(10),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    color: color_template()
                                                        .primary),
                                                child: Text('500.000',
                                                    style: font().header),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 30,
                                        ),

                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Expanded(
                                              child: Container(
                                                child: TextFormField(
                                                  controller: controller
                                                      .keypadController.value,
                                                  onChanged: (value) {
                                                    print(value);
                                                  },
                                                  readOnly: true,
                                                  decoration: InputDecoration(
                                                      prefixIcon: Icon(Icons
                                                          .attach_money_rounded),
                                                      hintText: 'Jumlah bayar'),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Obx(() {
                                              return Expanded(
                                                  child: Container(
                                                child: TextField(
                                                  onTap: () {
                                                    print(
                                                        'kembalian kasir--------------------');
                                                  },
                                                  onChanged: (val) {
                                                    print(
                                                        'kembalian kasir--------------------' +
                                                            val);
                                                  },
                                                  readOnly: true,
                                                  decoration: InputDecoration(
                                                    prefixIcon: Icon(
                                                        Icons.change_circle),
                                                    hintText: 'kembalian',
                                                  ),
                                                ),
                                              ));
                                            })
                                          ],
                                        ),
                                        // Row(
                                        //   mainAxisAlignment:
                                        //       MainAxisAlignment.spaceAround,
                                        //   children: [
                                        //     Expanded(
                                        //       child: Container(
                                        //         child: DropdownButton(
                                        //           hint: Text('Keterangan'),
                                        //           value: val_ongkir,
                                        //           items: ongkir.map((item) {
                                        //             return DropdownMenuItem(
                                        //               child: Text(item),
                                        //               value: item,
                                        //             );
                                        //           }).toList(),
                                        //           onChanged: (val) {
                                        //             print('lol');
                                        //           },
                                        //         ),
                                        //       ),
                                        //     )
                                        //   ],
                                        // ),
                                      ],
                                    );
                            })
                          ],
                        ),
                      ),
                      Column(
                        children: [
                          KeyPad(
                            keypadController: controller.keypadController.value,
                            onChange: (String pin) {
                              print(pin + '-----------PRINT PIN');
                              // controller.change();
                            },
                            onSubmit: (String pin) {},
                          ),
                        ],
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
                                      //  controller.tambahkasir();
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
              child: Container(
                width: context.width_query / 2,
                color: Colors.red,
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
            return Container(
                width: context.width_query,
                height: context.height_query,
                child: tambah_stock());
          },
        ),
      ),
    );
  }

  void popedituser(
      BuildContext context, edituserController controller, DataUser qwe) {
    Get.dialog(
        Center(
          child: Container(
            width: context.width_query / 1.5,
            padding: EdgeInsets.zero,
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
                  children: [
                    header(
                      title: 'Edit User',
                      icon: FontAwesomeIcons.person,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Obx(() {
                          return Form(
                              key: controller.formKeyedituser.value,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  TextFormField(
                                    //initialValue: controller.data.nama,
                                    controller: controller.nama.value,
                                    onChanged: ((String pass) {}),
                                    decoration: InputDecoration(
                                      icon: Icon(Icons.add_card),
                                      labelText: 'Nama',
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
                                  SizedBox(
                                    height: 15,
                                  ),
                                  TextFormField(
                                    controller: controller.email.value,
                                    onChanged: ((String pass) {}),
                                    decoration: InputDecoration(
                                      icon: Icon(Icons.person),
                                      labelText: "Email",
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
                                  SizedBox(
                                    height: 15,
                                  ),
                                  TextFormField(
                                    controller: controller.hp.value,
                                    onChanged: ((String pass) {}),
                                    decoration: InputDecoration(
                                      icon: Icon(Icons.pin_drop),
                                      labelText: "Nomor HP",
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
                                  SizedBox(
                                    height: 15,
                                  ),
                                  TextFormField(
                                    controller: controller.password.value,
                                    onChanged: ((String pass) {}),
                                    decoration: InputDecoration(
                                      icon: Icon(Icons.pin_drop),
                                      labelText: "Password",
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
                                  SizedBox(
                                    height: 30,
                                  ),
                                  button_solid_custom(
                                      onPressed: () {
                                        // controller.tambahuser();
                                        // controller.edituser(qwe.id.toString());
                                      },
                                      child: Text(
                                        'Edit User',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      width: double.infinity,
                                      height: 50)
                                ],
                              ));
                        }),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
        arguments: qwe);
  }

  void deleteuser(datauserController controller, DataUser arg) {
    Get.dialog(
      AlertDialog(
        title: header(
          title: 'Hapus Data User',
          icon: Icons.warning,
          icon_color: color_template().tritadery,
        ),
        contentPadding: EdgeInsets.all(10),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(12.0),
          ),
        ),
        content: Builder(
          builder: (context) {
            return Container(
                margin: EdgeInsets.all(10),
                width: context.width_query / 2.6,
                height: context.height_query / 2.6,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Center(
                      child: Text(
                        "Hapus " + arg.nama + ' ?',
                        style: font().header_black,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    button_solid_custom(
                        onPressed: () {
                          controller.deleteuser(arg.id.toString());
                        },
                        child: Text(
                          'Hapus',
                          style: font().primary_white,
                        ),
                        width: context.width_query,
                        height: context.height_query / 10),
                    button_border_custom(
                        onPressed: () {
                          Get.back();
                        },
                        child: Text(
                          'Batal',
                          style: font().primary,
                        ),
                        width: context.width_query,
                        height: context.height_query / 10)
                  ],
                ));
          },
        ),
      ),
    );
  }
}

// class edituserpop extends GetView<edituserController> {
//   const edituserpop({
//     Key? key,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       backgroundColor: Colors.transparent,
//       content: Center(
//         child: Container(
//           width: context.width_query / 1.5,
//           child: Card(
//             elevation: elevation().def_elevation,
//             //margin: EdgeInsets.all(30),
//             shape: RoundedRectangleBorder(
//               borderRadius: border_radius().def_border,
//               side: BorderSide(color: color_template().primary, width: 3.5),
//             ),
//
//             child: Padding(
//               padding: const EdgeInsets.all(15),
//               child: Column(
//                 children: [
//                   header(
//                     title: 'Edit User',
//                     icon: FontAwesomeIcons.person,
//                   ),
//                   SizedBox(
//                     height: 10,
//                   ),
//                   Expanded(
//                     child: SingleChildScrollView(
//                       child: Obx(() {
//                         return Form(
//                             key: controller.formKey.value,
//                             child: Column(
//                               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                               children: [
//                                 TextFormField(
//                                   //initialValue: controller.data.nama,
//                                   controller: controller.nama.value,
//                                   onChanged: ((String pass) {}),
//                                   decoration: InputDecoration(
//                                     icon: Icon(Icons.add_card),
//                                     labelText: 'Nama',
//                                     labelStyle: TextStyle(
//                                       color: Colors.black87,
//                                     ),
//                                     border: OutlineInputBorder(
//                                         borderRadius:
//                                             BorderRadius.circular(10)),
//                                     focusedBorder: OutlineInputBorder(
//                                         borderRadius:
//                                             BorderRadius.circular(10)),
//                                   ),
//                                   textAlign: TextAlign.center,
//                                   validator: (value) {
//                                     if (value!.isEmpty) {
//                                       return 'Please enter email';
//                                     }
//                                     return null;
//                                   },
//                                 ),
//                                 SizedBox(
//                                   height: 15,
//                                 ),
//                                 TextFormField(
//                                   controller: controller.email.value,
//                                   onChanged: ((String pass) {}),
//                                   decoration: InputDecoration(
//                                     icon: Icon(Icons.person),
//                                     labelText: "Email",
//                                     labelStyle: TextStyle(
//                                       color: Colors.black87,
//                                     ),
//                                     border: OutlineInputBorder(
//                                         borderRadius:
//                                             BorderRadius.circular(10)),
//                                     focusedBorder: OutlineInputBorder(
//                                         borderRadius:
//                                             BorderRadius.circular(10)),
//                                   ),
//                                   textAlign: TextAlign.center,
//                                   validator: (value) {
//                                     if (value!.isEmpty) {
//                                       return 'Please enter email';
//                                     }
//                                     return null;
//                                   },
//                                 ),
//                                 SizedBox(
//                                   height: 15,
//                                 ),
//                                 TextFormField(
//                                   controller: controller.hp.value,
//                                   onChanged: ((String pass) {}),
//                                   decoration: InputDecoration(
//                                     icon: Icon(Icons.pin_drop),
//                                     labelText: "Nomor HP",
//                                     labelStyle: TextStyle(
//                                       color: Colors.black87,
//                                     ),
//                                     border: OutlineInputBorder(
//                                         borderRadius:
//                                             BorderRadius.circular(10)),
//                                     focusedBorder: OutlineInputBorder(
//                                         borderRadius:
//                                             BorderRadius.circular(10)),
//                                   ),
//                                   textAlign: TextAlign.center,
//                                   validator: (value) {
//                                     if (value!.isEmpty) {
//                                       return 'Please enter email';
//                                     }
//                                     return null;
//                                   },
//                                 ),
//                                 SizedBox(
//                                   height: 15,
//                                 ),
//                                 TextFormField(
//                                   controller: controller.password.value,
//                                   onChanged: ((String pass) {}),
//                                   decoration: InputDecoration(
//                                     icon: Icon(Icons.pin_drop),
//                                     labelText: "Password",
//                                     labelStyle: TextStyle(
//                                       color: Colors.black87,
//                                     ),
//                                     border: OutlineInputBorder(
//                                         borderRadius:
//                                             BorderRadius.circular(10)),
//                                     focusedBorder: OutlineInputBorder(
//                                         borderRadius:
//                                             BorderRadius.circular(10)),
//                                   ),
//                                   textAlign: TextAlign.center,
//                                   validator: (value) {
//                                     if (value!.isEmpty) {
//                                       return 'Please enter email';
//                                     }
//                                     return null;
//                                   },
//                                 ),
//                                 SizedBox(
//                                   height: 30,
//                                 ),
//                                 button_solid_custom(
//                                     onPressed: () {
//                                       // controller.tambahuser();
//                                       controller.edituser(data.id);
//                                     },
//                                     child: Text(
//                                       'Edit User',
//                                       style: TextStyle(
//                                         fontWeight: FontWeight.bold,
//                                       ),
//                                     ),
//                                     width: double.infinity,
//                                     height: 50)
//                               ],
//                             ));
//                       }),
//                     ),
//                   )
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
