import 'dart:async';
import 'dart:convert';

import 'package:flutter_sample/exceptions/app_exception.dart';
import 'package:flutter_sample/pages/github_users/entities/user.dart';
import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'github_api_repository.g.dart';

@Riverpod(keepAlive: true)
http.Client client(ClientRef ref) {
  return http.Client();
}

@Riverpod(keepAlive: true)
GithubApiRepository githubApiRepository(GithubApiRepositoryRef ref) {
  return GithubApiRepository(ref);
}

class GithubApiRepository {
  GithubApiRepository(
    this._ref,
  );

  final GithubApiRepositoryRef _ref;

  Future<List<User>> fetchUsers({int? since, int? perPage}) async {
    final res = await _ref.read(clientProvider).get(
          Uri.https('api.github.com', 'users', {
            'since': since?.toString(),
            'per_page': perPage?.toString(),
          }),
        );

    if (res.statusCode >= 300 && res.statusCode <= 500) {
      final json = jsonDecode(utf8.decode(res.bodyBytes)) as Map;
      throw AppException(
        title: 'Error',
        detail: '${json['message'] as String?}',
      );
    }

    return (jsonDecode(utf8.decode(res.bodyBytes)) as List)
        .map((dynamic e) => User.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
