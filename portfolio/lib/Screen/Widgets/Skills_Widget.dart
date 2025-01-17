import 'package:flutter/material.dart';

class SkillsWidget extends StatelessWidget {
  final Size size;
   SkillsWidget({super.key, required this.size});

  
final List<Map<String, dynamic>> skillList = [
    {'imagePath': 'assets/images/HTML.jpg', 'stars': 1},
    {'imagePath': 'assets/images/CSS.jpg', 'stars': 2},
    {'imagePath': 'assets/images/Python.jpg', 'stars': 3},
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.height * 0.5, // Define height for the GridView
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: size.width * 0.05,
          mainAxisSpacing: size.height * 0.05,
        ),
        itemCount: 3, // Define how many projects you want to show
        itemBuilder: (context, index) {
                    final skill = skillList[index];

          return Container(
            width: size.width * 0.4,
            height: size.height * 0.3,
            padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.teal,
              borderRadius: BorderRadius.circular(50.0),
            ),
            child: Card(
              elevation: 3,
              color: Colors
                  .red, // You can dynamically set this color based on index
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  Expanded(
                    // Makes the image occupy the available space
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(
                        skill['imagePath'], // Use data from the list
                        width: double.infinity, // Takes full width
                        height: double.infinity, // Takes full height
                        fit: BoxFit.cover, // Makes image cover the container
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        'Project $index',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      Text(
                        'Project $index',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
