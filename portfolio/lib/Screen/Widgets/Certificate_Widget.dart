import 'package:flutter/material.dart';
import 'package:pdfx/pdfx.dart';
import 'package:portfolio/constants/colors.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class Certificate_Widget extends StatelessWidget {
  final Size size;
  final int itemct;
  Certificate_Widget({super.key, required this.size, required this.itemct});

  final List<String> CertificateList = [
    'assets/images/Cybersecurity.pdf',
    'assets/images/FullStack.pdf',
    'assets/images/Backend.pdf'
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: [
        GradientText(
          'Certificates',
          colors: [AppColors.valhalla, AppColors.capeCod],
          style: TextStyle(
              fontSize: size.width * 0.04, fontWeight: FontWeight.bold),
        ),
        Expanded(
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: itemct, // Number of cards per row
              crossAxisSpacing:
                  size.width * 0.05, // Spacing between cards horizontally
              mainAxisSpacing:
                  size.height * 0.05, // Spacing between cards vertically
            ),
            itemCount: CertificateList.length,
            itemBuilder: (context, index) {
              return Container(
                width: size.width * 0.4,
                height: size.height * 0.3, // Adjust height for the card
                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(20.0), // Rounded corners
                ),
                child: SizedBox(
                  child: Card(
                    elevation: 3,
                    color: Colors.transparent,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        width: double.infinity, // Take maximum available width
                        height: double.infinity, // Full height of the container
                        child: PdfView(
                          controller: PdfController(
                            document:
                                PdfDocument.openAsset(CertificateList[index]),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        )
      ],
    ));
  }
}
