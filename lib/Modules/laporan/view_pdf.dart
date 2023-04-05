import 'dart:async';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rims_waserda/Modules/Widgets/toast.dart';
import 'package:rims_waserda/Templates/setting.dart';

class PDFScreen extends StatefulWidget {
  final String? path;
  final File? file;

  PDFScreen({Key? key, this.path, this.file}) : super(key: key);

  _PDFScreenState createState() => _PDFScreenState();
}

class _PDFScreenState extends State<PDFScreen> with WidgetsBindingObserver {
  late String _localPath;
  late bool _permissionReady;

  final Completer<PDFViewController> _controller =
      Completer<PDFViewController>();
  int? pages = 0;
  int? currentPage = 0;
  bool isReady = false;
  String errorMessage = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          children: [
            Expanded(
              child: PDFView(
                filePath: widget.path,
                enableSwipe: true,
                swipeHorizontal: true,
                autoSpacing: false,
                pageFling: true,
                pageSnap: true,
                defaultPage: currentPage!,
                fitPolicy: FitPolicy.WIDTH,
                preventLinkNavigation: false,
                // if set to true the link is handled in flutter
                onRender: (_pages) {
                  setState(() {
                    pages = _pages;
                    isReady = true;
                  });
                },
                onError: (error) {
                  setState(() {
                    errorMessage = error.toString();
                  });
                  print(error.toString());
                },
                onPageError: (page, error) {
                  setState(() {
                    errorMessage = '$page: ${error.toString()}';
                  });
                  print('$page: ${error.toString()}');
                },
                onViewCreated: (PDFViewController pdfViewController) {
                  _controller.complete(pdfViewController);
                },
                onLinkHandler: (String? uri) {
                  print('goto uri: $uri');
                },
                onPageChanged: (int? page, int? total) {
                  print('page change: $page/$total');
                  setState(() {
                    currentPage = page;
                  });
                },
              ),
            ),
          ],
        ),
        floatingActionButton: Container(
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
              shape: BoxShape.circle, color: color_template().primary),
          child: IconButton(
            onPressed: () async {
              print(
                  'download pdf---------------------------------------------');
              DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
              AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
              if (androidInfo.version.sdkInt >= 33) {
                var status = await Permission.photos.status;
                if (!status.isGranted) {
                  await Permission.photos.request();
                }
              } else {
                var status = await Permission.storage.status;
                if (!status.isGranted) {
                  await Permission.storage.request();
                }
              }
              //await Permission.photos.status;
              bool dirDownloadExists = true;
              // var con = await Get.find<laporanController>();
              var directory = "/storage/emulated/0/Download/";
              var dir = '/storage/emulated/0/qwe/';
              var nama = basename(widget.file!.path);
              var finaldir = directory + nama;

              dirDownloadExists = await Directory(directory).exists();
              if (dirDownloadExists) {
                directory = "/storage/emulated/0/Download/";
              } else {
                directory = "/storage/emulated/0/Downloads/";
              }
              if (widget.file != null) {
                await moveFile(widget.file!, finaldir);
              } else {
                print('file kosong');
              }
            },
            icon: Icon(
              FontAwesomeIcons.download,
              color: Colors.white,
            ),
          ),
        ));
  }

  Future<File> moveFile(File sourceFile, String newPath) async {
    // prefer using rename as it is probably faster
    // print('rename----------------------');
    // return await sourceFile.rename(newPath);
    final newFile = await sourceFile.copy(newPath);
    Get.showSnackbar(
        toast().bottom_snackbar_success('berhasil', 'berhasil di download'));
    //await sourceFile.delete();
    return newFile;
  }
}
