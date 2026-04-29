import 'dart:io';
import 'dart:typed_data';

import 'package:archive/archive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

import '../../../data/database/app_database.dart';
import '../bloc/reader_cubit.dart';

class CbzReader extends StatefulWidget {
  const CbzReader({super.key, required this.book});

  final Book book;

  @override
  State<CbzReader> createState() => _CbzReaderState();
}

class _CbzReaderState extends State<CbzReader> {
  List<Uint8List> _pages = [];
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
    _loadCbz();
  }

  Future<void> _loadCbz() async {
    try {
      final bytes = await File(widget.book.filePath).readAsBytes();
      final archive = ZipDecoder().decodeBytes(bytes);

      // Sort files: typical naming conventions put pages in order
      final imageFiles =
          archive.files
              .where(
                (f) =>
                    f.isFile &&
                    (f.name.endsWith('.jpg') ||
                        f.name.endsWith('.jpeg') ||
                        f.name.endsWith('.png') ||
                        f.name.endsWith('.webp')),
              )
              .toList()
            ..sort((a, b) => a.name.compareTo(b.name));

      final pages = imageFiles.map((f) => f.content as Uint8List).toList();

      if (mounted) {
        setState(() {
          _pages = pages;
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
      return Center(child: Text('Error loading comic: $_error'));
    }
    if (_loading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (_pages.isEmpty) {
      return const Center(child: Text('No pages found in archive.'));
    }

    return Column(
      children: [
        Expanded(
          child: PhotoViewGallery.builder(
            scrollPhysics: const BouncingScrollPhysics(),
            builder: (ctx, index) {
              // In manga mode, display pages right-to-left
              final pageIndex = _mangaMode
                  ? (_pages.length - 1 - index)
                  : index;
              return PhotoViewGalleryPageOptions(
                imageProvider: MemoryImage(_pages[pageIndex]),
                minScale: PhotoViewComputedScale.contained,
                maxScale: PhotoViewComputedScale.covered * 3.0,
                heroAttributes: PhotoViewHeroAttributes(tag: 'cbz_page_$index'),
              );
            },
            itemCount: _pages.length,
            pageController: _pageController,
            onPageChanged: (page) {
              setState(() => _currentPage = page);
              context.read<ReaderCubit>().updatePosition(page.toString());
            },
            backgroundDecoration: const BoxDecoration(color: Colors.black),
          ),
        ),
        // Manga mode toggle + page indicator
        Container(
          color: Colors.black,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${_currentPage + 1} / ${_pages.length}',
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
