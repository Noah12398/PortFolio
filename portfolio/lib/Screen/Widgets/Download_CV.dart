import 'dart:html' as html; // For web download handling
import 'package:flutter/foundation.dart'; // For checking if it's a web platform
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:path_provider/path_provider.dart'; // For mobile platforms
import 'dart:io'; // For mobile platforms
import 'package:open_file/open_file.dart';
import 'package:http/http.dart' as http;
import 'package:portfolio/constants/colors.dart';

class DownloadCVButton extends StatelessWidget {
  const DownloadCVButton({super.key});

  // Method to download and open the resume from a URL
  Future<void> _downloadAndOpenResume(BuildContext context) async {
    try {
      // Define the URL to the resume (updated for direct download)
      final url = 'https://drive.google.com/uc?id=1Igu_ElkTXQbKlQF6yFaeyqanS2l3hstT&export=download';

      // Check if the platform is mobile (Android/iOS) or web
      if (kIsWeb) {
        // Web platform - use browser to download the file
        _downloadFileWeb(url);
      } else {
        // Mobile platforms (Android/iOS)
        await _downloadFileMobile(url, context);
      }
    } catch (e) {
      // Show an error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error downloading/opening resume: $e")),
      );
      print("Error downloading/opening resume: $e");
    }
  }

  // Function for handling file download on the Web
  void _downloadFileWeb(String url) {
    final anchor = html.AnchorElement(href: url)
      ..target = 'blank'
      ..download = 'My_Resume.pdf';
    anchor.click();
  }

  // Function for handling file download on mobile platforms
  Future<void> _downloadFileMobile(String url, BuildContext context) async {
    try {
      // Get the local directory for storage
      final directory = await getApplicationDocumentsDirectory();
      final filePath = '${directory.path}/My_Resume.pdf';

      // Fetch the resume file from the URL
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        // Write the bytes to the file
        final file = File(filePath);
        await file.writeAsBytes(response.bodyBytes);

        // Open the saved file
        await OpenFile.open(filePath);

        // Show a success message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Resume downloaded & opened successfully!")),
        );
      } else {
        throw Exception('Failed to load resume');
      }
    } catch (e) {
      // Handle any error that occurs during the file download
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error downloading/opening resume: $e")),
      );
      print("Error downloading/opening resume: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _downloadAndOpenResume(context),
      child: Container(
        height: 50,
        width: 250,
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColors.paleSlate),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Download Resume", style: TextStyle(color: AppColors.paleSlate)),
            const SizedBox.square(dimension: 12),
            FaIcon(FontAwesomeIcons.download, color: AppColors.paleSlate, size: 18),
          ],
        ),
      ),
    );
  }
}
