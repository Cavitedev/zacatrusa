import 'package:flutter/material.dart';
import 'package:zacatrusa/constants/app_margins.dart';
import 'package:zacatrusa/game_board/presentation/game_list/widgets/sort_list_grid_switcher_row/sort_games_widget.dart';

import 'list_grid_switcher.dart';

class SortChangeListRow extends StatelessWidget {
  const SortChangeListRow({
    Key? key,
    required this.onViewChange,
  }) : super(key: key);

    final Function(ListGrid) onViewChange;

  @override
  Widget build(BuildContext context) {
    return Padding(
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
    );
  }
}



