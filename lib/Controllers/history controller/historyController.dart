import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meta/meta.dart';
import 'package:rims_waserda/Models/history.dart';

import '../../Services/api.dart';

class historyController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  var history_list = <HistoryElement>[].obs;
  var id_kas = TextEditingController().obs;

  Future<List<HistoryElement>> gethistory(String id) async {
    var response = await api().client.post(link().POST_gethistory,
        body: ({
          'id_kasir': id,
        }));
    if (response.statusCode == 200) {
      var hasil = json.decode(response.body);
      var res = History.fromJson(hasil);
      print('--------------------------------------------------------------');
      print(res);
      history_list.value = res.history;
      return history_list;
    } else {
      return [];
    }
  }
}
