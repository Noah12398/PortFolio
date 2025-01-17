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
import 'package:simple_gradient_text/simple_gradient_text.dart';

class DesktopLayout extends StatefulWidget {
  const DesktopLayout({super.key});

  @override
  State<DesktopLayout> createState() => _DesktopLayoutState();
}

class _DesktopLayoutState extends State<DesktopLayout> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: Styles.gradientDecorations,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.symmetric(vertical: size.height * 0.18),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        HeaderTextWidget(
                          size: size,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Social_large(size: size),
                      ],
                    ),
                    Expanded(
                        child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [RotatingImageContainer()],
                      ),
                    ))
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
              SizedBox(
                height: size.height * 0.12,
              ),
              AboutWidget(size: size),
              Container(
                color: AppColors.ebony,
                padding: EdgeInsets.symmetric(vertical: size.width * 0.05),
                child: SizedBox(
                  height: size.height,
                  child: Certificate_Widget(size: size, itemct: 3),
                ),
              ),
              Container(
                color: AppColors.ebony,
                padding: EdgeInsets.symmetric(vertical: size.width * 0.05),
                child: SizedBox(
                  height: size.height,
                  child: EducationTab(size: size),
                ),
              ),
              Container(
                color: AppColors.ebony,
                padding: EdgeInsets.symmetric(vertical: size.width * 0.05),
                child: SizedBox(
                    height: size.height,
                    child: SkillsWidget(size: size, itemct: 3)),
              ),
              Container(
                color: AppColors.ebony,
                padding: EdgeInsets.symmetric(vertical: size.width * 0.05),
                child: SizedBox(
                    height: size.height,
                    child: Project_Widget(
                      size: size,
                      itemct: 3,
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
