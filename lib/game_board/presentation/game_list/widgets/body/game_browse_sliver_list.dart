import 'package:flutter/material.dart';
import 'package:zacatrusa/game_board/zacatrus/domain/game_overview.dart';

class GameBrowseSliverList extends StatelessWidget {
  const GameBrowseSliverList({
    required this.games,
    Key? key,
  }) : super(key: key);

    final List<GameOverview> games;


  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate((context, index) {
        final GameOverview game = games[index];
        return Card(
          child: Text(game.name),
        );
      //TODO render data
      }, childCount: games.length),
    );
  }
}
