import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';

class TmpCacheDirectory {
  TmpCacheDirectory._();

  static late final Directory _directory;

  static Future<void> setup() async {
    if (Platform.isIOS) {
      // /Users/xxx/Library/Developer/CoreSimulator/Devices/8453C0AB-E640-4044-87E3-7A891199062E/data/Containers/Data/Application/1B2DA1B2-CFEA-4070-8F23-F83A7B8DF6CE/tmp/
      _directory = Directory.systemTemp;
    } else {
      // /data/user/0/com.example.flutter_sample/cache/
      _directory = await getTemporaryDirectory();
    }
  }

  static Future<List<File>> fetchFiles() async {
    final list = await compute<Directory, List<File>>(
      (dir) {
        return dir
            .listSync(recursive: true, followLinks: false)
            .whereType<File>()
            .toList();
      },
      _directory,
    );
    return list;
  }

  static Future<void> deleteFiles() async {
    await compute<Directory, void>(
      (dir) {
        final list = dir
            .listSync(recursive: true, followLinks: false)
            .whereType<File>()
            .toList();
        for (final file in list) {
          file.deleteSync();
          debugPrint('delete: ${file.path}');
        }
      },
      _directory,
    );
  }
}
