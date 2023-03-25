import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class server {
  final String host = 'https://rimsdev.com/rimspos-standar/api-pos/';
}

class link {
  final Uri POST_login = Uri.parse(server().host + 'auth/login');
  final Uri POST_loadtoko = Uri.parse(server().host + 'loadtoko');
  final Uri POST_userdata = Uri.parse(server().host + 'user/data');
  final Uri POST_usertambah = Uri.parse(server().host + 'user/tambah');
  final Uri POST_useredit = Uri.parse(server().host + 'user/edit');
  final Uri POST_usereditpassword = Uri.parse(server().host + 'user/gantipass');
  final Uri POST_userdelete = Uri.parse(server().host + 'user/hapus');

  final Uri POST_produkall = Uri.parse(server().host + 'produk/data/allproduk');
  final Uri POST_produkjenis = Uri.parse(server().host + 'produk/jenis/data');
  final Uri POST_produktambah = Uri.parse(server().host + 'produk/tambah');
  final Uri POST_produkhapus = Uri.parse(server().host + 'produk/hapus');
  final Uri POST_produkqtytambah =
      Uri.parse(server().host + 'produk/tambah/stock');
  final Uri POST_produkjenistambah =
      Uri.parse(server().host + 'produk/jenis/tambah');
  final Uri POST_produkjeniedit =
      Uri.parse(server().host + 'produk/jenis/edit');
  final Uri POST_produkjenisdelete =
      Uri.parse(server().host + 'produk/jenis/hapus');
  final Uri POST_produkbyjenis =
      Uri.parse(server().host + 'produk/data/byjenis');
}

class api extends GetConnect {
  var client = http.Client();

// static Future<List<Product>> getproduct() async {
//   var error = 'error';
//   var response = await api().client.get(Uri.parse(
//       'http://makeup-api.herokuapp.com/api/v1/products.json?brand=maybelline'));
//   if (response.statusCode == 200) {
//     var jsonstring = response.body;
//     var hasil = productFromJson(jsonstring);
//     return hasil;
//   } else {
//     return [];
//   }
// }

// static Future<List<Kategeori>> get_kategori() async {
//   var error = 'error';
//   final String get_kategori = "http://192.168.100.33:8000/api/show_kategori";
//   var response = await api().client.get(link().GET_kategori);
//   if (response.statusCode == 200) {
//     var jsonstring = response.body;
//     var hasil_kat = kategeoriFromJson(jsonstring);
//     return hasil_kat;
//   } else {
//     return [];
//   }
// }

// static Future<List<Supliyer>> get_suplier() async {
//   var error = 'error';
//   final String get_kategori = "http://192.168.100.33:8000/api/show_supliyer";
//   var response = await api().client.get(link().GET_supliyer);
//   if (response.statusCode == 200) {
//     var jsonstring = response.body;
//     var hasil_supliyer = supliyerFromJson(jsonstring);
//     return hasil_supliyer;
//   } else {
//     return [];
//   }
// }

// static Future<List<Barang>> get_barang() async {
//   var error = 'error';
//   final String get_kategori = "http://192.168.100.33:8000/api/show_produk";
//   var response = await api().client.get(link().GET_produk);
//   if (response.statusCode == 200) {
//     var jsonstring = response.body;
//     var hasil_barang = barangFromJson(jsonstring);
//     return hasil_barang;
//   } else {
//     return [];
//   }
// }

// static Future getproduk() async {
//   var response = await api().client.get(link().GET_produkv2);
//   if (response.statusCode == 200) {
//     var hasil = json.decode(response.body);
//     var res = Produk.fromJson(hasil);
//     // Map<String, dynamic> map = json.decode(response.body);
//     // List<dynamic> data = map["produk"];
//     // print(data[1]['nama_produk']);
//     print('--------------------------------------------------------------');
//     print(res.produk[0].namaProduk);
//     return res;
//   } else {
//     return [];
//   }
// }
}
