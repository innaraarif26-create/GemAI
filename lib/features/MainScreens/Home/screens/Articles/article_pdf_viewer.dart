import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../../../../../widgets/appbar/appbar.dart';

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
      appBar: AppAppBar(title: Text(title),showBackArrow: true,),

      body: SfPdfViewer.asset(
        pdfPath,
        enableDoubleTapZooming: true,
        canShowScrollHead: true,
      ),
    );
  }
}
