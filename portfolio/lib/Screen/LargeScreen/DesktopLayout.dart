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

class DesktopLayout extends StatefulWidget {
  const DesktopLayout({super.key});

  @override
  State<DesktopLayout> createState() => _DesktopLayoutState();
}

class _DesktopLayoutState extends State<DesktopLayout>
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
    // Only preload the image here without using context.
    particleImage = Image.asset("assets/images/Shape.png");
  }

  @override
  Widget build(BuildContext context) {
    // Now accessing MediaQuery inside build() method
    Size size = MediaQuery.of(context).size;

    // Precache the image here in build() method
    precacheImage(particleImage.image, context);

    return Scaffold(
      appBar: PreferredSize(
        preferredSize:
            Size.fromHeight(80), // Increase the height of the AppBar here
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
                    Container(
                      key: homeKey,
                      margin: EdgeInsets.symmetric(vertical: size.height * 0.2),
                      height: size.height,
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
                            child: Column(
                              children: [RotatingImageContainer()],
                            ),
                          ),
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
                      color: Colors.transparent,
                      margin: EdgeInsets.all(15),
                      padding:
                          EdgeInsets.symmetric(vertical: size.width * 0.05),
                      child: SizedBox(
                        height: size.height,
                        child: CertificateWidget(
                            size: size, itemCt: 3), // Corrected to itemCt
                      ),
                    ),
                    Container(
                      key: educationKey,
                      color: Colors.transparent,
                      padding:
                          EdgeInsets.symmetric(vertical: size.width * 0.05),
                      child: SizedBox(
                        height: size.height,
                        child: EducationTab(
                            size: size, scrollController: _scrollController),
                      ),
                    ),
                    
                    Container(
                      key: skillsKey,
                      color: Colors.transparent,
                      margin: EdgeInsets.all(15),
                      padding:
                          EdgeInsets.symmetric(vertical: size.width * 0.03),
                      child: SkillsWidget(size: size, itemct: 4),
                    ),
                    Container(
                      key: projectKey,
                      color: Colors.transparent,
                      margin: EdgeInsets.all(15),
                      padding:
                          EdgeInsets.symmetric(vertical: size.width * 0.05),
                      child: ProjectWidget(size: size, itemct: 3),
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
