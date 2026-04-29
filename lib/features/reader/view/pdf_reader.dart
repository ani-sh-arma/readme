import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pdfx/pdfx.dart';

import '../../../data/database/app_database.dart';
import '../bloc/reader_cubit.dart';

class PdfReader extends StatefulWidget {
  const PdfReader({super.key, required this.book});

  final Book book;

  @override
  State<PdfReader> createState() => _PdfReaderState();
}

class _PdfReaderState extends State<PdfReader> {
  PdfController? _controller;

  @override
  void initState() {
    super.initState();
    final initialPage = int.tryParse(widget.book.currentPosition) ?? 1;
    _controller = PdfController(
      document: PdfDocument.openFile(widget.book.filePath),
      initialPage: initialPage,
    );
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PdfView(
      controller: _controller!,
      scrollDirection: Axis.horizontal,
      onPageChanged: (page) {
        context.read<ReaderCubit>().updatePosition(page.toString());
      },
      builders: PdfViewBuilders<DefaultBuilderOptions>(
        options: const DefaultBuilderOptions(),
        documentLoaderBuilder: (_) =>
            const Center(child: CircularProgressIndicator()),
        pageLoaderBuilder: (_) =>
            const Center(child: CircularProgressIndicator()),
        errorBuilder: (_, error) =>
            Center(child: Text('Error loading PDF: $error')),
      ),
    );
  }
}
