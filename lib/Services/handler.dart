import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:rims_waserda/Services/api.dart';

class check_conn {
  static Future<bool> check() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      try {
        final result = await InternetAddress.lookup("www.google.com");
        if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
          print('connected');
          return true;
        }
      } on SocketException catch (_) {
        print('not connected');
        Get.snackbar('Error', 'Tidak bisa mengakses internet');
      }
    } else if (connectivityResult == ConnectivityResult.wifi) {
      //Get.snackbar('conn', 'wifi');
      try {
        final result = await InternetAddress.lookup("www.google.com");
        if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
          print('connected');
          return true;
        }
      } on SocketException catch (_) {
        print('not connected');
        Get.snackbar('Error', 'Tidak bisa mengakses internet');
      }
    } else {
      // AppAlert.getOnlyAlert(FAILED, NO_INTERNET_CONNECTION);
      Get.snackbar("Gagal", "tidak ada jaringan");
      //     backgroundColor: AppColor.APP_BUTTON, colorText: Colors.white);
    }
    return false;
  }
}

class REST extends GetConnect {
  static Future<dynamic> login(String email, password) async {
    var response = await http.post(link().POST_login,
        body: ({
          'email': email,
          'password': password,
        }));
    if (response.statusCode == 200) {
      print('LOGIN network handler----------------------------------------->');

      //var data = json.decode(response.body);
      //var data = response.body;
      var data = response;
      print(data);
      print(response.statusCode);
      return (data);
    } else {
      print('LOGIN network handler----------------------------------------->');
      print('gagal POST LOGIN');
      print(response.statusCode);
      print(response.body);
    }
  }

  static Future<dynamic> loadToko(String token, idtoko) async {
    var response = await http.post(link().POST_loadtoko,
        body: ({
          'token': token,
          'id_toko': idtoko,
        }));
    if (response.statusCode == 200) {
      print(
          'LOAD TOKO network handler----------------------------------------->');
      var data = json.decode(response.body);
      //var data = response.body;
      print(data);
      print(response.statusCode);
      return (data);
    } else {
      print(
          'LOAD TOKO network handler----------------------------------------->');
      print('gagal POST LOADTOKO');
      print(response.statusCode);
      print(response.body);
    }
  }

  static Future<dynamic> userData(String token, idtoko) async {
    var response = await http.post(link().POST_userdata,
        body: ({
          'token': token,
          'id_toko': idtoko,
        }));
    if (response.statusCode == 200) {
      print(
          'USER DATA network handler----------------------------------------->');
      var data = json.decode(response.body);
      //var data = response.body;
      print(data);
      print(response.statusCode);
      return (data);
    } else {
      print(
          'USER DATA network handler----------------------------------------->');
      print('gagal USER DATA');
      print(response.statusCode);
      print(response.body);
    }
  }

  static Future<dynamic> userTambah(
      String token, idtoko, iduser, nama, email, password, role, hp) async {
    var response = await http.post(link().POST_usertambah,
        body: ({
          'token': token,
          'id_toko': idtoko,
          'id_user': iduser,
          'nama': nama,
          'email': email,
          'password': password,
          'role': role,
          'hp': hp,
        }));
    if (response.statusCode == 200) {
      print(
          'USER TAMBAH network handler----------------------------------------->');
      var data = json.decode(response.body);
      //var data = response.body;
      print(data);
      print(response.statusCode);
      return (data);
    } else {
      print(
          'USER TAMBAH network handler----------------------------------------->');
      print('gagal USER TAMBAH');
      print(response.statusCode);
      print(response.body);
    }
  }

  static Future<dynamic> userEdit(
      String token, idtoko, id, iduser, nama, email, hp) async {
    var response = await http.post(link().POST_useredit,
        body: ({
          'token': token,
          'id_toko': idtoko,
          'id': id.toString(),
          'id_user': iduser.toString(),
          'nama': nama,
          'email': email,
          'hp': hp,
        }));
    if (response.statusCode == 200) {
      print(
          'USER EDIT network handler----------------------------------------->');
      var data = json.decode(response.body);
      //var data = response.body;
      print(data);
      print(response.statusCode);
      return (data);
    } else {
      print(
          'USER EDIT network handler----------------------------------------->');
      print('gagal USER EDIT');
      print(response.statusCode);
      print(response.body);
    }
  }

