import 'dart:async';

import 'package:drift/drift.dart' show Value;
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/database/app_database.dart';
import '../../../data/repositories/book_repository.dart';
import '../../../data/repositories/bookmark_repository.dart';
import 'reader_bloc.dart';

/// Default reader preferences sourced from the global Settings screen and
/// applied to a book the first time its per-book settings row is created.
class ReaderDefaults {
  const ReaderDefaults({
    required this.fontSize,
    required this.fontFamily,
    required this.lineHeight,
    required this.scrollMode,
    required this.theme,
  });

  final double fontSize;
  final String fontFamily;
  final double lineHeight;
  final String scrollMode;
  final String theme;
}

class ReaderCubit extends Cubit<ReaderState> {
  ReaderCubit(
    this._bookRepo,
    this._bookmarkRepo,
    this._bookSettingsRepo,
    this._readingSessionRepo,
  ) : super(const ReaderState());

  final BookRepository _bookRepo;
  final BookmarkRepository _bookmarkRepo;
  final BookSettingsRepository _bookSettingsRepo;
  final ReadingSessionRepository _readingSessionRepo;

  StreamSubscription<dynamic>? _bookmarksSub;
  StreamSubscription<dynamic>? _settingsSub;
  Timer? _positionDebounce;
  String _pendingPosition = '';

  Future<void> open(Book book, {ReaderDefaults? defaults}) async {
    emit(state.copyWith(book: book, isLoading: true));

    // Load existing settings, or create a new row seeded with the user's
    // global reader defaults so changes in the Settings screen take effect for
    // newly opened books.
    var settings = await _bookSettingsRepo.getSettings(book.id);
    if (settings == null) {
      await _bookSettingsRepo.upsertSettings(
        BookSettingsCompanion(
          bookId: Value(book.id),
          fontSize: defaults != null
              ? Value(defaults.fontSize)
              : const Value.absent(),
          fontFamily: defaults != null
              ? Value(defaults.fontFamily)
              : const Value.absent(),
          lineHeight: defaults != null
              ? Value(defaults.lineHeight)
              : const Value.absent(),
          scrollMode: defaults != null
              ? Value(defaults.scrollMode)
              : const Value.absent(),
          theme: defaults != null
              ? Value(defaults.theme)
              : const Value.absent(),
        ),
      );
      settings = await _bookSettingsRepo.getSettings(book.id);
    }

    // Start reading session
    final sessionId = await _readingSessionRepo.startSession(book.id);

    emit(
      state.copyWith(
        book: book,
        settings: settings,
        isLoading: false,
        sessionId: sessionId,
      ),
    );

    // Subscribe to bookmarks and settings changes
    await _bookmarksSub?.cancel();
    _bookmarksSub = _bookmarkRepo
        .watchBookmarksForBook(book.id)
        .listen((bms) => emit(state.copyWith(bookmarks: bms)));

    await _settingsSub?.cancel();
    _settingsSub = _bookSettingsRepo.watchSettings(book.id).listen((s) {
      if (s != null) emit(state.copyWith(settings: s));
    });
  }

  void updatePosition(String position) {
    _pendingPosition = position;
    final book = state.book;
    if (book != null && book.currentPosition != position) {
      emit(
        state.copyWith(
          book: book.copyWith(
            currentPosition: position,
            lastOpenedAt: Value(DateTime.now()),
          ),
        ),
      );
    }
    _positionDebounce?.cancel();
    _positionDebounce = Timer(const Duration(seconds: 2), () {
      final activeBook = state.book;
      if (activeBook != null) {
        _bookRepo.updatePosition(activeBook.id, _pendingPosition);
      }
    });
  }

  Future<void> addBookmark({String label = ''}) async {
    final book = state.book;
    if (book == null) return;
    var effectivePosition = _pendingPosition;
    if (effectivePosition.isEmpty) {
      effectivePosition = book.currentPosition;
    }
    if (effectivePosition.isEmpty) return;
    await _bookmarkRepo.addBookmark(book.id, effectivePosition, label: label);
  }

  Future<void> deleteBookmark(int id) async {
    await _bookmarkRepo.deleteBookmark(id);
  }

  Future<void> updateSettings(BookSettingsCompanion settings) async {
    await _bookSettingsRepo.upsertSettings(settings);
  }

  void toggleUi() {
    emit(state.copyWith(showUi: !state.showUi));
  }

  @override
  Future<void> close() async {
    _positionDebounce?.cancel();

    // Flush pending position
    final book = state.book;
    if (book != null && _pendingPosition.isNotEmpty) {
      await _bookRepo.updatePosition(book.id, _pendingPosition);
    }

    // End reading session
    if (state.sessionId != null) {
      await _readingSessionRepo.endSession(state.sessionId!, 0);
    }

    await _bookmarksSub?.cancel();
    await _settingsSub?.cancel();

    emit(const ReaderState());
    return super.close();
  }
}
