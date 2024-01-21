import 'package:flutter_sample/exceptions/app_exception.dart';
import 'package:flutter_sample/repositories/github_api/github_api_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'dummy_data.dart';
import 'github_api_repository_test.mocks.dart';
import 'mock_client.dart' as original;

@GenerateNiceMocks([
  MockSpec<http.Client>(),
])
void main() {
  group('自作モックを注入した GithubApiRepository テスト', () {
    test(
      'usersの取得が成功すること',
      () async {
        /// テスト対象にモックをセット
        final repository = GithubApiRepository(original.MockClient());

        /// テスト実施
        final res = await repository.fetchUsers();

        /// テスト結果を検証
        expect(res.isNotEmpty, isTrue);
        expect(res.length, 1);
      },
    );
  });

  group('mockitoのモックを注入した GithubApiRepository テスト', () {
    test(
      'usersの取得が成功すること',
      () async {
        /// モックの返却データをセット
        final mockClient = MockClient();
        when(
          mockClient.get(any),
        ).thenAnswer((_) {
          const data = dummyData;
          return Future.value(
            http.Response(data, 200),
          );
        });

        /// テスト対象にモックをセット
        final repository = GithubApiRepository(mockClient);

        /// テスト実施
        final res = await repository.fetchUsers();

        /// テスト結果を検証
        expect(res.isNotEmpty, isTrue);
        expect(res.length, 1);
        verify(mockClient.get(any)).called(1);
      },
    );

    test(
      'usersの取得が失敗すること',
      () async {
        /// モックの返却データをセット
        final mockClient = MockClient();
        when(
          mockClient.get(any),
        ).thenAnswer((_) {
          const data = '{"message":"error"}';
          return Future.value(
            http.Response(data, 400),
          );
        });

        /// テスト対象にモックをセット
        final repository = GithubApiRepository(mockClient);

        /// テスト実施 & 検証
        expect(repository.fetchUsers(), throwsA(isA<AppException>()));
        verify(mockClient.get(any)).called(1);
      },
    );
  });
}
