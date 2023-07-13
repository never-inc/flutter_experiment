import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sample/repositories/local_database/database_key.dart';
import 'package:flutter_sample/utils.dart';

final sharedPreferencesRepositoryProvider =
    Provider<SharedPreferencesRepository>(
  SharedPreferencesRepository.new,
);

class SharedPreferencesRepository {
  SharedPreferencesRepository(this._ref);

  final Ref _ref;

  Future<void> saveInt(DatabaseKey key, int value) async {
    final db = _ref.read(sharedPreferencesProvider);
    await db.setInt(key.name, value);
  }

  Future<int?> fetchInt(DatabaseKey key) async {
    final db = _ref.read(sharedPreferencesProvider);
    return db.getInt(key.name);
  }
}
