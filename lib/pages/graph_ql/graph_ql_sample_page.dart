import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sample/pages/graph_ql/graph_ql_sample_page_1.dart';
import 'package:flutter_sample/pages/graph_ql/graph_ql_sample_page_2.dart';

class GraphQLSamplePage extends StatelessWidget {
  const GraphQLSamplePage({super.key});

  static Future<void> show(BuildContext context) {
    return Navigator.of(context, rootNavigator: true).push<void>(
      CupertinoPageRoute(
        settings: const RouteSettings(name: 'graph_ql_sample_page'),
        builder: (_) => const GraphQLSamplePage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(runtimeType.toString()),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Column(
            children: [
              ListTile(
                title: const Text(
                  'GraphQLFlutter Sample 1',
                ),
                trailing: const Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 16,
                ),
                onTap: () {
                  GraphQLSamplePage1.show(context);
                },
              ),
              const Divider(height: 1),
              ListTile(
                title: const Text(
                  'GraphQLFlutter Sample 2',
                ),
                trailing: const Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 16,
                ),
                onTap: () {
                  GraphQLSamplePage2.show(context);
                },
              ),
              const Divider(height: 1),
            ],
          ),
        ),
      ),
    );
  }
}
