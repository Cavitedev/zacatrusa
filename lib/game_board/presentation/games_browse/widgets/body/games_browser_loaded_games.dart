import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../constants/app_margins.dart';
import '../../../../zacatrus/application/browser/zacatrus_browser_notifier.dart';
import '../../../../zacatrus/domain/browse_page/game_overview.dart';
import '../../games_browse.dart';
import '../sort_list_grid_switcher_row/list_grid_switcher.dart';
import 'games_browse_sliver_grid.dart';
import 'games_browse_sliver_list.dart';

class GamesBrowserLoadedGames extends ConsumerWidget {
  const GamesBrowserLoadedGames({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Consumer(
      builder: (context, ref, _) {
        final loadedGames = ref.watch(zacatrusBrowserNotifierProvider).games;
        return _sucessBody([...loadedGames]);
      },
    );
  }

  Widget _sucessBody(List<GameOverview> gamesOverviews) {
    return Consumer(
      builder: (context, ref, _) {
        final listOrGridView = ref.watch(listGridViewProvider);
        return SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: listPadding),
            sliver: _gamesOverviewBody(listOrGridView, gamesOverviews));
      },
    );
  }

  Widget _gamesOverviewBody(
      ListGrid listGrid, List<GameOverview> gamesOverviews) {
    if (listGrid == ListGrid.list) {
      return GamesBrowseSliverList(
        games: gamesOverviews,
      );
    } else {
      return GamesBrowseSliverGrid(
        games: gamesOverviews,
      );
    }
  }
}
