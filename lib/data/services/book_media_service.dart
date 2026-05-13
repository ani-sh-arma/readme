import 'dart:io';
import 'dart:typed_data';

import 'package:archive/archive.dart';
import 'package:epubx/epubx.dart' as epubx;
import 'package:image/image.dart' as img;
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:pdfx/pdfx.dart';

import '../../features/reader/services/cbr_extractor_service.dart';

class BookMetadataSnapshot {
  const BookMetadataSnapshot({
    required this.title,
    required this.author,
    required this.totalPages,
    this.coverPath,
    this.coverSource = 'generated',
  });

  final String title;
  final String author;
  final int totalPages;
  final String? coverPath;
  final String coverSource;
}

class BookMediaService {
  Future<BookMetadataSnapshot> extractMetadata(
    File file, {
    required String format,
    required String fallbackTitle,
    String fallbackAuthor = 'Unknown',
  }) async {
    return switch (format) {
      'epub' => _extractEpub(file, fallbackTitle, fallbackAuthor),
      'pdf' => _extractPdf(file, fallbackTitle, fallbackAuthor),
      'cbz' => _extractCbz(file, fallbackTitle, fallbackAuthor),
      'cbr' => _extractCbr(file, fallbackTitle, fallbackAuthor),
      'txt' || 'html' || 'htm' || 'mobi' || 'azw' || 'azw3' =>
        _fallback(file, fallbackTitle, fallbackAuthor, format),
      _ => _fallback(file, fallbackTitle, fallbackAuthor, format),
    };
  }

  Future<BookMetadataSnapshot> _extractEpub(
    File file,
    String fallbackTitle,
    String fallbackAuthor,
  ) async {
    final bytes = await file.readAsBytes();
    final book = await epubx.EpubReader.readBook(bytes);
    final title = (book.Title ?? fallbackTitle).trim();
    final author = (book.Author ?? fallbackAuthor).trim();

    String? coverPath;
    String coverSource = 'generated';

    if (book.CoverImage != null) {
      coverPath = await _writeBytesCover(
        await _coverDirectory(),
        file.path,
        book.CoverImage!.getBytes(),
        suffix: 'epub_cover',
      );
      coverSource = 'cover';
    } else if (book.Content?.Images?.isNotEmpty ?? false) {
      final firstImage = book.Content!.Images!.values
          .map((image) => image.Content)
          .whereType<Uint8List>()
          .cast<List<int>>()
          .firstOrNull;
      if (firstImage != null) {
        coverPath = await _writeBytesCover(
          await _coverDirectory(),
          file.path,
          firstImage,
          suffix: 'epub_first_image',
        );
      }
    }

    return BookMetadataSnapshot(
      title: title.isEmpty ? fallbackTitle : title,
      author: author.isEmpty ? fallbackAuthor : author,
      totalPages: _countEpubChapters(book.Chapters ?? const []),
      coverPath: coverPath,
      coverSource: coverSource,
    );
  }

  Future<BookMetadataSnapshot> _extractPdf(
    File file,
    String fallbackTitle,
    String fallbackAuthor,
  ) async {
    final document = await PdfDocument.openFile(file.path);
    final pagesCount = document.pagesCount;
    String? coverPath;
    try {
      final page = await document.getPage(1);
      try {
        final pageImage = await page.render(
          width: page.width * 1.5,
          height: page.height * 1.5,
          format: PdfPageImageFormat.png,
          backgroundColor: '#ffffff',
        );
        if (pageImage != null) {
          coverPath = await _writeBytesCover(
            await _coverDirectory(),
            file.path,
            pageImage.bytes,
            suffix: 'pdf_first_page',
          );
        }
      } finally {
        await page.close();
      }
    } finally {
      await document.close();
    }

    return BookMetadataSnapshot(
      title: fallbackTitle,
      author: fallbackAuthor,
      totalPages: pagesCount,
      coverPath: coverPath,
      coverSource: coverPath != null ? 'first_page' : 'generated',
    );
  }

