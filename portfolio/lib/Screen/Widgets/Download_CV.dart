import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:portfolio/constants/colors.dart';
import 'download_helper.dart';

class DownloadCVButton extends StatefulWidget {
  const DownloadCVButton({super.key});

  @override
  State<DownloadCVButton> createState() => _DownloadCVButtonState();
}

class _DownloadCVButtonState extends State<DownloadCVButton> {
  bool _isDownloading = false;

  Future<void> _downloadAndOpenResume(BuildContext context) async {
    if (_isDownloading) return;

    setState(() => _isDownloading = true);

    try {
      const url = 'https://drive.google.com/uc?id=1Igu_ElkTXQbKlQF6yFaeyqanS2l3hstT&export=download';
      final downloadHelper = DownloadHelper();
      await downloadHelper.downloadFile(url, context);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Resume downloaded successfully!")),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Error: ${e.toString()}"),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isDownloading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => _downloadAndOpenResume(context),
        borderRadius: BorderRadius.circular(20),
        child: Container(
          height: 50,
          width: 250,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppColors.paleSlate),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Download Resume",
                style: TextStyle(
                  color: AppColors.paleSlate,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox.square(dimension: 12),
              _isDownloading
                  ? SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: AppColors.paleSlate,
                      ),
                    )
                  : FaIcon(
                      FontAwesomeIcons.download,
                      color: AppColors.paleSlate,
                      size: 18,
                    ),
            ],
          ),
        ),
      ),
    );
  }
}