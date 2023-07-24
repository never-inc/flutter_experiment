import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sample/pages/memory_leaks/global_object_test.dart';
import 'package:flutter_sample/pages/memory_leaks/riverpod_test.dart';
import 'package:flutter_sample/pages/memory_leaks/scope_test.dart';
import 'package:flutter_sample/pages/memory_leaks/scroll_controller_test.dart';
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
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: 16),
                child: ScopeTest(),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 16),
                child: GlobalObjectTest(),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 16),
                child: StaticGetterTest(),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 16),
                child: SizedBox(
                  height: 96,
                  child: ScrollControllerTest(),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 16),
                child: SizedBox(
                  height: 96,
                  child: StreamControllerTest(),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 16),
                child: ReverpodTest(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
