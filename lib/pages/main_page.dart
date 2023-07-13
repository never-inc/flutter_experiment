import 'package:flutter/material.dart';
import 'package:flutter_sample/pages/flutter_bloc/counter_page.dart'
    as flutter_bloc;
import 'package:flutter_sample/pages/riverpod/counter_page.dart' as riverpod;

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('メイン'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Column(
            children: [
              ListTile(
                title: const Text(
                  'カウンター画面（flutter_bloc）',
                ),
                trailing: const Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 16,
                ),
                onTap: () {
                  flutter_bloc.CounterPage.show(context);
                },
              ),
              const Divider(height: 1),
              ListTile(
                title: const Text(
                  'カウンター画面（riverpod）',
                ),
                trailing: const Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 16,
                ),
                onTap: () {
                  riverpod.CounterPage.show(context);
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
