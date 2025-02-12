import 'package:flutter/material.dart';

class PortfolioSidePanel extends StatelessWidget {
  final GlobalKey homeKey;
  final GlobalKey aboutKey;
  final GlobalKey certificateKey;
  final GlobalKey educationKey;
  final GlobalKey skillsKey;
  final GlobalKey projectKey;
  final Function scrollToSection;  // Function to scroll to section

  PortfolioSidePanel({
    required this.homeKey,
    required this.aboutKey,
    required this.certificateKey,
    required this.educationKey,
    required this.skillsKey,
    required this.projectKey,
    required this.scrollToSection,  // Pass the function
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      backgroundColor: Colors.black,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.black,
              boxShadow: [
                BoxShadow(
                  color: Colors.black38,
                  spreadRadius: 1,
                  blurRadius: 5,
                )
              ],
            ),
            child: Text(
              'Portfolio',
              style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          _buildNavItem(Icons.home, 'Home', homeKey),
          _buildNavItem(Icons.person, 'About', aboutKey),
          _buildNavItem(Icons.card_giftcard, 'Certificates', certificateKey),
          _buildNavItem(Icons.school, 'Education', educationKey),
          _buildNavItem(Icons.memory, 'Skills', skillsKey),
          _buildNavItem(Icons.work, 'Projects', projectKey),
        ],
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String title, GlobalKey key) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      child: InkWell(
        onTap: () {
          scrollToSection(key);  // Call the scroll function when tapped
        },
        borderRadius: BorderRadius.circular(15),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
          decoration: BoxDecoration(
            color: Colors.black54,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 5,
                spreadRadius: 1,
              ),
            ],
          ),
          child: Row(
            children: [
              Icon(icon, color: Colors.white),
              SizedBox(width: 16),
              Text(
                title,
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
