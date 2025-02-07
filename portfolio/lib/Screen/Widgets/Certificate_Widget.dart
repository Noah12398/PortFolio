import 'package:flutter/material.dart';
import 'package:pdfx/pdfx.dart';
import 'package:portfolio/constants/colors.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class CertificateWidget extends StatefulWidget {
  final Size size;
  final int itemCt;

  const CertificateWidget({
    super.key,
    required this.size,
    required this.itemCt,
  });

  @override
  State<CertificateWidget> createState() => _CertificateWidgetState();
}

class _CertificateWidgetState extends State<CertificateWidget> {
  final List<String> certificateList = [
    'assets/images/Cybersecurity.pdf',
    'assets/images/FullStack.pdf',
    'assets/images/Backend.pdf'
  ];

  late List<PdfController> pdfControllers;

  @override
  void initState() {
    super.initState();
    // Initialize a PdfController for each PDF
    pdfControllers = certificateList
        .map((path) => PdfController(document: PdfDocument.openAsset(path)))
        .toList();
  }

  @override
  void dispose() {
    // Dispose of all PdfControllers
    for (var controller in pdfControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GradientText(
          'Certificates',
          colors: [
            AppColors.valhalla,
            AppColors.darkblue,
          ],
          style: TextStyle(
            fontSize: widget.size.width * 0.04,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: widget.size.height * 0.02), // Space between title and grid
        Padding(
          padding: const EdgeInsets.all(30.0),
          child: GridView.builder(
            shrinkWrap: true, // Make GridView take only the space it needs
            physics: NeverScrollableScrollPhysics(), // Disable scrolling for GridView
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: widget.itemCt, // Number of items per row
              crossAxisSpacing: widget.size.width * 0.05,
              mainAxisSpacing: widget.size.height * 0.05,
            ),
            itemCount: certificateList.length,
            itemBuilder: (context, index) {
              return PdfView(
                controller: pdfControllers[index], // Use the persistent controller
                scrollDirection: Axis.vertical, // Make sure it scrolls vertically if necessary
              );
            },
          ),
        ),
      ],
    );
  }
}
