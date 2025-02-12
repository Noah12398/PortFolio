import 'package:flutter/material.dart';
import 'package:portfolio/constants/colors.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class EducationTab extends StatefulWidget {
  final Size size;
  final ScrollController scrollController;

  EducationTab({
    super.key,
    required this.size,
    required this.scrollController,
  });

  @override
  _EducationTabState createState() => _EducationTabState();
}

class _EducationTabState extends State<EducationTab>
    with TickerProviderStateMixin {
  late AnimationController _slideController;
  late AnimationController _fadeController; // Controller for fade animation
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation; // Fade animation
  bool isVisible = false;
  bool isScrollingDown = true;
  double lastScrollPosition = 0.0;
  bool _forceSlideUp = false;
  bool _forceSlideDown = false;

  final List<Map<String, String>> educationList = [
    {
      'imagePath': 'assets/images/Vim.jpg',
      'title': 'Vimalagiri International School',
      'details':
          'Completed high school with a focus on science subjects and extracurricular activities like sports and drama.'
    },
    {
      'imagePath': 'assets/images/TKM.jpg',
      'title': 'TKM College of Engineering',
      'details':
          'Currently pursuing a degree in Computer Science Engineering, actively involved in coding competitions, hackathons, and tech events.'
    },
  ];

  @override
  void initState() {
    super.initState();
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 600), // Duration for fade
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _fadeController,
        curve: Curves.easeIn,
      ),
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

       // print('Widget Position: $widgetPosition');
       // print('Viewport Height: $viewportHeight');
       // print('Is Widget Visible: $isWidgetVisible');

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
            _fadeController.forward(from: 0.0); // Fade in text
          });
        }
      }
    });
  }

  void _updateAnimation() {
    final beginOffset = _forceSlideUp
        ? const Offset(0.0, -2.0) // Force sliding up when scrolling down
        : (_forceSlideDown
            ? const Offset(0.0, 2.0) // Force sliding down when scrolling up
            : (isScrollingDown
                ? const Offset(0.0, 2.0)
                : const Offset(0.0, -2.0)));

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
    _fadeController.dispose(); // Dispose the fade controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GradientText(
          'Education',
          colors: [
            AppColors.valhalla,
            AppColors.darkblue,
          ],
          style: TextStyle(
              fontSize: widget.size.width * 0.04, fontWeight: FontWeight.bold),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: educationList.length, // Use the length of the data list
            itemBuilder: (context, index) {
              final education = educationList[index]; // Get the current item
              return Container(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: widget.size.width * 0.8,
                          height: widget.size.height * 0.3,
                          padding:
                              EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: AppColors.blue,
                            borderRadius: BorderRadius.circular(50.0),
                          ),
                          child: Card(
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50.0),
                            ),
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(50),
                                  child: Image.asset(
                                    education['imagePath']!,
                                    width: widget.size.width * 0.3,
                                    height: widget.size.height * 0.3,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Flexible(
                                  child: SlideTransition(
                                    position: _slideAnimation,
                                    child: FadeTransition(
                                      opacity:
                                          _fadeAnimation, // Apply fade effect
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              education['title']!,
                                              style: TextStyle(
                                                color: Colors.black87,
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              education['details']!,
                                              style: TextStyle(
                                                color: Colors.black54,
      fontSize: MediaQuery.of(context).size.width * 0.02, // Responsive font size
                                                fontStyle: FontStyle.italic,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}