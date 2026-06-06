import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

/// Platform channel wrapper for MOBI/AZW → HTML conversion on Android.
/// On iOS and other platforms this is not supported.
class MobiConverterService {
  static const _channel = MethodChannel('com.example.readme/mobi');

  /// Converts a MOBI/AZW file at [mobiPath] to an HTML file in a temp
  /// directory. Returns the path to the HTML file, or null on non-Android.
  static Future<String?> convert(String mobiPath) async {
    if (!Platform.isAndroid) return null;

    final tmp = await getTemporaryDirectory();
    final name = p.basenameWithoutExtension(mobiPath);
    final destFile = p.join(tmp.path, 'mobi_$name.html');

    try {
      final result = await _channel.invokeMethod<String>('convertToHtml', {
        'path': mobiPath,
        'destFile': destFile,
      });
      return result;
    } on PlatformException catch (e) {
      final message = e.message ?? 'Unknown platform error';
      if (message.contains('unavailable in this Android build')) {
        throw Exception(
          'MOBI/AZW reading is temporarily unavailable in this Android build.',
        );
      }
      throw Exception('MOBI conversion failed: $message');
    }
  }
}
