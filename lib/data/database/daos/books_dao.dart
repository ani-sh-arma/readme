import 'package:drift/drift.dart';

import '../app_database.dart';
import '../tables/books_table.dart';

part 'books_dao.g.dart';

@DriftAccessor(tables: [Books])
class BooksDao extends DatabaseAccessor<AppDatabase> with _$BooksDaoMixin {
  BooksDao(super.db);

  Stream<List<Book>> watchAllBooks() => select(books).watch();

  Future<List<Book>> getAllBooks() => select(books).get();

  Future<Book?> getBookById(int id) =>
      (select(books)..where((b) => b.id.equals(id))).getSingleOrNull();

  Future<Book?> getBookByPath(String path) =>
      (select(books)..where((b) => b.filePath.equals(path))).getSingleOrNull();

  Future<int> insertBook(BooksCompanion book) =>
      into(books).insertOnConflictUpdate(book);

  Future<bool> updateBook(BooksCompanion book) =>
      update(books).replace(book);

  Future<int> deleteBook(int id) =>
      (delete(books)..where((b) => b.id.equals(id))).go();

  Stream<List<Book>> watchFavorites() =>
      (select(books)..where((b) => b.isFavorite.equals(true))).watch();

  Stream<List<Book>> watchReadList() =>
      (select(books)..where((b) => b.isRead.equals(true))).watch();

  Stream<List<Book>> watchCurrentlyReading() =>
      (select(books)
            ..where(
              (b) =>
                  b.currentPosition.isNotValue('') & b.isRead.equals(false),
            ))
          .watch();

  Stream<List<Book>> watchHistory() =>
      (select(books)
            ..where((b) => b.lastOpenedAt.isNotNull())
            ..orderBy([(b) => OrderingTerm.desc(b.lastOpenedAt)]))
          .watch();

  Future<void> updatePosition(int id, String position) =>
      (update(books)..where((b) => b.id.equals(id))).write(
        BooksCompanion(
          currentPosition: Value(position),
          lastOpenedAt: Value(DateTime.now()),
        ),
      );

  Future<void> updateReadingProgress(
    int id, {
    required String position,
    required double progress,
  }) => (update(books)..where((b) => b.id.equals(id))).write(
    BooksCompanion(
      currentPosition: Value(position),
      lastOpenedAt: Value(DateTime.now()),
      lastReadProgress: Value(progress.clamp(0, 1)),
      isRead: Value(progress >= 0.999),
      isInReadList: Value(progress >= 0.999),
    ),
  );

  Future<void> markFavorite(int id, {required bool isFavorite}) =>
      (update(books)..where((b) => b.id.equals(id)))
          .write(BooksCompanion(isFavorite: Value(isFavorite)));

  Future<void> markRead(int id, {required bool isRead}) =>
      (update(books)..where((b) => b.id.equals(id)))
          .write(BooksCompanion(isRead: Value(isRead)));

  Future<void> markInReadList(int id, {required bool inReadList}) =>
      (update(books)..where((b) => b.id.equals(id)))
          .write(BooksCompanion(isInReadList: Value(inReadList)));

  Future<void> updateCover(int id, String coverPath) =>
      (update(books)..where((b) => b.id.equals(id)))
          .write(BooksCompanion(coverPath: Value(coverPath)));

  Future<void> updateMetadata(
    int id, {
    required String title,
    required String author,
    required int totalPages,
    String? coverPath,
    String? coverSource,
    required int fileSize,
  }) => (update(books)..where((b) => b.id.equals(id))).write(
    BooksCompanion(
      title: Value(title),
      author: Value(author),
      totalPages: Value(totalPages),
      coverPath: Value(coverPath),
      coverSource: Value(coverSource ?? 'generated'),
      fileSize: Value(fileSize),
    ),
  );

  Future<List<Book>> searchBooks(String query) =>
      (select(books)
            ..where(
              (b) =>
                  b.title.like('%$query%') | b.author.like('%$query%'),
            ))
          .get();

  Stream<List<Book>> watchBooksInDirectory(
    String directoryPath, {
    bool recursive = true,
  }) => watchAllBooks().map(
    (items) => items.where((book) {
      final normalized = book.filePath.replaceAll('\\', '/');
      final dir = directoryPath.replaceAll('\\', '/');
      if (recursive) {
        return normalized.startsWith('$dir/');
      }
      final separatorIndex = normalized.lastIndexOf('/');
      final parent = separatorIndex <= 0
          ? normalized
          : normalized.substring(0, separatorIndex);
      return parent == dir;
    }).toList(),
  );
}
