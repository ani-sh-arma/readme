import 'package:flutter/material.dart';

import '../../../data/database/app_database.dart';
import '../services/mobi_converter_service.dart';
import 'txt_reader.dart';

/// Renders MOBI/AZW files by first converting them to HTML via the Android
/// platform channel, then displaying the result as plain text.
///
/// On iOS this format is not supported (see ios_issues.md).
class MobiReader extends StatefulWidget {
  const MobiReader({super.key, required this.book});

  final Book book;

  @override
  State<MobiReader> createState() => _MobiReaderState();
}

class _MobiReaderState extends State<MobiReader> {
  String? _htmlPath;
  String? _error;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _convert();
  }

  Future<void> _convert() async {
    try {
      final path = await MobiConverterService.convert(widget.book.filePath);
      if (path == null) {
        if (mounted) {
          setState(
            () => _error =
                'MOBI/AZW is only supported on Android. See ios_issues.md.',
          );
        }
        return;
      }
      if (mounted) setState(() => _htmlPath = path);
    } catch (e) {
      if (mounted) setState(() => _error = e.toString());
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) return const Center(child: CircularProgressIndicator());
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

    // Reuse TxtReader-style rendering by substituting the file path
    // with the converted HTML file.
    final htmlBook = Book(
      id: widget.book.id,
      title: widget.book.title,
      author: widget.book.author,
      filePath: _htmlPath!,
      coverPath: widget.book.coverPath,
      format: 'html',
      dateAdded: widget.book.dateAdded,
      lastOpenedAt: widget.book.lastOpenedAt,
      totalPages: widget.book.totalPages,
      currentPosition: widget.book.currentPosition,
      isFavorite: widget.book.isFavorite,
      isRead: widget.book.isRead,
      isInReadList: widget.book.isInReadList,
      rating: widget.book.rating,
      fileSize: widget.book.fileSize,
      genre: widget.book.genre,
    );

    return TxtReader(book: htmlBook);
  }
}
