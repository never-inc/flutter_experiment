import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sample/pages/graph_ql/rick_and_morty_controller.dart';

class GraphQLSamplePage1 extends ConsumerWidget {
  const GraphQLSamplePage1({super.key});

  static Future<void> show(BuildContext context) {
    return Navigator.of(context, rootNavigator: true).push<void>(
      CupertinoPageRoute(
        settings: const RouteSettings(name: 'graph_ql_sample_page_1'),
        builder: (_) => const GraphQLSamplePage1(),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final items = ref.watch(rickAndMortyControllerProvider).asData?.value ?? [];
    return Scaffold(
      appBar: AppBar(
        title: Text(runtimeType.toString()),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          final data = items[index];
          return ListTile(
            title: Text(data),
          );
        },
        itemCount: items.length,
      ),
    );
  }
}
