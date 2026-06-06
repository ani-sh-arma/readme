import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_theme.dart';
import '../bloc/settings_cubit.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: BlocBuilder<SettingsCubit, SettingsState>(
        builder: (context, state) {
          final cubit = context.read<SettingsCubit>();
          return ListView(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
            children: [
              _SectionCard(
                title: 'Appearance',
                children: [
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: const Text('App theme'),
                    subtitle: Text(_themeModeLabel(state.themeMode)),
                    leading: const Icon(Icons.brightness_6_outlined),
                    onTap: () => _showThemePicker(context, cubit, state),
                  ),
                ],
              ),
              _SectionCard(
                title: 'EPUB Defaults',
                subtitle:
                    'Typography and reading defaults for reflowable EPUB books.',
                children: [
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: const Text('Font size'),
                    subtitle: Slider(
                      value: state.epubDefaults.fontSize,
                      min: AppConstants.minFontSize,
                      max: AppConstants.maxFontSize,
                      divisions: 26,
                      label: state.epubDefaults.fontSize.toStringAsFixed(0),
                      onChanged: cubit.setEpubFontSize,
                    ),
                    leading: const Icon(Icons.format_size),
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: const Text('Line height'),
                    subtitle: Slider(
                      value: state.epubDefaults.lineHeight,
                      min: AppConstants.minLineHeight,
                      max: AppConstants.maxLineHeight,
                      divisions: 20,
                      label: state.epubDefaults.lineHeight.toStringAsFixed(1),
                      onChanged: cubit.setEpubLineHeight,
                    ),
                    leading: const Icon(Icons.format_line_spacing),
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: const Text('Font family'),
                    leading: const Icon(Icons.font_download_outlined),
                    trailing: DropdownButton<String>(
                      value: state.epubDefaults.fontFamily,
                      items: AppConstants.readerFonts
                          .map(
                            (font) => DropdownMenuItem(
                              value: font,
                              child: Text(font),
                            ),
                          )
                          .toList(),
                      onChanged: (value) {
                        if (value != null) {
                          cubit.setEpubFontFamily(value);
                        }
                      },
                    ),
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: const Text('Scroll mode'),
                    leading: const Icon(Icons.swap_vert),
                    trailing: DropdownButton<String>(
                      value: state.epubDefaults.scrollMode,
                      items: const [
                        DropdownMenuItem(value: 'paged', child: Text('Paged')),
                        DropdownMenuItem(
                          value: 'continuous',
                          child: Text('Continuous'),
                        ),
                      ],
                      onChanged: (value) {
                        if (value != null) {
                          cubit.setEpubScrollMode(value);
                        }
                      },
                    ),
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: const Text('Theme'),
                    leading: const Icon(Icons.color_lens_outlined),
                    trailing: DropdownButton<String>(
                      value: state.epubDefaults.theme,
                      items: ReaderThemePreset.values
                          .map(
                            (preset) => DropdownMenuItem(
                              value: preset.label,
                              child: Text(preset.label),
                            ),
                          )
                          .toList(),
                      onChanged: (value) {
                        if (value != null) {
                          cubit.setEpubReaderTheme(value);
                        }
                      },
                    ),
                  ),
                ],
              ),
              _SectionCard(
                title: 'PDF Defaults',
                subtitle:
                    'Safe viewing defaults for fixed-layout PDF documents.',
                children: [
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: const Text('Scroll mode'),
                    subtitle: const Text(
                      'Paged uses horizontal page turns. Continuous uses a vertical flow.',
                    ),
                    leading: const Icon(Icons.swap_vert),
                    trailing: DropdownButton<String>(
                      value: state.pdfDefaults.scrollMode,
                      items: const [
                        DropdownMenuItem(value: 'paged', child: Text('Paged')),
                        DropdownMenuItem(
                          value: 'continuous',
                          child: Text('Continuous'),
                        ),
                      ],
                      onChanged: (value) {
                        if (value != null) {
                          cubit.setPdfScrollMode(value);
                        }
                      },
                    ),
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: const Text('Theme'),
                    subtitle: const Text(
                      'Dark themes invert page colors for more comfortable night reading.',
                    ),
                    leading: const Icon(Icons.picture_as_pdf_outlined),
                    trailing: DropdownButton<String>(
                      value: state.pdfDefaults.theme,
                      items: ReaderThemePreset.values
                          .where((preset) => preset != ReaderThemePreset.custom)
                          .map(
                            (preset) => DropdownMenuItem(
                              value: preset.label,
                              child: Text(preset.label),
                            ),
                          )
                          .toList(),
                      onChanged: (value) {
                        if (value != null) {
                          cubit.setPdfReaderTheme(value);
                        }
                      },
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }

  String _themeModeLabel(ThemeMode mode) {
    switch (mode) {
      case ThemeMode.system:
        return 'Follow system';
      case ThemeMode.light:
        return 'Light';
      case ThemeMode.dark:
        return 'Dark';
    }
  }

  void _showThemePicker(
    BuildContext context,
    SettingsCubit cubit,
    SettingsState state,
  ) {
    showDialog<void>(
      context: context,
      builder: (ctx) => SimpleDialog(
        title: const Text('App theme'),
        children: ThemeMode.values
            .map(
              (mode) => RadioListTile<ThemeMode>(
                title: Text(_themeModeLabel(mode)),
                value: mode,
                groupValue: state.themeMode,
                onChanged: (value) {
                  if (value != null) {
                    cubit.setThemeMode(value);
                    Navigator.pop(ctx);
                  }
                },
              ),
            )
            .toList(),
      ),
    );
  }
}

class _SectionCard extends StatelessWidget {
  const _SectionCard({
    required this.title,
    required this.children,
    this.subtitle,
  });

  final String title;
  final String? subtitle;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: theme.textTheme.titleMedium),
            if (subtitle != null) ...[
              const SizedBox(height: 4),
              Text(
                subtitle!,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ],
            const SizedBox(height: 8),
            ...children,
          ],
        ),
      ),
    );
  }
}
