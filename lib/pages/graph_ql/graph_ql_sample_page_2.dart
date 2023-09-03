import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class GraphQLSamplePage2 extends StatelessWidget {
  GraphQLSamplePage2({super.key});

  static Future<void> show(BuildContext context) {
    return Navigator.of(context, rootNavigator: true).push<void>(
      CupertinoPageRoute(
        settings: const RouteSettings(name: 'graph_ql_sample_page_2'),
        builder: (_) => GraphQLSamplePage2(),
      ),
    );
  }

  final ValueNotifier<GraphQLClient> _client = ValueNotifier(
    GraphQLClient(
      link: HttpLink('https://rickandmortyapi.com/graphql'),
      cache: GraphQLCache(store: HiveStore()),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
      client: _client,
      child: Scaffold(
        appBar: AppBar(
          title: Text(runtimeType.toString()),
        ),
        body: Query(
          options: QueryOptions(
            document: gql(_query),
            pollInterval: const Duration(seconds: 10),
          ),
          builder: (
            QueryResult result, {
            VoidCallback? refetch,
            FetchMore? fetchMore,
          }) {
            if (result.hasException) {
              return Text(result.exception.toString());
            }
            if (result.isLoading) {
              return const Text('Loading');
            }

            // TODO(shohei): Freezedでリファクタリング
            final nameMap = (result.data?['characters']
                as Map<String, dynamic>?)?['results'] as List<dynamic>?;
            if (nameMap == null) {
              return const Text('Nothing');
            }
            final items = nameMap
                .map((e) => (e as Map<String, dynamic>?)?['name'] as String?)
                .whereType<String>()
                .toList();

            /// Widget
            return ListView.builder(
              itemBuilder: (context, index) {
                final data = items[index];
                return ListTile(
                  title: Text(data),
                );
              },
              itemCount: items.length,
            );
          },
        ),
      ),
    );
  }
}

const _query = '''
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
