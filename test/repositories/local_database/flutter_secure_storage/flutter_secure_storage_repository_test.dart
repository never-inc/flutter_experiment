import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sample/repositories/local_database/database_key.dart';
import 'package:flutter_sample/repositories/local_database/flutter_secure_storage/flutter_secure_storage_repository_2.dart'
    as fss2;
import 'package:flutter_sample/repositories/local_database/flutter_secure_storage/flutter_secure_storage_repository_3.dart'
    as fss3;
import 'package:flutter_sample/repositories/local_database/flutter_secure_storage/flutter_secure_storage_repository_4.dart'
    as fss4;
import 'package:flutter_sample/utils.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'flutter_secure_storage_repository_test.mocks.dart';

@GenerateNiceMocks([MockSpec<FlutterSecureStorage>()])
void main() {
  const key = DatabaseKey.counter;

  group('FlutterSecureStorageRepository テスト', () {
    late final MockFlutterSecureStorage mockFlutterSecureStorage;

    setUpAll(() {
      mockFlutterSecureStorage = MockFlutterSecureStorage();
    });

    tearDown(() {
      reset(mockFlutterSecureStorage);
    });

    test(
      '保存と取得ができること',
      () async {
        /// Mockにデータをセットする
        when(
          mockFlutterSecureStorage.write(
            key: key.name,
            value: anyNamed('value'),
          ),
        ).thenAnswer((realInvocation) async {});
        when(
          mockFlutterSecureStorage.read(key: key.name),
        ).thenAnswer((_) async => '0');

        /// RepositoryにMockをセットし、テスト対象のインスタンスを生成
        final repository =
            fss2.FlutterSecureStorageRepository(mockFlutterSecureStorage);

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
      '[riverpod] 保存と取得ができること',
      () async {
        /// Mockにデータをセットする
        when(
          mockFlutterSecureStorage.write(
            key: key.name,
            value: anyNamed('value'),
          ),
        ).thenAnswer((realInvocation) async {});
        when(
          mockFlutterSecureStorage.read(key: key.name),
        ).thenAnswer((_) async => '0');

        /// ProviderにMockをセットする
        final container = ProviderContainer(
          overrides: [
            flutterSecureStorageProvider
                .overrideWithValue(mockFlutterSecureStorage)
          ],
        );
        addTearDown(container.dispose);

        /// テスト対象のインスタンスを生成
        final repository =
            container.read(fss3.flutterSecureStorageRepositoryProvider);

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
        ).thenAnswer((realInvocation) async {});
        when(
          mockFlutterSecureStorage.read(key: key.name),
        ).thenAnswer((_) async => '0');

        /// GetItにMockをセットする
        getIt.registerFactory<FlutterSecureStorage>(
          () => mockFlutterSecureStorage,
        );
        addTearDown(getIt.reset);

        /// テスト対象のインスタンスを生成
        final repository = fss4.FlutterSecureStorageRepository();

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
}
