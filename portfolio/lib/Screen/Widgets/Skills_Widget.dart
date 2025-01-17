import 'package:flutter/material.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class SkillsWidget extends StatelessWidget {
  final Size size;
  final int itemct;

  SkillsWidget({super.key, required this.size, required this.itemct});

  final List<Map<String, dynamic>> skillList = [
    {'imagePath': 'assets/images/HTML.jpg', 'stars': 4,'title':'HTML'},
    {'imagePath': 'assets/images/CSS.jpg', 'stars': 4,'title':'CSS'},
    {'imagePath': 'assets/images/Python.jpg', 'stars': 4,'title':'Python'},
    {'imagePath': 'assets/images/C.jpg', 'stars': 3,'title':'C'},
    {'imagePath': 'assets/images/Java.jpg', 'stars': 3,'title':'Java'},
    {'imagePath': 'assets/images/Flutter.jpg', 'stars': 4,'title':'Flutter'},
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.height * 0.7, // Adjust height for GridView
      child: Column(
        children: [
          GradientText(
            "Skills",
            colors: [Colors.blue, Colors.orange],
            style: TextStyle(
              fontSize: size.width * 0.04,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10), // Add spacing between title and grid
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: itemct,
                crossAxisSpacing: size.width * 0.05,
                mainAxisSpacing: size.height * 0.05,
              ),
              itemCount: skillList.length,
              itemBuilder: (context, index) {
                final skill = skillList[index];

                return Container(
                  padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.teal,
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Card(
                    elevation: 3,
                    color: Colors.blue[50],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.asset(
                                skill['imagePath'],
                                width: constraints.maxWidth * 0.7,
                                height: constraints.maxHeight * 0.4,
                                fit: BoxFit.contain, // Fit image inside container
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              skill['title'],
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 4),
                            // Add stars visually
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: List.generate(
                                5,
                                (starIndex) => Icon(
                                  starIndex < skill['stars']
                                      ? Icons.star
                                      : Icons.star_border, // Filled or outlined star
                                  color: Colors.amber,
                                  size: constraints.maxWidth * 0.1,
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
