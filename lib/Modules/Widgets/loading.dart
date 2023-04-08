import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:rims_waserda/Templates/setting.dart';

class showloading extends StatelessWidget {
  const showloading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Color> _kDefaultRainbowColors = [
      color_template().primary,
      color_template().secondary,
      color_template().select,
      Colors.blue
    ];
    return Center(
      child: Container(
        width: 250,
        //height: 150,
        child: LoadingIndicator(
          indicatorType: Indicator.ballSpinFadeLoader,
          colors: _kDefaultRainbowColors,
        ),
      ),
    );
  }
}
