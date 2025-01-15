import 'package:flutter/material.dart';
import 'package:portfolio/Screen/MobileScreen/MobileLayout.dart';
import 'package:portfolio/Screen/TabletScreen/TabletLayout.dart';
import 'LargeScreen/DesktopLayout.dart';

class Homescreen extends StatelessWidget {
  const Homescreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth > 950) {
        return DesktopLayout();
      } else if (constraints.maxWidth > 600) {
        return TabletLayout();
      } else {
        return MobileLayout();
      }
    });
  }
}
