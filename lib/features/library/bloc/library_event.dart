import 'dart:io';

import '../../../data/database/app_database.dart';
import 'library_state.dart';

abstract class LibraryEvent {}

class LibraryStarted extends LibraryEvent {}

class LibraryBooksUpdated extends LibraryEvent {
  LibraryBooksUpdated(this.books);
  final List<Book> books;
}

class LibraryScanRequested extends LibraryEvent {
  LibraryScanRequested(this.directory);
  final Directory directory;
}

class LibraryScanProgressUpdated extends LibraryEvent {
  LibraryScanProgressUpdated(this.path);
  final String path;
}

class LibrarySortChanged extends LibraryEvent {
  LibrarySortChanged(this.field, {this.ascending = true});
  final LibrarySortField field;
  final bool ascending;
}

class LibraryViewModeToggled extends LibraryEvent {}

class LibraryFormatFilterChanged extends LibraryEvent {
  LibraryFormatFilterChanged(this.format);
  final String? format;
}

class LibraryStatusFilterChanged extends LibraryEvent {
  LibraryStatusFilterChanged(this.status);
  final String? status;
}

class LibraryFavoritesFilterToggled extends LibraryEvent {}

class LibrarySearchChanged extends LibraryEvent {
  LibrarySearchChanged(this.query);
  final String query;
}

class LibraryBookFavoriteToggled extends LibraryEvent {
  LibraryBookFavoriteToggled(this.bookId, {required this.isFavorite});
  final int bookId;
  final bool isFavorite;
}

class LibraryBookReadToggled extends LibraryEvent {
  LibraryBookReadToggled(this.bookId, {required this.isRead});
  final int bookId;
  final bool isRead;
}

class LibraryBookDeleted extends LibraryEvent {
  LibraryBookDeleted(this.bookId);
  final int bookId;
}
