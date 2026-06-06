import 'dart:io';
import 'dart:typed_data';

import 'package:epubx/epubx.dart' as epubx;
import 'package:html/parser.dart' as html_parser;
import 'package:image/image.dart' as img;
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:pdfx/pdfx.dart';

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
  final Map<String, bool> _coverValidityCache = {};

  bool isUsableCover(String? coverPath) {
    if (coverPath == null) return false;
    final file = File(coverPath);
    if (!file.existsSync()) return false;
    final stat = file.statSync();
    final cacheKey =
        '$coverPath:${stat.size}:${stat.modified.millisecondsSinceEpoch}';
    final cached = _coverValidityCache[cacheKey];
    if (cached != null) return cached;
    try {
      final valid = img.decodeImage(file.readAsBytesSync()) != null;
      _coverValidityCache[cacheKey] = valid;
      return valid;
    } catch (_) {
      _coverValidityCache[cacheKey] = false;
      return false;
    }
  }

  Future<BookMetadataSnapshot> extractMetadata(
    File file, {
    required String format,
    required String fallbackTitle,
    String fallbackAuthor = 'Unknown',
  }) async {
    return switch (format) {
      'epub' => _extractEpub(file, fallbackTitle, fallbackAuthor),
      'pdf' => _extractPdf(file, fallbackTitle, fallbackAuthor),
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
        img.encodePng(book.CoverImage!),
        suffix: 'epub_cover_v2',
      );
      coverSource = 'cover';
    } else {
      final firstPage = _firstEpubPage(book);
      final firstPageImage = _firstEpubPageImage(book, firstPage);
      if (firstPageImage != null) {
        try {
          coverPath = await _writeBytesCover(
            await _coverDirectory(),
            file.path,
            firstPageImage,
            suffix: 'epub_first_page_image',
          );
        } on FormatException {
          coverPath = null;
        }
      }
      if (coverPath == null) {
        coverPath = await _writeEpubPagePreview(
          sourcePath: file.path,
          title: title.isEmpty ? fallbackTitle : title,
          author: author.isEmpty ? fallbackAuthor : author,
          html: firstPage?.html,
        );
        coverSource = 'first_page';
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
    coverPath ??= await _writePlaceholderCover(
      title: fallbackTitle,
      format: 'pdf',
      sourcePath: file.path,
    );

    return BookMetadataSnapshot(
      title: fallbackTitle,
      author: fallbackAuthor,
      totalPages: pagesCount,
      coverPath: coverPath,
      coverSource: coverPath.endsWith('_pdf_first_page.png')
          ? 'first_page'
          : 'generated',
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
    if (file.existsSync()) {
      return file.path;
    }

    final image = img.Image(420, 640);
    final background = _placeholderBackground(format);
    img.fill(image, background);
    img.fillRect(image, 0, 480, 420, 640, img.getColor(0, 0, 0));

    final bytes = img.encodePng(image);
    await file.writeAsBytes(bytes, flush: true);
    return file.path;
  }

  Future<String> _writeEpubPagePreview({
    required String sourcePath,
    required String title,
    required String author,
    String? html,
  }) async {
    final dir = await _coverDirectory();
    final file = File(
      p.join(dir.path, '${sourcePath.hashCode}_epub_first_page_preview.png'),
    );
    if (file.existsSync()) return file.path;

    final image = img.Image(420, 640);
    img.fill(image, img.getColor(246, 239, 221));
    img.fillRect(image, 0, 0, 420, 14, img.getColor(54, 83, 107));
    img.drawString(
      image,
      img.arial_24,
      28,
      42,
      _wrapText(title, maxCharacters: 26, maxLines: 4),
      color: img.getColor(44, 52, 56),
    );
    img.drawString(
      image,
      img.arial_14,
      30,
      170,
      _wrapText(author, maxCharacters: 44, maxLines: 2),
      color: img.getColor(93, 96, 90),
    );

    final excerpt = _pageExcerpt(html);
    if (excerpt.isNotEmpty) {
      img.drawString(
        image,
        img.arial_14,
        30,
        250,
        _wrapText(excerpt, maxCharacters: 48, maxLines: 16),
        color: img.getColor(69, 67, 61),
      );
    }

    await file.writeAsBytes(img.encodePng(image), flush: true);
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
    final output = File(p.join(dir.path, '${sourcePath.hashCode}_$suffix.png'));
    if (output.existsSync()) {
      return output.path;
    }

    final decoded = img.decodeImage(Uint8List.fromList(bytes));

    if (decoded == null) {
      throw const FormatException('Unsupported cover image format.');
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

  ({String path, String html})? _firstEpubPage(epubx.EpubBook book) {
    final htmlFiles = book.Content?.Html ?? const {};
    if (htmlFiles.isEmpty) return null;

    final manifest = book.Schema?.Package?.Manifest?.Items ?? const [];
    final spine = book.Schema?.Package?.Spine?.Items ?? const [];
    for (final spineItem in spine) {
      final manifestItem = manifest
          .where((item) => item.Id == spineItem.IdRef && item.Href != null)
          .firstOrNull;
      final path = manifestItem?.Href;
      if (path == null) continue;
      final match = _findTextContent(htmlFiles, path);
      if (match != null && match.value.Content != null) {
        return (path: match.key, html: match.value.Content!);
      }
    }

    final first = htmlFiles.entries.first;
    final html = first.value.Content;
    return html == null ? null : (path: first.key, html: html);
  }

  List<int>? _firstEpubPageImage(
    epubx.EpubBook book,
    ({String path, String html})? page,
  ) {
    if (page == null) return null;
    final images = book.Content?.Images ?? const {};
    if (images.isEmpty) return null;

    final document = html_parser.parse(page.html);
    final imageElement = document.querySelector('img, image');
    final source =
        imageElement?.attributes['src'] ??
        imageElement?.attributes['href'] ??
        imageElement?.attributes['xlink:href'];
    if (source == null ||
        source.startsWith('data:') ||
        source.startsWith('http:') ||
        source.startsWith('https:')) {
      return null;
    }

    final sourcePath = source.split('#').first.split('?').first;
    final imagePath = p.posix.normalize(
      p.posix.join(p.posix.dirname(page.path), Uri.decodeFull(sourcePath)),
    );
    for (final entry in images.entries) {
      if (p.posix.normalize(entry.key) == imagePath) {
        return entry.value.Content;
      }
    }
    return null;
  }

  MapEntry<String, epubx.EpubTextContentFile>? _findTextContent(
    Map<String, epubx.EpubTextContentFile> htmlFiles,
    String rawPath,
  ) {
    final normalized = p.posix.normalize(Uri.decodeFull(rawPath));
    for (final entry in htmlFiles.entries) {
      if (p.posix.normalize(entry.key) == normalized) return entry;
    }
    return null;
  }

  String _pageExcerpt(String? html) {
    if (html == null || html.trim().isEmpty) return '';
    return html_parser
            .parse(html)
            .body
            ?.text
            .replaceAll(RegExp(r'\s+'), ' ')
            .trim() ??
        '';
  }

  String _wrapText(
    String text, {
    required int maxCharacters,
    required int maxLines,
  }) {
    final words = text.replaceAll(RegExp(r'\s+'), ' ').trim().split(' ');
    final lines = <String>[];
    var current = '';
    for (final word in words) {
      final candidate = current.isEmpty ? word : '$current $word';
      if (candidate.length <= maxCharacters) {
        current = candidate;
        continue;
      }
      if (current.isNotEmpty) lines.add(current);
      current = word;
      if (lines.length == maxLines) break;
    }
    if (current.isNotEmpty && lines.length < maxLines) lines.add(current);
    return lines.join('\n');
  }
}

extension<T> on Iterable<T> {
  T? get firstOrNull => isEmpty ? null : first;
}
