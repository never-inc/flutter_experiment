import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sample/pages/github_users/pages/widgets/error_message.dart';
import 'package:flutter_sample/pages/github_users/use_cases/github_users_controller.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';
import 'package:url_launcher/url_launcher.dart';

class GithubUsersPage extends ConsumerWidget {
  GithubUsersPage({super.key});

  static Future<void> show(BuildContext context) {
    return Navigator.of(context, rootNavigator: true).push<void>(
      CupertinoPageRoute(
        settings: const RouteSettings(name: 'github_users'),
        builder: (_) => GithubUsersPage(),
      ),
    );
  }

  final RefreshController refreshController = RefreshController();
  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final githubUsers = ref.watch(githubUsersControllerProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Github Users'),
        centerTitle: true,
      ),
      body: githubUsers.when(
        data: (items) {
          return SmartRefresher(
            header: const SmartRefreshHeader(),
            footer: const SmartRefreshFooter(),
            enablePullUp: true,
            controller: refreshController,
            physics: const BouncingScrollPhysics(),
            onRefresh: () async {
              ref.invalidate(githubUsersControllerProvider);
              refreshController.refreshCompleted();
            },
            onLoading: () async {
              await ref
                  .read(githubUsersControllerProvider.notifier)
                  .onFetchMore();
              refreshController.loadComplete();
            },
            child: ListView.separated(
              controller: scrollController,
              itemBuilder: (BuildContext context, int index) {
                final data = items[index];
                return ListTile(
                  leading: CircleAvatar(
                    child: Image.network(
                      data.avatarUrl ?? '',
                    ),
                  ),
                  title: Text(data.login),
                  subtitle: Text(data.htmlUrl ?? '-'),
                  trailing: const Icon(
                    Icons.arrow_forward_ios,
                    size: 16,
                  ),
                  onTap: () {
                    final url = data.htmlUrl;
                    if (url != null) {
                      launchUrl(Uri.parse(url));
                    }
                  },
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return const Divider(height: 1);
              },
              itemCount: items.length,
            ),
          );
        },
        error: (e, _) => ErrorMessage(
          message: e.toString(),
          onTapRetry: () async {
            ref.invalidate(githubUsersControllerProvider);
          },
        ),
        loading: () => const Center(
          child: CupertinoActivityIndicator(),
        ),
      ),
    );
  }
}

class SmartRefreshHeader extends StatelessWidget {
  const SmartRefreshHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomHeader(
      builder: (context, mode) {
        if (mode == RefreshStatus.idle) {
          return const SizedBox.shrink();
        }
        return const SizedBox(
          height: 55,
          child: Center(child: CupertinoActivityIndicator()),
        );
      },
    );
  }
}

class SmartRefreshFooter extends StatelessWidget {
  const SmartRefreshFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomFooter(
      builder: (context, mode) {
        return SizedBox(
          height: 55,
          child: mode == LoadStatus.idle
              ? const SizedBox.shrink()
              : const Center(child: CupertinoActivityIndicator()),
        );
      },
    );
  }
}
