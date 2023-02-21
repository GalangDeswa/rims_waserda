import 'dart:io';

import 'package:get/get.dart';


class image_upload extends GetConnect {
  Future<String> uploadimage(List<String> list) async {
    try {
      final form = FormData({});
      for (String path in list) {
        form.files.add(MapEntry(
            'foto[]',
            MultipartFile(File(path),
                filename:
                    '${DateTime.now().microsecondsSinceEpoch}.${path.split('.').last}')));
      }
      final response = await post(
          'http://192.168.100.33:8000/api/tambah_foto_multiv2', form);
      if (response.status.hasError) {
        return Future.error(response.body);
      } else {
        return response.body('result');
      }
    } catch (error) {
      return Future.error(error.toString());
    }
  }

  Future<String> up(File file) async {
    try {
      final form = FormData({'foto': MultipartFile(file, filename: 'qwe.jpg')});
      final response =
          await post('http://192.168.100.33:8000/api/tambah_foto_single', form);
      if (response.status.hasError) {
        print('error up rpiver---------------------------------');
        return Future.error(response.body);
      } else {
        return response.body['result'];
      }
    } catch (error) {
      return Future.error(error.toString());
    }
  }
}