  static Future<dynamic> userEditPassword(
    String token,
    idtoko,
    id,
    iduser,
    password,
  ) async {
    var response = await http.post(link().POST_usereditpassword,
        body: ({
          'token': token,
          'id_toko': idtoko,
          'id': id.toString(),
          'id_user': iduser.toString(),
          'password': password,
        }));
    if (response.statusCode == 200) {
      print(
          'USER EDIT network handler----------------------------------------->');
      var data = json.decode(response.body);
      //var data = response.body;
      print(data);
      print(response.statusCode);
      return (data);
    } else {
      print(
          'USER EDIT network handler----------------------------------------->');
      print('gagal USER EDIT');
      print(response.statusCode);
      print(response.body);
    }
  }

  static Future<dynamic> userDelete(String token, idtoko, id) async {
    var response = await http.post(link().POST_userdelete,
        body: ({
          'token': token,
          'id_toko': idtoko,
          'id': id.toString(),
        }));
    if (response.statusCode == 200) {
      print(
          'USER DELETE network handler----------------------------------------->');
      var data = json.decode(response.body);
      //var data = response.body;
      print(data);
      print(response.statusCode);
      return (data);
    } else {
      print(
          'USER DELETE network handler----------------------------------------->');
      print('gagal USER DATA');
      print(response.statusCode);
      print(response.body);
    }
  }

  //-------------------------------------------------------------------------

  static Future<dynamic> produkAll(String token, idtoko, search) async {
    var response = await http.post(link().POST_produkall,
        body: ({
          'token': token,
          'id_toko': idtoko,
          'search': search,
        }));
    if (response.statusCode == 200) {
      print(
          'PRODUKALL network handler----------------------------------------->');

      var data = json.decode(response.body);
      //var data = response.body;
      //var data = response;
      print(data);
      print(response.statusCode);
      return (data);
    } else {
      print(
          'PRODUKALLnetwork handler----------------------------------------->');
      print('gagal PRODUKALL');
      print(response.statusCode);
      print(response.body);
    }
  }

  static Future<dynamic> produkJenis(String token, idtoko) async {
    var response = await http.post(link().POST_produkjenis,
        body: ({
          'token': token,
          'id_toko': idtoko,
        }));
    if (response.statusCode == 200) {
      print(
          'PRODUKALL network handler----------------------------------------->');

      var data = json.decode(response.body);
      //var data = response.body;
      //var data = response;
      print(data);
      print(response.statusCode);
      return (data);
    } else {
      print(
          'PRODUKALLnetwork handler----------------------------------------->');
      print('gagal PRODUKALL');
      print(response.statusCode);
      print(response.body);
    }
  }

  static Future<dynamic> produkTambah(String token, idtoko, iduser, idjenis,
      namaproduk, desc, qty, harga, File image) async {
    var response = http.MultipartRequest("POST", link().POST_produktambah);

    if (image != null) {
      var pic = await http.MultipartFile.fromPath("image", image.path);
      //add multipart to request
      response.files.add(pic);

      //imageUploadRequest.files.add(foto);
    }
    response.fields['token'] = token;
    response.fields['id_toko'] = idtoko.toString();
    response.fields['id_user'] = iduser.toString();
    response.fields['id_jenis'] = idjenis.toString();
    response.fields['nama_produk'] = namaproduk;
    response.fields['deskripsi'] = desc;
    response.fields['qty'] = qty;
    response.fields['harga'] = harga;

    final streamedResponse = await response.send();
    final datarespon = await http.Response.fromStream(streamedResponse);
    if (datarespon.statusCode != 200) {
      print('tambah produk handelr-------------------------------------------');
      print(datarespon.statusCode);
      return null;
    }
    var data = json.decode(datarespon.body);

    print(data);
    return data;
  }

