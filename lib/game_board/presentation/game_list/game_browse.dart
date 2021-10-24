import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zacatrusa/constants/app_constants.dart';
import 'package:zacatrusa/constants/app_margins.dart';
import 'package:zacatrusa/game_board/presentation/core/feedback_errors_loading/internet_feedback_widgets.dart';
import 'package:zacatrusa/game_board/presentation/core/feedback_errors_loading/loading.dart';
import 'package:zacatrusa/game_board/presentation/game_list/widgets/body/game_browse_sliver_grid.dart';
import 'package:zacatrusa/game_board/presentation/game_list/widgets/body/game_browse_sliver_list.dart';
import 'package:zacatrusa/game_board/presentation/game_list/widgets/sort_list_grid_switcher_row/list_grid_switcher.dart';
import 'package:zacatrusa/game_board/presentation/game_list/widgets/sort_list_grid_switcher_row/sort_list_grid_switcher_row.dart';
import 'package:zacatrusa/game_board/zacatrus/application/games_list.dart';
import 'package:zacatrusa/game_board/zacatrus/application/url/zacatrus_url_notifier.dart';
import 'package:zacatrusa/game_board/zacatrus/domain/game_overview.dart';
import 'package:zacatrusa/game_board/zacatrus/infrastructure/zacatrus_scrapper.dart';

final listGridViewProvider = StateProvider((_) => ListGrid.list);

class GameBrowse extends ConsumerWidget {
  const GameBrowse({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          ref.refresh(zacatrusGetGamesOverviewProvider);
          ref.refresh(gamesListNotifierProvider);
        },
        child: NotificationListener<ScrollUpdateNotification>(
          onNotification: (ScrollNotification scrollInfo) {
            if (scrollInfo.metrics.pixels >
                scrollInfo.metrics.maxScrollExtent - 100) {
              ref.read(zacatrusGetGamesOverviewProvider).whenData((value) {
                if (value.isRight()) {
                  final urlComposer =
                      ref.read(zacatrusUrlBrowserNotifierProvider.notifier);
                  urlComposer.nextPage();
                  print("Overscroll");
                  return true;
                }
              });
            }
            return false;
          },
          child: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverAppBar(
                title: const Text(appName),
                floating: true,
                actions: [
                  IconButton(
                      onPressed: () {
                        //TODO add filtering sprint 2
                      },
                      icon: const Icon(Icons.filter_list))
                ],
              ),
              SliverToBoxAdapter(
                child: SortListGridSwitcherRow(
                  onViewChange: (listOrGrid) {
                    ref.read(listGridViewProvider).state = listOrGrid;
                  },
                ),
              ),
              _loadedgames(),
              _loadedPending(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _loadedgames() {
    return Consumer(
      builder: (context, ref, _) {
        final loadedGames = ref.watch(gamesListNotifierProvider);
        return _sucessBody([...loadedGames]);
      },
    );
  }

  Widget _loadedPending() {
    return Consumer(
      builder: (context, ref, _) {
        return ref.watch(zacatrusGetGamesOverviewProvider).when(
              data: (either) => either.when(
                  (feedback) => SliverToBoxAdapter(
                      child: InternetFeedbackWidget(feedback: feedback)),
                  (gameList) {
                return const SliverToBoxAdapter(
                  child: SizedBox.shrink(),
                );
              }),
              error: (obj, trace, data) =>
                  SliverToBoxAdapter(child: Text("Error ${obj}")),
              loading: (_) => const SliverToBoxAdapter(child: Loading()),
            );
      },
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

  Widget _gamesOverviewBody(
      ListGrid listGrid, List<GameOverview> gamesOverviews) {
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
