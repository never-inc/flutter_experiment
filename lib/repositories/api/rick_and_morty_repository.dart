import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

final rickAndMortyRepositoryProvider = Provider(
  (ref) => RickAndMortyRepository(
    GraphQLClient(
      link: HttpLink('https://rickandmortyapi.com/graphql'),
      cache: GraphQLCache(store: HiveStore()),
    ),
  ),
);

class RickAndMortyRepository {
  RickAndMortyRepository(this._client);
  final GraphQLClient _client;

  Future<List<String>> fetchNameRick() async {
    /// https://rickandmortyapi.com/documentation/
    const query = '''
    query {
      characters(page: 2, filter: { name: "rick" }) {
        info {
          count
        }
        results {
          name
        }
      }
      location(id: 1) {
        id
      }
      episodesByIds(ids: [1, 2]) {
        id
      }
    }
    ''';
    final result = await _client.query(
      QueryOptions(
        document: gql(query),
      ),
    );
    if (kDebugMode) {
      print(result.data);
    }
    // TODO(shohei): Freezedでリファクタリング
    final nameMap = (result.data?['characters']
        as Map<String, dynamic>?)?['results'] as List<dynamic>?;
    if (nameMap == null) {
      return [];
    }
    final data = nameMap
        .map((e) => (e as Map<String, dynamic>?)?['name'] as String?)
        .whereType<String>()
        .toList();

    return data;
  }
}
