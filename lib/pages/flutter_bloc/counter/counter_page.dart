import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sample/pages/flutter_bloc/counter/counter_controller.dart';
import 'package:flutter_sample/utils.dart';

class CounterPage extends StatefulWidget {
  const CounterPage({super.key});

  static Future<void> show(BuildContext context) {
    return Navigator.of(context, rootNavigator: true).push<void>(
      CupertinoPageRoute(
        settings: const RouteSettings(name: 'counter_with_flutter_bloc'),
        builder: (_) => const CounterPage(),
      ),
    );
  }

  @override
  State<CounterPage> createState() => _State();
}

class _State extends State<CounterPage> {
  late final CounterController _counterController;

  @override
  void initState() {
    _counterController = getIt<CounterController>();
    super.initState();
    Future(() async {
      await _counterController.fetch();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('カウンター flutter_bloc'),
      ),
      body: BlocBuilder<CounterController, int>(
        bloc: _counterController,
        builder: (context, state) {
          return Center(
            child: Text(
              '$state',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await _counterController.increment();
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
