import 'dart:io';

import 'package:epubx/epubx.dart' as epubx;
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

class EpubWebPage {
  const EpubWebPage({
    required this.path,
    required this.html,
    required this.baseUrl,
  });

  final String path;
  final String html;
  final String baseUrl;
}

class EpubWebDocument {
  const EpubWebDocument({required this.pages});

  final List<EpubWebPage> pages;
}

class EpubDocumentService {
  Future<EpubWebDocument> load(File file) async {
    final stat = await file.stat();
    final bytes = await file.readAsBytes();
    final book = await epubx.EpubReader.readBook(bytes);
    final content = book.Content;
    final htmlFiles = content?.Html ?? const {};
    if (htmlFiles.isEmpty) {
      throw const FormatException('This EPUB does not contain readable HTML.');
    }

    final cacheDir = await _cacheDirectory(file, stat);
    await _materializeAssets(cacheDir, content!);

    final orderedPaths = _readingOrder(book, htmlFiles.keys);
    final pages = <EpubWebPage>[];
    for (final path in orderedPaths) {
      final htmlFile = _findHtmlFile(htmlFiles, path);
      final html = htmlFile?.Content;
      if (html == null || html.trim().isEmpty) continue;

      final cachedPage = _fileForRelativePath(cacheDir, path);
      pages.add(
        EpubWebPage(
          path: path,
          html: html,
          baseUrl: cachedPage.parent.uri.toString(),
        ),
      );
    }

    if (pages.isEmpty) {
      throw const FormatException('This EPUB does not contain readable pages.');
    }
    return EpubWebDocument(pages: pages);
  }

  Future<Directory> _cacheDirectory(File file, FileStat stat) async {
    final support = await getApplicationSupportDirectory();
    final fingerprint =
        '${file.path.hashCode}_${stat.size}_${stat.modified.millisecondsSinceEpoch}';
    final directory = Directory(
      p.join(support.path, 'epub_web_cache', fingerprint),
    );
    if (!directory.existsSync()) {
      await directory.create(recursive: true);
    }
    return directory;
  }

  Future<void> _materializeAssets(
    Directory cacheDir,
    epubx.EpubContent content,
  ) async {
    final marker = File(p.join(cacheDir.path, '.ready'));
    if (marker.existsSync()) return;

    for (final entry in (content.AllFiles ?? const {}).entries) {
      final relativePath = _safeRelativePath(entry.key);
      if (relativePath == null) continue;

      final target = _fileForRelativePath(cacheDir, relativePath);
      await target.parent.create(recursive: true);
      final contentFile = entry.value;
      if (contentFile is epubx.EpubTextContentFile &&
          contentFile.Content != null) {
        await target.writeAsString(contentFile.Content!, flush: true);
      } else if (contentFile is epubx.EpubByteContentFile &&
          contentFile.Content != null) {
        await target.writeAsBytes(contentFile.Content!, flush: true);
      }
    }

    await marker.writeAsString('ready', flush: true);
  }

  List<String> _readingOrder(epubx.EpubBook book, Iterable<String> htmlPaths) {
    final manifest = book.Schema?.Package?.Manifest?.Items ?? const [];
    final spine = book.Schema?.Package?.Spine?.Items ?? const [];
    final manifestById = {
      for (final item in manifest)
        if (item.Id != null && item.Href != null) item.Id!: item.Href!,
    };

    final ordered = <String>[];
    for (final item in spine) {
      final href = manifestById[item.IdRef];
      final path = href == null ? null : _safeRelativePath(href);
      if (path != null && _containsPath(htmlPaths, path)) {
        ordered.add(path);
      }
    }

    for (final path in htmlPaths) {
      final normalized = _safeRelativePath(path);
      if (normalized != null && !ordered.contains(normalized)) {
        ordered.add(normalized);
      }
    }
    return ordered;
  }

  epubx.EpubTextContentFile? _findHtmlFile(
    Map<String, epubx.EpubTextContentFile> htmlFiles,
    String path,
  ) {
    for (final entry in htmlFiles.entries) {
      if (_safeRelativePath(entry.key) == path) return entry.value;
    }
    return null;
  }

  bool _containsPath(Iterable<String> paths, String candidate) {
    return paths.any((path) => _safeRelativePath(path) == candidate);
  }

  File _fileForRelativePath(Directory root, String relativePath) {
    return File(p.joinAll([root.path, ...p.posix.split(relativePath)]));
  }

  String? _safeRelativePath(String rawPath) {
    final withoutFragment = rawPath.split('#').first.split('?').first;
    final decoded = Uri.decodeFull(withoutFragment).replaceAll('\\', '/');
    final normalized = p.posix.normalize(decoded);
    if (normalized.isEmpty ||
        normalized == '.' ||
        normalized == '..' ||
        normalized.startsWith('../') ||
        p.posix.isAbsolute(normalized)) {
      return null;
    }
    return normalized;
  }
}
