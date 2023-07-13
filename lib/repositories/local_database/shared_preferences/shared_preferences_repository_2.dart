import 'package:flutter_sample/repositories/local_database/database_key.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesRepository {
  SharedPreferencesRepository(this._db);

  final SharedPreferences _db;

  Future<void> saveInt(DatabaseKey key, int value) async {
    await _db.setInt(key.name, value);
  }

  Future<int?> fetchInt(DatabaseKey key) async {
    return _db.getInt(key.name);
  }
}
