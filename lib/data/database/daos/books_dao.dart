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

  Future<List<Book>> searchBooks(String query) =>
      (select(books)
            ..where(
              (b) =>
                  b.title.like('%$query%') | b.author.like('%$query%'),
            ))
          .get();
}
