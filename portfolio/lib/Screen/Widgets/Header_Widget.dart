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
      duration: Duration(milliseconds: 600),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12), // Added padding for better spacing
      child: TextButton(
        onPressed: () => _scrollToSection(key2),
        style: TextButton.styleFrom(
          foregroundColor: Colors.white, // More contrast for better readability
          backgroundColor: Colors.transparent,
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 14), // Balanced padding
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          // Subtle hover effect for better user experience
          side: BorderSide(
            color: AppColors.grey.withOpacity(0.6), 
            width: 1.5,
          ),
          // Elevation and shadow for depth
          elevation: 3,
        ),
        child: Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600, // Slightly bolder font weight
            letterSpacing: 1.5, // Enhanced letter spacing for readability
          ),
        ),
      ),
    );
  }
}
