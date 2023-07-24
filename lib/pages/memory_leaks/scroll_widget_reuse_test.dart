import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sample/pages/memory_leaks/custom_list_tile.dart';

class ScrollWidgetReuseTest1 extends StatelessWidget {
  const ScrollWidgetReuseTest1({super.key});

  static Future<void> show(BuildContext context) {
    return Navigator.of(context, rootNavigator: true).push<void>(
      CupertinoPageRoute(
        settings: const RouteSettings(name: 'scroll_widget_reuse_test_1'),
        builder: (_) => const ScrollWidgetReuseTest1(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(runtimeType.toString()),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Text(
              'ヘッダー',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return CustomListTile(index.toString());
              },
              itemCount: 100,
            ),
          ],
        ),
      ),
    );
  }
}

class ScrollWidgetReuseTest2 extends StatelessWidget {
  const ScrollWidgetReuseTest2({super.key});

  static Future<void> show(BuildContext context) {
    return Navigator.of(context, rootNavigator: true).push<void>(
      CupertinoPageRoute(
        settings: const RouteSettings(name: 'scroll_widget_reuse_test_2'),
        builder: (_) => const ScrollWidgetReuseTest2(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(runtimeType.toString()),
      ),
      body: CustomScrollView(
        slivers: [
          const SliverToBoxAdapter(
            child: Center(
              child: Text(
                'ヘッダー',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
          SliverList.builder(
            itemBuilder: (context, index) {
              return CustomListTile(index.toString());
            },
            itemCount: 100,
          ),
        ],
      ),
    );
  }
}