  Future<BookMetadataSnapshot> _extractCbz(
    File file,
    String fallbackTitle,
    String fallbackAuthor,
  ) async {
    final bytes = await file.readAsBytes();
    final archive = ZipDecoder().decodeBytes(bytes);
    final pages = archive.files
        .where((entry) => entry.isFile && _isImage(entry.name))
        .toList()
      ..sort((a, b) => a.name.compareTo(b.name));

    String? coverPath;
    if (pages.isNotEmpty) {
      final content = pages.first.content;
      if (content is List<int>) {
        coverPath = await _writeBytesCover(
          await _coverDirectory(),
          file.path,
          content,
          suffix: 'cbz_first_page',
        );
      }
    }

    return BookMetadataSnapshot(
      title: fallbackTitle,
      author: fallbackAuthor,
      totalPages: pages.length,
      coverPath: coverPath,
      coverSource: coverPath != null ? 'first_page' : 'generated',
    );
  }

  Future<BookMetadataSnapshot> _extractCbr(
    File file,
    String fallbackTitle,
    String fallbackAuthor,
  ) async {
    String? coverPath;
    int totalPages = 0;

    if (Platform.isAndroid) {
      final extracted = await CbrExtractorService.extract(file.path);
      if (extracted != null && extracted.isNotEmpty) {
        totalPages = extracted.length;
        coverPath = extracted.first;
      }
    }

    return BookMetadataSnapshot(
      title: fallbackTitle,
      author: fallbackAuthor,
      totalPages: totalPages,
      coverPath: coverPath,
      coverSource: coverPath != null ? 'first_page' : 'generated',
    );
  }

  Future<BookMetadataSnapshot> _fallback(
    File file,
    String fallbackTitle,
    String fallbackAuthor,
    String format,
  ) async {
    final coverPath = await _writePlaceholderCover(
      title: fallbackTitle,
      format: format,
      sourcePath: file.path,
    );
    return BookMetadataSnapshot(
      title: fallbackTitle,
      author: fallbackAuthor,
      totalPages: 0,
      coverPath: coverPath,
      coverSource: 'generated',
    );
  }

  Future<Directory> _coverDirectory() async {
    final base = await getApplicationSupportDirectory();
    final dir = Directory(p.join(base.path, 'covers'));
    if (!dir.existsSync()) {
      await dir.create(recursive: true);
    }
    return dir;
  }

  Future<String> _writePlaceholderCover({
    required String title,
    required String format,
    required String sourcePath,
  }) async {
    final dir = await _coverDirectory();
    final file = File(
      p.join(
        dir.path,
        '${sourcePath.hashCode}_${format.toLowerCase()}_placeholder.png',
      ),
    );

    final image = img.Image(420, 640);
    final background = _placeholderBackground(format);
    img.fill(image, background);
    img.fillRect(image, 0, 480, 420, 640, img.getColor(0, 0, 0));

    final bytes = img.encodePng(image);
    await file.writeAsBytes(bytes, flush: true);
    return file.path;
  }

  int _placeholderBackground(String format) {
    return switch (format) {
      'epub' => img.getColor(54, 83, 107),
      'pdf' => img.getColor(143, 37, 37),
      'cbz' || 'cbr' => img.getColor(38, 87, 54),
      'txt' => img.getColor(84, 78, 56),
      _ => img.getColor(66, 66, 66),
    };
  }

  Future<String> _writeBytesCover(
    Directory dir,
    String sourcePath,
    List<int> bytes, {
    required String suffix,
  }) async {
    final decoded = img.decodeImage(Uint8List.fromList(bytes));
    final output = File(p.join(dir.path, '${sourcePath.hashCode}_$suffix.png'));

    if (decoded == null) {
      await output.writeAsBytes(bytes, flush: true);
      return output.path;
    }

    final resized = img.copyResize(decoded, width: 420);
    await output.writeAsBytes(img.encodePng(resized), flush: true);
    return output.path;
  }

  int _countEpubChapters(List<epubx.EpubChapter> chapters) {
    if (chapters.isEmpty) return 0;
    var count = 0;
    for (final chapter in chapters) {
      count++;
      count += _countEpubChapters(chapter.SubChapters ?? const []);
    }
    return count;
  }

  bool _isImage(String name) {
    final lower = name.toLowerCase();
    return lower.endsWith('.jpg') ||
        lower.endsWith('.jpeg') ||
        lower.endsWith('.png') ||
        lower.endsWith('.webp');
  }
}

extension<T> on Iterable<T> {
  T? get firstOrNull => isEmpty ? null : first;
}
