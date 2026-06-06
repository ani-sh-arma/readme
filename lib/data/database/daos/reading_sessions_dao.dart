import 'package:drift/drift.dart';

import '../app_database.dart';
import '../tables/reading_sessions_table.dart';

part 'reading_sessions_dao.g.dart';

@DriftAccessor(tables: [ReadingSessions])
class ReadingSessionsDao extends DatabaseAccessor<AppDatabase>
    with _$ReadingSessionsDaoMixin {
  ReadingSessionsDao(super.db);

  Future<int> startSession(int bookId) => into(readingSessions).insert(
    ReadingSessionsCompanion(
      bookId: Value(bookId),
      startedAt: Value(DateTime.now()),
    ),
  );

  Future<void> endSession(int sessionId, int pagesRead) =>
      (update(readingSessions)..where((s) => s.id.equals(sessionId))).write(
        ReadingSessionsCompanion(
          endedAt: Value(DateTime.now()),
          pagesRead: Value(pagesRead),
        ),
      );

  Future<List<ReadingSession>> getSessionsForBook(int bookId) =>
      (select(readingSessions)..where((s) => s.bookId.equals(bookId))).get();

  Future<int> totalPagesReadForBook(int bookId) async {
    final sessions = await getSessionsForBook(bookId);
    return sessions.fold<int>(0, (sum, session) => sum + session.pagesRead);
  }

  Future<Duration> totalReadingTimeForBook(int bookId) async {
    final sessions = await getSessionsForBook(bookId);
    Duration total = Duration.zero;
    for (final s in sessions) {
      if (s.endedAt != null) {
        total += s.endedAt!.difference(s.startedAt);
      }
    }
    return total;
  }

  Stream<List<ReadingSession>> watchAllSessions() =>
      select(readingSessions).watch();
}