  static Future<dynamic> produkEdit(String token, id, idtoko, iduser, idjenis,
      namaproduk, desc, harga, File image) async {
    var response = http.MultipartRequest("POST", link().POST_produkedit);

    if (image != null) {
      var pic = await http.MultipartFile.fromPath("image", image.path);
      //add multipart to request
      response.files.add(pic);

      //imageUploadRequest.files.add(foto);
    }
    response.fields['token'] = token;
    response.fields['id_toko'] = idtoko.toString();
    response.fields['id_user'] = iduser.toString();
    response.fields['id_jenis'] = idjenis.toString();
    response.fields['nama_produk'] = namaproduk;
    response.fields['deskripsi'] = desc;
    response.fields['id'] = id.toString();
    response.fields['harga'] = harga;

    final streamedResponse = await response.send();
    final datarespon = await http.Response.fromStream(streamedResponse);
    if (datarespon.statusCode != 200) {
      print(
          'edit produk handelr gagal -------------------------------------------');
      print(datarespon.statusCode);
      return null;
    }
    var data = json.decode(datarespon.body);

    print(data);
    return data;
  }

  static Future<dynamic> produkJenisTambah(
      String token, idtoko, namajenis) async {
    var response = await http.post(link().POST_produkjenistambah,
        body: ({
          'token': token,
          'id_toko': idtoko,
          'nama_jenis': namajenis,
        }));
    if (response.statusCode == 200) {
      print(
          'TAMBAH JENIS network handler----------------------------------------->');

      var data = json.decode(response.body);
      //var data = response.body;
      //var data = response;
      print(data);
      print(response.statusCode);
      return (data);
    } else {
      print(
          'TAMBAH JENIS network handler----------------------------------------->');
      print('gagal TAMBAH JENIS');
      print(response.statusCode);
      print(response.body);
    }
  }

  static Future<dynamic> produkJenisedit(
      String token, id, idtoko, namajenis) async {
    var response = await http.post(link().POST_produkjeniedit,
        body: ({
          'token': token,
          'id': id,
          'id_toko': idtoko,
          'nama_jenis': namajenis,
        }));
    if (response.statusCode == 200) {
      print(
          'EDIT JENIS network handler----------------------------------------->');

      var data = json.decode(response.body);
      //var data = response.body;
      //var data = response;
      print(data);
      print(response.statusCode);
      return (data);
    } else {
      print(
          'EDIT JENIS network handler----------------------------------------->');
      print('gagal EDIT JENIS');
      print(response.statusCode);
      print(response.body);
    }
  }

  static Future<dynamic> produkJenidelete(
    String token,
    id,
    idtoko,
  ) async {
    var response = await http.post(link().POST_produkjenisdelete,
        body: ({
          'token': token,
          'id': id,
          'id_toko': idtoko,
        }));
    if (response.statusCode == 200) {
      print(
          'DELETE JENIS network handler----------------------------------------->');

      var data = json.decode(response.body);
      //var data = response.body;
      //var data = response;
      print(data);
      print(response.statusCode);
      return (data);
    } else {
      print(
          'DELETE JENIS network handler----------------------------------------->');
      print('gagal DELETE JENIS');
      print(response.statusCode);
      print(response.body);
    }
  }

  static Future<dynamic> produkbyjenis(
    String token,
    idjenis,
    idtoko,
  ) async {
    var response = await http.post(link().POST_produkbyjenis,
        body: ({
          'token': token,
          'id_jenis': idjenis,
          'id_toko': idtoko,
        }));
    if (response.statusCode == 200) {
      print(
          'PRODUK BY JENISnetwork handler----------------------------------------->');

      var data = json.decode(response.body);
      //var data = response.body;
      //var data = response;
      print(data);
      print(response.statusCode);
      return (data);
    } else {
      print(
          'PRODUK BY JENIS network handler----------------------------------------->');
      print('gagal PRODUK BY JENIS');
      print(response.statusCode);
      print(response.body);
    }
  }

