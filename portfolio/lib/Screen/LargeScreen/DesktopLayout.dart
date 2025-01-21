import 'package:flutter/material.dart';
import 'package:portfolio/Screen/Widgets/Count_Container_Widget.dart';
import 'package:portfolio/Screen/Widgets/Education_Widget.dart';
import 'package:portfolio/Screen/Widgets/Footer_Widget.dart';
import 'package:portfolio/Screen/Widgets/Header_Text_Widget.dart';
import 'package:portfolio/Screen/Widgets/About_Widget.dart';
import 'package:portfolio/Screen/Widgets/Project_Widget.dart';
import 'package:portfolio/Screen/Widgets/Rotating_image_widget.dart';
import 'package:portfolio/Screen/Widgets/Skills_Widget.dart';
import 'package:portfolio/Screen/Widgets/Certificate_Widget.dart';
import 'package:portfolio/constants/colors.dart';
import 'package:portfolio/constants/styles.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:animated_background/animated_background.dart';

class DesktopLayout extends StatefulWidget {
  const DesktopLayout({super.key});

  @override
  State<DesktopLayout> createState() => _DesktopLayoutState();
}

class _DesktopLayoutState extends State<DesktopLayout> with TickerProviderStateMixin {
  bool isAboutVisible = false;
  ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
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
            return AnimatedBackground(
              behaviour: SpaceBehaviour(
              ),
              vsync: this,
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
                    SizedBox(height: 75,),
                    AboutWidget(size: size, scrollController: _scrollController),
                    Container(
                      color: Colors.transparent,
                      margin: EdgeInsets.all(15),
                      padding: EdgeInsets.symmetric(vertical: size.width * 0.05),
                      child: SizedBox(
                        height: size.height,
                        child: CertificateWidget(size: size, itemct: 3, itemCt: 3),
                      ),
                    ),
                    Container(
                      color: Colors.transparent,
                      padding: EdgeInsets.symmetric(vertical: size.width * 0.05),
                      child: SizedBox(
                        height: size.height,
                        child: EducationTab(size: size, scrollController: _scrollController),
                      ),
                    ),
                    Container(
                      color: Colors.transparent,
                      padding: EdgeInsets.symmetric(vertical: size.width * 0.03),
                      child: SizedBox(
                        height: size.height,
                        child: SkillsWidget(size: size, itemct: 4),
                      ),
                    ),
                    Container(
                      color: Colors.transparent,
                      padding: EdgeInsets.symmetric(vertical: size.width * 0.05),
                      child: SizedBox(
                        height: size.height,
                        child: Project_Widget(size: size, itemct: 3),
                      ),
                    ),
                    FooterWidget(size: size),
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
