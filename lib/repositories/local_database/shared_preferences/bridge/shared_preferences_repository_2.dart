import 'package:flutter_sample/repositories/local_database/database_key.dart';
import 'package:flutter_sample/repositories/local_database/local_database_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesRepository implements LocalDatabaseRepository {
  SharedPreferencesRepository(this._db);

  final SharedPreferences _db;

  @override
  Future<void> saveInt(DatabaseKey key, int value) async {
    await _db.setInt(key.name, value);
  }

  @override
  Future<int?> fetchInt(DatabaseKey key) async {
    return _db.getInt(key.name);
  }
}
