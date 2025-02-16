import 'package:animated_background/animated_background.dart';
import 'package:flutter/material.dart';
import 'package:portfolio/Screen/Widgets/Count_Container_Widget.dart';
import 'package:portfolio/Screen/Widgets/Download_CV.dart';
import 'package:portfolio/Screen/Widgets/Education_Widget.dart';
import 'package:portfolio/Screen/Widgets/Footer_Widget.dart';
import 'package:portfolio/Screen/Widgets/Header_Text_Widget.dart';
import 'package:portfolio/Screen/Widgets/About_Widget.dart';
import 'package:portfolio/Screen/Widgets/Header_Widget.dart';
import 'package:portfolio/Screen/Widgets/PortfolioSidePanel.dart';
import 'package:portfolio/Screen/Widgets/Project_Widget.dart';
import 'package:portfolio/Screen/Widgets/Rotating_image_widget.dart';
import 'package:portfolio/Screen/Widgets/Skills_Widget.dart';
import 'package:portfolio/Screen/Widgets/Certificate_Widget.dart';
import 'package:portfolio/Screen/Widgets/Social_widget.dart';
import 'package:portfolio/constants/colors.dart';
import 'package:portfolio/constants/styles.dart';
import 'package:responsive_builder/responsive_builder.dart';

class MobileLayout extends StatefulWidget {
  const MobileLayout({super.key});

  @override
  State<MobileLayout> createState() => _MobileLayoutState();
}

class _MobileLayoutState extends State<MobileLayout>
    with TickerProviderStateMixin {
  bool isAboutVisible = false;
  final ScrollController _scrollController = ScrollController();

  final GlobalKey homeKey = GlobalKey();
  final GlobalKey aboutKey = GlobalKey();
  final GlobalKey certificateKey = GlobalKey();
  final GlobalKey educationKey = GlobalKey();
  final GlobalKey skillsKey = GlobalKey();
  final GlobalKey projectKey = GlobalKey();

  late Image particleImage;

  @override
  void initState() {
    super.initState();
    particleImage = Image.asset("assets/images/Shape.png");
  }

  void scrollToSection(GlobalKey key) {
    Scrollable.ensureVisible(
      key.currentContext!,
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: Colors.black.withOpacity(0.8),
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
      ),
      drawer: SizedBox(
        width: size.width*0.6,
        child: PortfolioSidePanel(
          homeKey: homeKey,
          aboutKey: aboutKey,
          certificateKey: certificateKey,
          educationKey: educationKey,
          skillsKey: skillsKey,
          projectKey: projectKey,
          scrollToSection: scrollToSection, // Pass the scroll function
        ),
      ),
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
              behaviour: RandomParticleBehaviour(
                options: ParticleOptions(
                  spawnMaxRadius: 90,
                  particleCount: 20,
                  image: particleImage,
                ),
              ),
              vsync: this,
              child: SingleChildScrollView(
                controller: _scrollController,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      key: homeKey,
                      margin: EdgeInsets.symmetric(vertical: size.height * 0.2),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          RotatingImageContainer(),
                          HeaderTextWidget(size: size),
                          SizedBox(height: 20),
                          Social_large(size: size),
                        ],
                      ),
                    ),
                    Container(
                      key: aboutKey,
                      child: AboutWidget(
                          size: size, scrollController: _scrollController),
                    ),
                    Container(
                      key: certificateKey,
                      margin: EdgeInsets.all(15),
                      padding:
                          EdgeInsets.symmetric(vertical: size.width * 0.05),
                      child: CertificateWidget(size: size, itemCt: 3),
                    ),
                    Container(
                      key: educationKey,
                      padding:
                          EdgeInsets.symmetric(vertical: size.width * 0.05),
                      child: EducationTab(
                          size: size, scrollController: _scrollController),
                    ),
                    Container(
                      key: skillsKey,
                      margin: EdgeInsets.all(15),
                      padding:
                          EdgeInsets.symmetric(vertical: size.width * 0.04),
                      child: SkillsWidget(size: size, itemct: 2),
                    ),
                    Container(
                      key: projectKey,
                      margin: EdgeInsets.all(15),
                      padding:
                          EdgeInsets.symmetric(vertical: size.width * 0.04),
                      child: ProjectWidget(size: size, itemct: 1),
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

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
