import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';

import '../../Templates/setting.dart';

class showloading extends StatelessWidget {
  const showloading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 300,
        height: 250,
        child: LoadingIndicator(
          indicatorType: Indicator.ballPulseSync,
          colors: [color_template().primary, color_template().select],
        ),
      ),
    );
  }
}
