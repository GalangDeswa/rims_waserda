import 'package:get/get.dart';
import 'package:rims_waserda/Controllers/history%20controller/historyBinding.dart';

import '../Controllers/base menu controller/base_menu_binding.dart';
import '../Controllers/dashboard controller/dashboard_binding.dart';
import '../Controllers/detail produk controller/detail_produk_binding.dart';
import '../Controllers/kasir controller/kasir_binding.dart';
import '../Controllers/login controller/login_binding.dart';
import '../Controllers/pilih toko controller/pilih_toko_binding.dart';
import '../Controllers/produk controller/tambah_produk_binding.dart';
import '../Controllers/reset password controller/reset_password_binding.dart';
import '../Controllers/splash controller/splash_binding.dart';
import '../Controllers/user controller/tambah_user_binding.dart';
import '../Controllers/verifikasi controller/verification_binding.dart';
import '../Views/Dashboard/dashboard.dart';
import '../Views/Login/login.dart';
import '../Views/base_menu/base_menu.dart';
import '../Views/detail produk/detail produk.dart';
import '../Views/history/history.dart';
import '../Views/kasir/kasir.dart';
import '../Views/pilih toko/pilih_toko.dart';
import '../Views/reset password/reset_password.dart';
import '../Views/splash/splash.dart';
import '../Views/tambah produk/tambah_produk.dart';
import '../Views/tambah_user/tambah_user.dart';
import '../Views/verification/verification.dart';

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
  GetPage(name: "/history", page: () => history(), binding: historyBinding())
];
