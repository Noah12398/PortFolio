import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:portfolio/constants/colors.dart';
import 'package:url_launcher/url_launcher.dart';

class SocialWidget extends StatelessWidget {
  const SocialWidget({super.key});

  // Single function to launch any URL
  void _launchUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: 40,
          width: 40,
          decoration: BoxDecoration(
            color: Colors.transparent,
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.studio.withOpacity(0.5)),
          ),
          child: Center(
            child: IconButton(
              hoverColor: AppColors.paleSlate,
              onPressed: () {
                _launchUrl('https://www.linkedin.com/in/noah-john-puthayathu/');
              },
              icon: FaIcon(
                FontAwesomeIcons.linkedinIn,
                color: AppColors.studio,
                size: 15,
              ),
            ),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Container(
          height: 40,
          width: 40,
          decoration: BoxDecoration(
            color: Colors.transparent,
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.studio.withOpacity(0.5)),
          ),
          child: Center(
            child: IconButton(
              hoverColor: AppColors.paleSlate,
              onPressed: () {
                _launchUrl('https://github.com/Noah12398');
              },
              icon: FaIcon(
                FontAwesomeIcons.github,
                color: AppColors.studio,
                size: 15,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
