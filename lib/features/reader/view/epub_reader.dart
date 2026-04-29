import 'dart:io';

import 'package:epub_view/epub_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/database/app_database.dart';
import '../bloc/reader_cubit.dart';

class EpubReader extends StatefulWidget {
  const EpubReader({super.key, required this.book});

  final Book book;

  @override
  State<EpubReader> createState() => _EpubReaderState();
}

class _EpubReaderState extends State<EpubReader> {
  EpubController? _controller;

  @override
  void initState() {
    super.initState();
    _controller = EpubController(
      document: EpubDocument.openFile(File(widget.book.filePath)),
      epubCfi: widget.book.currentPosition.isNotEmpty
          ? widget.book.currentPosition
          : null,
    );
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<ReaderCubit>().state;
    final settings = state.settings;

    return EpubView(
      controller: _controller!,
      onDocumentError: (e) {
        debugPrint('EPUB error: $e');
      },
      onChapterChanged: (_) {
        final cfi = _controller?.generateEpubCfi();
        if (cfi != null && cfi.isNotEmpty) {
          context.read<ReaderCubit>().updatePosition(cfi);
        }
      },
      builders: EpubViewBuilders<DefaultBuilderOptions>(
        options: DefaultBuilderOptions(
          textStyle: TextStyle(
            fontSize: settings?.fontSize ?? 16.0,
            height: settings?.lineHeight ?? 1.5,
            fontFamily: _fontFamily(settings?.fontFamily),
          ),
        ),
      ),
    );
  }

  String? _fontFamily(String? family) {
    if (family == null || family == 'Default') return null;
    return family;
  }
}
