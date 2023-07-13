import 'package:flutter_sample/utils.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class FlutterSecureStorageRepository {
  Future<void> saveInt(DatabaseKey key, int value) async {
    final db = getIt<FlutterSecureStorage>();
    await db.write(key: key.name, value: value.toString());
  }

  Future<int?> fetchInt(DatabaseKey key) async {
    final db = getIt<FlutterSecureStorage>();
    final value = await db.read(key: key.name);
    if (value == null) {
      return null;
    }
    return int.parse(value);
  }
}
