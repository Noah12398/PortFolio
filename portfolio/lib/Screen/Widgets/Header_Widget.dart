import 'package:flutter/material.dart';
import 'package:portfolio/constants/colors.dart';

class BuildNavButton extends StatelessWidget {
  final String title;
  final GlobalKey key2;

  const BuildNavButton({
    super.key,
    required this.title,
    required this.key2,
  });

  // Scroll to the section specified by the given GlobalKey
  void _scrollToSection(GlobalKey key) {
    Scrollable.ensureVisible(
      key.currentContext!,
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    // Responsive font size based on screen width
    double fontSize = screenWidth * 0.02; // 2.5% of screen width
    fontSize = fontSize.clamp(14, 22); // Restrict between 14px (smallest) and 22px (largest)

    // Responsive padding
    double horizontalPadding = screenWidth * 0.02; // 4% of screen width
    double verticalPadding = screenWidth * 0.015; // 1.5% of screen width

    // Responsive border radius
    double borderRadius = screenWidth * 0.03; // 3% of screen width
    borderRadius = borderRadius.clamp(20, 40); // Restrict range

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: TextButton(
        onPressed: () => _scrollToSection(key2),
        style: TextButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: Colors.transparent,
          padding: EdgeInsets.symmetric(
            horizontal: horizontalPadding,
            vertical: verticalPadding,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          side: BorderSide(
            color: AppColors.grey.withOpacity(0.6),
            width: 1.5,
          ),
          elevation: 3,
        ),
        child: Text(
          title,
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.w600,
            letterSpacing: 1.5,
          ),
        ),
      ),
    );
  }
}
