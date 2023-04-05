class server {
  final String host = 'https://rims.co.id/rimspos-standar/api-pos/';
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

  final Uri POST_bebankategori =
      Uri.parse(server().host + 'beban/kategori/data');
  final Uri POST_bebantambahjenis =
      Uri.parse(server().host + 'beban/kategori/tambah');
  final Uri POST_bebaneditjenis =
      Uri.parse(server().host + 'beban/kategori/edit');
  final Uri POST_bebanhapusjenis =
      Uri.parse(server().host + 'beban/kategori/hapus');

  final Uri POST_bebadata = Uri.parse(server().host + 'beban/data');
  final Uri POST_bebadatahariini =
      Uri.parse(server().host + 'beban/data/hariini');

  final Uri POST_bebandatatambah = Uri.parse(server().host + 'beban/tambah');
  final Uri POST_bebandataedit = Uri.parse(server().host + 'beban/edit');
  final Uri POST_bebandatahapus = Uri.parse(server().host + 'beban/hapus');

  final Uri POST_kasirkeranjangdata =
      Uri.parse(server().host + 'kasir/keranjang/data');
  final Uri POST_kasirkeranjangtambah =
      Uri.parse(server().host + 'kasir/keranjang/tambah');
  final Uri POST_kasirkeranjanghapus =
      Uri.parse(server().host + 'kasir/keranjang/hapus');
  final Uri POST_kasirpembayaran =
      Uri.parse(server().host + 'kasir/keranjang/pembayaran');

  final Uri POST_penjualadata = Uri.parse(server().host + 'penjualan/data');
  final Uri POST_penjualadatadetail =
      Uri.parse(server().host + 'penjualan/data/detail');
  final Uri POST_penjualadatahariini =
      Uri.parse(server().host + 'penjualan/data/hariini');
  final Uri POST_penjualanreversal =
      Uri.parse(server().host + 'penjualan/reversal');

  final Uri POST_laporanumum = Uri.parse(server().host + 'laporan/umum');
  final Uri POST_laporanpenjualan =
      Uri.parse(server().host + 'laporan/penjualan');
  final Uri POST_laporanbeban = Uri.parse(server().host + 'laporan/beban');
  final Uri POST_laporanreversal =
      Uri.parse(server().host + 'laporan/reversal');
}
