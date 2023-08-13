import 'package:get/get.dart';
import 'package:rims_waserda/Modules/beban/data%20beban/view_tambah_beban_base.dart';
import 'package:rims_waserda/Modules/history/binding_detail_penjualan.dart';
import 'package:rims_waserda/Modules/history/binding_history.dart';
import 'package:rims_waserda/Modules/history/view_detail_penjualan.dart';
import 'package:rims_waserda/Modules/pelanggan/data%20pelanggan/binding_data_pelanggan.dart';
import 'package:rims_waserda/Modules/pelanggan/data%20pelanggan/view_data_pelanggan_base.dart';
import 'package:rims_waserda/Modules/pelanggan/edit%20pelanggan/view_edit_pelanggan_base.dart';
import 'package:rims_waserda/Modules/pelanggan/hutang/view_hutang_table.dart';
import 'package:rims_waserda/Modules/pembelian/binding_pembelian.dart';
import 'package:rims_waserda/Modules/pembelian/view_pembelian_base.dart';
import 'package:rims_waserda/Modules/produk/data%20produk/binding_data_produk.dart';
import 'package:rims_waserda/Modules/produk/edit%20produk/binding_edit_produk.dart';
import 'package:rims_waserda/Modules/produk/jenis%20produk/binding_edit_jenis.dart';
import 'package:rims_waserda/Modules/produk/jenis%20produk/view_edit_jenis.dart';
import 'package:rims_waserda/Modules/produk/jenis%20produk/view_tambah_jenis.dart';
import 'package:rims_waserda/Modules/user/edit%20user/view_edit_user_password.dart';
import 'package:rims_waserda/Modules/user/toko/binding_tokov2.dart';
import 'package:rims_waserda/Modules/user/toko/view_edit_tokov2_base.dart';

import '../Modules/Login/binding_login.dart';
import '../Modules/Login/view_login_base.dart';
import '../Modules/Splash/binding_splash.dart';
import '../Modules/Splash/view_intro.dart';
import '../Modules/Splash/view_splash_base.dart';
import '../Modules/base menu/binding_base_menu.dart';
import '../Modules/base menu/view_base_menu_base.dart';
import '../Modules/beban/data beban/binding_beban.dart';
import '../Modules/beban/data beban/view_beban_base.dart';
import '../Modules/beban/edit beban/binding_edit_beban.dart';
import '../Modules/beban/edit beban/view_edit_beban_base.dart';
import '../Modules/beban/edit jenis beban/binding_edit_jenis_beban.dart';
import '../Modules/beban/edit jenis beban/view_edit_jenis_beban.dart';
import '../Modules/beban/edit jenis beban/view_tambah_jenis_beban.dart';
import '../Modules/dashboard/binding_dashboard.dart';
import '../Modules/dashboard/view_dashboard_base.dart';
import '../Modules/history/view_history_base.dart';
import '../Modules/kasir/binding_kasir.dart';
import '../Modules/kasir/view_kasir_basev2.dart';
import '../Modules/laporan/binding_laporan.dart';
import '../Modules/laporan/view_laporan_base.dart';
import '../Modules/pelanggan/data pelanggan/view_tambah_pelanggan_base.dart';
import '../Modules/pelanggan/edit pelanggan/binding_edit_pelanggan.dart';
import '../Modules/pelanggan/hutang/biniding_hutang.dart';
import '../Modules/produk/detail produk/binding_detail_produk.dart';
import '../Modules/produk/detail produk/view_detail_produk_base.dart';
import '../Modules/produk/edit produk/view_edit_produk_base.dart';
import '../Modules/produk/tambah produk/view_tambah_produk_base.dart';
import '../Modules/reset password/binding_reset_password.dart';
import '../Modules/reset password/view_reset_password_base.dart';
import '../Modules/toko/binding_toko.dart';
import '../Modules/toko/view_toko_base.dart';
import '../Modules/user/edit user/binding_edit_user.dart';
import '../Modules/user/edit user/view_edit_user_base.dart';
import '../Modules/user/tambah user/binding_tambah_user.dart';
import '../Modules/user/tambah user/view_tambah_user_base.dart';
import '../Modules/user/verification/binding_verification.dart';
import '../Modules/user/verification/view_verification_base.dart';

