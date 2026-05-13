import 'package:equatable/equatable.dart';

import '../../../data/database/app_database.dart';

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
    this.highlights = const [],
    this.isLoading = true,
    this.showUi = true,
    this.closeRequested = false,
    this.error,
    this.sessionId,
  });

  final Book? book;
  final BookSetting? settings;
  final List<Bookmark> bookmarks;
  final List<Highlight> highlights;
  final bool isLoading;
  final bool showUi;
  final bool closeRequested;
  final String? error;
  final int? sessionId;

  ReaderState copyWith({
    Book? book,
    BookSetting? settings,
    List<Bookmark>? bookmarks,
    List<Highlight>? highlights,
    bool? isLoading,
    bool? showUi,
    bool? closeRequested,
    String? error,
    int? sessionId,
    bool clearError = false,
  }) {
    return ReaderState(
      book: book ?? this.book,
      settings: settings ?? this.settings,
      bookmarks: bookmarks ?? this.bookmarks,
      highlights: highlights ?? this.highlights,
      isLoading: isLoading ?? this.isLoading,
      showUi: showUi ?? this.showUi,
      closeRequested: closeRequested ?? this.closeRequested,
      error: clearError ? null : (error ?? this.error),
      sessionId: sessionId ?? this.sessionId,
    );
  }

  @override
  List<Object?> get props => [
    book,
    settings,
    bookmarks,
    highlights,
    isLoading,
    showUi,
    closeRequested,
    error,
    sessionId,
  ];
}
