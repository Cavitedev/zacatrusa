import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../application/browser/browser_notifier.dart';
import 'games_browse_sliver_app_bar.dart';
import 'widgets/body/games_browser_loaded_games.dart';
import 'widgets/body/games_browser_loads.dart';
import 'widgets/sort_list_grid_switcher_row/list_grid_switcher.dart';
import 'widgets/sort_list_grid_switcher_row/sort_list_grid_switcher_row.dart';

final listGridViewProvider = StateProvider((_) => ListGrid.list);

class GamesBrowse extends ConsumerWidget {
  const GamesBrowse({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: RefreshIndicator(
        semanticsLabel: "Recargar juegos de mesa",
        triggerMode: RefreshIndicatorTriggerMode.onEdge,
        onRefresh: () async {
          ref.read(browserNotifierProvider.notifier).clear();
        },
        child: NotificationListener<ScrollUpdateNotification>(
          onNotification: (ScrollNotification scrollInfo) {
            return _onScroll(scrollInfo, ref);
          },
          child: CustomScrollView(
            slivers: [
              const GamesBrowseSliverAppBar(),
              SortListGridSwitcherRow(
                onViewChange: (listOrGrid) {
                  ref.read(listGridViewProvider.notifier).state = listOrGrid;
                },
              ),
              const GamesBrowserLoadedGames(),
              const GamesBrowserLoads(),
              //Fills the rest of the screen for detecting scrolls for loading
              const SliverFillRemaining(
                hasScrollBody: false,
                child: SizedBox.shrink(),
              ),
              SliverToBoxAdapter(
                child: Container(
                  height: 1,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  bool _onScroll(ScrollNotification scrollInfo, WidgetRef ref) {
    if (scrollInfo.metrics.pixels > scrollInfo.metrics.maxScrollExtent - 300 &&
        ref.read(browserNotifierProvider).isLoaded) {
      final zacatrusBrowserNotifier =
          ref.read(browserNotifierProvider.notifier);

      zacatrusBrowserNotifier.nextPageIfNotLoading();
      return true;
    }
    return false;
  }

}


