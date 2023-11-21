// ignore_for_file: must_be_immutable

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PertenenciasDocumentoPdf extends StatelessWidget {
  File pdfFile;
  PertenenciasDocumentoPdf(this.pdfFile, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reporte PDF'),
      ),
      body: SfPdfViewer.file(pdfFile),
    );
  }
}