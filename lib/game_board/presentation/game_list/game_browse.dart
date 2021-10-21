import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zacatrusa/constants/app_constants.dart';
import 'package:zacatrusa/constants/app_margins.dart';
import 'package:zacatrusa/game_board/domain/game_overview.dart';
import 'package:zacatrusa/game_board/presentation/game_list/widgets/game_browse_sliver_grid.dart';
import 'package:zacatrusa/game_board/presentation/game_list/widgets/game_browse_sliver_list.dart';
import 'package:zacatrusa/game_board/presentation/game_list/widgets/sort_list_grid_switcher_row/list_grid_switcher.dart';
import 'package:zacatrusa/game_board/presentation/game_list/widgets/sort_list_grid_switcher_row/sort_list_grid_switcher_row.dart';

final gameOverviewListGrid = StateProvider((_) => ListGrid.list);

class GameBrowse extends ConsumerWidget {
  const GameBrowse({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    final listOrGridView = ref.watch(gameOverviewListGrid);
    return Scaffold(
      body: CustomScrollView(
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
                listOrGridView.state = listOrGrid;
              },
            ),
          ),
          SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: listPadding),
              sliver: _gamesOverviewBody(listOrGridView.state))
        ],
      ),
    );
  }

  Widget _gamesOverviewBody(ListGrid listGrid) {
    if (listGrid == ListGrid.list) {
      return GameBrowseSliverList(
        games: _getGames(),
      );
    } else {
      return GameBrowseSliverGrid(
        games: _getGames(),
      );
    }
  }

  List<GameOverview> _getGames() {
    return List.generate(
          36,
          (index) => const GameOverview(
                name: "Unánimo",
                imageUrl:
                    "https://media.zacatrus.es/catalog/product/cache/5c1c4c2791f7788f78d4202f3db7adfa/u/n/unanimo_enviogratis.jpg",
                price: 9.95,
                numberOfComments: 12,
                stars: 4.85,
              ));
  }
}