final List<GetPage<dynamic>> route = [
  GetPage(name: "/splash", page: () => splash(), binding: splashBinding()),
  GetPage(name: "/intro", page: () => intro(), binding: splashBinding()),
  GetPage(
      name: "/pilih_toko",
      page: () => pilih_toko(),
      binding: pilih_tokoBinding()),
  GetPage(name: "/login", page: () => login(), binding: loginBinding()),
  GetPage(
      name: "/base_menu", page: () => base_menu(), binding: base_menuBinding()),
  GetPage(
      name: "/dashboard", page: () => dashboard(), binding: dashboardBinding()),
  GetPage(name: "/kasir", page: () => kasirv2(), binding: kasirBinding()),
  GetPage(
      name: "/reset_password",
      page: () => reset_password(),
      binding: reset_passwordBinding()),
  GetPage(
      name: "/verification",
      page: () => verification(),
      binding: verificationBinding()),
  GetPage(
      name: "/tambah_user",
      page: () => tambah_user(),
      binding: tambah_userBinding()),
  GetPage(
      name: "/tambah_produk",
      page: () => tambah_produk(),
      binding: produkBinding()),
  GetPage(
      name: "/detail_produk",
      page: () => detail_Produk(),
      binding: detail_produkBinding()),
  GetPage(name: "/beban", page: () => beban(), binding: bebanBinding()),
  GetPage(
      name: "/edit_user", page: () => edit_user(), binding: edituserBinding()),
  GetPage(
      name: "/edit_user_password",
      page: () => edit_user_password(),
      binding: edituserBinding()),
  GetPage(
      name: "/tambah_jenis",
      page: () => tambah_jenis(),
      binding: produkBinding()),
  GetPage(
      name: "/edit_jenis",
      page: () => edit_jenis(),
      binding: editjenisBinding()),
  GetPage(
      name: "/tambah_jenis_beban",
      page: () => tambah_jenis_beban(),
      binding: bebanBinding()),
  GetPage(
      name: "/edit_jenis_beban",
      page: () => edit_jenis_beban(),
      binding: editjenisbebanBinding()),
  GetPage(
      name: "/tambah_beban",
      page: () => tambah_beban_base(),
      binding: bebanBinding()),
  GetPage(
      name: "/edit_beban",
      page: () => edit_beban(),
      binding: editbebanBinding()),
  GetPage(name: "/beban", page: () => beban(), binding: bebanBinding()),
  GetPage(name: "/laporan", page: () => laporan(), binding: laporanBinding()),
  GetPage(name: "/history", page: () => history(), binding: historyBinding()),
  GetPage(
      name: "/detail_penjualan",
      page: () => detail_penjualan(),
      binding: detailpenjualanBinding()),
  GetPage(
      name: "/edit_produk",
      page: () => edit_produk(),
      binding: editprodukBinding()),
  GetPage(
      name: "/pelanggan", page: () => pelanggan(), binding: pelangganBinding()),
  GetPage(
      name: "/tambah_pelanggan",
      page: () => tambah_pelanggan(),
      binding: pelangganBinding()),
  GetPage(
      name: "/edit_pelanggan",
      page: () => edit_pelanggan(),
      binding: editpelangganBinding()),
  GetPage(
      name: "/hutang", page: () => hutang_table(), binding: hutangBinding()),
  GetPage(
      name: "/edit_tokov2",
      page: () => edit_tokov2(),
      binding: tokov2Binding()),
  GetPage(
      name: "/pembelian", page: () => pembelian(), binding: pembelianBinding()),
];