  static Future<dynamic> produkdelete(
    String token,
    id,
    idtoko,
  ) async {
    var response = await http.post(link().POST_produkhapus,
        body: ({
          'token': token,
          'id': id.toString(),
          'id_toko': idtoko,
        }));
    if (response.statusCode == 200) {
      print(
          'DELETE PRODUK network handler----------------------------------------->');

      var data = json.decode(response.body);
      //var data = response.body;
      //var data = response;
      print(data);
      print(response.statusCode);
      return (data);
    } else {
      print(
          'DELETE PRODUK network handler----------------------------------------->');
      print('gagal DELETE PRODUK');
      print(response.statusCode);
      print(response.body);
    }
  }

  static Future<dynamic> produkqtytambah(String token, id, idtoko, qty) async {
    var response = await http.post(link().POST_produkqtytambah,
        body: ({
          'token': token,
          'id': id.toString(),
          'id_toko': idtoko,
          'qty': qty.toString(),
        }));
    if (response.statusCode == 200) {
      print(
          'TAMBAH QTY network handler----------------------------------------->');

      var data = json.decode(response.body);
      //var data = response.body;
      //var data = response;
      print(data);
      print(response.statusCode);
      return (data);
    } else {
      print(
          'TAMBAH QTY network handler----------------------------------------->');
      print('gagal DTAMBAH QTY');
      print(response.statusCode);
      print(response.body);
    }
  }

  static Future<dynamic> bebanKategori(String token, idtoko) async {
    var response = await http.post(link().POST_bebankategori,
        body: ({
          'token': token,
          'id_toko': idtoko,
        }));
    if (response.statusCode == 200) {
      print(
          'BEBAN KATEGORI network handler----------------------------------------->');

      var data = json.decode(response.body);
      //var data = response.body;
      //var data = response;
      print(data);
      print(response.statusCode);
      return (data);
    } else {
      print(
          'BEBAN KATEGORI network handler----------------------------------------->');
      print('gagal BEBAN KATEGORI');
      print(response.statusCode);
      print(response.body);
    }
  }

  static Future<dynamic> bebanTambahJenis(
      String token, idtoko, kategori) async {
    var response = await http.post(link().POST_bebantambahjenis,
        body: ({
          'token': token,
          'id_toko': idtoko,
          'kategori': kategori,
        }));
    if (response.statusCode == 200) {
      print(
          'TAMBAH KATEGORI BEBAN network handler----------------------------------------->');

      var data = json.decode(response.body);
      //var data = response.body;
      //var data = response;
      print(data);
      print(response.statusCode);
      return (data);
    } else {
      print(
          'TAMBAH KATEGORI BEBAN network handler----------------------------------------->');
      print('gagal TAMBAH KATEGORI BEBAN');
      print(response.statusCode);
      print(response.body);
    }
  }

  static Future<dynamic> bebanEditJenis(
      String token, id, idtoko, kategori) async {
    var response = await http.post(link().POST_bebaneditjenis,
        body: ({
          'token': token,
          'id': id,
          'id_toko': idtoko,
          'kategori': kategori,
        }));
    if (response.statusCode == 200) {
      print(
          'EDIT KATEGORI BEBAN network handler----------------------------------------->');

      var data = json.decode(response.body);
      //var data = response.body;
      //var data = response;
      print(data);
      print(response.statusCode);
      return (data);
    } else {
      print(
          'EDIT KATEGORI BEBAN network handler----------------------------------------->');
      print('gagal EDIT KATEGORI BEBAN');
      print(response.statusCode);
      print(response.body);
    }
  }

  static Future<dynamic> bebanHapusJenis(
    String token,
    id,
    idtoko,
  ) async {
    var response = await http.post(link().POST_bebanhapusjenis,
        body: ({
          'token': token,
          'id': id,
          'id_toko': idtoko,
        }));
    if (response.statusCode == 200) {
      print(
          'HAPUS KATEGORI BEBAN network handler----------------------------------------->');

      var data = json.decode(response.body);
      //var data = response.body;
      //var data = response;
      print(data);
      print(response.statusCode);
      return (data);
    } else {
      print(
          'HAPUS KATEGORI BEBAN network handler----------------------------------------->');
      print('gagal HAPUS KATEGORI BEBAN');
      print(response.statusCode);
      print(response.body);
    }
  }

