import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';


import '../../Controllers/Templates/setting.dart';
import '../../Controllers/user controller/tambah_user_controller.dart';
import '../Widgets/appbar.dart';
import '../Widgets/buttons.dart';

class tambah_user extends GetView<tambah_userController> {
  const tambah_user({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();

    final email = TextEditingController();
    return SafeArea(
      // minimum: EdgeInsets.all(5),
      child: Scaffold(
        backgroundColor: color_template().primary.withOpacity(0.2),
        appBar: appbar_custom(
            height: 50,
            child: Text(
              'Tambah user',
              style: font().header,
            )),
        body: Card(
          // margin: EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                        padding: EdgeInsets.all(10),
                        margin:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        decoration: BoxDecoration(
                            color: color_template().primary,
                            borderRadius: BorderRadius.circular(10)),
                        child: FaIcon(
                          FontAwesomeIcons.userPlus,
                          size: 20,
                          color: Colors.white,
                        )),
                    Text(
                      'Tambah user',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                    )
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Form(
                      key: formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            controller: email,
                            onChanged: ((String pass) {}),
                            decoration: InputDecoration(
                              icon: Icon(Icons.add_card),
                              labelText: "Nomor identitas",
                              labelStyle: TextStyle(
                                color: Colors.black87,
                              ),
                              border: UnderlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                            textAlign: TextAlign.center,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter email';
                              }
                              return null;
                            },
                          ),
                          TextFormField(
                            controller: email,
                            onChanged: ((String pass) {}),
                            decoration: InputDecoration(
                              icon: Icon(Icons.person),
                              labelText: "Nama penlanggan",
                              labelStyle: TextStyle(
                                color: Colors.black87,
                              ),
                              border: UnderlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                            textAlign: TextAlign.center,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter email';
                              }
                              return null;
                            },
                          ),
                          TextFormField(
                            controller: email,
                            onChanged: ((String pass) {}),
                            decoration: InputDecoration(
                              icon: Icon(Icons.pin_drop),
                              labelText: "Alamat pelanggan",
                              labelStyle: TextStyle(
                                color: Colors.black87,
                              ),
                              border: UnderlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                            textAlign: TextAlign.center,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter email';
                              }
                              return null;
                            },
                          ),
                          TextFormField(
                            controller: email,
                            onChanged: ((String pass) {}),
                            decoration: InputDecoration(
                              icon: Icon(Icons.phone),
                              labelText: "No HP",
                              labelStyle: TextStyle(
                                color: Colors.black87,
                              ),
                              border: UnderlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                            textAlign: TextAlign.center,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter email';
                              }
                              return null;
                            },
                          ),
                          TextFormField(
                            controller: email,
                            onChanged: ((String pass) {}),
                            decoration: InputDecoration(
                              icon: Icon(Icons.email),
                              labelText: "Email",
                              labelStyle: TextStyle(
                                color: Colors.black87,
                              ),
                              border: UnderlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                            textAlign: TextAlign.center,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter email';
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: 50,
                          ),
                          button_solid_custom(
                              onPressed: () {
                                controller.testprint();
                              },
                              child: Text('tambah user'),
                              width: 900,
                              height: 50)
                        ],
                      )),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
