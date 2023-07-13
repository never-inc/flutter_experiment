import 'package:flutter_sample/utils.dart';

abstract class LocalDatabaseRepository {
  Future<void> saveInt(DatabaseKey key, int value);
  Future<int?> fetchInt(DatabaseKey key);
}
