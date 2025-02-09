import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:portfolio/constants/colors.dart';
import 'package:url_launcher/url_launcher.dart';

class SocialWidget extends StatelessWidget {
  const SocialWidget({super.key});

  // Function to launch URLs
  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    // Adjust button size dynamically (shrinks more on smaller screens)
    double buttonSize = screenWidth * 0.04; // 7% of screen width
    buttonSize = buttonSize.clamp(35, 60); // Limit between 35px (smallest) and 60px (largest)

    // Adjust icon size relative to button size
    double iconSize = buttonSize * 0.5; // 50% of button size
    iconSize = iconSize.clamp(14, 26); // Limit between 14px and 26px

    // Border thickness should shrink proportionally
    double borderWidth = buttonSize * 0.08; // 8% of button size
    borderWidth = borderWidth.clamp(1, 3); // Limit between 1px and 3px

    // Social media links
    final List<Map<String, dynamic>> socialLinks = [
      {
        'url': 'https://www.linkedin.com/in/noah-john-puthayathu/',
        'icon': FontAwesomeIcons.linkedinIn,
      },
      {
        'url': 'https://github.com/Noah12398',
        'icon': FontAwesomeIcons.github,
      },
    ];
return Wrap(
  spacing: screenWidth * 0.02, // Add spacing dynamically
  alignment: WrapAlignment.center,
  children: socialLinks.map((social) {
    return Container(
      height: buttonSize,
      width: buttonSize,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: AppColors.studio.withOpacity(0.5),
          width: borderWidth,
        ),
      ),
      child: Center(
        child: IconButton(
          hoverColor: AppColors.paleSlate,
          iconSize: iconSize,
          onPressed: () => _launchUrl(social['url']),
          icon: FaIcon(
            social['icon'],
            color: AppColors.studio,
          ),
        ),
      ),
    );
  }).toList(),
);

  }
}
