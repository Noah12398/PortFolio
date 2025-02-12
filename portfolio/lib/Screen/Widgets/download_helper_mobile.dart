import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'download_helper.dart';

DownloadHelper createDownloadHelper() => DownloadHelperMobile();

class DownloadHelperMobile implements DownloadHelper {
  @override
  Future<void> downloadFile(String url, BuildContext context) async {
    final dio = Dio();
    final tempDir = await getTemporaryDirectory();
    final filePath = '${tempDir.path}/resume.pdf';

    await dio.download(url, filePath);
    await OpenFile.open(filePath);
  }
}
