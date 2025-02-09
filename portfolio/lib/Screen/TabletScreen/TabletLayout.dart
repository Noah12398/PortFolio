import 'package:flutter/material.dart';
import 'package:portfolio/Screen/Widgets/Education_Widget.dart';
import 'package:portfolio/Screen/Widgets/Footer_Widget.dart';
import 'package:portfolio/Screen/Widgets/Header_Text_Widget.dart';
import 'package:portfolio/Screen/Widgets/About_Widget.dart';
import 'package:portfolio/Screen/Widgets/Header_Widget.dart';
import 'package:portfolio/Screen/Widgets/Project_Widget.dart';
import 'package:portfolio/Screen/Widgets/Rotating_image_widget.dart';
import 'package:portfolio/Screen/Widgets/Skills_Widget.dart';
import 'package:portfolio/Screen/Widgets/Certificate_Widget.dart';
import 'package:portfolio/constants/colors.dart';
import 'package:portfolio/constants/styles.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:animated_background/animated_background.dart';

class TabletLayout extends StatefulWidget {
  const TabletLayout({super.key});

  @override
  State<TabletLayout> createState() => _TabletLayoutState();
}

class _TabletLayoutState extends State<TabletLayout> with TickerProviderStateMixin {
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

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    precacheImage(particleImage.image, context);

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80),
        child: AppBar(
          title: Text('My Portfolio'),
          backgroundColor: Colors.black.withOpacity(0.8),
          actions: [
            Spacer(),
            BuildNavButton(title: 'Home', key2: homeKey),
            Spacer(),
            BuildNavButton(title: 'About', key2: aboutKey),
            Spacer(),
            BuildNavButton(title: 'Certificates', key2: certificateKey),
            Spacer(),
            BuildNavButton(title: 'Education', key2: educationKey),
            Spacer(),
            BuildNavButton(title: 'Skills', key2: skillsKey),
            Spacer(),
            BuildNavButton(title: 'Projects', key2: projectKey),
            Spacer(),
          ],
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
                  children: [
                    // Home Section
                    Container(
                      key: homeKey,
                      margin: EdgeInsets.symmetric(vertical: size.height * 0.15),
                      height: size.height * 0.85, // Adjusted for tablet size
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              HeaderTextWidget(size: size),
                              SizedBox(height: 20),
                              Social_large(size: size),
                            ],
                          ),
                          Expanded(
                            child: Column(
                              children: [RotatingImageContainer()],
                            ),
                          ),
                        ],
                      ),
                    ),
                    // About Section
                    Container(
                      key: aboutKey,
                      child: AboutWidget(
                        size: size,
                        scrollController: _scrollController,
                      ),
                    ),
                    // Certificate Section
                    Container(
                      key: certificateKey,
                      color: Colors.transparent,
                      margin: EdgeInsets.all(15),
                      padding: EdgeInsets.symmetric(vertical: size.width * 0.05),
                      child: SizedBox(
                        height: size.height * 0.7,
                        child: CertificateWidget(size: size, itemCt: 3),
                      ),
                    ),
                    // Education Section
                    Container(
                      key: educationKey,
                      color: Colors.transparent,
                      padding: EdgeInsets.symmetric(vertical: size.width * 0.05),
                      child: SizedBox(
                        height: size.height * 0.75,
                        child: EducationTab(
                          size: size,
                          scrollController: _scrollController,
                        ),
                      ),
                    ),
                    // Skills Section
                    Container(
                      key: skillsKey,
                      color: Colors.transparent,
                      padding: EdgeInsets.symmetric(vertical: size.width * 0.03),
                      child: SizedBox(
                        height: size.height * 0.7,
                        child: SkillsWidget(size: size, itemct: 3),
                      ),
                    ),
                    // Projects Section
                    Container(
                      key: projectKey,
                      color: Colors.transparent,
                      padding:
                          EdgeInsets.symmetric(vertical: size.width * 0.05),
                      child: SizedBox(
                        height: size
                            .height, // Set a height for your SizedBox if needed
                        child: Project_Widget(size: size, itemct: 2),
                      ),
                    ),
                    // Footer Section
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
