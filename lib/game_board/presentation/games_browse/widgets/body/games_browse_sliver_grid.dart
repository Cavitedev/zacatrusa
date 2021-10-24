import 'package:flutter/material.dart';

import '../../../../../constants/app_margins.dart';
import '../../../../zacatrus/domain/game_overview.dart';

class GamesBrowseSliverGrid extends StatelessWidget {
  const GamesBrowseSliverGrid({
    required this.games,
    Key? key,
  }) : super(key: key);

  final List<GameOverview> games;

  @override
  Widget build(BuildContext context) {
    return SliverGrid(
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 256,
        mainAxisSpacing: listSpacing,
        crossAxisSpacing: listSpacing,
      ),
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return const Placeholder();
        //TODO render data
        },
        childCount: games.length,
      ),
    );
  }
}
