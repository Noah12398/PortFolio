import 'package:flutter/material.dart';
import 'dart:html' as html;
import 'download_helper.dart';

DownloadHelper createDownloadHelper() => DownloadHelperWeb();

class DownloadHelperWeb implements DownloadHelper {
  @override
  Future<void> downloadFile(String url, BuildContext context) async {
    html.window.open(url, '_blank');
  }
}