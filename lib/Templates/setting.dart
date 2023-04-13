import 'package:flutter/material.dart';

class color_template {
  var primary = Color.fromRGBO(16, 85, 196, 1);
  var primary_v2 = Color.fromRGBO(115, 186, 146, 1);
  var primary_v3 = Color.fromRGBO(218, 224, 128, 1);
  var primary_dark = Color.fromRGBO(43, 84, 102, 1);
  var secondary = Color.fromRGBO(77, 119, 168, 1);
  var tritadery = Color.fromRGBO(255, 2, 78, 1);
  var select = Color.fromRGBO(255, 150, 60, 1);
  var nav = Color.fromRGBO(87, 225, 250, 0.35);
  var base = Color.fromRGBO(252, 252, 252, 1);
  var base_blue = Color.fromRGBO(210, 240, 250, 1);
  var base_white = Color.fromRGBO(255, 255, 255, 1);
}

class font {
  var primary_dark =
      TextStyle(color: color_template().primary_dark, fontSize: 20);
  var primary_white = TextStyle(color: Colors.white, fontSize: 20);

  var primary = TextStyle(color: color_template().primary, fontSize: 20);
  var primary_bold = TextStyle(
      color: color_template().primary,
      fontSize: 20,
      fontWeight: FontWeight.bold);

  var header =
      TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white);
  var header_big =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white);
  var header_xl =
      TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: Colors.white);
  var header_black =
      TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black);
  var header_blue = TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: color_template().primary);
  var table_header = TextStyle(fontSize: 20, fontWeight: FontWeight.bold);
  var reguler = TextStyle(
    fontSize: 18,
  );

  var reguler_white = TextStyle(fontSize: 18, color: Colors.white);

  var produktitle =
      TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold);
  var produkharga = TextStyle(
    fontSize: 15,
    color: Colors.white,
  );
}

class shadow {
  var reguler = BoxShadow(
    color: Colors.black.withOpacity(0.2),
    spreadRadius: 1,
    blurRadius: 8,
    offset: Offset(2, 5), // changes position of shadow
  );
}

extension MediaQueryValues on BuildContext {
  double get width_query => MediaQuery.of(this).size.width;

  double get height_query => MediaQuery.of(this).size.height;
}

class border_radius {
  var def_border = BorderRadius.circular(20);
  var header_border = BorderRadius.circular(15);
}

class elevation {
  var def_elevation = 9.0;
}
