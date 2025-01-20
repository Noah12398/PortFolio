import 'package:flutter/material.dart';
import 'package:portfolio/Screen/Widgets/Count_Container_Widget.dart';
import 'package:portfolio/Screen/Widgets/Download_CV.dart';
import 'package:portfolio/Screen/Widgets/Education_Widget.dart';
import 'package:portfolio/Screen/Widgets/Header_Text_Widget.dart';
import 'package:portfolio/Screen/Widgets/About_Widget.dart';
import 'package:portfolio/Screen/Widgets/Project_Widget.dart';
import 'package:portfolio/Screen/Widgets/Rotating_image_widget.dart';
import 'package:portfolio/Screen/Widgets/Skills_Widget.dart';
import 'package:portfolio/Screen/Widgets/Certificate_Widget.dart';
import 'package:portfolio/Screen/Widgets/Social_widget.dart';
import 'package:portfolio/constants/colors.dart';
import 'package:portfolio/constants/styles.dart';

class MobileLayout extends StatefulWidget {
  const MobileLayout({super.key});

  @override
  State<MobileLayout> createState() => _MobileLayoutState();
}

class _MobileLayoutState extends State<MobileLayout> {
  // Declare ScrollController
  ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    // Mobile layout adjustments
    double paddingFactor =
        size.width * 0.05; // Adjusting padding for mobile screens

    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: Styles.gradientDecorations,
        child: SingleChildScrollView(
          controller: _scrollController, // Assign the ScrollController
          child: Container(
            margin: EdgeInsets.symmetric(
                vertical:
                    size.height * 0.12), // Reduced vertical margin for mobile
            child: Column(
              children: [
                // Rotating Image Container
                Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [RotatingImageContainer()],
                  ),
                ),
                SizedBox(
                  height: size.width * 0.06, // Adjusted space after image
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            HeaderTextWidget(
                              size: size,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Social_Tab(size: size)
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: size.width * 0.06, // Adjusted space between sections
                ),
                // Count Widget
               
                SizedBox(
                  height:
                      size.width * 0.06, // Adjusted space after count widgets
                ),
                AboutWidget(size: size, scrollController: _scrollController),

                // Certificate Widget
                Container(
                  color: Colors.transparent,
                  padding: EdgeInsets.symmetric(vertical: size.width * 0.04),
                  child: SizedBox(
                    height: 300, // Adjusted height for mobile view
                    child: CertificateWidget(size: size, itemct: 1, itemCt: 1),
                  ),
                ),
                // Education Tab
                Container(
                  color: Colors.transparent,
                  padding: EdgeInsets.symmetric(vertical: size.width * 0.04),
                  child: SizedBox(
                    height: 400, // Adjusted height for mobile view
                    child: EducationTab(
                        size: size, scrollController: _scrollController),
                  ),
                ),
                // Skills Widget
                Container(
                  color: Colors.transparent,
                  padding: EdgeInsets.symmetric(vertical: size.width * 0.04),
                  child: SizedBox(
                      height: 500, child: SkillsWidget(size: size, itemct: 2)),
                ),
                // Project Widget
                Container(
                  color: Colors.transparent,
                  padding: EdgeInsets.symmetric(vertical: size.width * 0.04),
                  child: SizedBox(
                    height: size.height,
                    child: Project_Widget(
                      size: size,
                      itemct: 1, // Adjusted for mobile
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // Always dispose the ScrollController
    _scrollController.dispose();
    super.dispose();
  }
}

class Social_Tab extends StatelessWidget {
  const Social_Tab({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          DownloadCVButton(),
          SizedBox(
            height: 20,
          ),
          SocialWidget(),
        ],
      ),
    );
  }
}