  static Future<dynamic> bebanData(String token, idtoko, search) async {
    var response = await http.post(link().POST_bebadata,
        body: ({
          'token': token,
          'id_toko': idtoko,
          'search': search,
        }));
    if (response.statusCode == 200) {
      print(
          'BEBAN DATA network handler----------------------------------------->');

      var data = json.decode(response.body);
      //var data = response.body;
      //var data = response;
      print(data);
      print(response.statusCode);
      return (data);
    } else {
      print(
          'BEBAN DATA network handler----------------------------------------->');
      print('gagal BEBAN DATA');
      print(response.statusCode);
      print(response.body);
    }
  }

  static Future<dynamic> bebanDataHariIni(String token, idtoko, search) async {
    var response = await http.post(link().POST_bebadatahariini,
        body: ({
          'token': token,
          'id_toko': idtoko,
          'search': search,
        }));
    if (response.statusCode == 200) {
      print(
          'BEBAN DATA HARI INI network handler----------------------------------------->');

      var data = json.decode(response.body);
      //var data = response.body;
      //var data = response;
      print(data);
      print(response.statusCode);
      return (data);
    } else {
      print(
          'BEBAN DATA  HARI INInetwork handler----------------------------------------->');
      print('gagal BEBAN DATA HARI INI');
      print(response.statusCode);
      print(response.body);
    }
  }

  static Future<dynamic> bebanDataTambah(
    String token,
    idtoko,
    idkatbeban,
    iduser,
    nama,
    keterangan,
    tgl,
    jumlah,
  ) async {
    var response = await http.post(link().POST_bebandatatambah,
        body: ({
          'token': token,
          'id_toko': idtoko,
          'id_user': iduser,
          'id_ktr_beban': idkatbeban,
          'nama': nama,
          'keterangan': keterangan,
          'tgl': tgl,
          'jumlah': jumlah,
        }));
    if (response.statusCode == 200) {
      print(
          'TAMBAH BEBAN network handler----------------------------------------->');

      var data = json.decode(response.body);
      //var data = response.body;
      //var data = response;
      print(data);
      print(response.statusCode);
      return (data);
    } else {
      print(
          'TAMBAH BEBAN network handler----------------------------------------->');
      print('gagal TAMBAH BEBAN');
      print(response.statusCode);
      print(response.body);
    }
  }

  static Future<dynamic> bebanDataEdit(
    String token,
    id,
    idtoko,
    idkatbeban,
    nama,
    keterangan,
    tgl,
    jumlah,
  ) async {
    var response = await http.post(link().POST_bebandataedit,
        body: ({
          'token': token,
          'id': id.toString(),
          'id_toko': idtoko,
          'id_ktr_beban': idkatbeban,
          'nama': nama,
          'keterangan': keterangan,
          'tgl': tgl,
          'jumlah': jumlah,
        }));
    if (response.statusCode == 200) {
      print(
          'TAMBAH BEBAN network handler----------------------------------------->');

      var data = json.decode(response.body);
      //var data = response.body;
      //var data = response;
      print(data);
      print(response.statusCode);
      return (data);
    } else {
      print(
          'TAMBAH BEBAN network handler----------------------------------------->');
      print('gagal TAMBAH BEBAN');
      print(response.statusCode);
      print(response.body);
    }
  }

  static Future<dynamic> bebanDataHapus(
    String token,
    id,
    idtoko,
  ) async {
    var response = await http.post(link().POST_bebandatahapus,
        body: ({
          'token': token,
          'id': id.toString(),
          'id_toko': idtoko,
        }));
    if (response.statusCode == 200) {
      print(
          'BEBAN HAPUS network handler----------------------------------------->');

      var data = json.decode(response.body);
      //var data = response.body;
      //var data = response;
      print(data);
      print(response.statusCode);
      return (data);
    } else {
      print(
          ' BEBAN HAPUS network handler----------------------------------------->');
      print('gagal BEBAN HAPUS');
      print(response.statusCode);
      print(response.body);
    }
  }

