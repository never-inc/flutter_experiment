import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sample/pages/memory_leaks/dummy_object.dart';

class ConstTest extends StatelessWidget {
  const ConstTest({super.key});

  static Future<void> show(BuildContext context) {
    return Navigator.of(context, rootNavigator: true).push<void>(
      CupertinoPageRoute(
        settings: const RouteSettings(name: 'const_test'),
        builder: (_) => const ConstTest(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(runtimeType.toString()),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const ConstWidget(),
            const ConstStatefulWidget(),
            NoConstWidget(),
          ],
        ),
      ),
    );
  }
}

class ConstWidget extends StatelessWidget {
  const ConstWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(hashCode.toString());
  }
}

class ConstStatefulWidget extends StatefulWidget {
  const ConstStatefulWidget({super.key});

  @override
  State<ConstStatefulWidget> createState() => ConstStatefulState();
}

class ConstStatefulState extends State<ConstStatefulWidget> {
  final DummyObject dummyObject = DummyObject.create();

  @override
  Widget build(BuildContext context) {
    return Text(dummyObject.hashCode.toString());
  }
}

class NoConstWidget extends StatelessWidget {
  const NoConstWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(hashCode.toString());
  }
}
