import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_theme.dart';
import '../../../data/database/tables/book_settings_table.dart';
import '../bloc/reader_bloc.dart';
import '../bloc/reader_cubit.dart';

class BookSettingsPanel extends StatefulWidget {
  const BookSettingsPanel({super.key});

  @override
  State<BookSettingsPanel> createState() => _BookSettingsPanelState();
}

class _BookSettingsPanelState extends State<BookSettingsPanel> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReaderCubit, ReaderState>(
      builder: (context, state) {
        final settings = state.settings;
        if (settings == null) return const SizedBox.shrink();
        final cubit = context.read<ReaderCubit>();

        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.2),
                blurRadius: 8,
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Theme presets
              Text(
                'Theme',
                style: Theme.of(context).textTheme.titleSmall,
              ),
              const SizedBox(height: 8),
              _ThemeRow(currentTheme: settings.theme, cubit: cubit, settings: settings),
              const Divider(),
              // Font size
              Row(
                children: [
                  const Icon(Icons.format_size),
                  const SizedBox(width: 8),
                  const Text('Size'),
                  Expanded(
                    child: Slider(
                      value: settings.fontSize,
                      min: AppConstants.minFontSize,
                      max: AppConstants.maxFontSize,
                      divisions: 26,
                      label: settings.fontSize.toStringAsFixed(0),
                      onChanged: (v) => cubit.updateSettings(
                        BookSettingsCompanion(
                          bookId: Value(settings.bookId),
                          fontSize: Value(v),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              // Line height
              Row(
                children: [
                  const Icon(Icons.format_line_spacing),
                  const SizedBox(width: 8),
                  const Text('Spacing'),
                  Expanded(
                    child: Slider(
                      value: settings.lineHeight,
                      min: AppConstants.minLineHeight,
                      max: AppConstants.maxLineHeight,
                      divisions: 20,
                      label: settings.lineHeight.toStringAsFixed(1),
                      onChanged: (v) => cubit.updateSettings(
                        BookSettingsCompanion(
                          bookId: Value(settings.bookId),
                          lineHeight: Value(v),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              // Font family
              Row(
                children: [
                  const Icon(Icons.font_download_outlined),
                  const SizedBox(width: 8),
                  const Text('Font'),
                  const SizedBox(width: 8),
                  Expanded(
                    child: DropdownButton<String>(
                      value: settings.fontFamily,
                      isExpanded: true,
                      items: AppConstants.readerFonts
                          .map(
                            (f) => DropdownMenuItem(value: f, child: Text(f)),
                          )
                          .toList(),
                      onChanged: (v) {
                        if (v != null) {
                          cubit.updateSettings(
                            BookSettingsCompanion(
                              bookId: Value(settings.bookId),
                              fontFamily: Value(v),
                            ),
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
              // Scroll mode
              Row(
                children: [
                  const Icon(Icons.swap_vert),
                  const SizedBox(width: 8),
                  const Text('Scroll'),
                  const SizedBox(width: 8),
                  SegmentedButton<String>(
                    segments: const [
                      ButtonSegment(value: 'paged', label: Text('Paged')),
                      ButtonSegment(
                        value: 'continuous',
                        label: Text('Continuous'),
                      ),
                    ],
                    selected: {settings.scrollMode},
                    onSelectionChanged: (sel) => cubit.updateSettings(
                      BookSettingsCompanion(
                        bookId: Value(settings.bookId),
                        scrollMode: Value(sel.first),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

class _ThemeRow extends StatelessWidget {
  const _ThemeRow({
    required this.currentTheme,
    required this.cubit,
    required this.settings,
  });

  final String currentTheme;
  final ReaderCubit cubit;
  final BookSetting settings;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          for (final preset in ReaderThemePreset.values)
            if (preset != ReaderThemePreset.custom)
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: ChoiceChip(
                  label: Text(preset.label),
                  selected: currentTheme == preset.label,
                  onSelected: (_) => cubit.updateSettings(
                    BookSettingsCompanion(
                      bookId: Value(settings.bookId),
                      theme: Value(preset.label),
                    ),
                  ),
                ),
              ),
          // Custom color picker button
          InkWell(
            onTap: () => _showCustomPicker(context),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                border: Border.all(
                  color: currentTheme == 'Custom'
                      ? Theme.of(context).colorScheme.primary
                      : Colors.grey,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Row(
                children: [
                  Icon(Icons.color_lens_outlined, size: 16),
                  SizedBox(width: 4),
                  Text('Custom'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showCustomPicker(BuildContext context) {
    Color bg = settings.customBg != null
        ? Color(int.parse(settings.customBg!.replaceFirst('#', '0xFF')))
        : Colors.white;
    Color fg = settings.customFg != null
        ? Color(int.parse(settings.customFg!.replaceFirst('#', '0xFF')))
        : Colors.black;
    Color accent = settings.customAccent != null
        ? Color(
            int.parse(settings.customAccent!.replaceFirst('#', '0xFF')),
          )
        : const Color(0xFF1E5A6B);

    showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Custom theme'),
        content: _CustomThemePicker(
          initialBg: bg,
          initialFg: fg,
          initialAccent: accent,
          onChanged: (newBg, newFg, newAccent) {
            bg = newBg;
            fg = newFg;
            accent = newAccent;
          },
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              cubit.updateSettings(
                BookSettingsCompanion(
                  bookId: Value(settings.bookId),
                  theme: const Value('Custom'),
                  customBg: Value('#${bg.value.toRadixString(16).padLeft(8, '0')}'),
                  customFg: Value('#${fg.value.toRadixString(16).padLeft(8, '0')}'),
                  customAccent:
                      Value('#${accent.value.toRadixString(16).padLeft(8, '0')}'),
                ),
              );
              Navigator.pop(ctx);
            },
            child: const Text('Apply'),
          ),
        ],
      ),
    );
  }
}

class _CustomThemePicker extends StatefulWidget {
  const _CustomThemePicker({
    required this.initialBg,
    required this.initialFg,
    required this.initialAccent,
    required this.onChanged,
  });

  final Color initialBg;
  final Color initialFg;
  final Color initialAccent;
  final void Function(Color bg, Color fg, Color accent) onChanged;

  @override
  State<_CustomThemePicker> createState() => _CustomThemePickerState();
}

class _CustomThemePickerState extends State<_CustomThemePicker> {
  late Color _bg;
  late Color _fg;
  late Color _accent;

  @override
  void initState() {
    super.initState();
    _bg = widget.initialBg;
    _fg = widget.initialFg;
    _accent = widget.initialAccent;
  }

  void _notify() => widget.onChanged(_bg, _fg, _accent);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _ColorRow(
          label: 'Background',
          color: _bg,
          onChanged: (c) {
            setState(() => _bg = c);
            _notify();
          },
        ),
        _ColorRow(
          label: 'Text',
          color: _fg,
          onChanged: (c) {
            setState(() => _fg = c);
            _notify();
          },
        ),
        _ColorRow(
          label: 'Accent',
          color: _accent,
          onChanged: (c) {
            setState(() => _accent = c);
            _notify();
          },
        ),
      ],
    );
  }
}

class _ColorRow extends StatelessWidget {
  const _ColorRow({
    required this.label,
    required this.color,
    required this.onChanged,
  });

  final String label;
  final Color color;
  final ValueChanged<Color> onChanged;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      title: Text(label),
      trailing: GestureDetector(
        onTap: () => _pick(context),
        child: Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
            border: Border.all(color: Colors.grey),
          ),
        ),
      ),
    );
  }

  void _pick(BuildContext context) {
    Color current = color;
    showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Pick $label'),
        content: ColorPicker(
          pickerColor: current,
          onColorChanged: (c) => current = c,
        ),
        actions: [
          FilledButton(
            onPressed: () {
              onChanged(current);
              Navigator.pop(ctx);
            },
            child: const Text('Select'),
          ),
        ],
      ),
    );
  }
}
