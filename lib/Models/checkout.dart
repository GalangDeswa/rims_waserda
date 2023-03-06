// To parse this JSON data, do
//
//     final checkout = checkoutFromJson(jsonString);

import 'dart:convert';

Checkout checkoutFromJson(String str) => Checkout.fromJson(json.decode(str));

String checkoutToJson(Checkout data) => json.encode(data.toJson());

class Checkout {
  Checkout({
    required this.status,
    required this.message,
    required this.checkout,
  });

  bool status;
  String message;
  List<CheckoutElement> checkout;

  factory Checkout.fromJson(Map<String, dynamic> json) => Checkout(
        status: json["status"],
        message: json["message"],
        checkout: List<CheckoutElement>.from(
            json["checkout"].map((x) => CheckoutElement.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "checkout": List<dynamic>.from(checkout.map((x) => x.toJson())),
      };
}

class CheckoutElement {
  CheckoutElement({
    required this.id,
    required this.kodeProduk,
    required this.qty,
    required this.tgl,
  });

  String id;
  String kodeProduk;
  String qty;
  String tgl;

  factory CheckoutElement.fromJson(Map<String, dynamic> json) =>
      CheckoutElement(
        id: json["id"],
        kodeProduk: json["kode_produk"],
        qty: json["qty"],
        tgl: json["tgl"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "kode_produk": kodeProduk,
        "qty": qty,
        "tgl": tgl,
      };
}
