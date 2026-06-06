import 'package:flutter/material.dart';

/// Built-in reader theme presets.
enum ReaderThemePreset { light, dark, sepia, amoled, solarized, custom }

extension ReaderThemePresetExt on ReaderThemePreset {
  String get label {
    switch (this) {
      case ReaderThemePreset.light:
        return 'Light';
      case ReaderThemePreset.dark:
        return 'Dark';
      case ReaderThemePreset.sepia:
        return 'Sepia';
      case ReaderThemePreset.amoled:
        return 'Amoled';
      case ReaderThemePreset.solarized:
        return 'Solarized';
      case ReaderThemePreset.custom:
        return 'Custom';
    }
  }

  Color get background {
    switch (this) {
      case ReaderThemePreset.light:
        return const Color(0xFFFFFFFF);
      case ReaderThemePreset.dark:
        return const Color(0xFF1E1E1E);
      case ReaderThemePreset.sepia:
        return const Color(0xFFF5E6C8);
      case ReaderThemePreset.amoled:
        return const Color(0xFF000000);
      case ReaderThemePreset.solarized:
        return const Color(0xFFFDF6E3);
      case ReaderThemePreset.custom:
        return const Color(0xFFFFFFFF);
    }
  }

  Color get foreground {
    switch (this) {
      case ReaderThemePreset.light:
        return const Color(0xFF1A1A1A);
      case ReaderThemePreset.dark:
        return const Color(0xFFE0E0E0);
      case ReaderThemePreset.sepia:
        return const Color(0xFF4A3728);
      case ReaderThemePreset.amoled:
        return const Color(0xFFCCCCCC);
      case ReaderThemePreset.solarized:
        return const Color(0xFF657B83);
      case ReaderThemePreset.custom:
        return const Color(0xFF1A1A1A);
    }
  }

  Color get accent {
    switch (this) {
      case ReaderThemePreset.light:
        return const Color(0xFF1E5A6B);
      case ReaderThemePreset.dark:
        return const Color(0xFF89B4C9);
      case ReaderThemePreset.sepia:
        return const Color(0xFF7B4F2E);
      case ReaderThemePreset.amoled:
        return const Color(0xFF89B4C9);
      case ReaderThemePreset.solarized:
        return const Color(0xFF268BD2);
      case ReaderThemePreset.custom:
        return const Color(0xFF1E5A6B);
    }
  }
}

class AppTheme {
  static ThemeData light() {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFF1E5A6B),
        brightness: Brightness.light,
      ),
      useMaterial3: true,
    );
  }

  static ThemeData dark() {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFF89B4C9),
        brightness: Brightness.dark,
      ),
      useMaterial3: true,
    );
  }
}
