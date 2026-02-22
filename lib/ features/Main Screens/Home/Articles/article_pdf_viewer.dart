import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class ArticlePDFViewer extends StatelessWidget {
  final String title;
  final String pdfPath;

  const ArticlePDFViewer({
    super.key,
    required this.title,
    required this.pdfPath,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  const Color.fromARGB(255, 230, 227, 227),
      appBar: AppBar(
        title: Text(title,style: TextStyle(fontFamily: 'TimesRomanFont'),),
        backgroundColor: const Color.fromARGB(255, 230, 227, 227),
      ),
      body: SfPdfViewer.asset(
        pdfPath,
        enableDoubleTapZooming: true,
        canShowScrollHead: true,
      ),
    );
  }
}
