import 'package:flutter/material.dart';

import '../../../../../constants/app_margins.dart';
import 'list_grid_switcher.dart';
import 'sort_games_widget.dart';

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
        padding: const EdgeInsets.fromLTRB(listPadding, 2, listPadding, 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(child: const SortGamesWidget()),
            ListGridSwitcher(onViewChange: onViewChange),
          ],
        ),
      ),
    );
  }
}
