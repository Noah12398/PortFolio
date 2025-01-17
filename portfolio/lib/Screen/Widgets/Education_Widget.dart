import 'package:flutter/material.dart';
import 'package:portfolio/constants/colors.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class Education {
  final String imagePath;
  final String title;

  Education({required this.imagePath, required this.title});
}

class EducationTab extends StatelessWidget {
  final Size size;

  EducationTab({super.key, required this.size});

  // List of data
  final List<Education> educationList = [
    Education(imagePath: 'assets/images/Vim.jpg', title: 'Vimalagiri International School'),
    Education(imagePath: 'assets/images/TKM.jpg', title: 'TKM College of Engineering'),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Gradient Text for the title
        GradientText(
          'Education',
          colors: [AppColors.valhalla, AppColors.capeCod],
          style: TextStyle(fontSize: size.width*0.04, fontWeight: FontWeight.bold),
        ),
        // ListView.builder for displaying education items
        Expanded(
          child: ListView.builder(
            itemCount: educationList.length, // Use the length of the data list
            itemBuilder: (context, index) {
              final education = educationList[index]; // Get the current item
              return Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: size.width * 0.8, // Adjusted to better fit the layout
                        height: size.height * 0.3,
                        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.teal,
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                        child: Card(
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50.0),
                          ),
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                child: Image.asset(
                                  education.imagePath, // Use data from the list
                                  width: size.height * 0.4,
                                  height: size.height * 0.3,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  education.title, // Use title from the list
                                  style: TextStyle(
                                    color: const Color.fromARGB(255, 21, 17, 17),
                                    fontSize: 18,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16), // Add gap between items
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
