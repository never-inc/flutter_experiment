import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sample/repositories/local_database/database_key.dart';
import 'package:flutter_sample/repositories/local_database/flutter_secure_storage/impl/flutter_secure_storage_repository_3.dart'
    as fss3;
import 'package:flutter_sample/repositories/local_database/flutter_secure_storage/impl/flutter_secure_storage_repository_4.dart'
    as fss4;
import 'package:flutter_sample/repositories/local_database/local_database_repository.dart';
import 'package:flutter_sample/repositories/local_database/shared_preferences/impl/shared_preferences_repository_3.dart'
    as spr3;
import 'package:flutter_sample/repositories/local_database/shared_preferences/impl/shared_preferences_repository_4.dart'
    as spr4;
import 'package:flutter_sample/utils.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'local_database_repository_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<FlutterSecureStorage>(),
  MockSpec<SharedPreferences>(),
])
void main() {
  const key = DatabaseKey.counter;

  group('FlutterSecureStorageRepository の実体を注入した LocalDatabaseRepository テスト',
      () {
    late final MockFlutterSecureStorage mockFlutterSecureStorage;

    setUpAll(() {
      mockFlutterSecureStorage = MockFlutterSecureStorage();
    });

    tearDown(() {
      reset(mockFlutterSecureStorage);
    });

    test(
      '[riverpod] 保存と取得ができること',
      () async {
        /// Mockにデータをセットする
        when(
          mockFlutterSecureStorage.write(
            key: key.name,
            value: anyNamed('value'),
          ),
        ).thenAnswer((_) async {});
        when(
          mockFlutterSecureStorage.read(key: key.name),
        ).thenAnswer((_) async => '0');

        /// ProviderにMockをセットする
        final container = ProviderContainer(
          overrides: [
            flutterSecureStorageProvider
                .overrideWithValue(mockFlutterSecureStorage),
            localDatabaseRepositoryProvider.overrideWith(
              fss3.FlutterSecureStorageRepository.new,
            ),
          ],
        );
        addTearDown(container.dispose);

        /// テスト対象のインスタンスを生成
        final repository = container.read(localDatabaseRepositoryProvider);

        /// テスト実施
        await repository.saveInt(key, 0);
        final result = await repository.fetchInt(key);

        /// テスト結果を検証
        expect(result, 0);
        verify(mockFlutterSecureStorage.write(key: key.name, value: '0'))
            .called(1);
        verify(mockFlutterSecureStorage.read(key: key.name)).called(1);
      },
    );

    test(
      '[get_it] 保存と取得ができること',
      () async {
        /// Mockにデータをセットする
        when(
          mockFlutterSecureStorage.write(
            key: key.name,
            value: anyNamed('value'),
          ),
        ).thenAnswer((_) async {});
        when(
          mockFlutterSecureStorage.read(key: key.name),
        ).thenAnswer((_) async => '0');

        /// GetItにMockをセットする
        getIt
          ..registerFactory<FlutterSecureStorage>(
            () => mockFlutterSecureStorage,
          )
          ..registerFactory<LocalDatabaseRepository>(
            fss4.FlutterSecureStorageRepository.new,
          );
        addTearDown(getIt.reset);

        /// テスト対象のインスタンスを生成
        final repository = getIt<LocalDatabaseRepository>();

        /// テスト実施
        await repository.saveInt(key, 0);
        final result = await repository.fetchInt(key);

        /// テスト結果を検証
        expect(result, 0);
        verify(mockFlutterSecureStorage.write(key: key.name, value: '0'))
            .called(1);
        verify(mockFlutterSecureStorage.read(key: key.name)).called(1);
      },
    );
  });

  group('SharedPreferencesRepository の実体を注入した LocalDatabaseRepository テスト', () {
    late final MockSharedPreferences mockSharedPreferences;

    setUpAll(() {
      mockSharedPreferences = MockSharedPreferences();
    });

    tearDown(() {
      reset(mockSharedPreferences);
    });

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
            sharedPreferencesProvider.overrideWithValue(mockSharedPreferences),
            localDatabaseRepositoryProvider.overrideWith(
              spr3.SharedPreferencesRepository.new,
            ),
          ],
        );
        addTearDown(container.dispose);

        /// テスト対象のインスタンスを生成
        final repository = container.read(localDatabaseRepositoryProvider);

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
        getIt
          ..registerFactory<SharedPreferences>(
            () => mockSharedPreferences,
          )
          ..registerFactory<LocalDatabaseRepository>(
            spr4.SharedPreferencesRepository.new,
          );
        addTearDown(getIt.reset);

        /// テスト対象のインスタンスを生成
        final repository = getIt<LocalDatabaseRepository>();

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
