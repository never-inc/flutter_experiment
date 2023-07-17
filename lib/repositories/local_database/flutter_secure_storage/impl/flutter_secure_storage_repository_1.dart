import 'package:flutter_sample/repositories/local_database/database_key.dart';
import 'package:flutter_sample/repositories/local_database/local_database_repository.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final class FlutterSecureStorageRepository implements LocalDatabaseRepository {
  @override
  Future<void> saveInt(DatabaseKey key, int value) async {
    const db = FlutterSecureStorage();
    await db.write(key: key.name, value: value.toString());
  }

  @override
  Future<int?> fetchInt(DatabaseKey key) async {
    const db = FlutterSecureStorage();
    final value = await db.read(key: key.name);
    if (value == null) {
      return null;
    }
    return int.parse(value);
  }
}
