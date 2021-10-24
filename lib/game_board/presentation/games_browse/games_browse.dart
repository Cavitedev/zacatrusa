import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zacatrusa/game_board/presentation/games_browse/widgets/body/games_browser_loaded_games.dart';
import 'package:zacatrusa/game_board/presentation/games_browse/widgets/body/games_browser_loads.dart';
import 'package:zacatrusa/game_board/presentation/games_browse/widgets/sort_list_grid_switcher_row/list_grid_switcher.dart';
import 'package:zacatrusa/game_board/presentation/games_browse/widgets/sort_list_grid_switcher_row/sort_list_grid_switcher_row.dart';
import 'package:zacatrusa/game_board/zacatrus/application/browser/zacatrus_browser_notifier.dart';

import 'games_browse_sliver_app_bar.dart';

final listGridViewProvider = StateProvider((_) => ListGrid.list);

class GamesBrowse extends ConsumerWidget {
  const GamesBrowse({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          ref.read(zacatrusBrowserNotifierProvider.notifier).clear();
        },
        child: NotificationListener<ScrollUpdateNotification>(
          onNotification: (ScrollNotification scrollInfo) {
            return _onScroll(scrollInfo, ref);
          },
          child: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              const GamesBrowseSliverAppBar(),
              SortListGridSwitcherRow(
                onViewChange: (listOrGrid) {
                  ref.read(listGridViewProvider).state = listOrGrid;
                },
              ),
              const GamesBrowserLoadedGames(),
              const GamesBrowserLoads(),
            ],
          ),
        ),
      ),
    );
  }

  bool _onScroll(ScrollNotification scrollInfo, WidgetRef ref) {
    if (scrollInfo.metrics.pixels > scrollInfo.metrics.maxScrollExtent - 300 &&
        ref.read(zacatrusBrowserNotifierProvider).isLoaded) {
      final zacatrusBrowserNotifier =
          ref.read(zacatrusBrowserNotifierProvider.notifier);

      zacatrusBrowserNotifier.nextPage();
      return true;
    }
    return false;
  }
}