  static Future<dynamic> kasirKeranjangData(
      String token, iduser, idtoko, meja) async {
    var response = await http.post(link().POST_kasirkeranjangdata,
        body: ({
          'token': token,
          'id_user': iduser.toString(),
          'id_toko': idtoko,
          'meja': meja,
        }));
    if (response.statusCode == 200) {
      print(
          'DATA KERANJANG network handler----------------------------------------->');

      var data = json.decode(response.body);
      //var data = response.body;
      //var data = response;
      print(data);
      print(response.statusCode);
      return (data);
    } else {
      print(
          ' DATA KERANJANGnetwork handler----------------------------------------->');
      print('gagal DATA KERANJANG');
      print(response.statusCode);
      print(response.body);
    }
  }

  static Future<dynamic> kasirKeranjangTambah(
      String token, iduser, idtoko, meja, idproduk, diskon_brg, qty) async {
    var response = await http.post(link().POST_kasirkeranjangtambah,
        body: ({
          'token': token,
          'id_user': iduser.toString(),
          'id_toko': idtoko,
          'meja': meja,
          'id_produk': idproduk,
          'diskon_brg': diskon_brg,
          'qty': qty,
        }));
    if (response.statusCode == 200) {
      print(
          'TAMBAH KERANJANG network handler----------------------------------------->');

      var data = json.decode(response.body);
      //var data = response.body;
      //var data = response;
      print(data);
      print(response.statusCode);
      return (data);
    } else {
      print(
          ' TAMBAH KERANJANG network handler----------------------------------------->');
      print('TAMBAH DATA KERANJANG');
      print(response.statusCode);
      print(response.body);
    }
  }

  static Future<dynamic> kasirKeranjangHapus(
    String token,
    id,
    iduser,
    idtoko,
    idproduk,
    meja,
  ) async {
    var response = await http.post(link().POST_kasirkeranjanghapus,
        body: ({
          'token': token,
          'id': id,
          'id_user': iduser.toString(),
          'id_toko': idtoko,
          'meja': meja,
          'id_produk': idproduk,
        }));
    if (response.statusCode == 200) {
      print(
          'HAPUS KERANJANG network handler----------------------------------------->');

      var data = json.decode(response.body);
      //var data = response.body;
      //var data = response;
      print(data);
      print(response.statusCode);
      return (data);
    } else {
      print(
          ' HAPUS KERANJANG network handler----------------------------------------->');
      print('HAPUS DATA KERANJANG');
      print(response.statusCode);
      print(response.body);
    }
  }

  static Future<dynamic> kasirPembayaran(
      String token, iduser, idtoko, meja, bayar) async {
    var response = await http.post(link().POST_kasirpembayaran,
        body: ({
          'token': token,
          'id_user': iduser.toString(),
          'id_toko': idtoko,
          'meja': meja,
          'bayar': bayar,
        }));
    if (response.statusCode == 200) {
      print(
          'PEMBAYARAN network handler----------------------------------------->');

      var data = json.decode(response.body);
      //var data = response.body;
      //var data = response;
      print(data);
      print(response.statusCode);
      return (data);
    } else {
      print(
          ' PEMBAYARAN network handler----------------------------------------->');
      print('GAGAL PEMBAYARAN');
      print(response.statusCode);
      print(response.body);
    }
  }

  static Future<dynamic> penjualanData(String token, iduser, idtoko) async {
    var response = await http.post(link().POST_penjualadata,
        body: ({
          'token': token,
          'id_user': iduser.toString(),
          'id_toko': idtoko,
        }));
    if (response.statusCode == 200) {
      print(
          'DATA PENJUALAN network handler----------------------------------------->');

      var data = json.decode(response.body);
      //var data = response.body;
      //var data = response;
      print(data);
      print(response.statusCode);
      return (data);
    } else {
      print(
          'DATA PENJUALAN network handler----------------------------------------->');
      print('GAGAL DATA PENJUALAN');
      print(response.statusCode);
      print(response.body);
    }
  }

