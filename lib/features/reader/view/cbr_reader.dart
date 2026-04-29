import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

import '../../../data/database/tables/books_table.dart';
import '../bloc/reader_cubit.dart';
import '../services/cbr_extractor_service.dart';
import '../services/volume_key_service.dart';

class CbrReader extends StatefulWidget {
  const CbrReader({super.key, required this.book});

  final Book book;

  @override
  State<CbrReader> createState() => _CbrReaderState();
}

class _CbrReaderState extends State<CbrReader> {
  List<String> _imagePaths = [];
  bool _loading = true;
  String? _error;
  bool _mangaMode = false;
  late PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    final initialPage = int.tryParse(widget.book.currentPosition) ?? 0;
    _currentPage = initialPage;
    _pageController = PageController(initialPage: initialPage);
    _extract();

    // Volume button page turning (Android only)
    VolumeKeyService.events.listen((event) {
      if (!mounted) return;
      if (event == 'down') {
        _pageController.nextPage(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
        );
      } else if (event == 'up') {
        _pageController.previousPage(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  Future<void> _extract() async {
    try {
      final paths = await CbrExtractorService.extract(widget.book.filePath);
      if (paths == null) {
        if (mounted) {
          setState(
            () => _error =
                'CBR extraction is only supported on Android. See ios_issues.md.',
          );
        }
        return;
      }
      if (mounted) {
        setState(() {
          _imagePaths = paths;
          _loading = false;
        });
      }
    } catch (e) {
      if (mounted) setState(() => _error = e.toString());
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_error != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Text(
            _error!,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white),
          ),
        ),
      );
    }
    if (_loading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (_imagePaths.isEmpty) {
      return const Center(
        child: Text(
          'No pages found.',
          style: TextStyle(color: Colors.white),
        ),
      );
    }

    return Column(
      children: [
        Expanded(
          child: PhotoViewGallery.builder(
            scrollPhysics: const BouncingScrollPhysics(),
            builder: (ctx, index) {
              final pageIndex =
                  _mangaMode ? (_imagePaths.length - 1 - index) : index;
              return PhotoViewGalleryPageOptions(
                imageProvider: FileImage(File(_imagePaths[pageIndex])),
                minScale: PhotoViewComputedScale.contained,
                maxScale: PhotoViewComputedScale.covered * 3.0,
              );
            },
            itemCount: _imagePaths.length,
            pageController: _pageController,
            onPageChanged: (page) {
              setState(() => _currentPage = page);
              context.read<ReaderCubit>().updatePosition(page.toString());
            },
            backgroundDecoration: const BoxDecoration(color: Colors.black),
          ),
        ),
        Container(
          color: Colors.black,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${_currentPage + 1} / ${_imagePaths.length}',
                style: const TextStyle(color: Colors.white),
              ),
              Row(
                children: [
                  const Text('Manga', style: TextStyle(color: Colors.white)),
                  Switch(
                    value: _mangaMode,
                    onChanged: (v) => setState(() => _mangaMode = v),
                    activeColor: Colors.white,
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
