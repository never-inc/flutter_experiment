import 'package:flutter_sample/repositories/local_database/database_key.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class FlutterSecureStorageRepository {
  FlutterSecureStorageRepository(this._db);

  final FlutterSecureStorage _db;

  Future<void> saveInt(DatabaseKey key, int value) async {
    await _db.write(key: key.name, value: value.toString());
  }

  Future<int?> fetchInt(DatabaseKey key) async {
    final value = await _db.read(key: key.name);
    if (value == null) {
      return null;
    }
    return int.parse(value);
  }
}
