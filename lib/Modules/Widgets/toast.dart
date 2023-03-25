import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rims_waserda/Templates/setting.dart';

class toast {
  bottom_snackbar_error(
    String title,
    mesaage,
  ) {
    return GetSnackBar(
      title: title,
      message: mesaage,
      icon: Container(
          margin: EdgeInsets.only(
            left: 6,
          ),
          padding: EdgeInsets.all(5),
          decoration:
              BoxDecoration(color: Colors.white, shape: BoxShape.circle),
          child: Icon(Icons.error, color: color_template().tritadery)),
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: color_template().tritadery,
      borderRadius: 20,
      margin: EdgeInsets.all(15),
      duration: Duration(seconds: 4),
      isDismissible: true,
      dismissDirection: DismissDirection.horizontal,
      forwardAnimationCurve: Curves.elasticInOut,
      reverseAnimationCurve: Curves.easeOut,
    );
  }

  bottom_snackbar_success(String title, mesaage) {
    return GetSnackBar(
      padding: EdgeInsets.all(10),
      title: title,
      message: mesaage,
      icon: Container(
          margin: EdgeInsets.only(
            left: 6,
          ),
          padding: EdgeInsets.all(5),
          decoration:
              BoxDecoration(color: Colors.white, shape: BoxShape.circle),
          child: Icon(Icons.check, color: color_template().primary)),
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: color_template().primary,
      borderRadius: 20,
      margin: EdgeInsets.all(15),
      duration: Duration(seconds: 4),
      isDismissible: true,
      dismissDirection: DismissDirection.horizontal,
      forwardAnimationCurve: Curves.elasticInOut,
      reverseAnimationCurve: Curves.easeOut,
    );
  }
}
