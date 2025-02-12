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
    if (key.currentContext != null) {
      Scrollable.ensureVisible(
        key.currentContext!,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    // Responsive font size
    double fontSize = screenWidth * 0.015; // 2% of screen width
    fontSize = fontSize.clamp(10, 20); // Limit between 10px and 20px

    // Adjust padding and border dynamically
    double horizontalPadding = screenWidth * 0.015; // 1.5% of screen width
    double verticalPadding = screenWidth * 0.007; // 0.7% of screen width
    double borderRadius = screenWidth * 0.03; // 3% of screen width
    borderRadius = borderRadius.clamp(12, 40); // Limit between 12px and 40px

    return Padding(
  padding: const EdgeInsets.symmetric(horizontal: 8),
  child: ConstrainedBox(
    constraints: BoxConstraints(
      maxWidth: screenWidth * 0.25, // Max width is 25% of screen
      minWidth: 80, // Ensures button is never too small
    ),
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
      ),
      child: FittedBox(
        fit: BoxFit.scaleDown, // Ensures text never overflows
        child: Text(
          title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis, // Adds '...' if needed
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.w600,
            letterSpacing: 1.5,
          ),
        ),
      ),
    ),
  ),
);

  }
}
