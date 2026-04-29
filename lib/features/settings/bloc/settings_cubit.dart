import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

// --- State ---
class SettingsState extends Equatable {
  const SettingsState({
    this.themeMode = ThemeMode.system,
    this.defaultFontSize = 16.0,
    this.defaultFontFamily = 'Default',
    this.defaultLineHeight = 1.5,
    this.defaultScrollMode = 'paged',
    this.defaultReaderTheme = 'Light',
  });

  final ThemeMode themeMode;
  final double defaultFontSize;
  final String defaultFontFamily;
  final double defaultLineHeight;
  final String defaultScrollMode;
  final String defaultReaderTheme;

  SettingsState copyWith({
    ThemeMode? themeMode,
    double? defaultFontSize,
    String? defaultFontFamily,
    double? defaultLineHeight,
    String? defaultScrollMode,
    String? defaultReaderTheme,
  }) {
    return SettingsState(
      themeMode: themeMode ?? this.themeMode,
      defaultFontSize: defaultFontSize ?? this.defaultFontSize,
      defaultFontFamily: defaultFontFamily ?? this.defaultFontFamily,
      defaultLineHeight: defaultLineHeight ?? this.defaultLineHeight,
      defaultScrollMode: defaultScrollMode ?? this.defaultScrollMode,
      defaultReaderTheme: defaultReaderTheme ?? this.defaultReaderTheme,
    );
  }

  @override
  List<Object?> get props => [
    themeMode,
    defaultFontSize,
    defaultFontFamily,
    defaultLineHeight,
    defaultScrollMode,
    defaultReaderTheme,
  ];
}

// --- Cubit ---
class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit() : super(const SettingsState()) {
    _load();
  }

  static const _kThemeMode = 'settings_themeMode';
  static const _kFontSize = 'settings_fontSize';
  static const _kFontFamily = 'settings_fontFamily';
  static const _kLineHeight = 'settings_lineHeight';
  static const _kScrollMode = 'settings_scrollMode';
  static const _kReaderTheme = 'settings_readerTheme';

  Future<void> _load() async {
    final prefs = await SharedPreferences.getInstance();
    final themeModeIndex = prefs.getInt(_kThemeMode) ?? ThemeMode.system.index;
    emit(
      state.copyWith(
        themeMode: ThemeMode.values[themeModeIndex],
        defaultFontSize: prefs.getDouble(_kFontSize) ?? 16.0,
        defaultFontFamily: prefs.getString(_kFontFamily) ?? 'Default',
        defaultLineHeight: prefs.getDouble(_kLineHeight) ?? 1.5,
        defaultScrollMode: prefs.getString(_kScrollMode) ?? 'paged',
        defaultReaderTheme: prefs.getString(_kReaderTheme) ?? 'Light',
      ),
    );
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_kThemeMode, mode.index);
    emit(state.copyWith(themeMode: mode));
  }

  Future<void> setDefaultFontSize(double size) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(_kFontSize, size);
    emit(state.copyWith(defaultFontSize: size));
  }

  Future<void> setDefaultFontFamily(String family) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_kFontFamily, family);
    emit(state.copyWith(defaultFontFamily: family));
  }

  Future<void> setDefaultLineHeight(double height) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(_kLineHeight, height);
    emit(state.copyWith(defaultLineHeight: height));
  }

  Future<void> setScrollMode(String mode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_kScrollMode, mode);
    emit(state.copyWith(defaultScrollMode: mode));
  }

  Future<void> setReaderTheme(String theme) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_kReaderTheme, theme);
    emit(state.copyWith(defaultReaderTheme: theme));
  }
}
