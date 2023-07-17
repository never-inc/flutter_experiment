import 'package:flutter_sample/exceptions/app_exception.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;

abstract interface class ReqBase {
  String get baseUrl;
  String get path;
}

final class GetGithubUsersReq implements ReqBase {
  @override
  String get baseUrl => 'api.github.com';

  @override
  String get path => 'users';
}

final class GetGithubUserReq implements ReqBase {
  GetGithubUserReq({
    required this.username,
  });

  final String username;

  @override
  String get baseUrl => 'api.github.com';

  @override
  String get path => 'users/$username';
}

Future<http.Response> api(ReqBase req) async {
  try {
    final res = await http.get(
      Uri.https(req.baseUrl, req.path),
    );
    return res;
  } on Exception catch (e) {
    throw AppException.error('エラーが発生しました: $e');
  }
}

void main() {
  group('抽象化クラスのテスト', () {
    test(
      'テスト1',
      () async {
        final res1 = await api(GetGithubUsersReq());
        print(res1.body);
        final res2 = await api(GetGithubUserReq(username: 'hukusuke1007'));
        print(res2.body);
      },
    );
  });
}
