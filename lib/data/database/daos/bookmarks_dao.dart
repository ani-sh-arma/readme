import 'package:drift/drift.dart';

import '../app_database.dart';
import '../tables/bookmarks_table.dart';

part 'bookmarks_dao.g.dart';

@DriftAccessor(tables: [Bookmarks])
class BookmarksDao extends DatabaseAccessor<AppDatabase>
    with _$BookmarksDaoMixin {
  BookmarksDao(super.db);

  Stream<List<Bookmark>> watchBookmarksForBook(int bookId) =>
      (select(bookmarks)..where((bm) => bm.bookId.equals(bookId))).watch();

  Future<List<Bookmark>> getBookmarksForBook(int bookId) =>
      (select(bookmarks)..where((bm) => bm.bookId.equals(bookId))).get();

  Future<int> insertBookmark(BookmarksCompanion bookmark) =>
      into(bookmarks).insert(bookmark);

  Future<int> deleteBookmark(int id) =>
      (delete(bookmarks)..where((bm) => bm.id.equals(id))).go();

  Future<int> deleteBookmarksForBook(int bookId) =>
      (delete(bookmarks)..where((bm) => bm.bookId.equals(bookId))).go();

  /// Returns true if the given book has at least one bookmark.
  Future<bool> hasBookmarks(int bookId) async {
    final result =
        await (select(bookmarks)..where((bm) => bm.bookId.equals(bookId)))
            .get();
    return result.isNotEmpty;
  }
}
