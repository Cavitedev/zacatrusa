import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zacatrusa/constants/app_margins.dart';
import 'package:zacatrusa/game_board/infrastructure/http_loader.dart';
import 'package:zacatrusa/game_board/presentation/core/feedback_errors_loading/internet_feedback_widgets.dart';
import 'package:zacatrusa/game_board/presentation/core/feedback_errors_loading/loading.dart';
import 'package:zacatrusa/game_board/presentation/game_list/game_browse.dart';
import 'package:zacatrusa/game_board/presentation/game_list/widgets/sort_list_grid_switcher_row/list_grid_switcher.dart';
import 'package:zacatrusa/game_board/zacatrus/domain/game_overview.dart';
import 'package:zacatrusa/game_board/zacatrus/infrastructure/zacatrus_scrapper.dart';

import 'game_browse_sliver_grid.dart';
import 'game_browse_sliver_list.dart';

final fetchPageProvider = StreamProvider.autoDispose((ref) {
  final scrapper = ref.watch(httpLoaderProvider);


  return scrapper.getPage(
      url: "https://zacatrus.es/juegos-de-mesa.html");
});

class GameBrowseBody extends ConsumerWidget {
  const GameBrowseBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    return ref.watch(zacatrusGetGamesOverviewProvider).when(
          data: (either) => either.when(
              (feedback) => SliverToBoxAdapter(
                  child: InternetFeedbackWidget(feedback: feedback)),
              (gameList) => _sucessBody(gameList)),
          error: (obj, trace, data) =>
              SliverToBoxAdapter(child: Text("Error ${obj}")),
          loading: (_) => const SliverToBoxAdapter(child: Loading()),
        );
  }

  Widget _sucessBody(List<GameOverview> gamesOverviews) {
    return Consumer(
      builder: (context, ref, _) {
        final listOrGridView = ref.watch(listGridViewProvider);
        return SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: listPadding),
          sliver: _gamesOverviewBody(listOrGridView.state, gamesOverviews));
      },
    );
  }

  Widget _gamesOverviewBody(ListGrid listGrid, List<GameOverview> gamesOverviews) {
    if (listGrid == ListGrid.list) {
      return GameBrowseSliverList(
        games: gamesOverviews,
      );
    } else {
      return GameBrowseSliverGrid(
        games: gamesOverviews,
      );
    }
  }

}
