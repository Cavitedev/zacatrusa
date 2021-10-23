import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zacatrusa/constants/app_constants.dart';
import 'package:zacatrusa/game_board/presentation/game_list/widgets/body/game_browse_body.dart';
import 'package:zacatrusa/game_board/presentation/game_list/widgets/sort_list_grid_switcher_row/list_grid_switcher.dart';
import 'package:zacatrusa/game_board/presentation/game_list/widgets/sort_list_grid_switcher_row/sort_list_grid_switcher_row.dart';

final gameOverviewListGrid = StateProvider((_) => ListGrid.list);

class GameBrowse extends ConsumerWidget {
  const GameBrowse({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
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
                  ref.read(gameOverviewListGrid).state = listOrGrid;
              },
            ),
          ),
          const GameBrowseBody(),
        ],
      ),
    );
  }


}
