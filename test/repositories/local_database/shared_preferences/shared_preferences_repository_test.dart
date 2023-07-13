import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sample/repositories/local_database/database_key.dart';
import 'package:flutter_sample/repositories/local_database/shared_preferences/shared_preferences_repository_2.dart'
    as spr2;
import 'package:flutter_sample/repositories/local_database/shared_preferences/shared_preferences_repository_3.dart'
    as spr3;
import 'package:flutter_sample/repositories/local_database/shared_preferences/shared_preferences_repository_4.dart'
    as spr4;
import 'package:flutter_sample/utils.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'shared_preferences_repository_test.mocks.dart';

@GenerateNiceMocks([MockSpec<SharedPreferences>()])
void main() {
  const key = DatabaseKey.counter;

  group('SharedPreferencesRepository オフラインテスト', () {
    late final MockSharedPreferences mockSharedPreferences;

    setUpAll(() {
      mockSharedPreferences = MockSharedPreferences();
    });

    tearDown(() {
      reset(mockSharedPreferences);
    });

    test(
      '保存と取得ができること',
      () async {
        /// Mockにデータをセットする
        when(
          mockSharedPreferences.setInt(key.name, any),
        ).thenAnswer((_) async => true);
        when(
          mockSharedPreferences.getInt(key.name),
        ).thenAnswer((_) => 0);

        /// RepositoryにMockをセットし、テスト対象のインスタンスを生成
        final repository =
            spr2.SharedPreferencesRepository(mockSharedPreferences);

        /// テスト実施
        await repository.saveInt(key, 0);
        final result = await repository.fetchInt(key);

        /// テスト結果を検証
        expect(result, 0);
        verify(mockSharedPreferences.setInt(key.name, 0)).called(1);
        verify(mockSharedPreferences.getInt(key.name)).called(1);
      },
    );

    test(
      '[riverpod] 保存と取得ができること',
      () async {
        /// Mockにデータをセットする
        when(
          mockSharedPreferences.setInt(key.name, any),
        ).thenAnswer((_) async => true);
        when(
          mockSharedPreferences.getInt(key.name),
        ).thenAnswer((_) => 0);

        /// ProviderにMockをセットする
        final container = ProviderContainer(
          overrides: [
            sharedPreferencesProvider.overrideWithValue(mockSharedPreferences)
          ],
        );
        addTearDown(container.dispose);

        /// テスト対象のインスタンスを生成
        final repository =
            container.read(spr3.sharedPreferencesRepositoryProvider);

        /// テスト実施
        await repository.saveInt(key, 0);
        final result = await repository.fetchInt(key);

        /// テスト結果を検証
        expect(result, 0);
        verify(mockSharedPreferences.setInt(key.name, 0)).called(1);
        verify(mockSharedPreferences.getInt(key.name)).called(1);
      },
    );

    test(
      '[get_it] 保存と取得ができること',
      () async {
        /// Mockにデータをセットする
        when(
          mockSharedPreferences.setInt(key.name, any),
        ).thenAnswer((_) async => true);
        when(
          mockSharedPreferences.getInt(key.name),
        ).thenAnswer((_) => 0);

        /// GetItにMockをセットする
        getIt.registerFactory<SharedPreferences>(
          () => mockSharedPreferences,
        );
        addTearDown(getIt.reset);

        /// テスト対象のインスタンスを生成
        final repository = spr4.SharedPreferencesRepository();

        /// テスト実施
        await repository.saveInt(key, 0);
        final result = await repository.fetchInt(key);

        /// テスト結果を検証
        expect(result, 0);
        verify(mockSharedPreferences.setInt(key.name, 0)).called(1);
        verify(mockSharedPreferences.getInt(key.name)).called(1);
      },
    );
  });
}
