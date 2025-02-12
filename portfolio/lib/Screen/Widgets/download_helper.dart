import 'package:flutter/material.dart';
import 'download_helper_mobile.dart' if (dart.library.html) 'download_helper_web.dart';

abstract class DownloadHelper {
  // Factory constructor that returns the correct platform implementation
  factory DownloadHelper() => createDownloadHelper();
  
  // Abstract method that must be implemented by platform-specific classes
  Future<void> downloadFile(String url, BuildContext context);
}