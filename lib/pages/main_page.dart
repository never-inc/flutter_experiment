import 'package:flutter/material.dart';
import 'package:flutter_sample/pages/flutter_bloc/index.dart' as flutter_bloc;
import 'package:flutter_sample/pages/github_users/pages/github_users_page.dart';
import 'package:flutter_sample/pages/graph_ql/graph_ql_sample_page.dart';
import 'package:flutter_sample/pages/image_picker/image_picker_page.dart';
import 'package:flutter_sample/pages/memory_leaks/memory_leaks_sample_page.dart';
import 'package:flutter_sample/pages/riverpod/index.dart' as riverpod;

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
                  'カウンター flutter_bloc',
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
                  'カウンター riverpod',
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
              ListTile(
                title: const Text(
                  'Memory Leak Sample',
                ),
                trailing: const Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 16,
                ),
                onTap: () {
                  MemoryLeakSamplePage.show(context);
                },
              ),
              const Divider(height: 1),
              ListTile(
                title: const Text(
                  'GraphQL Sample',
                ),
                trailing: const Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 16,
                ),
                onTap: () {
                  GraphQLSamplePage.show(context);
                },
              ),
              const Divider(height: 1),
              ListTile(
                title: const Text(
                  'ImagePicker',
                ),
                trailing: const Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 16,
                ),
                onTap: () {
                  ImagePickerPage.show(context);
                },
              ),
              const Divider(height: 1),
              ListTile(
                title: const Text(
                  'GitHub Users',
                ),
                trailing: const Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 16,
                ),
                onTap: () {
                  GithubUsersPage.show(context);
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
