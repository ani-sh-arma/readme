/// Supported book formats mirroring [BookFormat] enum in books_table.dart.
class AppConstants {
  AppConstants._();

  static const List<String> supportedExtensions = ['epub', 'pdf'];

  static const List<String> readerFonts = [
    'Default',
    'Serif',
    'Sans-Serif',
    'Monospace',
  ];

  static const double minFontSize = 10.0;
  static const double maxFontSize = 36.0;
  static const double defaultFontSize = 16.0;

  static const double minLineHeight = 1.0;
  static const double maxLineHeight = 3.0;
  static const double defaultLineHeight = 1.5;
  static const String defaultScrollMode = 'paged';
  static const String defaultReaderTheme = 'Light';

  // Drift DB page write-back debounce
  static const Duration positionSaveDebounce = Duration(seconds: 2);
}
