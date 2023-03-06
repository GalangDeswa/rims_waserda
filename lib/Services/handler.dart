import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart';

class networkHandler extends GetConnect {
  static Future<String> postApi(var body, String endpoint) async {
    var response = await post(api(endpoint), body: body, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      // 'Authorization': GetStorage().read(PREF_TOKEN)
    });
    print('dari network handler----------------------------------------->');
    print(response.body);
    return response.body;
  }

  static Future getApi(String endpoint) async {
    var response = await get(api(endpoint));
    return response.body;
  }

  static Uri api(String endpoint) {
    String host = 'http://192.168.100.33/waserda/waserda/';
    final apikey = host + endpoint;
    return Uri.parse(apikey);
  }

  static void storeToken(String token) async {
    await GetStorage().write('token', token);
  }

  static Future<String?> getToken() async {
    return await GetStorage().read('token');
  }
}
