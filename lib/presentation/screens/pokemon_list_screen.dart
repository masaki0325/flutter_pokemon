import 'package:flutter/material.dart';
import 'package:flutter_pokemon/controllers/pokemon_paging_controller.dart';
import 'package:flutter_pokemon/data/models/pokemon.dart';
import 'package:flutter_pokemon/presentation/widgets/pokemon_list_item.dart';
import 'package:flutter_pokemon/presentation/widgets/skeleton_loader.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class PokemonListScreen extends HookConsumerWidget {
  const PokemonListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pagingController = ref.watch(pagingControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('ポケモン一覧'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(48.0),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: TextField(
              decoration: const InputDecoration(
                hintText: 'ポケモン名で検索',
                border: OutlineInputBorder(),
                suffixIcon: Icon(Icons.search),
              ),
              onChanged: (query) {
                ref.read(searchQueryProvider.notifier).state = query;
                pagingController.refresh();
              },
            ),
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () => Future.sync(
          () => pagingController.refresh(),
        ),
        child: PagedListView<int, Pokemon>(
          pagingController: pagingController,
          builderDelegate: PagedChildBuilderDelegate<Pokemon>(
            itemBuilder: (context, item, index) =>
                PokemonListItem(pokemon: item),
            firstPageProgressIndicatorBuilder: (context) =>
                const SkeletonLoader(),
            newPageProgressIndicatorBuilder: (context) =>
                const LoadingIndicator(),
            firstPageErrorIndicatorBuilder: (context) => ErrorRetryView(
              onRetry: () => pagingController.refresh(),
            ),
            newPageErrorIndicatorBuilder: (context) => ErrorRetryView(
              onRetry: () => pagingController.retryLastFailedRequest(),
            ),
          ),
        ),
      ),
    );
  }
}

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}

class ErrorRetryView extends StatelessWidget {
  final VoidCallback onRetry;

  const ErrorRetryView({super.key, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('読み込みに失敗しました'),
        const SizedBox(height: 8),
        ElevatedButton(
          onPressed: onRetry,
          child: const Text('リトライ'),
        ),
      ],
    );
  }
}
