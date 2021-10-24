import 'package:flutter/material.dart';
import 'package:zacatrusa/constants/app_margins.dart';
import 'package:zacatrusa/game_board/presentation/games_browse/widgets/sort_list_grid_switcher_row/sort_games_widget.dart';

import 'list_grid_switcher.dart';

class SortListGridSwitcherRow extends StatelessWidget {
  const SortListGridSwitcherRow({
    Key? key,
    required this.onViewChange,
  }) : super(key: key);

    final Function(ListGrid) onViewChange;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(listPadding),
        child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const SortGamesWidget(),
                ListGridSwitcher(
                  onViewChange: onViewChange
                ),
              ],
        ),
      ),
    );
  }
}



