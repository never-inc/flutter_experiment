import 'package:flutter_sample/repositories/local_database/database_key.dart';
import 'package:flutter_sample/repositories/local_database/local_database_repository.dart';

final class LocalDatabaseRepositoryMock implements LocalDatabaseRepository {
  /// Mockデータを設定するためのハンドラー
  Future<int?> Function(DatabaseKey key)? fetchIntHandler;
  Future<void> Function(DatabaseKey key, int value)? saveIntHandler;

  /// 関数が呼ばれるごとにカウントする
  int fetchIntCallCount = 0;
  int saveIntCallCount = 0;

  @override
  Future<int?> fetchInt(DatabaseKey key) async {
    fetchIntCallCount += 1;
    return fetchIntHandler?.call(key);
  }

  @override
  Future<void> saveInt(DatabaseKey key, int value) async {
    saveIntCallCount += 1;
    return saveIntHandler?.call(key, value);
  }

  /// ハンドラーをリセットする
  void resetHandler() {
    fetchIntHandler = null;
    saveIntHandler = null;
    fetchIntCallCount = 0;
    saveIntCallCount = 0;
  }
}
