# ReadMe

A local-first ebook library and reader app built with Flutter.

## Features

- 📚 **Library** — scan local directories for EPUB, PDF, TXT, HTML, CBZ, CBR, MOBI/AZW books
- 📂 **Shelves** — filesystem-backed directory tree; create/remove shelves in-app
- 🗂 **Collections** — filtered views: Currently Reading, Read, Favourites, Bookmarked, History
- 📖 **Reader** — per-format readers with auto-resume, bookmarks, per-book settings (font, size, theme)
- 🎨 **Themes** — Light, Dark, Sepia, Amoled, Solarized, Custom (color picker)
- ⚙️ **Settings** — global defaults for reader font, size, scroll mode, theme

### Android extras

- `MANAGE_EXTERNAL_STORAGE` for broad file-system access
- CBR/RAR extraction via native Kotlin + junrar
- MOBI/AZW → HTML conversion via Apache Tika
- Volume-button page turning in the reader

### iOS notes

See [ios_issues.md](ios_issues.md) for platform gaps (CBR, MOBI, volume keys, etc.).

---

## Getting started

### Prerequisites

- Flutter ≥ 3.x (Dart ≥ 3.11)
- Android Studio or Xcode for device/emulator deployment

### 1. Install dependencies

```bash
flutter pub get
```

### 2. Generate Drift database code

The `.g.dart` files checked in are manually-written stubs. Replace them with properly generated code:

```bash
dart run build_runner build --delete-conflicting-outputs
```

Re-run this command whenever you modify any table or DAO file.

### 3. Run

```bash
flutter run
```

---

## Project structure

```
lib/
  main.dart                      # App entry, DI, navigation shell
  core/
    theme/app_theme.dart          # ThemeData + ReaderThemePreset
    constants/app_constants.dart
  data/
    database/                     # Drift schema + generated code
      app_database.dart
      tables/                     # Table definitions
      daos/                       # DAO accessor classes
    repositories/                 # BookRepository, ShelfRepository, etc.
  features/
    library/                      # Library screen + BLoC
    shelves/                      # Shelves screen + cubit
    collections/                  # Collections (tabs) screen
    settings/                     # Settings screen + cubit
    reader/                       # Format-specific readers + cubit
      view/                       # epub_reader, pdf_reader, txt_reader, cbz_reader, cbr_reader, mobi_reader
      services/                   # CbrExtractorService, MobiConverterService, VolumeKeyService
      widgets/                    # BookSettingsPanel
android/
  app/src/main/kotlin/…/MainActivity.kt   # CBR + MOBI platform channels
ios_issues.md                              # iOS platform gap tracker
```

---

## Architecture

- **State management** — BLoC / Cubit (flutter_bloc)
- **Database** — Drift (SQLite) with DAOs and reactive streams
- **Repositories** — thin wrappers over DAOs, injected via `RepositoryProvider`
- **Platform channels** — Kotlin channels for CBR (junrar) and MOBI (Apache Tika)

