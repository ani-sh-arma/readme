import 'package:equatable/equatable.dart';

import '../../../data/database/tables/book_settings_table.dart';
import '../../../data/database/tables/bookmarks_table.dart';
import '../../../data/database/tables/books_table.dart';

// --- Events ---

abstract class ReaderEvent {}

class ReaderOpened extends ReaderEvent {
  ReaderOpened(this.book);
  final Book book;
}

class ReaderPositionUpdated extends ReaderEvent {
  ReaderPositionUpdated(this.position);
  final String position;
}

class ReaderBookmarkAdded extends ReaderEvent {
  ReaderBookmarkAdded(this.label);
  final String label;
}

class ReaderBookmarkDeleted extends ReaderEvent {
  ReaderBookmarkDeleted(this.bookmarkId);
  final int bookmarkId;
}

class ReaderSettingsUpdated extends ReaderEvent {
  ReaderSettingsUpdated(this.settings);
  final BookSettingsCompanion settings;
}

class ReaderUiToggled extends ReaderEvent {}

class ReaderClosed extends ReaderEvent {}

// --- State ---

class ReaderState extends Equatable {
  const ReaderState({
    this.book,
    this.settings,
    this.bookmarks = const [],
    this.isLoading = true,
    this.showUi = true,
    this.error,
    this.sessionId,
  });

  final Book? book;
  final BookSetting? settings;
  final List<Bookmark> bookmarks;
  final bool isLoading;
  final bool showUi;
  final String? error;
  final int? sessionId;

  ReaderState copyWith({
    Book? book,
    BookSetting? settings,
    List<Bookmark>? bookmarks,
    bool? isLoading,
    bool? showUi,
    String? error,
    int? sessionId,
    bool clearError = false,
  }) {
    return ReaderState(
      book: book ?? this.book,
      settings: settings ?? this.settings,
      bookmarks: bookmarks ?? this.bookmarks,
      isLoading: isLoading ?? this.isLoading,
      showUi: showUi ?? this.showUi,
      error: clearError ? null : (error ?? this.error),
      sessionId: sessionId ?? this.sessionId,
    );
  }

  @override
  List<Object?> get props =>
      [book, settings, bookmarks, isLoading, showUi, error, sessionId];
}
