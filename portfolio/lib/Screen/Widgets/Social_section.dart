import 'package:flutter/material.dart';
import 'package:portfolio/Screen/Widgets/Download_CV.dart';
import 'package:portfolio/Screen/Widgets/Social_widget.dart';
import 'package:portfolio/constants/colors.dart';

class SocialSection extends StatelessWidget {
  const SocialSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      height: 50,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            height: 50,
            width: 250,
            decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: AppColors.studio)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DownloadCVButton(),
                const SizedBox(
                  width: 20,
                ),
                Expanded(child: SocialWidget())
              ],
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          Expanded(child: SocialWidget())
        ],
      ),
    );
  }
}
