import 'dart:io';

import 'package:path_provider/path_provider.dart';

class FileRepository {
  static final FileRepository getInstance = FileRepository();

  Future<List<File>> fetchTempFiles() async {
    final dir = await _fetchTemporaryDirectory();
    return dir
        .listSync(recursive: true, followLinks: false)
        .whereType<File>()
        .toList();
  }

  Future<void> clearTempFiles() async {
    final dir = await _fetchTemporaryDirectory();
    final list = dir
        .listSync(recursive: true, followLinks: false)
        .whereType<File>()
        .toList();
    for (final file in list) {
      file.deleteSync();
    }
  }

  Future<Directory> _fetchTemporaryDirectory() async {
    if (Platform.isIOS) {
      /// iOS: /Users/xxx/Library/Developer/CoreSimulator/Devices/8453C0AB-E640-4044-87E3-7A891199062E/data/Containers/Data/Application/1B2DA1B2-CFEA-4070-8F23-F83A7B8DF6CE/tmp/
      return Directory.systemTemp;
    } else {
      /// Android: /data/user/0/com.example.flutter_sample/cache/
      final dir = await getTemporaryDirectory();
      return dir;
    }
  }
}
