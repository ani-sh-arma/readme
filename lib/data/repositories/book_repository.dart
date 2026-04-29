import 'dart:io';

import 'package:drift/drift.dart';
import 'package:mime/mime.dart';
import 'package:path/path.dart' as p;

import '../database/app_database.dart';
import '../database/tables/books_table.dart';

class BookRepository {
  const BookRepository(this._db);

  final AppDatabase _db;

  // --- streams ---

  Stream<List<Book>> watchAllBooks() => _db.booksDao.watchAllBooks();
  Stream<List<Book>> watchFavorites() => _db.booksDao.watchFavorites();
  Stream<List<Book>> watchReadList() => _db.booksDao.watchReadList();
  Stream<List<Book>> watchCurrentlyReading() =>
      _db.booksDao.watchCurrentlyReading();
  Stream<List<Book>> watchHistory() => _db.booksDao.watchHistory();

  // --- queries ---

  Future<List<Book>> getAllBooks() => _db.booksDao.getAllBooks();
  Future<Book?> getBookById(int id) => _db.booksDao.getBookById(id);
  Future<Book?> getBookByPath(String path) =>
      _db.booksDao.getBookByPath(path);
  Future<List<Book>> searchBooks(String query) =>
      _db.booksDao.searchBooks(query);

  // --- mutations ---

  /// Inserts or updates a book record. Returns the book id.
  Future<int> upsertBook(BooksCompanion book) =>
      _db.booksDao.insertBook(book);

  Future<bool> updateBook(BooksCompanion book) =>
      _db.booksDao.updateBook(book);

  Future<int> deleteBook(int id) => _db.booksDao.deleteBook(id);

  Future<void> updatePosition(int id, String position) =>
      _db.booksDao.updatePosition(id, position);

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
    // DjVu support is intentionally deferred for v1; skip until reader exists.
    if (format == BookFormat.unknown || format == BookFormat.djvu) return;

    if (!await file.exists()) return;

    final existing = await getBookByPath(file.path);
    final stat = await file.stat();

    if (existing != null) {
      if (existing.fileSize != stat.size) {
        await updateBook(
          existing.copyWith(fileSize: stat.size).toCompanion(false),
        );
      }
      return;
    }

    await upsertBook(
      BooksCompanion(
        title: Value(titleFromPath(file.path)),
        filePath: Value(file.path),
        format: Value(format.name),
        dateAdded: Value(DateTime.now()),
        fileSize: Value(stat.size),
      ),
    );
  }

  // --- scanning helpers ---

  /// Derives a [BookFormat] from a file path by looking at its MIME type and
  /// extension.
  static BookFormat formatFromPath(String path) {
    final ext = p.extension(path).toLowerCase().replaceFirst('.', '');
    const map = {
      'epub': BookFormat.epub,
      'pdf': BookFormat.pdf,
      'txt': BookFormat.txt,
      'html': BookFormat.html,
      'htm': BookFormat.html,
      'cbz': BookFormat.cbz,
      'cbr': BookFormat.cbr,
      'mobi': BookFormat.mobi,
      'azw': BookFormat.azw,
      'azw3': BookFormat.azw3,
      'djvu': BookFormat.djvu,
    };
    if (map.containsKey(ext)) return map[ext]!;

    final mime = lookupMimeType(path);
    if (mime != null) {
      if (mime.contains('epub')) return BookFormat.epub;
      if (mime.contains('pdf')) return BookFormat.pdf;
      if (mime.contains('text')) return BookFormat.txt;
      if (mime.contains('zip')) return BookFormat.cbz;
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

    final entities = recursive
        ? dir.list(recursive: true, followLinks: false)
        : dir.list(recursive: false, followLinks: false);

    await for (final entity in entities) {
      if (entity is! File) continue;
      final format = formatFromPath(entity.path);
      if (format == BookFormat.unknown || format == BookFormat.djvu) continue;

      onProgress?.call(entity.path);

      final existing = await getBookByPath(entity.path);
      if (existing != null) continue;

      final stat = await entity.stat();
      await upsertBook(
        BooksCompanion(
          title: Value(titleFromPath(entity.path)),
          filePath: Value(entity.path),
          format: Value(format.name),
          dateAdded: Value(DateTime.now()),
          fileSize: Value(stat.size),
        ),
      );
      added++;
    }

    return added;
  }
}
