import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sample/pages/memory_leaks/composition_test.dart';
import 'package:flutter_sample/pages/memory_leaks/const_test.dart';
import 'package:flutter_sample/pages/memory_leaks/global_object_test.dart';
import 'package:flutter_sample/pages/memory_leaks/riverpod_test.dart';
import 'package:flutter_sample/pages/memory_leaks/scope_test.dart';
import 'package:flutter_sample/pages/memory_leaks/scroll_controller_test.dart';
import 'package:flutter_sample/pages/memory_leaks/scroll_widget_reuse_test.dart';
import 'package:flutter_sample/pages/memory_leaks/static_getter_test.dart';
import 'package:flutter_sample/pages/memory_leaks/stream_controller_test.dart';

class MemoryLeakSamplePage extends ConsumerWidget {
  const MemoryLeakSamplePage({super.key});

  static Future<void> show(BuildContext context) {
    return Navigator.of(context, rootNavigator: true).push<void>(
      CupertinoPageRoute(
        settings: const RouteSettings(name: 'memory_leak_sample'),
        builder: (_) => const MemoryLeakSamplePage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Memory Leak Sample'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.only(bottom: 16),
                child: ScopeTest(),
              ),
              const Padding(
                padding: EdgeInsets.only(bottom: 16),
                child: GlobalObjectTest(),
              ),
              const Padding(
                padding: EdgeInsets.only(bottom: 16),
                child: StaticGetterTest(),
              ),
              const Padding(
                padding: EdgeInsets.only(bottom: 16),
                child: SizedBox(
                  height: 96,
                  child: ScrollControllerTest(),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(bottom: 16),
                child: SizedBox(
                  height: 96,
                  child: StreamControllerTest(),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(bottom: 16),
                child: RiverpodTest(),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Column(
                  children: [
                    ListTile(
                      title: const Text('CompositionTest 1'),
                      onTap: () {
                        Navigator.of(context, rootNavigator: true).push<void>(
                          CupertinoPageRoute<void>(
                            settings:
                                const RouteSettings(name: 'composition_test'),
                            builder: (_) {
                              final data = CompositionData('test');
                              return CompositionTest(data);
                            },
                          ),
                        );
                      },
                    ),
                    const Divider(height: 1),
                    ListTile(
                      title: const Text('CompositionTest 2'),
                      onTap: () {
                        final data = CompositionData('test');
                        Navigator.of(context, rootNavigator: true).push<void>(
                          CupertinoPageRoute<void>(
                            settings:
                                const RouteSettings(name: 'composition_test'),
                            builder: (_) {
                              return CompositionTest(data);
                            },
                          ),
                        );
                      },
                    ),
                    const Divider(height: 1),
                    ListTile(
                      title: const Text('ConstTest'),
                      onTap: () {
                        ConstTest.show(context);
                      },
                    ),
                    const Divider(height: 1),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Column(
                  children: [
                    const Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Scroll Reuse Widget Test',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    ListTile(
                      title: const Text('リークする例'),
                      onTap: () {
                        ScrollWidgetReuseTest1.show(context);
                      },
                    ),
                    const Divider(height: 1),
                    ListTile(
                      title: const Text('リークしない実装'),
                      onTap: () {
                        ScrollWidgetReuseTest2.show(context);
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