  static Future<dynamic> penjualanDataDetail(String token, id, idtoko) async {
    var response = await http.post(link().POST_penjualadatadetail,
        body: ({
          'token': token,
          'id': id,
          'id_toko': idtoko,
        }));
    if (response.statusCode == 200) {
      print(
          'DATA PENJUALAN DETAIL network handler----------------------------------------->');

      var data = json.decode(response.body);
      //var data = response.body;
      //var data = response;
      print(data);
      print(response.statusCode);
      return (data);
    } else {
      print(
          'DATA PENJUALAN DETAIL network handler----------------------------------------->');
      print('GAGAL DATA PENJUALAN DETAIL');
      print(response.statusCode);
      print(response.body);
    }
  }

  static Future<dynamic> penjualanDataHariIni(
      String token, iduser, idtoko) async {
    var response = await http.post(link().POST_penjualadatahariini,
        body: ({
          'token': token,
          'id_user': iduser,
          'id_toko': idtoko,
        }));
    if (response.statusCode == 200) {
      print(
          'DATA PENJUALAN HARI INI network handler----------------------------------------->');

      var data = json.decode(response.body);
      //var data = response.body;
      //var data = response;
      print(data);
      print(response.statusCode);
      return (data);
    } else {
      print(
          'DATA PENJUALAN HARI INI network handler----------------------------------------->');
      print('GAGAL DATA PENJUALAN HARI INI');
      print(response.statusCode);
      print(response.body);
    }
  }

  static Future<dynamic> penjualanReversal(String token, id, idtoko) async {
    var response = await http.post(link().POST_penjualanreversal,
        body: ({
          'token': token,
          'id': id,
          'id_toko': idtoko,
        }));
    if (response.statusCode == 200) {
      print(
          'DATA PENJUALAN REVERSAL network handler----------------------------------------->');

      var data = json.decode(response.body);
      //var data = response.body;
      //var data = response;
      print(data);
      print(response.statusCode);
      return (data);
    } else {
      print(
          'DATA PENJUALAN REVERSAL network handler----------------------------------------->');
      print('GAGAL DATA PENJUALAN REVERSAL');
      print(response.statusCode);
      print(response.body);
    }
  }

  static Future<dynamic> laporanUmum(String token, idtoko, date1, date2) async {
    //Completer<File> completer = Completer();
    var response = await http.post(link().POST_laporanumum,
        body: ({
          'token': token,
          'id_toko': idtoko,
          'date1': date1,
          'date2': date2,
        }));
    if (response.statusCode == 200) {
      print(
          'DATA LAPORAN UMUM network handler----------------------------------------->');
      //  final filename = 'qwe';
      var data = response;
      return data;

      // var request = await HttpClient().getUrl(link().POST_laporanumum);
      //  var response = await request.close();
      // var bytes = await consolidateHttpClientResponseBytes(response);

      // Directory tempDir = await getTemporaryDirectory();
      // String tempPath = tempDir.path;
      // File file = File('$tempPath/$filename.pdf');
      // print('$tempPath/$filename');
      // await file.writeAsBytes(response.bodyBytes);
      // return file;

      //await file.writeAsBytes(bytes, flush: true);
      //completer.complete(file);
      // createFileOfPdfUrl().then((f) {
      //   remotePDFpath.value = f.path;
      // });

      // File data = response.body;
      // var data = json.decode(response.body);
      //var data = response.body;
      //var data = response;
      //print(data);
      print(response.statusCode);
      // return completer.future;
      //return (data);
    } else {
      print(
          'DATA LAPORAN UMUM network handler----------------------------------------->');
      print('GAGAL DATA LAPORAN UMUM');
      print(response.statusCode);
      print(response.body);
    }
  }

