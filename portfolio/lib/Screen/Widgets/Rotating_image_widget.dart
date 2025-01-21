import 'package:flutter/material.dart';

import 'dart:math' as math;

import 'package:portfolio/constants/colors.dart';


class RotatingImageContainer extends StatefulWidget {
  const RotatingImageContainer({super.key});

  @override
  State<RotatingImageContainer> createState() => _RotatingImageContainerState();
}

class _RotatingImageContainerState extends State<RotatingImageContainer> {
  
   bool isHovered=false;
  @override
  Widget build(BuildContext context) {
    final size=MediaQuery.of(context).size;
    return MouseRegion(
      
      onEnter: (_)=>setState(()=>isHovered=true),
      onExit: (_)=>setState(()=>isHovered=false),
      
      child: AnimatedContainer(
        
        duration: Duration(microseconds: 300),
        
        height: isHovered?size.width*0.26:size.width*0.24,
        width: isHovered?size.width*0.26:size.width*0.24,
        
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage('assets/images/ProfilePhoto.jpg')
          ),
          
          border: Border.all(color: AppColors.studio,width: 1.2),
          borderRadius: BorderRadius.circular(20)
        ),
        
      ),
      
    );
  }
}