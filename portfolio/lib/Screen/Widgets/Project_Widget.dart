import 'package:flutter/material.dart';
import 'package:portfolio/constants/colors.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:url_launcher/url_launcher.dart';

class Project_Widget extends StatefulWidget {
  final Size size;
  final int itemct;

  Project_Widget({super.key, required this.size, required this.itemct});

  @override
  _Project_WidgetState createState() => _Project_WidgetState();
}

class _Project_WidgetState extends State<Project_Widget> {
  final List<Map<String, String>> ProjectList = [
    {
      'image': 'assets/images/Translator.png',
      'title': 'Translator',
      'link': 'https://github.com/Noah12398/Translator'
    },
    {
      'image': 'assets/images/Recipemaker.png',
      'title': 'Recipe Maker',
      'link': 'https://github.com/Noah12398/Recipe-Maker'
    },
    {
      'image': 'assets/images/Cargame.png',
      'title': 'Car Game',
      'link': 'https://github.com/Noah12398/CarGame'
    },
    {
      'image': 'assets/images/Legal_AI.png',
      'title': 'Legal AI',
      'link': 'https://github.com/Noah12398/Lawful_AI',
      'deploy': 'https://lawful-ai.onrender.com/'
    },
    {
      'image': 'assets/images/Notes.png',
      'title': 'Notes',
      'link': 'https://github.com/Noah12398/NotesApp'
    },
    {
      'image': 'assets/images/Titanic.png',
      'title': 'Titanic Survival Prediction',
      'link': 'https://github.com/Noah12398/Titanic',
      'deploy': 'https://titanic-y364.onrender.com'
    },
  ];

  List<bool> _isHovered = [];

  @override
  void initState() {
    super.initState();
    _isHovered = List.filled(ProjectList.length, false);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GradientText(
          'Projects',
          colors: [
            AppColors.valhalla,
            AppColors.darkblue,
          ],
          style: TextStyle(
            fontSize: widget.size.width * 0.04,
            fontWeight: FontWeight.bold,
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: widget.itemct,
                crossAxisSpacing: widget.size.width * 0.05,
                mainAxisSpacing: widget.size.height * 0.05,
              ),
              itemCount: ProjectList.length,
              itemBuilder: (context, index) {
                return MouseRegion(
                  onEnter: (_) {
                    setState(() {
                      _isHovered[index] = true;
                    });
                  },
                  onExit: (_) {
                    setState(() {
                      _isHovered[index] = false;
                    });
                  },
                  child: Container(
                    width: widget.size.width * 0.4,
                    height: widget.size.height * 0.3,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Stack(
                      children: [
                        Card(
                          elevation: 0,
                          color: Colors.transparent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Column(
                              children: [
                                Expanded(
                                  child: Container(
                                    width: double.infinity,
                                    height: double.infinity,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.transparent,
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.asset(
                                        ProjectList[index]['image']!,
                                        fit: BoxFit
                                            .contain, // Ensures the entire image fits within the container
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    ProjectList[index]['title']!,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.valhalla,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        if (_isHovered[index])
                          Positioned.fill(
                            child: Container(
                              color: Colors.black.withOpacity(
                                  0.6), // Semi-transparent background
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .center, // Align children at the bottom
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  ElevatedButton(
                                    onPressed: () {
                                      final url = ProjectList[index]['link'];
                                      if (url != null) {
                                        _launchURL(url);
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColors
                                          .gravel, // Dark professional color
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            30), // Smoother rounded corners
                                      ),
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 24,
                                          vertical: 16), // Better spacing
                                      elevation: 5, // Add subtle shadow for depth
                                      shadowColor: Colors.black.withOpacity(0.3),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize
                                          .min, // Adjust width based on content
                                      children: [
                                        Icon(
                                          Icons
                                              .code, // Add an icon for a professional touch
                                          color: Colors.white,
                                          size: 22,
                                        ),
                                        SizedBox(
                                            width:
                                                10), // Space between icon and text
                                        Text(
                                          'Get Code',
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight
                                                .w600, // Semi-bold for better readability
                                            fontFamily:
                                                'Poppins', // Use a professional font
                                            letterSpacing:
                                                0.8, // Improve spacing between letters
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                      width:
                                          20), // Add spacing from the bottom edge
                                  if (ProjectList[index]['deploy'] != null &&
                                      ProjectList[index]['deploy']!.isNotEmpty)
                                    ElevatedButton(
                                      onPressed: () {
                                        final url = ProjectList[index]['deploy'];
                                        if (url != null) {
                                          _launchURL(url);
                                        }
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: AppColors
                                            .gravel, // Dark professional color
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              30), // Smoother rounded corners
                                        ),
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 24,
                                            vertical: 16), // Better spacing
                                        elevation:
                                            5, // Add subtle shadow for depth
                                        shadowColor:
                                            Colors.black.withOpacity(0.3),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize
                                            .min, // Adjust width based on content
                                        children: [
                                          Icon(
                                            Icons
                                                .visibility, // Add an icon for "View"
                                            color: Colors.white,
                                            size: 22,
                                          ),
                                          SizedBox(
                                              width:
                                                  10), // Space between icon and text
                                          Text(
                                            'View',
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight
                                                  .w600, // Semi-bold for better readability
                                              fontFamily:
                                                  'Poppins', // Use a professional font
                                              letterSpacing:
                                                  0.8, // Improve spacing between letters
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  void _launchURL(String url) {
    // Using url_launcher package to open the link in the browser
    launchUrl(Uri.parse(url));
  }
}
