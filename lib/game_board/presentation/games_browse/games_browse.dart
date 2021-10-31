import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../zacatrus/application/browser/zacatrus_browser_notifier.dart';
import 'games_browse_sliver_app_bar.dart';
import 'widgets/body/games_browser_loaded_games.dart';
import 'widgets/body/games_browser_loads.dart';
import 'widgets/sort_list_grid_switcher_row/list_grid_switcher.dart';
import 'widgets/sort_list_grid_switcher_row/sort_list_grid_switcher_row.dart';

final listGridViewProvider = StateProvider((_) => ListGrid.list);

class GamesBrowse extends ConsumerStatefulWidget {
  const GamesBrowse({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _GamesBrowseState();
}

class _GamesBrowseState extends ConsumerState<GamesBrowse> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: RefreshIndicator(
        semanticsLabel: "Recargar juegos de mesa",
        triggerMode: RefreshIndicatorTriggerMode.anywhere,
        onRefresh: () async {
          ref.read(zacatrusBrowserNotifierProvider.notifier).clear();
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
                  ref.read(listGridViewProvider).state = listOrGrid;
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
                child: Container(height: 1,),
              )
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


