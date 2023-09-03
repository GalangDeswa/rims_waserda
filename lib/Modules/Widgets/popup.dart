import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:rims_waserda/Modules/Widgets/toast.dart';
import 'package:rims_waserda/Modules/base%20menu/controller_base_menu.dart';
import 'package:rims_waserda/Modules/kasir/model_kasir.dart';
import 'package:rims_waserda/Modules/pelanggan/data%20pelanggan/controller_data_pelanggan.dart';
import 'package:rims_waserda/Modules/produk/data%20produk/controller_data_produk.dart';
import 'package:rims_waserda/Modules/produk/data%20produk/model_produk.dart';
import 'package:rims_waserda/Modules/produk/jenis%20produk/model_jenisproduk.dart';
import 'package:rims_waserda/Modules/user/data%20user/controller_data_user.dart';
import 'package:rims_waserda/Modules/user/edit%20user/controller_edit_user.dart';

import '../../Templates/setting.dart';
import '../../db_helper.dart';
import '../beban/data beban/controller_beban.dart';
import '../beban/data beban/model_data_beban.dart';
import '../beban/edit jenis beban/model_jenis_beban.dart';
import '../history/Controller_history.dart';
import '../history/model_penjualan.dart';
import '../kasir/controller_kasir.dart';
import '../kasir/model_meja.dart';
import '../pelanggan/data pelanggan/model_data_pelanggan.dart';
import '../user/data user/model_data_user.dart';
import 'buttons.dart';
import 'header.dart';

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
                        'Tidak',
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

  deletemejadetail(kasirController controller, DataMeja arg) {
    Get.dialog(AlertDialog(
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
                      'Hapus pesanan ' + arg.namaProduk! + ' ?',
                      style: font().header_black,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  button_solid_custom(
                      onPressed: () async {
                        await DBHelper().DELETEITEMMEJADETAIL(
                            'meja_detail', arg.idProdukLocal!);
                        List<DataMeja> datadetail =
                            await controller.fetchmejadetail(arg.idMeja);
                        List<DataMeja> datameja = await controller.fetchmeja();

                        List<int> subtotal = [];

                        datadetail.forEach((e) {
                          var harga = e.harga!.round() -
                              (e.harga!.round() * e.diskonBrg!.round() / 100)
                                  .round();
                          subtotal.add(e.harga! * e.qty!);
                        });
                        var foldsubtotal = subtotal.fold(
                            0,
                            (previousValue, element) =>
                                previousValue + element);

                        var filter = datameja
                            .map((e) => e)
                            .where((element) =>
                                element.meja.toString() ==
                                arg.idMeja.toString())
                            .first;
                        var diskonkasir = filter.diskonKasir;
                        var totalsub = foldsubtotal - diskonkasir!.round();
                        var ppn = 11 / 100 * totalsub;

                        var total = totalsub + ppn!.toInt();

                        await DBHelper().UPDATEMEJA(
                            table: 'meja',
                            data: controller.updatesubtotalmeja(
                                foldsubtotal, total, ppn),
                            id: arg.idMeja);

                        List<DataMeja> check =
                            await controller.fetchmejadetail(arg.idMeja);

                        if (check.isEmpty) {
                          print('empety');

                          await DBHelper().DELETEMEJAITEMKOSONG(
                              'meja', arg.idMeja.toString());
                          await controller.fetchmeja();
                          Get.back();
                        } else {
                          await controller.fetchmeja();
                          Get.back();
                        }
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

  deletemeja(kasirController controller, DataMeja arg) {
    Get.dialog(AlertDialog(
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
                      'Batalkan pesana meja ' + arg.meja!,
                      style: font().header_black,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  button_solid_custom(
                      onPressed: () async {
                        await DBHelper().DELETEMEJA('meja', arg.id!);
                        await controller.fetchmeja();
                        List<DataMeja> data =
                            await controller.fetchmejadetail(arg.meja);
                        Future.forEach(data, (element) async {
                          // var query = data
                          //     .where((element) => element.idMeja == arg.meja)
                          //     .first;
                          await DBHelper().DELETEMEJADETAIL(
                              'meja_detail', int.parse(arg.meja!));
                        });

                        Get.back();
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
                      Text(controller.namakasir, style: font().reguler_bold),
                    ],
                  ),
                  controller.bayarprebill.value == false
                      ? Container()
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Meja:', style: font().reguler),
                            Text(controller.nomormejabayarprebill.value,
                                style: font().reguler_bold),
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
                          style: font().reguler_bold),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Total harga :', style: font().reguler),
                      Text(
                          'Rp. ' +
                              controller.total
                                  .toStringAsFixed(0)
                                  .replaceAll(RegExp(r'[^\w\s]+'), '')
                                  .replaceAllMapped(
                                      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                                      (Match m) => '${m[1]},'),
                          style: font().reguler_bold),
                    ],
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Pembayaran:', style: font().reguler),
                      Text(
                          controller.keypadController.value.text.isNotEmpty
                              ? 'Rp. ' + controller.keypadController.value.text
                              : '-',
                          style: font().reguler_bold),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Kembalian :', style: font().reguler),
                      Text(
                          controller.kembalian.value.text.isNotEmpty
                              ? 'Rp. ' + controller.kembalian.value.text
                              : '0',
                          style: font().reguler_bold),
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
                                  ? 'Hutang'
                                  : '-',
                          style: font().reguler_bold),
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
                            popprintstruk(context, controller);
                          },
                          child: Text(controller.groupindex.value != 2
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

  void popkonfirmasiprebill(
      BuildContext context,
      kasirController controller,
      List<DataMeja> prebill,
      String nomor_meja,
      int total_prebill,
      diskon_kasir,
      subtotal,
      ppn) {
    var total_qty = prebill
        .where((element) => element.idMeja.toString() == nomor_meja)
        .toList();
    print(
        '------------------------------------------------------ total item pre bill ------------------------------------------------------');
    print(total_qty.map((e) => e.namaProduk));

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
              'Konfirmasi pembayaran open bill',
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
                      Text(controller.namakasir, style: font().reguler_bold),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Meja:', style: font().reguler),
                      Text(nomor_meja, style: font().reguler_bold),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Total item :', style: font().reguler),
                      Text(
                          total_qty
                              .map((e) => e.qty)
                              .fold(
                                  0,
                                  (previous, current) =>
                                      previous + current!.toInt())
                              .toString(),
                          style: font().reguler_bold),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Total harga :', style: font().reguler),
                      Text('Rp. ' + total_prebill.toString(),
                          style: font().reguler_bold),
                    ],
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Pembayaran:', style: font().reguler),
                      Text(
                          controller.keypadController_prebill.value.text
                                  .isNotEmpty
                              ? 'Rp. ' +
                                  controller.keypadController_prebill.value.text
                              : '-',
                          style: font().reguler_bold),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Kembalian :', style: font().reguler),
                      Text(
                          controller.kembalian_prebill.value.text.isNotEmpty
                              ? 'Rp. ' + controller.kembalian_prebill.value.text
                              : '0',
                          style: font().reguler_bold),
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
                                  ? 'Hutang'
                                  : '-',
                          style: font().reguler_bold),
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
                          onPressed: () async {
                            popprintstrukmeja(
                                context,
                                controller,
                                prebill,
                                nomor_meja,
                                total_prebill,
                                diskon_kasir,
                                subtotal,
                                ppn);
                          },
                          child: Text(controller.groupindex.value != 2
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

  void popprintstruk(BuildContext context, kasirController controller) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
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
              height: context.height_query / 4,
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
                        'Cetak struk ?',
                        style: font().header,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      button_border_custom(
                          onPressed: () async {
                            await controller
                                .pembayaranlocal(controller.id_toko);
                          },
                          child: Text(
                            'Tidak',
                            style: TextStyle(color: Colors.black),
                          ),
                          width: 100,
                          height: 50),
                      button_solid_custom(
                          onPressed: () async {
                            print(
                                'cetak struk local------------------------------->');
                            print(controller.listPrinter.toString());
                            print(controller.isConnected.value == true);
                            if ((await controller.printer.isConnected)!) {
                              await controller.printstrukpembayaran();
                              print('connn');
                            } else {
                              Get.find<base_menuController>()
                                  .popprinter('normal');
                              print('noononon');
                            }
                          },
                          child: Text(controller.groupindex.value != 2
                              ? 'Cetak'
                              : 'Cetak'),
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

  void popprintstrukulang(
      BuildContext context, historyController controller, DataPenjualan d) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
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
              height: context.height_query / 4,
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
                        'Cetak ulang struk ?',
                        style: font().header,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      button_border_custom(
                          onPressed: () async {
                            Get.back();
                          },
                          child: Text(
                            'Tidak',
                            style: TextStyle(color: Colors.black),
                          ),
                          width: 100,
                          height: 50),
                      button_solid_custom(
                          onPressed: () async {
                            print(
                                'cetak struk local------------------------------->');
                            print(controller.listPrinter.toString());
                            print(controller.isConnected.value == true);
                            if ((await controller.printer.isConnected)!) {
                              await controller.printstrukpembayaranulang(d);
                              print('connn');
                            } else {
                              Get.find<base_menuController>()
                                  .popprinterulang(d);
                              print('noononon');
                            }
                          },
                          child: Text('Cetak'),
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

  void popprintstrukmeja(
      BuildContext context,
      kasirController controller,
      List<DataMeja> prebill,
      String nomor_meja,
      int total_prebill,
      diskon_kasir,
      subtotal,
      ppn) {
    print('print struk meja-----------------------');
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
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
              height: context.height_query / 4,
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
                        'Cetak struk ?',
                        style: font().header,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      button_border_custom(
                          onPressed: () async {
                            print(
                                'bayar local------------------------------->');
                            await controller.pembayaranlocalprebill(
                                controller.id_toko,
                                nomor_meja,
                                total_prebill,
                                diskon_kasir);
                            await controller.deletemeja(nomor_meja);
                            var items = prebill
                                .where((element) =>
                                    element.idMeja.toString() == nomor_meja)
                                .toList();
                            await Future.forEach(items, (e) async {
                              await controller.deletemejadetail(e.idMeja);
                              await controller.fetchmeja();
                              // Get.back(closeOverlays: true);
                            });
                          },
                          child: Text(
                            'Tidak',
                            style: TextStyle(color: Colors.black),
                          ),
                          width: 100,
                          height: 50),
                      button_solid_custom(
                          onPressed: () async {
                            print(
                                'cetak struk local------------------------------->');
                            print(controller.listPrinter.toString());
                            print(controller.isConnected == true);

                            if (controller.groupindex == 1) {
                              if ((await controller.printer.isConnected)!) {
                                if (controller.logo == '-') {
                                  controller.printer
                                      .printImage(controller.pathImage.value);
                                } else {
                                  controller.printer.printImageBytes(
                                      base64Decode(controller.logo));
                                }
                                controller.printer
                                    .printCustom(controller.namatoko, 3, 1);
                                controller.printer
                                    .printCustom(controller.alamat_toko, 0, 3);
                                controller.printer.printCustom(
                                    '-------------------------------', 1, 3);
                                controller.printer.printLeftRight(
                                    controller.tgl_penjualan.isEmpty
                                        ? controller.dateFormatprint
                                            .format(DateTime.now())
                                        : controller.dateFormatprint.format(
                                            controller.tgl_penjualan.first!),
                                    controller.kasir,
                                    0);
                                controller.printer.printCustom(
                                    '-------------------------------', 1, 3);
                                controller.printer.printNewLine();
                                //item-------------------------------------------------
                                controller.printer.print4Column(
                                    'Produk', 'QTY', 'Harga', 'Subtotal', 0,
                                    format: "%-17s %-4s %-10s %5s %n");
                                controller.printer.printCustom(
                                    '-------------------------------', 1, 3);
                                controller.cachemejadetail.forEach((e) {
                                  String nama = e.namaProduk!;
                                  if (nama.length > 15) {
                                    nama =
                                        e.namaProduk!.substring(0, 15) + '...';
                                  }
                                  controller.printer.print4Column(
                                      nama,
                                      e.qty.toString(),
                                      format: "%-17s %-4s %-10s %5s %n",
                                      controller.nominal.format(e.harga),
                                      controller.nominal
                                          .format((e.harga! * e.qty!.toInt())),
                                      0);
                                  controller.printer.printCustom(
                                      '-------------------------------', 1, 2);
                                });
                                //  await controller.subtotalval();
                                // controller.printer.print3Column(
                                //     'Subtotal',
                                //     ':',
                                //     controller.nominal
                                //         .format(controller.subtotal.value),
                                //     0);
                                controller.printer.printLeftRight('Subtotal :',
                                    controller.nominal.format(subtotal), 0);
                                // controller.printer.printCustom(
                                //     '-------------------------------', 1, 1);
                                // await controller.hitungbesardiskonkasir();
                                // controller.printer.print3Column(
                                //     'Total diskon',
                                //     ':',
                                //     controller.nominal.format(
                                //         controller.jumlahdiskonkasir.value),
                                //     0);

                                controller.printer.printLeftRight(
                                    'Total diskon :',
                                    controller.nominal.format(diskon_kasir),
                                    0);

                                controller.printer.printCustom(
                                    '-------------------------------', 1, 1);
                                // await controller.totalval();
                                // controller.printer.print3Column(
                                //   'PPN',
                                //   ':',
                                //   controller.nominal
                                //       .format(controller.ppn.value),
                                //   0,
                                // );
                                // controller.printer.print3Column(
                                //   'Total',
                                //   ':',
                                //   controller.nominal
                                //       .format(controller.total.value),
                                //   0,
                                // );
                                // controller.printer.print3Column(
                                //   'Tunai',
                                //   ':',
                                //   controller.nominal
                                //       .format(controller.bayarvalue.value),
                                //   0,
                                // );
                                // controller.printer.print3Column(
                                //   'Kembalian',
                                //   ':',
                                //   controller.kembalian.value.text.isNotEmpty
                                //       ? controller.kembalian.value.text
                                //       : '0',
                                //   0,
                                // );

                                controller.printer.printLeftRight(
                                    'PPN :', controller.nominal.format(ppn), 0);
                                controller.printer.printLeftRight(
                                    'Total :',
                                    controller.nominal.format(total_prebill),
                                    0);
                                controller.printer.printLeftRight(
                                    'Tunai :',
                                    controller.nominal.format(
                                        controller.bayarvalue_prebill.value),
                                    0);
                                controller.printer.printLeftRight(
                                    'Kembalian :',
                                    controller.kembalian_prebill.value.text
                                            .isNotEmpty
                                        ? controller.nominal.format(
                                            controller.balikvalue_prebill.value)
                                        : '0',
                                    0);
                                controller.printer.printCustom(
                                    '-------------------------------', 1, 1);
                                controller.printer
                                    .printCustom('-- Terima Kasih --', 0, 1);
                                controller.printer.printCustom(
                                    '-------------------------------', 1, 1);
                                controller.printer.printImage(
                                    controller.printstruklogo.value);
                                controller.printer.printCustom(
                                    '*** Powered by RIMS ***', 0, 1);
                                controller.printer
                                    .printCustom('www.rims.co.id', 0, 1);
                                controller.printer.printCustom(
                                    '-------------------------------', 1, 1);
                                controller.printer.printNewLine();
                                controller.printer.paperCut();
                                //proses bayar local--------------------------
                                print(
                                    'bayar local------------------------------->');
                                await controller.pembayaranlocalprebill(
                                    controller.id_toko,
                                    nomor_meja,
                                    total_prebill,
                                    diskon_kasir);
                                await controller.deletemeja(nomor_meja);
                                var items = prebill
                                    .where((element) =>
                                        element.idMeja.toString() == nomor_meja)
                                    .toList();
                                await Future.forEach(items, (e) async {
                                  await controller.deletemejadetail(e.idMeja);
                                  await controller.fetchmeja();
                                  // Get.back(closeOverlays: true);
                                });
                              } else {
                                Get.showSnackbar(toast().bottom_snackbar_error(
                                    'Error', 'Printer belum terkoneksi'));
                              }
                            } else {
                              if ((await controller.printer.isConnected)!) {
                                var pelanggan = controller.list_pelanggan_local
                                    .where((e) =>
                                        e.idLocal ==
                                        controller.id_pelanggan.value)
                                    .first;
                                if (controller.logo == '-') {
                                  controller.printer
                                      .printImage(controller.pathImage.value);
                                } else {
                                  controller.printer.printImageBytes(
                                      base64Decode(controller.logo));
                                }
                                controller.printer
                                    .printCustom(controller.namatoko, 3, 1);
                                controller.printer
                                    .printCustom(controller.alamat_toko, 0, 3);
                                controller.printer.printCustom(
                                    '-------------------------------', 1, 3);
                                controller.printer.printLeftRight(
                                    controller.tgl_penjualan.isEmpty
                                        ? controller.dateFormatprint
                                            .format(DateTime.now())
                                        : controller.dateFormatprint.format(
                                            controller.tgl_penjualan.first!),
                                    controller.kasir,
                                    0);
                                controller.printer.printCustom(
                                    '-------------------------------', 1, 3);
                                controller.printer.printNewLine();
                                controller.printer
                                    .printCustom('--- Hutang ---', 2, 1);
                                controller.printer.printNewLine();
                                //item-------------------------------------------------
                                controller.printer.print4Column(
                                    'Produk', 'QTY', 'Harga', 'Subtotal', 0,
                                    format: "%-17s %-4s %-10s %5s %n");
                                controller.printer.printCustom(
                                    '-------------------------------', 1, 3);
                                controller.cachemejadetail.forEach((e) {
                                  String nama = e.namaProduk!;
                                  if (nama.length > 15) {
                                    nama =
                                        e.namaProduk!.substring(0, 15) + '...';
                                  }
                                  controller.printer.print4Column(
                                      nama,
                                      e.qty.toString(),
                                      format: "%-17s %-4s %-10s %5s %n",
                                      controller.nominal.format(e.harga),
                                      controller.nominal
                                          .format((e.harga! * e.qty!.toInt())),
                                      0);
                                  controller.printer.printCustom(
                                      '-------------------------------', 1, 2);
                                });
                                await controller.subtotalval();
                                controller.printer.printLeftRight('Subtotal :',
                                    controller.nominal.format(subtotal), 0);
                                // controller.printer.printCustom(
                                //     '-------------------------------', 1, 1);
                                await controller.hitungbesardiskonkasir();
                                controller.printer.printLeftRight(
                                    'Total diskon :',
                                    controller.nominal.format(diskon_kasir),
                                    0);
                                controller.printer.printCustom(
                                    '-------------------------------', 1, 1);
                                controller.printer.printLeftRight(
                                  'Nama pelanggan :',
                                  pelanggan.namaPelanggan!,
                                  0,
                                );
                                await controller.totalval();
                                controller.printer.printLeftRight(
                                  'PPN :',
                                  controller.nominal.format(ppn),
                                  0,
                                );
                                controller.printer.printLeftRight(
                                  'Total Hutang :',
                                  controller.nominal.format(total_prebill),
                                  0,
                                );
                                controller.printer.printLeftRight(
                                  'Tanggal hutang :',
                                  controller.tgl_penjualan.isEmpty
                                      ? controller.dateFormatprint
                                          .format(DateTime.now())
                                      : controller.dateFormatprint.format(
                                          controller.tgl_penjualan.first!),
                                  0,
                                );

                                controller.printer.printCustom(
                                    '-------------------------------', 1, 1);
                                controller.printer
                                    .printCustom('-- Terima Kasih --', 0, 1);
                                controller.printer.printCustom(
                                    '-------------------------------', 1, 1);
                                controller.printer.printImage(
                                    controller.printstruklogo.value);
                                controller.printer.printCustom(
                                    '*** Powered by RIMS ***', 0, 1);
                                controller.printer
                                    .printCustom('www.rims.co.id', 0, 1);
                                controller.printer.printCustom(
                                    '-------------------------------', 1, 1);
                                controller.printer.printNewLine();
                                controller.printer.paperCut();

                                print(
                                    'bayar local------------------------------->');
                                await controller.pembayaranlocalprebill(
                                    controller.id_toko,
                                    nomor_meja,
                                    total_prebill,
                                    diskon_kasir);
                                await controller.deletemeja(nomor_meja);
                                var items = prebill
                                    .where((element) =>
                                        element.idMeja.toString() == nomor_meja)
                                    .toList();
                                await Future.forEach(items, (e) async {
                                  await controller.deletemejadetail(e.idMeja);
                                  await controller.fetchmeja();
                                  // Get.back(closeOverlays: true);
                                });
                              } else {
                                Get.showSnackbar(toast().bottom_snackbar_error(
                                    'Error', 'Printer belum terkoneksi'));
                              }
                            }
                          },
                          child: Text(controller.groupindex.value != 2
                              ? 'Cetak'
                              : 'Cetak'),
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

  void popprintstrukprebill(
      BuildContext context,
      kasirController controller,
      List<DataMeja> prebill,
      String nomor_meja,
      int total_prebill,
      diskon_kasir) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
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
              height: context.height_query / 4,
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
                        'Cetak struk open bill ?',
                        style: font().header,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      button_border_custom(
                          onPressed: () async {
                            await controller.addmeja();

                            Get.back(closeOverlays: true);
                          },
                          child: Text(
                            'Tidak',
                            style: TextStyle(color: Colors.black),
                          ),
                          width: 100,
                          height: 50),
                      button_solid_custom(
                          onPressed: () async {
                            print(
                                'cetak struk local prebill------------------------------->');
                            print(controller.listPrinter.toString());
                            print(controller.isConnected == true);

                            if ((await controller.printer.isConnected)!) {
                              controller.printstrukprebill();
                            } else {
                              Get.find<base_menuController>()
                                  .popprinter('prebill');
                            }
                          },
                          child: Text(controller.groupindex.value != 2
                              ? 'Cetak'
                              : 'Cetak'),
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
