import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:portfolio/Screen/Widgets/Text_Widget.dart';
import 'package:portfolio/constants/colors.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class AboutWidget extends StatelessWidget {
  final Size size;
  const AboutWidget({super.key, required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.ebony,
      padding: EdgeInsets.symmetric(vertical: size.width * 0.05),
      child: Container(
        height: size.height * 0.4,
        child: Column(
          children: [
            GradientText(
              "About",
              colors: [
                AppColors.studio,
                AppColors.paleSlate,
              ],
              style: TextStyle(
                  fontSize: size.width * 0.030,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: size.height * 0.02,
            ),
            Padding(
              padding: const EdgeInsets.all(40.0),
              child: Text(
                'Hi, I’m a passionate Computer Science Student with expertise in Flutter, Kotlin, and Python. I love creating innovative, user-friendly applications and solving real-world problems through technology.My projects range from  mobile apps to engaging games, reflecting my creativity and technical skills. I’m always eager to learn and grow while contributing to impactful projects.When I’m not coding, I enjoy exploring new tech. Let’s connect and create something amazing!',
                style: TextStyle(
                    fontSize: size.width * 0.015,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
                    color: Colors.white),
                textAlign: TextAlign.justify, // Center the text
              ),
            ),
          ],
        ),
      ),
    );
  }
}
