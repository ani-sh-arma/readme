import 'package:drift/drift.dart';

import '../database/app_database.dart';

class BookmarkRepository {
  const BookmarkRepository(this._db);

  final AppDatabase _db;

  Stream<List<Bookmark>> watchBookmarksForBook(int bookId) =>
      _db.bookmarksDao.watchBookmarksForBook(bookId);

  Future<List<Bookmark>> getBookmarksForBook(int bookId) =>
      _db.bookmarksDao.getBookmarksForBook(bookId);

  Future<int> addBookmark(int bookId, String position, {String label = ''}) =>
      _db.bookmarksDao.insertBookmark(
        BookmarksCompanion(
          bookId: Value(bookId),
          position: Value(position),
          label: Value(label),
          createdAt: Value(DateTime.now()),
        ),
      );

  Future<int> deleteBookmark(int id) => _db.bookmarksDao.deleteBookmark(id);

  Future<int> deleteBookmarksForBook(int bookId) =>
      _db.bookmarksDao.deleteBookmarksForBook(bookId);

  Future<bool> hasBookmarks(int bookId) =>
      _db.bookmarksDao.hasBookmarks(bookId);
}

class BookSettingsRepository {
  const BookSettingsRepository(this._db);

  final AppDatabase _db;

  Future<BookSetting?> getSettings(int bookId) =>
      _db.bookSettingsDao.getSettingsForBook(bookId);

  Stream<BookSetting?> watchSettings(int bookId) =>
      _db.bookSettingsDao.watchSettingsForBook(bookId);

  Future<void> upsertSettings(BookSettingsCompanion settings) =>
      _db.bookSettingsDao.upsertSettings(settings);
}

class ReadingSessionRepository {
  const ReadingSessionRepository(this._db);

  final AppDatabase _db;

  Future<int> startSession(int bookId) =>
      _db.readingSessionsDao.startSession(bookId);

  Future<void> endSession(int sessionId, int pagesRead) =>
      _db.readingSessionsDao.endSession(sessionId, pagesRead);

  Future<int> totalPagesRead(int bookId) =>
      _db.readingSessionsDao.totalPagesReadForBook(bookId);

  Future<Duration> totalReadingTime(int bookId) =>
      _db.readingSessionsDao.totalReadingTimeForBook(bookId);

  Stream<List<ReadingSession>> watchAllSessions() =>
      _db.readingSessionsDao.watchAllSessions();
}

class HighlightRepository {
  const HighlightRepository(this._db);

  final AppDatabase _db;

  Stream<List<Highlight>> watchHighlightsForBook(int bookId) =>
      _db.highlightsDao.watchHighlightsForBook(bookId);

  Future<List<Highlight>> getHighlightsForBook(int bookId) =>
      _db.highlightsDao.getHighlightsForBook(bookId);

  Future<int> addHighlight(
    int bookId,
    String cfiRange,
    String selectedText, {
    String color = 'yellow',
  }) => _db.highlightsDao.insertHighlight(
    HighlightsCompanion(
      bookId: Value(bookId),
      cfiRange: Value(cfiRange),
      selectedText: Value(selectedText),
      color: Value(color),
      createdAt: Value(DateTime.now()),
      updatedAt: Value(DateTime.now()),
    ),
  );

  Future<int> deleteHighlight(int id) => _db.highlightsDao.deleteHighlight(id);
}
