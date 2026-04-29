import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

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
            children: [
              _SectionHeader('Appearance'),
              ListTile(
                title: const Text('App theme'),
                subtitle: Text(_themeModeLabel(state.themeMode)),
                leading: const Icon(Icons.brightness_6_outlined),
                onTap: () => _showThemePicker(context, cubit, state),
              ),
              const Divider(),
              _SectionHeader('Reader defaults'),
              ListTile(
                title: const Text('Font size'),
                subtitle: Slider(
                  value: state.defaultFontSize,
                  min: AppConstants.minFontSize,
                  max: AppConstants.maxFontSize,
                  divisions: 26,
                  label: state.defaultFontSize.toStringAsFixed(0),
                  onChanged: (v) => cubit.setDefaultFontSize(v),
                ),
                leading: const Icon(Icons.format_size),
              ),
              ListTile(
                title: const Text('Line height'),
                subtitle: Slider(
                  value: state.defaultLineHeight,
                  min: AppConstants.minLineHeight,
                  max: AppConstants.maxLineHeight,
                  divisions: 20,
                  label: state.defaultLineHeight.toStringAsFixed(1),
                  onChanged: (v) => cubit.setDefaultLineHeight(v),
                ),
                leading: const Icon(Icons.format_line_spacing),
              ),
              ListTile(
                title: const Text('Font family'),
                leading: const Icon(Icons.font_download_outlined),
                trailing: DropdownButton<String>(
                  value: state.defaultFontFamily,
                  items: AppConstants.readerFonts
                      .map(
                        (f) => DropdownMenuItem(value: f, child: Text(f)),
                      )
                      .toList(),
                  onChanged: (v) {
                    if (v != null) cubit.setDefaultFontFamily(v);
                  },
                ),
              ),
              ListTile(
                title: const Text('Scroll mode'),
                leading: const Icon(Icons.swap_vert),
                trailing: DropdownButton<String>(
                  value: state.defaultScrollMode,
                  items: const [
                    DropdownMenuItem(value: 'paged', child: Text('Paged')),
                    DropdownMenuItem(
                      value: 'continuous',
                      child: Text('Continuous'),
                    ),
                  ],
                  onChanged: (v) {
                    if (v != null) cubit.setScrollMode(v);
                  },
                ),
              ),
              ListTile(
                title: const Text('Reader theme'),
                leading: const Icon(Icons.color_lens_outlined),
                trailing: DropdownButton<String>(
                  value: state.defaultReaderTheme,
                  items: ReaderThemePreset.values
                      .map(
                        (p) => DropdownMenuItem(
                          value: p.label,
                          child: Text(p.label),
                        ),
                      )
                      .toList(),
                  onChanged: (v) {
                    if (v != null) cubit.setReaderTheme(v);
                  },
                ),
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
                onChanged: (v) {
                  if (v != null) {
                    cubit.setThemeMode(v);
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

class _SectionHeader extends StatelessWidget {
  const _SectionHeader(this.title);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
      child: Text(
        title,
        style: Theme.of(context).textTheme.labelMedium?.copyWith(
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
    );
  }
}
