import 'package:flutter/material.dart';
import 'package:portfolio/Screen/Widgets/Count_Container_Widget.dart';
import 'package:portfolio/Screen/Widgets/Download_CV.dart';
import 'package:portfolio/Screen/Widgets/Education_Widget.dart';
import 'package:portfolio/Screen/Widgets/Header_Text_Widget.dart';
import 'package:portfolio/Screen/Widgets/About_Widget.dart';
import 'package:portfolio/Screen/Widgets/Project_Widget.dart';
import 'package:portfolio/Screen/Widgets/Rotating_image_widget.dart';
import 'package:portfolio/Screen/Widgets/Skills_Widget.dart';
import 'package:portfolio/Screen/Widgets/Social_widget.dart';
import 'package:portfolio/Screen/Widgets/Certificate_Widget.dart';
import 'package:portfolio/constants/colors.dart';
import 'package:portfolio/constants/styles.dart';

class TabletLayout extends StatefulWidget {
  const TabletLayout({super.key});

  @override
  State<TabletLayout> createState() => _TabletLayoutState();
}

class _TabletLayoutState extends State<TabletLayout> {
  // ScrollController for controlling scrolling behavior
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController
        .dispose(); // Dispose the controller when the widget is disposed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: Styles.gradientDecorations,
        child: SingleChildScrollView(
          controller: _scrollController, // Assign the scroll controller here
          child: Container(
            margin: EdgeInsets.symmetric(vertical: size.height * 0.18),
            child: Column(
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [RotatingImageContainer()],
                          ),
                        ),
                        SizedBox(
                          height: size.width * 0.09,
                        ),
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
                  height: 20,
                ),
               
                AboutWidget(size: size, scrollController: _scrollController),
                Container(
                  color: Colors.transparent,
                  padding: EdgeInsets.symmetric(vertical: size.width * 0.05),
                  child: SizedBox(
                    height: 400,
                    child: CertificateWidget(
                      size: size,
                      itemCt: 2,
                    ),
                  ),
                ),
                Container(
                  color: Colors.transparent,
                  padding: EdgeInsets.symmetric(vertical: size.width * 0.05),
                  child: SizedBox(
                    height: 550,
                    child: EducationTab(
                        size: size, scrollController: _scrollController),
                  ),
                ),
                Container(
                  color: Colors.transparent,
                  padding: EdgeInsets.symmetric(vertical: size.width * 0.05),
                  child: SizedBox(
                      height: 600, child: SkillsWidget(size: size, itemct: 3)),
                ),
                Container(
                  color: Colors.transparent,
                  padding: EdgeInsets.symmetric(vertical: size.width * 0.05),
                  child: SizedBox(
                      height: size.height,
                      child: Project_Widget(
                        size: size,
                        itemct: 2,
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
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
