import 'package:get/get.dart';
import 'package:rims_waserda/Modules/history/binding_history.dart';

import '../Modules/dashboard/view_dashboard_base.dart';
import '../Modules/history/view_history_base.dart';
import '../Modules/kasir/view_kasir_base.dart';
import '../Modules/produk/detail produk/view_detail_produk_base.dart';
import '../Modules/produk/tambah produk/view_tambah_produk_base.dart';
import '../Modules/reset password/binding_reset_password.dart';
import '../Modules/reset password/view_reset_password_base.dart';
import '../Modules/toko/view_toko_base.dart';
import '../Modules/user/tambah user/binding_tambah_user.dart';
import '../Modules/user/tambah user/view_tambah_user_base.dart';
import '../Modules/user/verification/binding_verification.dart';
import '../Modules/Login/binding_login.dart';
import '../Modules/Login/view_login_base.dart';
import '../Modules/Splash/binding_splash.dart';
import '../Modules/Splash/view_splash_base.dart';
import '../Modules/base menu/binding_base_menu.dart';
import '../Modules/base menu/view_base_menu_base.dart';
import '../Modules/beban/binding_beban.dart';
import '../Modules/beban/view_beban.dart';
import '../Modules/dashboard/binding_dashboard.dart';
import '../Modules/kasir/binding_kasir.dart';
import '../Modules/produk/detail produk/binding_detail_produk.dart';
import '../Modules/produk/tambah produk/binding_tambah_produk.dart';
import '../Modules/toko/binding_toko.dart';
import '../Modules/user/verification/view_verification_base.dart';

final List<GetPage<dynamic>> route = [
  GetPage(name: "/splash", page: () => splash(), binding: splashBinding()),
  GetPage(
      name: "/pilih_toko",
      page: () => pilih_toko(),
      binding: pilih_tokoBinding()),
  GetPage(name: "/login", page: () => login(), binding: loginBinding()),
  GetPage(
      name: "/base_menu", page: () => base_menu(), binding: base_menuBinding()),
  GetPage(
      name: "/dashboard", page: () => dashboard(), binding: dashboardBinding()),
  GetPage(name: "/kasir", page: () => kasir(), binding: kasirBinding()),
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
      binding: tambah_produkBinding()),
  GetPage(
      name: "/detail_produk",
      page: () => detail_Produk(),
      binding: detail_produkBinding()),
  GetPage(name: "/history", page: () => history(), binding: historyBinding()),
  GetPage(name: "/beban", page: () => beban(), binding: bebanBinding())
];
