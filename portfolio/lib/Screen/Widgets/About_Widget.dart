import 'package:flutter/material.dart';
import 'package:portfolio/constants/colors.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class AboutWidget extends StatefulWidget {
  final Size size;
  final ScrollController scrollController;

  const AboutWidget({
    super.key,
    required this.size,
    required this.scrollController,
  });

  @override
  _AboutWidgetState createState() => _AboutWidgetState();
}

class _AboutWidgetState extends State<AboutWidget> with TickerProviderStateMixin {
  late AnimationController _slideController;
  late Animation<Offset> _slideAnimation;
  bool isVisible = false;
  bool isScrollingDown = true;
  double lastScrollPosition = 0.0;
  bool _forceSlideUp = false;
  bool _forceSlideDown = false;

  @override
  void initState() {
    super.initState();
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _updateAnimation(); // Initialize the animation
    widget.scrollController.addListener(_handleScroll);
  }

  void _handleScroll() {
    final currentPosition = widget.scrollController.position.pixels;
    final viewportHeight = widget.scrollController.position.viewportDimension;

    // Check if user is scrolling down or up
    final isCurrentlyScrollingDown = currentPosition > lastScrollPosition;
    lastScrollPosition = currentPosition;

    // Check if the scroll direction changed
    if (isScrollingDown != isCurrentlyScrollingDown) {
      setState(() {
        isScrollingDown = isCurrentlyScrollingDown;
        _updateAnimation();
      });
    }

    // Determine widget visibility
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final renderBox = context.findRenderObject() as RenderBox?;
      if (renderBox != null) {
        final widgetPosition = renderBox.localToGlobal(Offset.zero).dy;
final isWidgetVisible = widgetPosition + renderBox.size.height > 0 &&
                        widgetPosition < viewportHeight;
// print(isWidgetVisible);
        // If widget becomes invisible while scrolling down, force slide up
        if (!isWidgetVisible && isScrollingDown) {
          setState(() {
            _forceSlideUp = true;
            _forceSlideDown = false;
            isVisible = false;
          });
        }
        // If widget becomes invisible while scrolling up, force slide down
        else if (!isWidgetVisible && !isScrollingDown) {
          setState(() {
            _forceSlideDown = true;
            _forceSlideUp = false;
            isVisible = false;
          });
        }

        if (isWidgetVisible && !isVisible) {
          setState(() {
            isVisible = true;
            _slideController.forward(from: 0.0); // Slide into position
          });
        }
      }
    });
  }

  void _updateAnimation() {
  final beginOffset = _forceSlideUp
      ? const Offset(0.0, -1.0) // Force sliding up when scrolling down
      : (_forceSlideDown
          ? const Offset(0.0, 1.0) // Force sliding down when scrolling up
          : (isScrollingDown ? const Offset(0.0, 1.0) : const Offset(0.0, -1.0)));

  _slideAnimation = Tween<Offset>(
    begin: beginOffset,
    end: Offset.zero, // Always slide into position
  ).animate(CurvedAnimation(
    parent: _slideController,
    curve: Curves.easeOutCubic,
  ));

  // Restart the animation when forced slide occurs
  if (_forceSlideUp || _forceSlideDown) {
    _slideController.forward(from: 0.0).then((_) {
      // Reset forced flags after animation completes
      setState(() {
        _forceSlideUp = false;
        _forceSlideDown = false;
      });
    });
  }
}


  @override
  void dispose() {
    widget.scrollController.removeListener(_handleScroll);
    _slideController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      color: Colors.transparent,
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(30)),
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
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: widget.size.height * 0.02,
            ),
            SlideTransition(
              position: _slideAnimation,
              child: Padding(
                padding: const EdgeInsets.all(40.0),
                child: Text(
                  'Hi, I’m a passionate Computer Science student with expertise in Flutter, Kotlin, and Python. I love creating innovative, user-friendly applications and solving real-world problems through technology. My projects range from mobile apps to engaging games, reflecting my creativity and technical skills. I’m always eager to learn and grow while contributing to impactful projects. When I’m not coding, I enjoy exploring new tech. Let’s connect and create something amazing!',
                  style: TextStyle(
                    fontSize: widget.size.width * 0.015,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
                    color: const Color.fromARGB(255, 21, 21, 21),
                  ),
                  textAlign: TextAlign.justify,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
