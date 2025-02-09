import 'package:flutter/material.dart';
import 'package:portfolio/constants/colors.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:url_launcher/url_launcher.dart';

class ProjectWidget extends StatefulWidget {
  final Size size;
  final int itemct;

  ProjectWidget({super.key, required this.size, required this.itemct});

  @override
  _ProjectWidgetState createState() => _ProjectWidgetState();
}

class _ProjectWidgetState extends State<ProjectWidget> {
  final List<Map<String, String>> projectList = [
    {
      'image': 'assets/images/Translator.png',
      'title': 'Translator',
      'link': 'https://github.com/Noah12398/Translator'
    },
    {
      'image': 'assets/images/Recipemaker.png',
      'title': 'Recipe Maker',
      'link': 'https://github.com/Noah12398/Recipe-Maker',
      'deploy': 'https://recipe-maker-9c7a0.web.app/'
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
    _isHovered = List.filled(projectList.length, false);
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final crossAxisCount = screenSize.width > 1000 ? 3 : screenSize.width > 600 ? 2 : 1;

    return Column(
      children: [
        GradientText(
          'Projects',
          colors: [AppColors.valhalla, AppColors.darkblue],
          style: TextStyle(
            fontSize: screenSize.width * 0.05,
            fontWeight: FontWeight.bold,
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
              ),
              itemCount: projectList.length,
              itemBuilder: (context, index) {
                return MouseRegion(
                  onEnter: (_) => setState(() => _isHovered[index] = true),
                  onExit: (_) => setState(() => _isHovered[index] = false),
                  child: Stack(
                    children: [
                      Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        elevation: 5,
                        child: Column(
                          children: [
                            Expanded(
                              child: ClipRRect(
                                borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
                                child: Image.asset(
                                  projectList[index]['image']!,
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                projectList[index]['title']!,
                                style: TextStyle(
                                  fontSize: screenSize.width * 0.015,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.valhalla,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (_isHovered[index])
                        Positioned.fill(
                          child: Container(
                            color: Colors.black.withOpacity(0.6),
                            child: Center(
                              child: Wrap(
                                spacing: 10,
                                children: [
                                  _buildButton('Get Code', Icons.code, projectList[index]['link']),
                                  if (projectList[index]['deploy'] != null)
                                    _buildButton('View', Icons.visibility, projectList[index]['deploy']),
                                ],
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildButton(String text, IconData icon, String? url) {
    return ElevatedButton.icon(
      onPressed: url != null ? () => _launchURL(url) : null,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.gravel,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      ),
      icon: Icon(icon, color: Colors.white),
      label: Text(
        text,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
    );
  }

  void _launchURL(String url) {
    launchUrl(Uri.parse(url));
  }
}
