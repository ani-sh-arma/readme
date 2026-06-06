import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pdfx/pdfx.dart';

import '../../../core/theme/reader_style.dart';
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

  // Color matrix that inverts RGB while preserving alpha. Used to render
  // light-on-dark PDFs when the reader theme is dark.
  static const List<double> _invertMatrix = <double>[
    -1, 0, 0, 0, 255, //
    0, -1, 0, 0, 255, //
    0, 0, -1, 0, 255, //
    0, 0, 0, 1, 0, //
  ];

  PhotoViewGalleryPageOptions _buildPage(
    BuildContext context,
    Future<PdfPageImage> pageImage,
    int index,
    PdfDocument document,
    bool invert,
  ) {
    if (!invert) {
      return PhotoViewGalleryPageOptions(
        imageProvider: PdfPageImageProvider(pageImage, index, document.id),
        minScale: PhotoViewComputedScale.contained,
        maxScale: PhotoViewComputedScale.contained * 3.0,
        initialScale: PhotoViewComputedScale.contained,
        heroAttributes: PhotoViewHeroAttributes(tag: '${document.id}-$index'),
      );
    }

    final viewport = MediaQuery.sizeOf(context);

    return PhotoViewGalleryPageOptions.customChild(
      minScale: PhotoViewComputedScale.contained,
      maxScale: PhotoViewComputedScale.contained * 3.0,
      initialScale: PhotoViewComputedScale.contained,
      heroAttributes: PhotoViewHeroAttributes(tag: '${document.id}-$index'),
      childSize: Size(viewport.width, viewport.height),
      child: Center(
        child: FutureBuilder<PdfPageImage>(
          future: pageImage,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const CircularProgressIndicator();
            }

            return ColorFiltered(
              colorFilter: const ColorFilter.matrix(_invertMatrix),
              child: Image(
                image: PdfPageImageProvider(pageImage, index, document.id),
                fit: BoxFit.contain,
                filterQuality: FilterQuality.high,
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<ReaderCubit>().state;
    final preset = state.settings?.theme ?? 'Light';
    final style = resolveReaderStyle(state.settings);
    final scrollMode = state.settings?.scrollMode ?? 'paged';
    final invert = preset == 'Dark' || preset == 'Amoled';
    final bg = invert ? Colors.black : style.background;

    Widget pdf = PdfView(
      controller: _controller!,
      scrollDirection: scrollMode == 'continuous'
          ? Axis.vertical
          : Axis.horizontal,
      backgroundDecoration: BoxDecoration(color: bg),
      onPageChanged: (page) {
        final total = widget.book.totalPages > 0 ? widget.book.totalPages : 1;
        context.read<ReaderCubit>().updatePosition(
          page.toString(),
          progress: (page / total).clamp(0.0, 1.0),
        );
      },
      builders: PdfViewBuilders<DefaultBuilderOptions>(
        options: const DefaultBuilderOptions(),
        documentLoaderBuilder: (_) =>
            const Center(child: CircularProgressIndicator()),
        pageLoaderBuilder: (_) =>
            const Center(child: CircularProgressIndicator()),
        pageBuilder: (context, pageImage, index, document) =>
            _buildPage(context, pageImage, index, document, invert),
        errorBuilder: (_, error) =>
            Center(child: Text('Error loading PDF: $error')),
      ),
    );

    return Container(color: bg, child: pdf);
  }
}
