import 'package:flutter/material.dart';
import 'package:portfolio/Screen/Widgets/Count_Container_Widget.dart';
import 'package:portfolio/Screen/Widgets/Education_Widget.dart';
import 'package:portfolio/Screen/Widgets/Header_Text_Widget.dart';
import 'package:portfolio/Screen/Widgets/About_Widget.dart';
import 'package:portfolio/Screen/Widgets/Project_Widget.dart';
import 'package:portfolio/Screen/Widgets/Rotating_image_widget.dart';
import 'package:portfolio/Screen/Widgets/Skills_Widget.dart';
import 'package:portfolio/Screen/Widgets/Certificate_Widget.dart';
import 'package:portfolio/constants/colors.dart';
import 'package:portfolio/constants/styles.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class DesktopLayout extends StatefulWidget {
  const DesktopLayout({super.key});

  @override
  State<DesktopLayout> createState() => _DesktopLayoutState();
}

class _DesktopLayoutState extends State<DesktopLayout> {
  bool isAboutVisible = false;
  ScrollController _scrollController = ScrollController();
  ScrollController _aboutScrollController = ScrollController();
  ScrollController _certificateScrollController = ScrollController();
  ScrollController _educationScrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    _aboutScrollController.dispose();
    _certificateScrollController.dispose();
    _educationScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification notification) {
          if (notification is ScrollUpdateNotification) {
            final position = _scrollController.position.pixels;
            final shouldBeVisible = position > size.height * 0.5;
            if (shouldBeVisible != isAboutVisible) {
              setState(() {
                isAboutVisible = shouldBeVisible;
              });
            }
          }
          return true;
        },
        child: ResponsiveBuilder(
          builder: (context, sizingInformation) {
            return Container(
              height: double.infinity,
              width: double.infinity,
              decoration: Styles.gradientDecorations,
              child: SingleChildScrollView(
                controller: _scrollController, // Main scroll controller
                child: Column(
                  children: [
                    if (sizingInformation.deviceScreenType == DeviceScreenType.desktop)
                      // Desktop layout
                      Container(
                        margin: EdgeInsets.symmetric(vertical: size.height * 0.2),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                HeaderTextWidget(size: size),
                                SizedBox(height: 20),
                                Social_large(size: size),
                              ],
                            ),
                            Expanded(
                              child: Container(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [RotatingImageContainer()],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    if (sizingInformation.deviceScreenType != DeviceScreenType.desktop)
                      // Mobile or Tablet layout
                      Container(
                        margin: EdgeInsets.symmetric(vertical: size.height * 0.1),
                        child: Column(
                          children: [
                            HeaderTextWidget(size: size),
                            SizedBox(height: 20),
                            Social_large(size: size),
                            RotatingImageContainer(),
                          ],
                        ),
                      ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: size.width * 0.05),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CountWidget(
                            size: size,
                            text1: "14",
                            text2: "Years of",
                            text3: "Experience",
                          ),
                          CountWidget(
                            size: size,
                            text1: "50+",
                            text2: "Projects",
                            text3: "Completed",
                          ),
                          CountWidget(
                            size: size,
                            text1: "1.5K",
                            text2: "Happy",
                            text3: "Customers",
                          ),
                          CountWidget(
                            size: size,
                            text1: "1M",
                            text2: "Awesome",
                            text3: "Reviews",
                          ),
                        ],
                      ),
                    ),
                    AboutWidget(size: size, scrollController: _scrollController),
                    Container(
                      color: AppColors.ebony,
                      padding: EdgeInsets.symmetric(vertical: size.width * 0.05),
                      child: SizedBox(
                        height: size.height,
                        child: CertificateWidget(size: size, itemct: 3, itemCt: 3, ),
                      ),
                    ),
                    Container(
                      color: AppColors.ebony,
                      padding: EdgeInsets.symmetric(vertical: size.width * 0.05),
                      child: SizedBox(
                        height: size.height,
                        child: EducationTab(size: size, scrollController: _scrollController),
                      ),
                    ),
                    Container(
                      color: AppColors.ebony,
                      padding: EdgeInsets.symmetric(vertical: size.width * 0.05),
                      child: SizedBox(
                        height: size.height,
                        child: SkillsWidget(size: size, itemct: 3),
                      ),
                    ),
                    Container(
                      color: AppColors.ebony,
                      padding: EdgeInsets.symmetric(vertical: size.width * 0.05),
                      child: SizedBox(
                        height: size.height,
                        child: Project_Widget(
                          size: size,
                          itemct: 3,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
