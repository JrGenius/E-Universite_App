import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:webinar/common/common.dart';
import 'package:webinar/common/components.dart';

class PdfViewerPage extends StatefulWidget {
  static const String pageName = '/pdf-viewer';
  const PdfViewerPage({super.key});

  @override
  State<PdfViewerPage> createState() => _PdfViewerPageState();
}

class _PdfViewerPageState extends State<PdfViewerPage> {

  String? title;
  String? path;
  
  final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();
  PdfViewerController pdfViewerController = PdfViewerController();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      path = (ModalRoute.of(context)!.settings.arguments as List)[0];
      title = (ModalRoute.of(context)!.settings.arguments as List)[1];

      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return directionality(
      child: Scaffold(

        appBar: appbar(title: title ?? ''),

        body: path != null 
          ? SfPdfViewer.network(
              path ?? '', 
              key: _pdfViewerKey,
              controller: pdfViewerController,
              
            ) 
          : const SizedBox(),
        
      )
    );
  }

  @override
  void dispose() {
    pdfViewerController.dispose();
    super.dispose();
  }
}