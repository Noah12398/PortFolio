import 'package:flutter/material.dart';
import 'package:portfolio/constants/colors.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class AboutWidget extends StatefulWidget {
  final Size size;
  final ScrollController scrollController; // Accept ScrollController here

  const AboutWidget({
    super.key,
    required this.size,
    required this.scrollController, // Initialize ScrollController here
  });

  @override
  _AboutWidgetState createState() => _AboutWidgetState();
}

class _AboutWidgetState extends State<AboutWidget> with TickerProviderStateMixin {
  bool isVisible = false;
  late AnimationController _slideController;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    // Initialize the animation controller
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    // Define the slide animation (starting from below)
    _slideAnimation = Tween<Offset>(
      begin: Offset(0.0, 1.0), // Start position (off-screen, from below)
      end: Offset.zero, // End position (on-screen)
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: Curves.easeInOut,
    ));

    widget.scrollController.addListener(() {
      final position = widget.scrollController.position.pixels;

      // Debugging the scroll position
      print("Scroll Position: $position");

      final shouldBeVisible = position > widget.size.height * 0.5;

      if (shouldBeVisible != isVisible) {
        print("Visibility Changed: $shouldBeVisible"); // Debugging visibility change
        setState(() {
          isVisible = shouldBeVisible;
        });

        // Trigger the slide animation when visibility changes
        if (shouldBeVisible) {
          _slideController.forward(); // Start the slide animation
        } else {
          _slideController.reverse(); // Reverse the slide animation when hiding
        }
      }
    });
  }

  @override
  void dispose() {
    _slideController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 800),
      opacity: isVisible ? 1.0 : 0.0,
      child: Container(
        padding: EdgeInsets.all(20),
        color: AppColors.cocoaBrown, // Adding a color to see if it appears
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ShaderMask(
              shaderCallback: (bounds) => LinearGradient(
                colors: [
                  AppColors.valhalla,
                  const Color(0xFF9BA4B5),
                ],
              ).createShader(bounds),
              child: GradientText(
                "About",
                colors: [
                  AppColors.studio,
                  AppColors.paleSlate,
                ],
                style: TextStyle(
                    fontSize: widget.size.width * 0.030,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: widget.size.height * 0.02,
            ),
            // Applying the SlideTransition only to the text
            SlideTransition(
              position: _slideAnimation, // Apply the slide animation to the text
              child: Padding(
                padding: const EdgeInsets.all(40.0),
                child: Text(
                  'Hi, I’m a passionate Computer Science Student with expertise in Flutter, Kotlin, and Python. I love creating innovative, user-friendly applications and solving real-world problems through technology.My projects range from mobile apps to engaging games, reflecting my creativity and technical skills. I’m always eager to learn and grow while contributing to impactful projects.When I’m not coding, I enjoy exploring new tech. Let’s connect and create something amazing!',
                  style: TextStyle(
                      fontSize: widget.size.width * 0.015,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                      color: Colors.white),
                  textAlign: TextAlign.justify, // Center the text
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
