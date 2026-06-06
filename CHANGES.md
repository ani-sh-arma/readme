# Changes

This document records the fixes applied in this change set.

## 1. Library — toggleable search bar

**File:** `lib/features/library/view/library_screen.dart`

The persistent search field has been replaced with a search icon in the app bar. Tapping the icon expands an auto-focused `SearchBar` underneath the bar; tapping it again (or the close icon that replaces it) hides the search bar and clears the active query.

- Added `_searchVisible` state and `_toggleSearch()` on `_LibraryScreenState`.
- The app bar now exposes a leading search/close `IconButton` next to the existing view-mode toggle.
- The `PreferredSize` height collapses from 108 px to 48 px when the search bar is hidden, recovering vertical space for the book list.
- The search field's clear button and `onChanged` handler call `setState(() {})` so the trailing clear icon stays in sync with the controller's text.

## 2. Library — fixed 2-column grid

**File:** `lib/features/library/view/library_screen.dart`

The grid delegate was switched from `SliverGridDelegateWithMaxCrossAxisExtent(maxCrossAxisExtent: 180)` to `SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2)` so phones consistently render two columns regardless of screen width. `childAspectRatio` was tuned from `0.6` to `0.62` to better fit the new cell layout.

## 3. Library — `BookGridItem` overflow

**File:** `lib/features/library/widgets/book_items.dart`

The bottom text block previously used `Expanded(flex: 2)` with a 2-line title and 1-line author, which overflowed at small cell heights. The fix:

- Cover image keeps `Expanded`.
- The text block now uses `Padding` + inner `Column(mainAxisSize: MainAxisSize.min)`, no `Expanded`, no `flex`.
- Title is capped at `maxLines: 1` (was 2) with explicit `SizedBox(height: 2)` between title and author.
- `Card.margin` is set to `EdgeInsets.zero` so cell spacing is fully controlled by the grid delegate.

## 4. EPUB reader — error handling and theme integration

**File:** `lib/features/reader/view/epub_reader.dart`

Previously, EPUB load failures only printed to the debug console and the screen stayed blank. The reader also did not honor the per-book theme.

- Controller initialization is now wrapped in a `try`/`catch`, and the file's existence is checked first. Failures populate `_initError` and surface a themed `_ErrorView`.
- `onDocumentError` from `EpubView` now also flips into `_ErrorView` rather than silently logging.
- `_ErrorView` shows the error message and a **Retry from start** button that disposes the failed controller and rebuilds it without the saved CFI — the typical recovery path when a stored `epubCfi` no longer matches the document.
- The `EpubView` is wrapped in a `Container` painted with the reader theme background; `DefaultBuilderOptions.textStyle.color` is set to the theme foreground. Custom themes use the saved `customBg` / `customFg` hex strings.

## 5. PDF reader — dark theme support

**File:** `lib/features/reader/view/pdf_reader.dart`

`pdfx` rasterizes pages as images, so simply switching backgrounds was not enough to make PDFs readable in dark mode.

- The reader resolves the active `ReaderThemePreset` from the per-book settings.
- For `dark` and `amoled` presets, the entire `PdfView` is wrapped in a `ColorFiltered` widget using a `ColorFilter.matrix` that inverts RGB channels while preserving alpha. The result is white-on-black PDFs without re-rendering.
- `PdfView.backgroundDecoration` is also colored to match the preset so margins between pages no longer flash white.
- Light/sepia/solarized presets are unchanged.

## 6. Settings now apply to newly opened books

**Files:**

- `lib/features/reader/bloc/reader_cubit.dart`
- `lib/features/reader/view/reader_screen.dart`

The Settings screen wrote default font size, font family, line height, scroll mode, and reader theme to `SharedPreferences`, but `ReaderCubit.open()` always created the per-book `BookSettings` row using the database column defaults. The user's defaults were therefore ignored.

- Added a `ReaderDefaults` value object in `reader_cubit.dart` carrying the five settable fields.
- `ReaderCubit.open()` now takes an optional `ReaderDefaults defaults` named parameter. When the per-book row does not yet exist, it is inserted with those defaults; otherwise the existing row is preserved (per-book overrides win, as before).
- `ReaderScreen.build()` reads the live `SettingsCubit` state and constructs a `ReaderDefaults` that is forwarded into `open()`.
- Added `@override` on `ReaderCubit.close()` (pre-existing analyzer info, fixed while editing the file).

**Behavior note:** This applies only to books opened for the first time after a settings change. Books that already have a per-book settings row keep their existing values — change them from the in-reader settings panel.

## Files changed

- `lib/features/library/view/library_screen.dart`
- `lib/features/library/widgets/book_items.dart`
- `lib/features/reader/view/epub_reader.dart`
- `lib/features/reader/view/pdf_reader.dart`
- `lib/features/reader/bloc/reader_cubit.dart`
- `lib/features/reader/view/reader_screen.dart`

## Verification

- `flutter analyze` reports no new issues attributable to these changes; remaining infos are pre-existing (`unnecessary_underscores`, deprecated `activeColor` / `Color.value` / `Radio.groupValue`).
- IDE diagnostics on each modified file: no errors or warnings.

## Follow-up fixes

### 7. EPUB crash on open with saved position

**File:** `lib/features/reader/view/epub_reader.dart`

Some EPUBs crashed with `Null check operator used on a null value` inside `EpubView` when a previously saved `epubCfi` was passed into `EpubController` during construction. The `epub_view` package parses that CFI very early in its load path, and invalid / stale CFIs can trip internal null assertions before our `onDocumentError` callback gets a chance to handle the failure.

- `EpubController` is now always created **without** an initial `epubCfi`.
- Saved position restore happens later via `onDocumentLoaded`, after the document and paragraph list are available.
- The restore attempt runs once per open, is skipped when retrying from start, and is wrapped in `try`/`catch`.

This preserves resume support for valid CFIs while preventing bad saved positions from crashing the reader.

### 8. PDF inversion now affects pages only

**File:** `lib/features/reader/view/pdf_reader.dart`

The first dark-mode PDF implementation wrapped the entire `PdfView` in `ColorFiltered`, which also inverted the gallery background. That caused the empty space above/below pages to flip white while page images themselves turned dark.

- Replaced whole-widget inversion with a custom `pageBuilder`.
- For dark / amoled themes, each rendered page image is wrapped in `ColorFiltered` individually.
- `PdfView.backgroundDecoration` remains the preset background color, so the unused gallery space stays dark.

Result: the PDF pages invert for readability, but the surrounding margins / letterboxing keep the intended dark theme color.

## Suggested follow-ups

- Add widget tests covering: search-bar toggle, grid item layout at small heights, EPUB error/retry path, PDF dark inversion, and `ReaderCubit.open` honoring `ReaderDefaults`.
- Consider replacing the deprecated `Color.value` calls in `book_settings_panel.dart` with `toARGB32()`.
- Consider replacing the deprecated `Radio.groupValue` / `onChanged` usage in `settings_screen.dart` with `RadioGroup`.
