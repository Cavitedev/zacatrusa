import 'package:flutter/material.dart';
import 'package:zacatrusa/constants/app_constants.dart';
import 'package:zacatrusa/constants/app_margins.dart';
import 'package:zacatrusa/game_board/presentation/game_list/widgets/game_browse_sliver_grid.dart';
import 'package:zacatrusa/game_board/presentation/game_list/widgets/sort_list_grid_switcher_row/sort_list_grid_switcher_row.dart';

class GameList extends StatelessWidget {
  const GameList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            child: SortChangeListRow(
              onViewChange: (listOrGrid) {},
            ),
          ),
          const SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: listPadding),
              sliver: GameBrowseSliverGrid())

        ],
      ),
    );
  }
}
