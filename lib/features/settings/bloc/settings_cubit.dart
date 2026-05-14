import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/constants/app_constants.dart';

class EpubSettingsDefaults extends Equatable {
  const EpubSettingsDefaults({
    this.fontSize = AppConstants.defaultFontSize,
    this.fontFamily = 'Default',
    this.lineHeight = AppConstants.defaultLineHeight,
    this.scrollMode = AppConstants.defaultScrollMode,
    this.theme = AppConstants.defaultReaderTheme,
  });

  final double fontSize;
  final String fontFamily;
  final double lineHeight;
  final String scrollMode;
  final String theme;

  EpubSettingsDefaults copyWith({
    double? fontSize,
    String? fontFamily,
    double? lineHeight,
    String? scrollMode,
    String? theme,
  }) {
    return EpubSettingsDefaults(
      fontSize: fontSize ?? this.fontSize,
      fontFamily: fontFamily ?? this.fontFamily,
      lineHeight: lineHeight ?? this.lineHeight,
      scrollMode: scrollMode ?? this.scrollMode,
      theme: theme ?? this.theme,
    );
  }

  @override
  List<Object?> get props => [
    fontSize,
    fontFamily,
    lineHeight,
    scrollMode,
    theme,
  ];
}

class PdfSettingsDefaults extends Equatable {
  const PdfSettingsDefaults({
    this.scrollMode = AppConstants.defaultScrollMode,
    this.theme = AppConstants.defaultReaderTheme,
  });

  final String scrollMode;
  final String theme;

  PdfSettingsDefaults copyWith({String? scrollMode, String? theme}) {
    return PdfSettingsDefaults(
      scrollMode: scrollMode ?? this.scrollMode,
      theme: theme ?? this.theme,
    );
  }

  @override
  List<Object?> get props => [scrollMode, theme];
}

// --- State ---
class SettingsState extends Equatable {
  const SettingsState({
    this.themeMode = ThemeMode.system,
    this.epubDefaults = const EpubSettingsDefaults(),
    this.pdfDefaults = const PdfSettingsDefaults(),
  });

  final ThemeMode themeMode;
  final EpubSettingsDefaults epubDefaults;
  final PdfSettingsDefaults pdfDefaults;

  SettingsState copyWith({
    ThemeMode? themeMode,
    EpubSettingsDefaults? epubDefaults,
    PdfSettingsDefaults? pdfDefaults,
  }) {
    return SettingsState(
      themeMode: themeMode ?? this.themeMode,
      epubDefaults: epubDefaults ?? this.epubDefaults,
      pdfDefaults: pdfDefaults ?? this.pdfDefaults,
    );
  }

  @override
  List<Object?> get props => [themeMode, epubDefaults, pdfDefaults];
}

// --- Cubit ---
class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit() : super(const SettingsState()) {
    _load();
  }

  static const _kThemeMode = 'settings_themeMode';
  static const _kEpubFontSize = 'settings_epub_fontSize';
  static const _kEpubFontFamily = 'settings_epub_fontFamily';
  static const _kEpubLineHeight = 'settings_epub_lineHeight';
  static const _kEpubScrollMode = 'settings_epub_scrollMode';
  static const _kEpubReaderTheme = 'settings_epub_readerTheme';
  static const _kPdfScrollMode = 'settings_pdf_scrollMode';
  static const _kPdfReaderTheme = 'settings_pdf_readerTheme';

  Future<void> _load() async {
    final prefs = await SharedPreferences.getInstance();
    final themeModeIndex = prefs.getInt(_kThemeMode) ?? ThemeMode.system.index;
    emit(
      state.copyWith(
        themeMode: ThemeMode.values[themeModeIndex],
        epubDefaults: EpubSettingsDefaults(
          fontSize:
              prefs.getDouble(_kEpubFontSize) ?? AppConstants.defaultFontSize,
          fontFamily: prefs.getString(_kEpubFontFamily) ?? 'Default',
          lineHeight:
              prefs.getDouble(_kEpubLineHeight) ??
              AppConstants.defaultLineHeight,
          scrollMode:
              prefs.getString(_kEpubScrollMode) ??
              AppConstants.defaultScrollMode,
          theme:
              prefs.getString(_kEpubReaderTheme) ??
              AppConstants.defaultReaderTheme,
        ),
        pdfDefaults: PdfSettingsDefaults(
          scrollMode:
              prefs.getString(_kPdfScrollMode) ??
              AppConstants.defaultScrollMode,
          theme:
              prefs.getString(_kPdfReaderTheme) ??
              AppConstants.defaultReaderTheme,
        ),
      ),
    );
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_kThemeMode, mode.index);
    emit(state.copyWith(themeMode: mode));
  }

  Future<void> setEpubFontSize(double size) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(_kEpubFontSize, size);
    emit(
      state.copyWith(epubDefaults: state.epubDefaults.copyWith(fontSize: size)),
    );
  }

  Future<void> setEpubFontFamily(String family) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_kEpubFontFamily, family);
    emit(
      state.copyWith(
        epubDefaults: state.epubDefaults.copyWith(fontFamily: family),
      ),
    );
  }

  Future<void> setEpubLineHeight(double height) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(_kEpubLineHeight, height);
    emit(
      state.copyWith(
        epubDefaults: state.epubDefaults.copyWith(lineHeight: height),
      ),
    );
  }

  Future<void> setEpubScrollMode(String mode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_kEpubScrollMode, mode);
    emit(
      state.copyWith(
        epubDefaults: state.epubDefaults.copyWith(scrollMode: mode),
      ),
    );
  }

  Future<void> setEpubReaderTheme(String theme) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_kEpubReaderTheme, theme);
    emit(
      state.copyWith(epubDefaults: state.epubDefaults.copyWith(theme: theme)),
    );
  }

  Future<void> setPdfScrollMode(String mode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_kPdfScrollMode, mode);
    emit(
      state.copyWith(pdfDefaults: state.pdfDefaults.copyWith(scrollMode: mode)),
    );
  }

  Future<void> setPdfReaderTheme(String theme) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_kPdfReaderTheme, theme);
    emit(state.copyWith(pdfDefaults: state.pdfDefaults.copyWith(theme: theme)));
  }
}
