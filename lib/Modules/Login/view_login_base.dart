import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';

import '../../Templates/setting.dart';
import 'controller_login.dart';
import 'view_login_card.dart';

class login extends GetView<loginController> {
  const login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/bg_login.png'),
                    colorFilter: ColorFilter.mode(
                        Colors.white.withOpacity(0.8), BlendMode.dstATop),
                    fit: BoxFit.cover)),
          ),
          Row(
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.5,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/bg_login.png'),
                      colorFilter: ColorFilter.mode(
                          color_template().primary.withOpacity(0.1),
                          BlendMode.dstATop),
                      fit: BoxFit.cover),
                  color: color_template().primary,
                ),
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      image: DecorationImage(
                          image: AssetImage('assets/images/bg_login.png'),
                          colorFilter: ColorFilter.mode(
                              Colors.white.withOpacity(0.1), BlendMode.dstATop),
                          fit: BoxFit.cover)),
                ),
              ),
            ],
          ),
          Scaffold(
              backgroundColor: Colors.transparent,
              body: Center(child: SingleChildScrollView(child: login_card())))
        ],
      ),
    );
  }
}
