import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:rims_waserda/Services/api.dart';

import '../Modules/Widgets/toast.dart';
import '../Modules/produk/data produk/model_produk.dart';

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
        Get.showSnackbar(
            toast().bottom_snackbar_error('Error', 'Periksa koneksi internet'));
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
        Get.showSnackbar(
            toast().bottom_snackbar_error('Error', 'Periksa koneksi internet'));
      }
    } else {
      // AppAlert.getOnlyAlert(FAILED, NO_INTERNET_CONNECTION);
      Get.showSnackbar(
          toast().bottom_snackbar_error('Error', 'Periksa koneksi internet'));
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

  static Future<dynamic> editToko(
      {required String token,
      id,
      nama_toko,
      jenisusaha,
      alamat,
      nohp,
      email,
      logo}) async {
    // try{
    //
    // }catch(e){
    //   Get.back();
    //   Get.showSnackbar(toast().bottom_snackbar_error('Error', e.toString()));
    // }

    var response = await http.post(link().POST_edittoko,
        body: ({
          'token': token,
          'id': id,
          'nama_toko': nama_toko,
          'jenisusaha': jenisusaha,
          'alamat': alamat,
          'nohp': nohp,
          'email': email,
          'logo': logo ?? '-',
        }));
    if (response.statusCode == 200) {
      print(
          'EDIT TOKO network handler----------------------------------------->');

      var data = json.decode(response.body);
      //var data = response.body;
      //var data = response;
      print(data);
      print(response.statusCode);
      return data;
    } else {
      var data = json.decode(response.body);
      print(
          'EDIT TOKO network handler----------------------------------------->');
      print('gagal EDIT TOKO');
      print(response.statusCode);
      print(response.body);
      return data;
    }
  }

  static Future<dynamic> userData(String token, idtoko) async {
    try {
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
        return Future.error('Error tambah user');
      }
    } catch (e) {
      Get.back();
      Get.showSnackbar(toast().bottom_snackbar_error('Error', e.toString()));
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
      return data;
    } else {
      var data = json.decode(response.body);
      print(
          'USER TAMBAH network handler----------------------------------------->');
      print('gagal USER TAMBAH');
      print(response.statusCode);
      print(response.body);
      return data;
    }
  }

  static Future<dynamic> userEdit(
      String token, idtoko, id, iduser, nama, email, hp) async {
    try {
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
        return Future.error('Error tambah user');
      }
    } catch (e) {
      Get.back();
      Get.showSnackbar(toast().bottom_snackbar_error('Error', e.toString()));
    }
  }

  static Future<dynamic> userEditPassword(
      String token, idtoko, id, iduser, password, passwordlama) async {
    try {
      var response = await http.post(link().POST_usereditpassword,
          body: ({
            'token': token,
            'id_toko': idtoko,
            'id': id.toString(),
            'id_user': iduser.toString(),
            'password': password,
            'old_password': passwordlama,
          }));
      if (response.statusCode == 200) {
        print(
            'USER EDIT network handler----------------------------------------->');
        var data = json.decode(response.body);
        //var data = response.body;
        print(data);
        print(response.statusCode);
        return data;
      } else {
        var data = json.decode(response.body);
        print(
            'USER EDIT network handler----------------------------------------->');
        print('gagal USER EDIT password');
        print(response.statusCode);
        print(response.body);
        return data;
      }
    } catch (e) {
      Get.back();
      Get.showSnackbar(toast().bottom_snackbar_error('Error', e.toString()));
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
    try {
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

        print(response.statusCode);
        return (data);
      } else {
        print(
            'PRODUKALLnetwork handler----------------------------------------->');
        print('gagal PRODUKALL');
        print(response.statusCode);
        print(response.body);
      }
    } catch (e) {
      print(e);
      Get.showSnackbar(toast().bottom_snackbar_error('error', e.toString()));
    }
  }

  static List<DataProduk> parseproduk(String responseBody) {
    final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

    return parsed.map<DataProduk>((json) => DataProduk.fromJson(json)).toList();
  }

  static Future<dynamic> produkAllv2(String token, idtoko) async {
    //Get.dialog(showloading());
    try {
      var response = await http.post(link().POST_produkall,
          body: ({
            'token': token,
            'id_toko': idtoko,
          }));
      if (response.statusCode == 200) {
        print(
            'PRODUKALL V2 network handler----------------------------------------->');

        var data = await json.decode(response.body);
        //var data = response.body;
        //var data = response;
        // var l = [];
        //data = l;
        //print(l.length);
        // print(data['data']);
        print(response.statusCode);
        //Get.back(closeOverlays: true);
        return data;
      } else {
        var data = json.decode(response.body);
        print(data['message']);
        print(
            'PRODUKALLnetwork handler----------------------------------------->');
        print('gagal PRODUKALL');
        print(response.statusCode);
        print(response.body);
        return Future.error(
            response.statusCode.toString() + ' - ' + 'Fetch produk all gagal');
      }
    } catch (e) {
      print(e);
      Get.showSnackbar(toast().bottom_snackbar_error('Error', e.toString()));
    }
  }

  static Future<dynamic> produknext(String token, idtoko, page) async {
    var response = await http.post(link().POST_produkall,
        body: ({
          'token': token,
          'id_toko': idtoko,
          'page': page,
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

  static Future<dynamic> checkIdProduk({required String token}) async {
    //Get.dialog(showloading());
    var response = await http.post(link().POST_checkidporduk,
        body: ({
          'token': token,
        }));
    if (response.statusCode == 200) {
      print(
          'CHECK ID PRODUK network handler----------------------------------------->');

      var data = await json.decode(response.body);
      //var data = response.body;
      //var data = response;
      // var l = [];
      //data = l;
      //print(l.length);
      print(data);
      print(response.statusCode);
      //Get.back(closeOverlays: true);
      return data;
    } else {
      var data = json.decode(response.body);
      // print(data['message']);
      print(
          'CHECK ID PRODUK handler----------------------------------------->');
      print('gagal CHECK ID PRODUK');
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

  static Future<dynamic> produkTambah(
      {required String token,
      idtoko,
      iduser,
      idjenis,
      idjenisstock,
      namaproduk,
      desc,
      qty,
      harga,
      harga_modal,
      diskon_barang,
      barcode,
      File? image}) async {
    var response = http.MultipartRequest("POST", link().POST_produktambah);

    if (image != null) {
      var pic = await http.MultipartFile.fromPath("image", image.path);
      //add multipart to request
      response.files.add(pic);
      //imageUploadRequest.files.add(foto);
    }

    // var pic = await http.MultipartFile.fromPath("image", image.path);
    // response.files.add(pic);

    response.fields['token'] = token;
    response.fields['id_toko'] = idtoko.toString();
    response.fields['id_user'] = iduser.toString();
    response.fields['id_jenis'] = idjenis.toString();
    response.fields['id_jenis_stock'] = idjenisstock.toString();
    response.fields['nama_produk'] = namaproduk;
    response.fields['deskripsi'] = desc;
    response.fields['qty'] = qty;
    response.fields['harga'] = harga;
    response.fields['harga_modal'] = harga_modal;
    response.fields['diskon_barang'] = diskon_barang;
    response.fields['barcode'] = barcode;

    print('next diskon000000000000');
    //response.fields['diskon_barang'] = diskon_barang;

    final streamedResponse = await response.send();
    final datarespon = await http.Response.fromStream(streamedResponse);
    if (datarespon.statusCode != 200) {
      print('tambah produk handelr-------------------------------------------');
      print(datarespon.statusCode);
      print(datarespon.body);
      return null;
    }
    var data = json.decode(datarespon.body);

    print(data);
    return data;
  }

  static Future<dynamic> syncproduk({
    required String token,
    id,
    barcode,
    id_toko,
    id_user,
    id_jenis,
    id_kategori,
    id_jenis_stock,
    nama_produk,
    deskripsi,
    qty,
    harga,
    harga_modal,
    diskon_barang,
    image,
    status,
    //  aktif,
    //created_at,
    //updated_at,
    // deleted_at
  }) async {
    try {
      var response = http.MultipartRequest("POST", link().POST_produklocaltodb);
      response.fields['token'] = token;
      response.fields['image'] = image ?? '-';
      response.fields['id_local'] = id.toString();
      response.fields['barcode'] = barcode ?? '-';
      response.fields['id_toko'] = id_toko.toString();
      response.fields['id_user'] = id_user.toString();
      response.fields['id_jenis'] = id_jenis.toString();
      response.fields['id_kategori'] = id_kategori.toString();
      response.fields['id_jenis_stock'] = id_jenis_stock.toString();
      response.fields['nama_produk'] = nama_produk;
      response.fields['deskripsi'] = deskripsi;
      response.fields['qty'] = qty.toString();
      response.fields['harga'] = harga.toString();
      response.fields['harga_modal'] = harga_modal.toString();
      response.fields['diskon_barang'] = diskon_barang.toString();
      response.fields['status'] = status.toString();
      //response.fields['aktif'] = aktif.toString();
      // response.fields['created_at'] = created_at.toString();
      // response.fields['updated_at'] = updated_at.toString();
      // response.fields['deleted_at'] = deleted_at.toString();

      //response.fields['diskon_barang'] = diskon_barang;

      final streamedResponse = await response.send();
      final datarespon = await http.Response.fromStream(streamedResponse);
      if (datarespon.statusCode != 200) {
        print(
            'SYNC PRODUK handelr gagal-------------------------------------------');
        print(datarespon.statusCode);
        print(datarespon.body);
        return Future.error(
            datarespon.statusCode.toString() + ' - ' + 'Sync produk gagal');
      }
      var data = json.decode(datarespon.body);

      print(data);
      return data;
    } catch (e) {
      Get.back();
      Get.showSnackbar(toast().bottom_snackbar_error('Error', e.toString()));
    }
  }

  static Future<dynamic> produkEdit(
      {required String token,
      id,
      idjenisstock,
      idtoko,
      iduser,
      idjenis,
      namaproduk,
      desc,
      harga,
      harga_modal,
      diskon_barang,
      barcode,
      File? image}) async {
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
    //response.fields['id_jenis_stock'] = idjenisstock.toString();
    response.fields['nama_produk'] = namaproduk;
    response.fields['deskripsi'] = desc;
    response.fields['id'] = id.toString();
    response.fields['harga'] = harga;
    response.fields['harga_modal'] = harga_modal;
    response.fields['diskon_barang'] = diskon_barang;
    response.fields['barcode'] = barcode;

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

  static Future<dynamic> syncProdukJenis(
      {required String token, idtoko, namajenis, aktif, id}) async {
    try {
      var response = await http.post(link().POST_syncprodukjenis,
          body: ({
            'token': token,
            'id_local': id.toString(),
            'id_toko': idtoko.toString(),
            'nama_jenis': namajenis,
            'aktif': aktif,
          }));
      if (response.statusCode == 200) {
        print(
            'SYNC PRODUK JENIS network handler----------------------------------------->');

        var data = json.decode(response.body);

        print(data);
        print(response.statusCode);
        return (data);
      } else {
        print(
            'SYNC PRODUK JENIS network handler----------------------------------------->');
        print('gagal SYNC PRODUK JENIS');
        print(response.statusCode);
        print(response.body);
        return Future.error(
            response.statusCode.toString() + ' - ' + 'Sync produk jenis gagal');
      }
    } catch (e) {
      Get.back();
      Get.showSnackbar(toast().bottom_snackbar_error('Error', e.toString()));
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

  static Future<dynamic> syncbeban(
      {required String token,
      id,
      idtoko,
      idkatbeban,
      iduser,
      nama,
      keterangan,
      tgl,
      jumlah,
      aktif}) async {
    try {
      var response = await http.post(link().POST_syncbeban,
          body: ({
            'token': token,
            'id_toko': idtoko.toString(),
            'id_local': id.toString(),
            'id_user': iduser.toString(),
            'id_ktr_beban': idkatbeban.toString(),
            'nama': nama,
            'keterangan': keterangan,
            'tgl': tgl.toString(),
            'jumlah': jumlah.toString(),
            'aktif': aktif,
          }));
      if (response.statusCode == 200) {
        print(
            'SYNC BEBAN network handler----------------------------------------->');

        var data = json.decode(response.body);
        //var data = response.body;
        //var data = response;
        print(data);
        print(response.statusCode);
        return (data);
      } else {
        print(
            'SYNC BEBAN network handler----------------------------------------->');
        print('gagal SYNC BEBAN');
        print(response.statusCode);
        print(response.body);
        return Future.error(
            response.statusCode.toString() + ' - ' + 'Sync beban gagal');
      }
    } catch (e) {
      Get.back();
      Get.showSnackbar(toast().bottom_snackbar_error('Error', e.toString()));
    }
  }

  static Future<dynamic> syncbebanJenis(
      String token, id, idtoko, kategori, aktif) async {
    try {
      var response = await http.post(link().POST_syncbebankategori,
          body: ({
            'token': token,
            'id_toko': idtoko.toString(),
            'id_local': id.toString(),
            'kategori': kategori,
            'aktif': aktif,
          }));
      if (response.statusCode == 200) {
        print(
            'SYNC KATEGORI BEBAN network handler----------------------------------------->');

        var data = json.decode(response.body);
        //var data = response.body;
        //var data = response;
        print(data);
        print(response.statusCode);
        return (data);
      } else {
        print(
            'SYNC KATEGORI BEBAN network handler----------------------------------------->');
        print('gagal SYNC KATEGORI BEBAN');
        print(response.statusCode);
        print(response.body);
        return Future.error(
            response.statusCode.toString() + ' - ' + 'Sync beban jenis gagal');
      }
    } catch (e) {
      Get.back();
      Get.showSnackbar(toast().bottom_snackbar_error('Error', e.toString()));
    }
  }

  static Future<dynamic> bebanKategori(String token, idtoko) async {
    try {
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
        return Future.error(
            response.statusCode.toString() + 'Error beban kategori');
      }
    } catch (e) {
      Get.back(closeOverlays: true);
      Get.showSnackbar(toast().bottom_snackbar_error('Error', e.toString()));
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
    try {
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
        return Future.error('error beban data');
      }
    } catch (e) {
      Get.back(closeOverlays: true);
      Get.showSnackbar(toast().bottom_snackbar_error('Error', e.toString()));
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
      {required String token,
      iduser,
      idtoko,
      idjenisstock,
      meja,
      idproduk,
      diskon_brg,
      diskon_kasir,
      qty}) async {
    var response = await http.post(link().POST_kasirkeranjangtambah,
        body: ({
          'token': token,
          'id_user': iduser.toString(),
          'id_toko': idtoko,
          'meja': meja,
          'id_produk': idproduk,
          'diskon_brg': diskon_brg,
          'qty': qty,
          'id_jenis_stock': idjenisstock,
          'diskon_kasir': diskon_kasir,
        }));
    if (response.statusCode == 200) {
      print(
          'TAMBAH KERANJANG network handler----------------------------------------->');

      var data = json.decode(response.body);
      //var data = response.body;
      //var data = response;

      print(response.statusCode);
      return data;
    } else {
      var data = json.decode(response.body);

      print(
          ' TAMBAH KERANJANG network handler----------------------------------------->');
      print('TAMBAH DATA KERANJANG');
      print(data['message']);
      print(response.statusCode);
      print(response.body);
      return data;
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
      {required String token,
      iduser,
      idtoko,
      meja,
      String? bayar,
      metodebayar,
      String? id_pelanggan}) async {
    var response = await http.post(link().POST_kasirpembayaran,
        body: ({
          'token': token,
          'id_user': iduser.toString(),
          'id_toko': idtoko,
          'meja': meja,
          'bayar': bayar,
          'metode_bayar': metodebayar,
          'id_pelanggan': id_pelanggan,
        }));
    if (response.statusCode == 200) {
      print(
          'PEMBAYARAN network handler----------------------------------------->');

      var data = json.decode(response.body);
      //var data = response.body;
      //var data = response;
      // print(data);
      print(response.statusCode);
      return (data);
    } else {
      var data = json.decode(response.body);
      print(
          ' PEMBAYARAN network handler----------------------------------------->');
      print('GAGAL PEMBAYARAN');
      print(response.statusCode);
      print(response.body);
      return data;
    }
  }

  static Future<dynamic> syncpenjualan({
    required String token,
    id,
    iduser,
    idtoko,
    aktif,
    id_pelanggan,
    meja,
    id_hutang,
    total_item,
    diskon_total,
    sub_total,
    total,
    bayar,
    kembalian,
    tgl_penjualan,
    metode_bayar,
    status,
    diskon_kasir,
    ppn,
  }) async {
    try {
      var response = await http.post(link().POST_syncpenjualan,
          body: ({
            'token': token,
            'id_local': id.toString(),
            'id_user': iduser.toString(),
            'id_toko': idtoko.toString(),
            'aktif': aktif,
            'id_pelanggan': id_pelanggan.toString(),
            'meja': meja,
            'id_hutang': id_hutang.toString(),
            'total_item': total_item.toString(),
            'diskon_total': diskon_total.toString(),
            'sub_total': sub_total.toString(),
            'total': total.toString(),
            'bayar': bayar.toString(),
            'kembalian': kembalian.toString(),
            'tgl_penjualan': tgl_penjualan,
            'metode_bayar': metode_bayar.toString(),
            'status': status.toString(),
            'diskon_kasir': diskon_kasir.toString(),
            'ppn': ppn.toString(),
          }));
      if (response.statusCode == 200) {
        print(
            'SYNC PENJUALAN network handler----------------------------------------->');

        var data = json.decode(response.body);
        //var data = response.body;
        //var data = response;
        // print(data);
        print(response.statusCode);
        return (data);
      } else {
        print(
            'SYNC PENJUALAN network handler----------------------------------------->');
        print('GAGAL SYNC PENJUALAN');
        print(response.statusCode);
        print(response.body);
        return Future.error(
            response.statusCode.toString() + ' - ' + 'Sync penjualan gagal');
      }
    } catch (e) {
      Get.back();
      Get.showSnackbar(toast().bottom_snackbar_error('Error', e.toString()));
    }
  }

  static Future<dynamic> syncpenjualandetail({
    required String token,
    id,
    iduser,
    idtoko,
    aktif,
    id_penjualan,
    id_produk,
    id_kategori,
    id_jenis_stock,
    nama_brg,
    harga_modal,
    harga_brg,
    qty,
    diskon_brg,
    diskon_kasir,
    total,
    tgl,
  }) async {
    try {
      var response = await http.post(link().POST_syncpenjualandetail,
          body: ({
            'token': token,
            'id_local': id.toString(),
            'id_user': iduser.toString(),
            'id_toko': idtoko.toString(),
            'aktif': aktif,
            'id_penjualan': id_penjualan.toString(),
            'id_produk': id_produk.toString(),
            'id_kategori': id_kategori.toString(),
            'id_jenis_stock': id_jenis_stock.toString(),
            'nama_brg': nama_brg,
            'harga_modal': harga_modal.toString(),
            'harga_brg': harga_brg.toString(),
            'qty': qty.toString(),
            'diskon_brg': diskon_brg.toString(),
            'diskon_kasir': diskon_kasir.toString(),
            'total': total.toString(),
            'tgl': tgl,
          }));
      if (response.statusCode == 200) {
        print(
            'SYNC PENJUALAN network handler----------------------------------------->');

        var data = json.decode(response.body);
        //var data = response.body;
        //var data = response;
        print(data);
        print(response.statusCode);
        return (data);
      } else {
        print(
            'SYNC PENJUALAN network handler----------------------------------------->');
        print('GAGAL SYNC PENJUALAN');
        print(response.statusCode);
        print(response.body);
        return Future.error(response.statusCode.toString() +
            ' - ' +
            'Sync penjualan detail gagal');
      }
    } catch (e) {
      Get.back();
      Get.showSnackbar(toast().bottom_snackbar_error('Error', e.toString()));
    }
  }

  static Future<dynamic> penjualanData(
      String token, iduser, idtoko, search) async {
    try {
      var response = await http.post(link().POST_penjualadata,
          body: ({
            'token': token,
            'id_user': iduser.toString(),
            'id_toko': idtoko,
            'search': search,
          }));
      if (response.statusCode == 200) {
        print(
            'DATA PENJUALAN network handler----------------------------------------->');

        var data = json.decode(response.body);
        //var data = response.body;
        //var data = response;
        // print(data);
        print(response.statusCode);
        return (data);
      } else {
        print(
            'DATA PENJUALAN network handler----------------------------------------->');
        print('GAGAL DATA PENJUALAN');
        print(response.statusCode);
        print(response.body);
        return Future.error('error fetch penjualan');
      }
    } catch (e) {
      Get.back(closeOverlays: true);
      Get.showSnackbar(toast().bottom_snackbar_error('Error', e.toString()));
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

  static Future<dynamic> penjualanDataDetailAll(String token, idtoko) async {
    var response = await http.post(link().POST_penjualadatadetailall,
        body: ({
          'token': token,
          'id_toko': idtoko,
        }));
    if (response.statusCode == 200) {
      print(
          'DATA PENJUALAN DETAIL ALL network handler----------------------------------------->');

      var data = json.decode(response.body);
      //var data = response.body;
      //var data = response;
      print(data);
      print(response.statusCode);
      return (data);
    } else {
      print(
          'DATA PENJUALAN DETAIL ALL network handler----------------------------------------->');
      print('GAGAL DATA PENJUALAN DETAIL ALL');
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
    try {
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
        return Future.error(response.statusCode.toString() +
            ' - ' +
            'fetch laporan umum gagal');
      }
    } catch (e) {
      Get.back();
      Get.showSnackbar(toast().bottom_snackbar_error('Error', e.toString()));
    }
  }

  static Future<dynamic> laporanPenjualan(
      String token, idtoko, date1, date2) async {
    //Completer<File> completer = Completer();
    try {
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
        return Future.error(
            response.statusCode.toString() + ' - ' + 'Sync produk jenis gagal');
      }
    } catch (e) {
      Get.back();
      Get.showSnackbar(toast().bottom_snackbar_error('Error', e.toString()));
    }
  }

  static Future<dynamic> laporanBeban(
      String token, idtoko, date1, date2) async {
    //Completer<File> completer = Completer();
    try {
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
        return Future.error(response.statusCode.toString() +
            ' - ' +
            'fetch laporan beban gagal');
      }
    } catch (e) {
      Get.back();
      Get.showSnackbar(toast().bottom_snackbar_error('Error', e.toString()));
    }
  }

  static Future<dynamic> laporanReversal(
      String token, idtoko, date1, date2) async {
    //Completer<File> completer = Completer();

    try {
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
      } else {
        print(
            'DATA LAPORAN REVERSAL network handler----------------------------------------->');
        print('GAGAL DATA LAPORAN REVERSAL');
        print(response.statusCode);
        print(response.body);
        return Future.error(response.statusCode.toString() +
            ' - ' +
            'fetch laporan reversal gagal');
      }
    } catch (e) {
      Get.back();
      Get.showSnackbar(toast().bottom_snackbar_error('Error', e.toString()));
    }
  }

  static Future<dynamic> syncpelanggan(
      String token, id, id_toko, nama_pelanggan, no_hp, aktif) async {
    try {
      var response = await http.post(link().POST_syncpelanggan,
          body: ({
            'token': token,
            'id_toko': id_toko.toString(),
            'id_local': id.toString(),
            'nama_pelanggan': nama_pelanggan,
            'no_hp': no_hp,
            'aktif': aktif,
          }));
      if (response.statusCode == 200) {
        print(
            'SYNC PELANGGAN TAMBAH network handler----------------------------------------->');

        var data = json.decode(response.body);
        //var data = response.body;
        //var data = response;
        print(data);
        print(response.statusCode);
        return (data);
      } else {
        print(
            'SYNC PELANGGAN TAMBAH network handler----------------------------------------->');
        print('GAGAL SYNC PELANGGAN TAMBAH');
        print(response.statusCode);
        print(response.body);
        return Future.error(
            response.statusCode.toString() + ' - ' + 'Sync pelanggan gagal');
      }
    } catch (e) {
      Get.back();
      Get.showSnackbar(toast().bottom_snackbar_error('Error', e.toString()));
    }
  }

  static Future<dynamic> pelangganData(String token, idtoko) async {
    var response = await http.post(link().POST_pelanggandata,
        body: ({
          'token': token,
          'id_toko': idtoko,
        }));
    if (response.statusCode == 200) {
      print(
          'DATA PELANGGAN network handler----------------------------------------->');

      var data = json.decode(response.body);
      //var data = response.body;
      //var data = response;
      print(data);
      print(response.statusCode);
      return (data);
    } else {
      print(
          'DATA PELANGGAN network handler----------------------------------------->');
      print('GAGAL DATA PELANGGAN');
      print(response.statusCode);
      print(response.body);
    }
  }

  static Future<dynamic> pelangganTambah(
      String token, id_toko, nama_pelanggan, no_hp) async {
    var response = await http.post(link().POST_pelanggantambah,
        body: ({
          'token': token,
          'id_toko': id_toko,
          'nama_pelanggan': nama_pelanggan,
          'no_hp': no_hp,
        }));
    if (response.statusCode == 200) {
      print(
          'DATA PELANGGAN TAMBAH network handler----------------------------------------->');

      var data = json.decode(response.body);
      //var data = response.body;
      //var data = response;
      print(data);
      print(response.statusCode);
      return (data);
    } else {
      print(
          'DATA PELANGGAN TAMBAH network handler----------------------------------------->');
      print('GAGAL DATA PELANGGAN TAMBAH');
      print(response.statusCode);
      print(response.body);
    }
  }

  static Future<dynamic> pelangganEdit(
      String token, id_toko, id, nama_pelanggan, no_hp) async {
    var response = await http.post(link().POST_pelangganedit,
        body: ({
          'token': token,
          'id_toko': id_toko,
          'id': id.toString(),
          'nama_pelanggan': nama_pelanggan,
          'no_hp': no_hp,
        }));
    if (response.statusCode == 200) {
      print(
          'DATA PELANGGAN EDIT network handler----------------------------------------->');

      var data = json.decode(response.body);
      //var data = response.body;
      //var data = response;
      print(data);
      print(response.statusCode);
      return (data);
    } else {
      print(
          'DATA PELANGGAN EDIT network handler----------------------------------------->');
      print('GAGAL DATA PELANGGAN EDIT');
      print(response.statusCode);
      print(response.body);
    }
  }

  static Future<dynamic> pelangganHapus(String token, id_toko, id) async {
    var response = await http.post(link().POST_pelangganhapus,
        body: ({
          'token': token,
          'id_toko': id_toko,
          'id': id.toString(),
        }));
    if (response.statusCode == 200) {
      print(
          'DATA PELANGGAN HAPUS network handler----------------------------------------->');

      var data = json.decode(response.body);
      //var data = response.body;
      //var data = response;
      print(data);
      print(response.statusCode);
      return (data);
    } else {
      print(
          'DATA PELANGGAN HAPUS network handler----------------------------------------->');
      print('GAGAL DATA PELANGGAN EDIT');
      print(response.statusCode);
      print(response.body);
    }
  }

  static Future<dynamic> kontenSquare() async {
    try {
      var response = await http.get(link().GET_kontensquare);

      if (response.statusCode == 200) {
        print(
            'KONTEN SQUARE network handler----------------------------------------->');

        var data = json.decode(response.body);
        //var data = response.body;
        //var data = response;
        // print(data);
        print(response.statusCode);
        return data;
      } else {
        var data = json.decode(response.body);
        print(
            'KONTEN SQUARE network handler----------------------------------------->');
        print('GAGAL DATA KONTEN SQUARE');
        print(response.statusCode);
        print(response.body);
        return data;
      }
    } catch (e) {
      print(e);
      Get.back();
      Get.showSnackbar(toast().bottom_snackbar_error('Error', e.toString()));
    }
  }

  static Future<dynamic> kontenBanner() async {
    try {
      var response = await http.get(link().GET_kontenbanner);

      if (response.statusCode == 200) {
        print(
            'KONTEN BANNER network handler----------------------------------------->');

        var data = json.decode(response.body);
        //var data = response.body;
        //var data = response;
        print(data);
        print(response.statusCode);
        return data;
      } else {
        var data = json.decode(response.body);
        print(
            'KONTEN BANNER network handler----------------------------------------->');
        print('GAGAL DATA KONTEN BANNER');
        print(response.statusCode);
        print(response.body);
        return data;
      }
    } catch (e) {
      Get.back();
      Get.showSnackbar(toast().bottom_snackbar_error('Error', e.toString()));
    }
  }

  static Future<dynamic> logout(String token) async {
    try {
      var response = await http.post(link().POST_logout,
          body: ({
            'token': token,
          }));
      if (response.statusCode == 200) {
        print(
            'LOGOUT network handler----------------------------------------->');

        var data = json.decode(response.body);
        //var data = response.body;
        //var data = response;
        print(data);
        print(response.statusCode);
        return (data);
      } else {
        var data = json.decode(response.body);
        print(
            'LOGOUT network handler----------------------------------------->');
        print('GAGAL DATA PELANGGAN EDIT');
        print(response.statusCode);

        print(response.body);
        return data;
      }
    } catch (e) {
      Get.back();
      Get.showSnackbar(toast().bottom_snackbar_error('Error', e.toString()));
    }
  }

  static Future<dynamic> synchutang(
      {required String token,
      required String id_toko,
      required String aktif,
      id,
      id_pelanggan,
      hutang,
      sisa_hutang,
      tgl_hutang,
      status}) async {
    try {
      var response = await http.post(link().POST_synchutang,
          body: ({
            'token': token,
            'id_toko': id_toko.toString(),
            'id_local': id.toString(),
            'aktif': aktif,
            'id_pelanggan': id_pelanggan.toString(),
            'hutang': hutang.toString(),
            'sisa_hutang': sisa_hutang.toString(),
            'tgl_hutang': tgl_hutang.toString(),
            'status': status.toString(),
          }));
      if (response.statusCode == 200) {
        print(
            'SYNC HUTANG  network handler----------------------------------------->');

        var data = json.decode(response.body);
        //var data = response.body;
        //var data = response;
        print(data);
        print(response.statusCode);
        return data;
      } else {
        var data = json.decode(response.body);
        print(
            'SYNC HUTANG network handler----------------------------------------->');
        print('GAGAL SYNC HUTANG');
        print(response.statusCode);

        print(response.body);
        return Future.error(
            response.statusCode.toString() + ' - ' + 'Sync hutang gagal');
      }
    } catch (e) {
      Get.back();
      Get.showSnackbar(toast().bottom_snackbar_error('Error', e.toString()));
    }
  }

  static Future<dynamic> synchutangdetail({
    required String token,
    required String id_toko,
    required String aktif,
    id,
    id_hutang,
    id_pelanggan,
    bayar,
    sisa,
    tgl_hutang,
    tgl_bayar,
    String? tgl_lunas,
  }) async {
    try {
      var response = await http.post(link().POST_synchutangdetail,
          body: ({
            'token': token,
            'id_toko': id_toko.toString(),
            'id_local': id.toString(),
            'aktif': aktif,
            'id_pelanggan': id_pelanggan.toString(),
            'id_hutang': id_hutang.toString(),
            'tgl_hutang': tgl_hutang,
            'bayar': bayar.toString(),
            'sisa': sisa.toString(),
            'tgl_bayar': tgl_bayar,
            'tgl_lunas': tgl_lunas ?? '-',
          }));
      if (response.statusCode == 200) {
        print(
            'SYNC HUTANG DETAIL  network handler----------------------------------------->');

        var data = json.decode(response.body);

        print(data);
        print(response.statusCode);
        return data;
      } else {
        var data = json.decode(response.body);
        print(
            'SYNC HUTANG DETAIL network handler----------------------------------------->');
        print('GAGAL SYNC HUTANG DETAIL');
        print(response.statusCode);

        print(response.body);
        return Future.error(response.statusCode.toString() +
            ' - ' +
            'Sync hutang detail gagal');
      }
    } catch (e) {
      print(
          "<------------------------------------error----------------------------------->");
      print(e);
      Get.back();
      Get.showSnackbar(toast().bottom_snackbar_error('Error', e.toString()));
    }
  }

  static Future<dynamic> hutangAll({
    required String token,
    required String id_toko,
  }) async {
    try {
      var response = await http.post(link().POST_hutangall,
          body: ({
            'token': token,
            'id_toko': id_toko,
          }));
      if (response.statusCode == 200) {
        print(
            'HUTANG ALL network handler----------------------------------------->');

        var data = json.decode(response.body);
        //var data = response.body;
        //var data = response;
        print(data);
        print(response.statusCode);
        return data;
      } else {
        var data = json.decode(response.body);
        print(
            'HUTANG network handler----------------------------------------->');
        print('GAGAL DATA HUTANG ALL');
        print(response.statusCode);

        print(response.body);
        return Future.error('error fetch hutang');
      }
    } catch (e) {
      Get.back(closeOverlays: true);
      Get.showSnackbar(toast().bottom_snackbar_error('Error', e.toString()));
    }
  }

  static Future<dynamic> hutangDetail({
    required String token,
    required String id_toko,
  }) async {
    var response = await http.post(link().POST_hutangdetail,
        body: ({
          'token': token,
          'id_toko': id_toko,
        }));
    if (response.statusCode == 200) {
      print(
          'HUTANG DETAIL network handler----------------------------------------->');

      var data = json.decode(response.body);
      //var data = response.body;
      //var data = response;
      print(data);
      print(response.statusCode);
      return data;
    } else {
      var data = json.decode(response.body);
      print(
          'HUTANG DETAIL network handler----------------------------------------->');
      print('GAGAL DATA HUTANG DETAIL');
      print(response.statusCode);

      print(response.body);
      return data;
    }
  }

  static Future<dynamic> hutangBayar({
    required String token,
    required String id_toko,
    required String id_hutang,
    required String bayar,
  }) async {
    var response = await http.post(link().POST_hutangbayar,
        body: ({
          'token': token,
          'id_toko': id_toko,
          'id': id_hutang.toString(),
          'bayar': bayar,
        }));
    if (response.statusCode == 200) {
      print(
          'HUTANG BAYAR network handler----------------------------------------->');

      var data = json.decode(response.body);
      //var data = response.body;
      //var data = response;
      print(data);
      print(response.statusCode);
      return data;
    } else {
      var data = json.decode(response.body);
      print(
          'HUTANG BAYAR network handler----------------------------------------->');
      print('GAGAL DATA HUTANG BAYAR');
      print(response.statusCode);

      print(response.body);
      return data;
    }
  }
}
