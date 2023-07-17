import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sample/pages/riverpod/counter/counter_controller.dart';
import 'package:flutter_sample/repositories/local_database/database_key.dart';
import 'package:flutter_sample/repositories/local_database/local_database_repository.dart';
import 'package:flutter_sample/utils.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../repositories/local_database/local_database_repository_test_mock.dart';
import 'counter_controller_test.mocks.dart';

@GenerateNiceMocks(
  [MockSpec<LocalDatabaseRepository>()],
)
void main() {
  group('CounterController テスト（MockitoのMockを使う）', () {
    late final MockLocalDatabaseRepository mockLocalDatabaseRepository;

    setUpAll(() {
      mockLocalDatabaseRepository = MockLocalDatabaseRepository();
    });

    tearDown(() {
      reset(mockLocalDatabaseRepository);
    });

    test(
      'カウントアップできること',
      () async {
        const key = DatabaseKey.counter;

        /// Mockにデータをセットする
        when(mockLocalDatabaseRepository.fetchInt(key))
            .thenAnswer((_) async => 0);
        when(
          mockLocalDatabaseRepository.saveInt(
            key,
            any,
          ),
        ).thenAnswer((_) async {});

        /// MockをProviderにセットし、テスト実施
        final container = ProviderContainer(
          overrides: [
            localDatabaseRepositoryProvider.overrideWithValue(
              mockLocalDatabaseRepository,
            ),
          ],
        );
        addTearDown(container.dispose);

        /// テスト実施
        await container.read(counterControllerProvider.future);

        expect(container.exists(counterControllerProvider), isTrue);
        expect(container.read(counterControllerProvider).value, 0);

        await container.read(counterControllerProvider.notifier).increment();
        expect(container.read(counterControllerProvider).value, 1);

        await container.read(counterControllerProvider.notifier).increment();
        expect(container.read(counterControllerProvider).value, 2);

        verify(container.read(localDatabaseRepositoryProvider).fetchInt(key))
            .called(1);
        verify(
          container.read(localDatabaseRepositoryProvider).saveInt(key, 1),
        ).called(1);
        verify(
          container.read(localDatabaseRepositoryProvider).saveInt(key, 2),
        ).called(1);

        /// Providerが再構築されるまで待ち、CounterControllerが破棄されるか確認
        await container.pump();
        expect(container.exists(counterControllerProvider), isFalse);
      },
    );
  });

  group('CounterController テスト（自前のMockを使う）', () {
    late final LocalDatabaseRepositoryMock localDatabaseRepositoryMock;

    setUpAll(() {
      localDatabaseRepositoryMock = LocalDatabaseRepositoryMock();
    });

    tearDown(() {
      localDatabaseRepositoryMock.resetHandler();
    });

    test(
      'カウントアップできること',
      () async {
        /// Mockにデータをセットする
        localDatabaseRepositoryMock
          ..fetchIntHandler = (DatabaseKey key) {
            expect(key, DatabaseKey.counter);
            return Future.value(0);
          }
          ..saveIntHandler = (DatabaseKey key, int value) {
            expect(key, DatabaseKey.counter);
            return Future.value();
          };

        /// MockをProviderにセットし、テスト実施
        final container = ProviderContainer(
          overrides: [
            localDatabaseRepositoryProvider.overrideWithValue(
              localDatabaseRepositoryMock,
            ),
          ],
        );
        addTearDown(container.dispose);

        /// テスト実施
        await container.read(counterControllerProvider.future);

        expect(container.exists(counterControllerProvider), isTrue);
        expect(container.read(counterControllerProvider).value, 0);

        await container.read(counterControllerProvider.notifier).increment();
        expect(container.read(counterControllerProvider).value, 1);

        await container.read(counterControllerProvider.notifier).increment();
        expect(container.read(counterControllerProvider).value, 2);

        expect(localDatabaseRepositoryMock.fetchIntCallCount, 1);
        expect(localDatabaseRepositoryMock.saveIntCallCount, 2);

        /// Providerが再構築されるまで待ち、CounterControllerが破棄されるか確認
        await container.pump();
        expect(container.exists(counterControllerProvider), isFalse);
      },
    );
  });
}