  static Future<dynamic> laporanPenjualan(
      String token, idtoko, date1, date2) async {
    //Completer<File> completer = Completer();
    var response = await http.post(link().POST_laporanpenjualan,
        body: ({
          'token': token,
          'id_toko': idtoko,
          'date1': date1,
          'date2': date2,
        }));
    if (response.statusCode == 200) {
      print(
          'DATA LAPORAN PENJUALAN network handler----------------------------------------->');
      //  final filename = 'qwe';
      var data = response;
      return data;

      // var request = await HttpClient().getUrl(link().POST_laporanumum);
      //  var response = await request.close();
      // var bytes = await consolidateHttpClientResponseBytes(response);

      // Directory tempDir = await getTemporaryDirectory();
      // String tempPath = tempDir.path;
      // File file = File('$tempPath/$filename.pdf');
      // print('$tempPath/$filename');
      // await file.writeAsBytes(response.bodyBytes);
      // return file;

      //await file.writeAsBytes(bytes, flush: true);
      //completer.complete(file);
      // createFileOfPdfUrl().then((f) {
      //   remotePDFpath.value = f.path;
      // });

      // File data = response.body;
      // var data = json.decode(response.body);
      //var data = response.body;
      //var data = response;
      //print(data);
      print(response.statusCode);
      // return completer.future;
      //return (data);
    } else {
      print(
          'DATA LAPORAN PENJUALAN network handler----------------------------------------->');
      print('GAGAL DATA LAPORAN UMUM');
      print(response.statusCode);
      print(response.body);
    }
  }

  static Future<dynamic> laporanBeban(
      String token, idtoko, date1, date2) async {
    //Completer<File> completer = Completer();
    var response = await http.post(link().POST_laporanbeban,
        body: ({
          'token': token,
          'id_toko': idtoko,
          'date1': date1,
          'date2': date2,
        }));
    if (response.statusCode == 200) {
      print(
          'DATA LAPORAN BEBAN network handler----------------------------------------->');
      //  final filename = 'qwe';
      var data = response;
      return data;

      // var request = await HttpClient().getUrl(link().POST_laporanumum);
      //  var response = await request.close();
      // var bytes = await consolidateHttpClientResponseBytes(response);

      // Directory tempDir = await getTemporaryDirectory();
      // String tempPath = tempDir.path;
      // File file = File('$tempPath/$filename.pdf');
      // print('$tempPath/$filename');
      // await file.writeAsBytes(response.bodyBytes);
      // return file;

      //await file.writeAsBytes(bytes, flush: true);
      //completer.complete(file);
      // createFileOfPdfUrl().then((f) {
      //   remotePDFpath.value = f.path;
      // });

      // File data = response.body;
      // var data = json.decode(response.body);
      //var data = response.body;
      //var data = response;
      //print(data);
      print(response.statusCode);
      // return completer.future;
      //return (data);
    } else {
      print(
          'DATA LAPORAN BEBAN network handler----------------------------------------->');
      print('GAGAL DATA LAPORAN BEBAN');
      print(response.statusCode);
      print(response.body);
    }
  }

  static Future<dynamic> laporanReversal(
      String token, idtoko, date1, date2) async {
    //Completer<File> completer = Completer();
    var response = await http.post(link().POST_laporanreversal,
        body: ({
          'token': token,
          'id_toko': idtoko,
          'date1': date1,
          'date2': date2,
        }));
    if (response.statusCode == 200) {
      print(
          'DATA LAPORAN REVERSAL network handler----------------------------------------->');
      //  final filename = 'qwe';
      var data = response;
      return data;

      // var request = await HttpClient().getUrl(link().POST_laporanumum);
      //  var response = await request.close();
      // var bytes = await consolidateHttpClientResponseBytes(response);

      // Directory tempDir = await getTemporaryDirectory();
      // String tempPath = tempDir.path;
      // File file = File('$tempPath/$filename.pdf');
      // print('$tempPath/$filename');
      // await file.writeAsBytes(response.bodyBytes);
      // return file;

      //await file.writeAsBytes(bytes, flush: true);
      //completer.complete(file);
      // createFileOfPdfUrl().then((f) {
      //   remotePDFpath.value = f.path;
      // });

      // File data = response.body;
      // var data = json.decode(response.body);
      //var data = response.body;
      //var data = response;
      //print(data);
      print(response.statusCode);
      // return completer.future;
      //return (data);
    } else {
      print(
          'DATA LAPORAN REVERSAL network handler----------------------------------------->');
      print('GAGAL DATA LAPORAN REVERSAL');
      print(response.statusCode);
      print(response.body);
    }
  }
}
