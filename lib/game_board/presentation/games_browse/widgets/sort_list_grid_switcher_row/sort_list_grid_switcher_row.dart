import 'package:flutter/material.dart';

import '../../../../../constants/app_margins_and_sizes.dart';
import 'list_grid_switcher.dart';
import 'sort_games_widget.dart';

class SortListGridSwitcherRow extends StatelessWidget {
  const SortListGridSwitcherRow({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(listPadding, 2, listPadding, 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Flexible(
              child: SortGamesWidget(),
            ),
            ListGridSwitcher(),
          ],
        ),
      ),
    );
  }
}
