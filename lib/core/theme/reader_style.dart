import 'package:flutter/material.dart';

import '../../data/database/app_database.dart';
import 'app_theme.dart';

class ReaderStyle {
  const ReaderStyle({
    required this.background,
    required this.foreground,
    required this.accent,
    required this.fontFamily,
    required this.fontSize,
    required this.lineHeight,
  });

  final Color background;
  final Color foreground;
  final Color accent;
  final String? fontFamily;
  final double fontSize;
  final double lineHeight;
}

ReaderStyle resolveReaderStyle(BookSetting? settings) {
  final preset = ReaderThemePreset.values.firstWhere(
    (item) => item.label == (settings?.theme ?? 'Light'),
    orElse: () => ReaderThemePreset.light,
  );

  Color background = preset.background;
  Color foreground = preset.foreground;
  Color accent = preset.accent;

  if (preset == ReaderThemePreset.custom &&
      settings?.customBg != null &&
      settings?.customFg != null) {
    background = _colorFromHex(settings!.customBg!);
    foreground = _colorFromHex(settings.customFg!);
    if (settings.customAccent != null) {
      accent = _colorFromHex(settings.customAccent!);
    }
  }

  return ReaderStyle(
    background: background,
    foreground: foreground,
    accent: accent,
    fontFamily: resolveReaderFontFamily(settings?.fontFamily),
    fontSize: settings?.fontSize ?? 16,
    lineHeight: settings?.lineHeight ?? 1.5,
  );
}

String? resolveReaderFontFamily(String? label) {
  switch (label) {
    case null:
    case 'Default':
      return null;
    case 'Serif':
      return 'serif';
    case 'Sans-Serif':
      return 'sans-serif';
    case 'Monospace':
      return 'monospace';
    default:
      return label;
  }
}

Color _colorFromHex(String hex) {
  final normalized = hex.replaceFirst('#', '');
  final value = normalized.length == 8 ? normalized : 'FF$normalized';
  return Color(int.parse('0x$value'));
}
