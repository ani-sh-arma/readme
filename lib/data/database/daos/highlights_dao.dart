import 'package:drift/drift.dart';

import '../app_database.dart';
import '../tables/highlights_table.dart';

part 'highlights_dao.g.dart';

@DriftAccessor(tables: [Highlights])
class HighlightsDao extends DatabaseAccessor<AppDatabase>
    with _$HighlightsDaoMixin {
  HighlightsDao(super.db);

  Stream<List<Highlight>> watchHighlightsForBook(int bookId) =>
      (select(highlights)
            ..where((h) => h.bookId.equals(bookId))
            ..orderBy([(h) => OrderingTerm.asc(h.createdAt)]))
          .watch();

  Future<List<Highlight>> getHighlightsForBook(int bookId) =>
      (select(highlights)
            ..where((h) => h.bookId.equals(bookId))
            ..orderBy([(h) => OrderingTerm.asc(h.createdAt)]))
          .get();

  Future<int> insertHighlight(HighlightsCompanion highlight) =>
      into(highlights).insert(highlight);

  Future<bool> updateHighlight(HighlightsCompanion highlight) =>
      update(highlights).replace(highlight);

  Future<int> deleteHighlight(int id) =>
      (delete(highlights)..where((h) => h.id.equals(id))).go();
}
