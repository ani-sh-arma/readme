import 'dart:io';

import 'package:drift/drift.dart';
import 'package:mime/mime.dart';
import 'package:path/path.dart' as p;

import '../database/app_database.dart';
import '../database/tables/books_table.dart';
import '../services/book_media_service.dart';

class BookRepository {
  BookRepository(this._db) : _media = BookMediaService();

  final AppDatabase _db;
  final BookMediaService _media;
  static const Set<String> _supportedFormats = {'epub', 'pdf'};

  // --- streams ---

  Stream<List<Book>> watchAllBooks() =>
      _db.booksDao.watchAllBooks().map(_supportedOnly);
  Stream<List<Book>> watchFavorites() => _db.booksDao.watchFavorites();
  Stream<List<Book>> watchReadList() => _db.booksDao.watchReadList();
  Stream<List<Book>> watchCurrentlyReading() =>
      _db.booksDao.watchCurrentlyReading();
  Stream<List<Book>> watchHistory() => _db.booksDao.watchHistory();
  Stream<List<Book>> watchBooksInDirectory(
    String directoryPath, {
    bool recursive = true,
  }) => _db.booksDao.watchBooksInDirectory(directoryPath, recursive: recursive);

  // --- queries ---

  Future<List<Book>> getAllBooks() async =>
      _supportedOnly(await _db.booksDao.getAllBooks());
  Future<Book?> getBookById(int id) => _db.booksDao.getBookById(id);
  Future<Book?> getBookByPath(String path) => _db.booksDao.getBookByPath(path);
  Future<List<Book>> searchBooks(String query) async =>
      _supportedOnly(await _db.booksDao.searchBooks(query));

  // --- mutations ---

  /// Inserts or updates a book record. Returns the book id.
  Future<int> upsertBook(BooksCompanion book) => _db.booksDao.insertBook(book);

  Future<bool> updateBook(BooksCompanion book) => _db.booksDao.updateBook(book);

  Future<int> deleteBook(int id) => _db.booksDao.deleteBook(id);

  Future<void> updatePosition(int id, String position, {double? progress}) =>
      progress == null
      ? _db.booksDao.updatePosition(id, position)
      : _db.booksDao.updateReadingProgress(
          id,
          position: position,
          progress: progress,
        );

  Future<void> markFavorite(int id, {required bool isFavorite}) =>
      _db.booksDao.markFavorite(id, isFavorite: isFavorite);

  Future<void> markRead(int id, {required bool isRead}) =>
      _db.booksDao.markRead(id, isRead: isRead);

  Future<void> markInReadList(int id, {required bool inReadList}) =>
      _db.booksDao.markInReadList(id, inReadList: inReadList);

  Future<void> updateCover(int id, String coverPath) =>
      _db.booksDao.updateCover(id, coverPath);

  Future<void> removeBookByPath(String path) async {
    final existing = await getBookByPath(path);
    if (existing != null) {
      await deleteBook(existing.id);
    }
  }

  Future<void> upsertFromFile(File file) async {
    final format = formatFromPath(file.path);
    if (format == BookFormat.unknown) return;

    if (!await file.exists()) return;

    final existing = await getBookByPath(file.path);
    final stat = await file.stat();
    final currentCoverExists =
        existing?.coverPath != null && File(existing!.coverPath!).existsSync();
    if (existing != null &&
        existing.fileSize == stat.size &&
        currentCoverExists &&
        existing.format == format.name) {
      return;
    }

    final metadata = await _media.extractMetadata(
      file,
      format: format.name,
      fallbackTitle: titleFromPath(file.path),
    );

    if (existing != null) {
      await _db.booksDao.updateMetadata(
        existing.id,
        title: metadata.title,
        author: metadata.author,
        totalPages: metadata.totalPages,
        coverPath: metadata.coverPath ?? existing.coverPath,
        coverSource: metadata.coverSource,
        fileSize: stat.size,
      );
      return;
    }

    await upsertBook(
      BooksCompanion(
        title: Value(metadata.title),
        author: Value(metadata.author),
        filePath: Value(file.path),
        format: Value(format.name),
        dateAdded: Value(DateTime.now()),
        coverPath: Value(metadata.coverPath),
        coverSource: Value(metadata.coverSource),
        totalPages: Value(metadata.totalPages),
        fileSize: Value(stat.size),
      ),
    );
  }

  // --- scanning helpers ---

  /// Derives a [BookFormat] from a file path by looking at its MIME type and
  /// extension.
  static BookFormat formatFromPath(String path) {
    final ext = p.extension(path).toLowerCase().replaceFirst('.', '');
    const map = {'epub': BookFormat.epub, 'pdf': BookFormat.pdf};
    if (map.containsKey(ext)) return map[ext]!;

    final mime = lookupMimeType(path);
    if (mime != null) {
      if (mime.contains('epub')) return BookFormat.epub;
      if (mime.contains('pdf')) return BookFormat.pdf;
    }
    return BookFormat.unknown;
  }

  /// Returns a displayable title derived from the filename.
  static String titleFromPath(String path) {
    final name = p.basenameWithoutExtension(path);
    return name.replaceAll('_', ' ').replaceAll('-', ' ');
  }

  /// Scans [dir] recursively and inserts any new supported books. Returns the
  /// count of newly added books.
  Future<int> scanDirectory(
    Directory dir, {
    bool recursive = true,
    void Function(String currentFile)? onProgress,
  }) async {
    int added = 0;
    final seenPaths = <String>{};

    final entities = recursive
        ? dir.list(recursive: true, followLinks: false)
        : dir.list(recursive: false, followLinks: false);

    await for (final entity in entities) {
      if (entity is! File) continue;
      final format = formatFromPath(entity.path);
      if (format == BookFormat.unknown) continue;

      onProgress?.call(entity.path);
      seenPaths.add(entity.path);

      final existing = await getBookByPath(entity.path);
      if (existing != null) {
        await upsertFromFile(entity);
        continue;
      }

      await upsertFromFile(entity);
      added++;
    }

    final allBooks = await getAllBooks();
    for (final book in allBooks) {
      final inScope = recursive
          ? _isDescendant(book.filePath, dir.path)
          : p.dirname(book.filePath) == dir.path;
      if (!inScope) continue;
      if (!seenPaths.contains(book.filePath)) {
        await deleteBook(book.id);
      }
    }

    return added;
  }

  bool _isDescendant(String filePath, String rootPath) {
    final normalizedFile = filePath.replaceAll('\\', '/');
    final normalizedRoot = rootPath.replaceAll('\\', '/');
    return normalizedFile.startsWith('$normalizedRoot/');
  }

  List<Book> _supportedOnly(List<Book> books) =>
      books.where((book) => _supportedFormats.contains(book.format)).toList();
}
